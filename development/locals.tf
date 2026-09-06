locals {
  vpc_name = "${var.Environment}-VPC"
  bucket_name = "${var.bucket_name}-bucket-${var.Environment}-${var.region}"
}