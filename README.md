Terraform modules that provide a basic static website hosted in S3 with Cloudfront as CDN

- It uses terraform version 0.12.24

- /static-website-s3/.github/workflows/terraform.yml > CI/CD, triggered when changes are merged/pulled into master.

- Secrets AWS keys stored in Github's secret store

- For this demo the website is served in HTTP as no DNS/SSL certificate was configured for this cloudfront distribution.

- Caching provided by Cloudfront, 24hs TTL on cache, no WAF enabled.

 *Variables*
   
variable "AWS_ACCESS_KEY" {}

variable "AWS_SECRET_KEY" {}

variable "aws_region" {}

variable "website_bucket_name" {}

variable "logs_bucket" {}

*Outputs:*

The domain name for the cloudfront distribution



- It is also a tribute to Diego.
