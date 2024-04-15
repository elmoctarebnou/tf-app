resource "aws_s3_bucket" "s3-bucket" {
    bucket        = var.bucket_name
    force_destroy = true
    tags = {
        Name = var.bucket_name
    }
}
resource "aws_s3_bucket_versioning" "s3-bucker-versioning" {
    bucket = aws_s3_bucket.s3-bucket.bucket
    versioning_configuration {
        status = var.bucket_versioning ? "Enabled" : "Suspended"
    }
}
# /*********************************/
# // DynamoDB table for state lock //
# /*********************************/
# resource "aws_dynamodb_table" "terraform-state-lock" {
#     name           = "terraform-state-lock"
#     billing_mode   = "PAY_PER_REQUEST"
#     hash_key       = "LockID"
#     attribute {
#         name = "LockID"
#         type = "S"
#     }
# }