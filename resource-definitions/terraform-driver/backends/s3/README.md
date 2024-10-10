# S3 Backend using Temporary Credentials

The Backend is configured using the `backend` block. A `config` resource holds the key configuration for the backend.

The Credentials for the backend are automatically read in via the `AWS_` environment variables defined in `credentials_config`.