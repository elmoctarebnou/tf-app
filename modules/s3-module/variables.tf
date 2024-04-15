variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "bucket_acl" {
  description = "The ACL for the S3 bucket"
  type        = string
  default     = "private"
}

variable "bucket_versioning" {
  description = "Enable versioning for the S3 bucket"
  type        = bool
  default     = true
}
