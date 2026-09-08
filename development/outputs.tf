output "buckets_created" {
  value = local.bucket_name
}

output "apps_created" {
  value = aws_elastic_beanstalk_application.app.name
}