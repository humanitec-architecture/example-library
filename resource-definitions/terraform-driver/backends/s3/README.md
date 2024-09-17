# S3 Backend using Temporary Credentials

The Backend is configured using the `backend` block. A `config` resource holds the key configuration for the backend.

The Credentials for the backend are automatically read in via the `AWS_` environment variables defined in `credentials_config`.

The following needs to be defined in `tf-be-config.yaml` resource definition:
- `.entity.driver_account` - Should be the ID of the Cloud Account that was configured.
- `.entity.driver_inputs.values.bucket` - Should be the ID of the S3 bucket.
- `.entity.driver_inputs.values.prefix` - Should be the prefix for state path
- `.entity.driver_inputs.values.region` - The region that the bucket is in.

It is critical that the Identity defined in the driver account has access to the S3 bucket.

For example, using this policy document, replacing `my-terraform-state-bucket` with your bucket ID:
```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket",
                "s3:GetObject",
                "s3:PutObject"
            ],
            "Resource": [
                "arn:aws:s3:::my-terraform-state-bucket",
                "arn:aws:s3:::my-terraform-state-bucket/*"
            ]
        }
    ]
}
```
