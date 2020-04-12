# AWS S3 bucket for static hosting

data "aws_iam_policy_document" "s3_policy_cf_bucket" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::${var.website_bucket_name}/*"]

    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }

  statement {
    actions   = ["s3:ListBucket"]
    resources = ["arn:aws:s3:::${var.website_bucket_name}"]

    principals {
      type        = "AWS"
      identifiers = ["${aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn}"]
    }
  }
}

resource "aws_s3_bucket" "website" {
  bucket = var.website_bucket_name
  acl    = "private"
  policy = data.aws_iam_policy_document.s3_policy_cf_bucket.json
  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}

resource "aws_s3_bucket_object" "index" {
  bucket       = aws_s3_bucket.website.id
  key          = "index.html"
  source       = "./index.html"
  content_type = "text/html"
  etag         = filemd5("./index.html")
}

resource "aws_s3_bucket_object" "image" {
  bucket       = aws_s3_bucket.website.id
  key          = "diego.jpg"
  source       = "./diego.jpg"
  content_type = "image/jpeg"
  etag         = filemd5("./diego.jpg")
}


resource "aws_s3_bucket_object" "error" {
  bucket       = aws_s3_bucket.website.id
  key          = "error.html"
  source       = "./error.html"
  content_type = "text/html"
  etag         = filemd5("./error.html")
}

resource "aws_s3_bucket" "logs" {
  bucket        = var.logs_bucket
  acl           = "private"
  force_destroy = "true"
}