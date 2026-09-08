/* Create ZIP file of all website files in file directory */
data "archive_file" "wf_site" {
  type        = "zip"
  source_dir  = "${path.module}/website"
  output_path = "${path.module}/website-bundle.zip"
}

/* Create S3 bucket and enable bucket versioning*/
resource "aws_s3_bucket" "webflow_bucket" {
  bucket = local.bucket_name

  tags = {
    Name        = "${local.bucket_name}"
    Environment = var.environment
  }
}

resource "aws_s3_bucket_versioning" "app_source" {
  bucket = aws_s3_bucket.webflow-bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

/* Upload website files to previously created S3 bucket */
resource "aws_s3_object" "webflow_site_files" {

  bucket = aws_s3_bucket.webflow_bucket.id
  key    = "wf-site-${var.environment}.zip"
  source = data.wf_site.output_path
  etag   = filemd5(data.wf_site.output_path)

  tags = {
    Environment = var.environment
  }
}

/* Create Elastic Beanstalk app */
resource "aws_elastic_beanstalk_application" "app" {
  name        = "${var.app_name}-${var.environment}"
  description = "WebFlow hosting infrastructure created and managed with Terraform"
}

/* Enable app versioning */
resource "aws_elastic_beanstalk_application_version" "app_version" {
  name        = "v1-${aws_elastic_beanstalk_application.app.name}"
  application = aws_elastic_beanstalk_application.app.name
  description = "App version deployed from S3"
  bucket      = aws_s3_bucket.webflow-bucket.bucket
  key         = aws_s3_object.webflow_site_files.key

  depends_on = [aws_s3_object.webflow_site_files]
}

/* Configure the app environment */
resource "aws_elastic_beanstalk_environment" "app_environment" {
  name                = "${var.policy_name}-${var.environment}"
  application         = aws_elastic_beanstalk_application.app.name
  solution_stack_name = "64bit Amazon Linux 2023 v6.7.1 running Node.js 20"
  version_label       = aws_elastic_beanstalk_application_version.app_version.name

  tier = "WebServer"

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = "aws-elasticbeanstalk-ec2-role"
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = "${var.policy_name}-${local.vpc_name}"
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = "subnet-${var.policy_name}-1,subnet-${var.policy_name}"
  }

  # Optional: Configure environment variables for static hosting
  setting {
    namespace = "aws:elasticbeanstalk:environment:process:default"
    name      = "Port"
    value     = "80"
  }
}