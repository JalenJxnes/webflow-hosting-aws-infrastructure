resource "aws_s3_bucket" "webflow-bucket" {
  bucket = local.bucket_name

  tags = {
    Name        = "${local.bucket_name}"
    Environment = var.Environment
  }
}

resource "aws_s3_bucket" "webflow-site-files" {
    bucket = 
}