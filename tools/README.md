# Tools

## def-json-hcl.jq

This is a JQ script that converts a JSON representation of a resource definition into a terraform representation of the same resource definition.

It makes the following assumptions:

- The Terrafrom resource name of the `humanitec_resource_definition` will be the ID of the Resource Definition
- The Terrafrom resource name of the `humanitec_resource_definition_matching_criteria` resources will have the index value appended as `_0`.
   NOTE: This means that re-running the conversion might result in state changes if the order of the matching criteria changes.

NOTE: Requires `jq` v1.6 or higher.

### USAGE

Can be used with `humctl` as follows:

```
humctl get def my-res-def -o json | jq -r -f ./def-json-hcl.jq > my-res-def.tf
```

Can be used with Humanitec YAML files, but requires a conversion to JSON, e.g. using `yq`:

```
cat my-res-def.yaml | yq -o json | jq -r -f ./def-json-hcl.jq > my-res-def.tf
```

### Handling of multiline strings

Using a [heredoc](https://developer.hashicorp.com/terraform/language/expressions/strings#heredoc-strings) section is the most user-friendly way of mapping multiline YAML strings into Terraform.

The problem is that Terraform's heredoc always inserts an empty new line at the end of the generated string. This might break the data in cases when there must not be one. Therefore, the script only generates a heredoc if there is a trailing newline in the source string, and uses a traditional single-line string otherwise containing `\n` for any line breaks.