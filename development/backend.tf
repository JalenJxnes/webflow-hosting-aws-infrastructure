terraform {
  backend "s3" {
        bucket = "jalen-jones-webflow-hosting"
        key = "dev/terraform.tfstate"
        region = "us-east-2"
        encrypt = true
        use_lockfile = true
    }
}