output "bucket_name" {
  description = "Created S3 Bucket Name"
  value       = aws_s3_bucket.backup_bucket.bucket
}

output "bucket_arn" {
  description = "Created S3 Bucket ARN"
  value       = aws_s3_bucket.backup_bucket.arn
}

output "bucket_region" {
  description = "Bucket Region"
  value       = aws_s3_bucket.backup_bucket.region
}