variable "name" {
  type        = string
  description = "The name of the S3 bucket"
}

variable "bucket_acl" {
  type        = string
  description = "The ACL for the bucket. Default: private"
  default     = "private"
}

variable "bucket_policy" {
  type        = string
  description = "The policy that will be applied to the bucket"
  default     = null
}

variable "enable_versioning" {
  type        = bool
  description = "Whether or not to enable versioning on bucket contents"
  default     = false
}

variable "enable_lifecycle_policy" {
  type        = bool
  description = "Whether or not to enable lifecycle on bucket contents"
  default     = true
}

variable "kms_master_key_id" {
  type        = string
  description = "The AWS KMS master key ID used for server-side encryption. If null, AES256 encryption is used."
  default     = null
}

variable "enable_logging" {
  type        = bool
  description = "Whether to enable access logging for the bucket"
  default     = false
}

variable "logging_target_bucket" {
  type        = string
  description = "The name of the bucket to store access logs"
  default     = null
}

variable "logging_target_prefix" {
  type        = string
  description = "The prefix for access log objects"
  default     = "logs/"
}
