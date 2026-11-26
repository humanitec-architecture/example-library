This example shows how to provision an AWS S3 bucket with the [Container (builtin) Driver](https://developer.humanitec.com/platform-orchestrator/docs/integration-and-extensions/drivers/container-builtin/) and the [s3-container-runner](https://github.com/humanitec-architecture/s3-container-runner) image. The runner calls the S3 API directly, without Terraform or the AWS CLI.

The example is made up of this file:

* [s3.yaml](s3.yaml): a Resource Definition of type `s3`. It outputs `bucket`, `region` and `arn`. There are no secret outputs.

## How the bucket name is handled

The bucket name is generated once by the Definition, never by the runner. `templates.init` reuses the name stored in the Resource state, or generates `hum-` followed by 20 random lowercase characters on the first run:

```yaml
init: |
  {{- if and $.state (hasKey $.state "bucket") }}
  bucket: {{ $.state.bucket }}
  {{- else }}
  bucket: hum-{{ randAlphaNum 20 | lower }}
  {{- end }}
state: |
  bucket: {{ $.init.bucket }}
```

`templates.state` persists the name, so later deployments and the destroy run use the same bucket.

`templates.outputs.job` injects the name into the Job. It deep-copies `values.job` and adds `BUCKET_NAME` to its `variables`:

```yaml
outputs:
  job: |
    {{- $job := deepCopy $.driver.values.job -}}
    {{- $_ := set $job.variables "BUCKET_NAME" $.init.bucket -}}
    {{ $job | toRawJson }}
```

## Credentials

By default, the Definition sets no secrets. The runner uses the AWS default credential chain: in the cluster, that is the IAM role bound to the Job's service account through IRSA or EKS Pod Identity.

As an alternative, `s3.yaml` contains a commented-out `secret_refs.job.variables` block. It sets `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` from a secret store. Don't put keys in `values.job.variables`: those end up in clear text in the Job spec. The runner also supports static credentials from a file through `AWS_CREDENTIALS_FILE`; see the runner documentation.

## Requirements

* The Humanitec Operator installed in the target cluster.
* The namespace and service account for the Job. The example uses `humanitec-runner` for both: change `values.job.namespace` and `values.job.service_account` to match yours.
* An IAM role bound to that service account, with the permissions below. Or, as an alternative, the static keys of an IAM user with the same permissions, in the commented-out `secret_refs` block.

The minimal IAM policy, scoped to the `hum-` name prefix used by the Definition:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": ["s3:CreateBucket", "s3:ListBucket", "s3:DeleteBucket"],
      "Resource": "arn:aws:s3:::hum-*"
    },
    {
      "Effect": "Allow",
      "Action": "s3:DeleteObject",
      "Resource": "arn:aws:s3:::hum-*/*"
    }
  ]
}
```

## Behaviour

* Create is idempotent: the Job runs on every deployment, and a bucket that already exists in your account (`BucketAlreadyOwnedByYou`) counts as success. A name owned by another account fails the run.
* Destroy empties the bucket first, then deletes it.
* Versioned buckets aren't supported: destroy deletes only the current objects, so deleting the bucket fails.
