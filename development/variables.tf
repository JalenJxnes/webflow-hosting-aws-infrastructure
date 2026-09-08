variable "environment" {
  default = "dev"
  type    = string
}

variable "bucket_name" {
  default = "jalen-jones-webflow-hosting"
  type    = string
}

variable "region" {
  default = "us-east-2"
  type    = string
}

variable "policy_name" {
  type    = string
  default = "webflow-hosting-aws"
}

variable "beanstalk_role_name" {
    type = string
    default = "aws-beanstalk"
}