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
