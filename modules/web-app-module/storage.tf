/****************************/
// Terraform state bucket //
/****************************/
resource "aws_s3_bucket" "ebnou-terraform-state" {
    bucket        = "ebnou-terraform-state"
    force_destroy = true
    tags = {
        Name = "ebnou-terraform-state"
        Environment = "research"
    }
}
resource "aws_s3_bucket_versioning" "ebnou-terraform-state" {
    bucket = aws_s3_bucket.ebnou-terraform-state.bucket
    versioning_configuration {
        status = "Enabled"
    }
}
/*********************************/
// DynamoDB table for state lock //
/*********************************/
resource "aws_dynamodb_table" "terraform-state-lock" {
    name           = "terraform-state-lock"
    billing_mode   = "PAY_PER_REQUEST"
    hash_key       = "LockID"
    attribute {
        name = "LockID"
        type = "S"
    }
}