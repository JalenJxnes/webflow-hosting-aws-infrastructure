locals {
  vpc_name                       = "${var.environment}-VPC"
  bucket_name                    = "${var.bucket_name}-bucket-${var.environment}-${var.region}"
  policy_name                    = "${var.policy_name}-policy"
  wf_site_zip_files_directory    = "./Documents/GitHub/webflow-hosting-aws-infrastructure/development/wf-site-files.zip"
  wf_site_static_files_directory = "./Documents/GitHub/webflow-hosting-aws-infrastructure/development/website"
}