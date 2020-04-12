output "static_web_url" {
  value = aws_cloudfront_distribution.s3_distribution.domain_name
}