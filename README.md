# OpenTofu AWS S3 Module

A module for creating S3 buckets with server-side encryption, optional logging, versioning, and lifecycle policies.

## Usage

### Basic Usage

```hcl
module "bucket" {
  source = "git::https://github.com/im5tu/opentofu-aws-s3.git?ref=f0401b77f5fe7c0fe09757001f7f6045f1296093"

  name = "my-application-bucket"
}
```

### With KMS Encryption

```hcl
module "bucket" {
  source = "git::https://github.com/im5tu/opentofu-aws-s3.git?ref=f0401b77f5fe7c0fe09757001f7f6045f1296093"

  name              = "my-encrypted-bucket"
  kms_master_key_id = aws_kms_key.bucket_key.arn
  enable_versioning = true
}
```

### With Access Logging

```hcl
module "bucket" {
  source = "git::https://github.com/im5tu/opentofu-aws-s3.git?ref=f0401b77f5fe7c0fe09757001f7f6045f1296093"

  name                  = "my-logged-bucket"
  enable_logging        = true
  logging_target_bucket = "my-logging-bucket"
  logging_target_prefix = "s3-access-logs/"
}
```

## Requirements

| Name | Version |
|------|---------|
| opentofu | >= 1.9 |
| aws | ~> 6 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | The name of the S3 bucket | `string` | n/a | yes |
| bucket_acl | The ACL for the bucket | `string` | `"private"` | no |
| bucket_policy | The policy that will be applied to the bucket | `string` | `null` | no |
| enable_versioning | Whether or not to enable versioning on bucket contents | `bool` | `false` | no |
| enable_lifecycle_policy | Whether or not to enable lifecycle on bucket contents | `bool` | `true` | no |
| kms_master_key_id | The AWS KMS master key ID used for server-side encryption. If null, AES256 encryption is used. | `string` | `null` | no |
| enable_logging | Whether to enable access logging for the bucket | `bool` | `false` | no |
| logging_target_bucket | The name of the bucket to store access logs | `string` | `null` | no |
| logging_target_prefix | The prefix for access log objects | `string` | `"logs/"` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | The ARN of the bucket |
| name | The name of the bucket |

## Development

### Validation

This module uses GitHub Actions for validation:

- **Format check**: `tofu fmt -check -recursive`
- **Validation**: `tofu validate`
- **Security scanning**: Checkov, Trivy

### Local Development

```bash
# Format code
tofu fmt -recursive

# Validate
tofu init -backend=false
tofu validate
```

## License

MIT License - see [LICENSE](LICENSE) for details.
