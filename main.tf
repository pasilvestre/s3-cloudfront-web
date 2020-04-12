provider "aws" {
  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_KEY
  region     = "eu-west-2"
}

//terraform {
//  backend "s3" {
//    bucket = "pablo-terraform-web-state-bucket"
//    key    = "keys"
//    region = "eu-west-2"
//  }
//}
//
//
//resource "aws_s3_bucket" "state_bucket" {
//  bucket = "pablo-terraform-web-state-bucket"
//
//  versioning {
//    enabled = true
//  }
//
//  policy = <<EOF
//{
//  "Version": "2012-10-17",
//  "Statement": [
//    {
//      "Effect": "Allow",
//      "Action": "s3:ListBucket",
//      "Resource": "arn:aws:s3:::pablo-terraform-web-state-bucket"
//    },
//    {
//      "Effect": "Allow",
//      "Action": ["s3:GetObject", "s3:PutObject"],
//      "Resource": "arn:aws:s3:::pablo-terraform-web-state-bucket/keys"
//    }
//  ]
//}
//  EOF
//}
//
//#A DynamoDB table to store state file locks
//resource "aws_dynamodb_table" "state_lock_table" {
//  name           = "pablo-terraform-web-state-locks"
//  read_capacity  = 5
//  write_capacity = 5
//  hash_key       = "LockID"
//
//  attribute {
//    name = "LockID"
//    type = "S"
//  }
//}
//
//#Role to allow access to state
//resource "aws_iam_role" "state_access_role" {
//  name = "TerraformState"
//
//  assume_role_policy = <<EOF
//{
//  "Version": "2012-10-17",
//  "Statement": [
//    {
//      "Effect": "Allow",
//      "Principal": {
//        "AWS": "arn:aws:iam::474314003562:root",
//      },
//      "Action": "sts:AssumeRole",
//      "Condition": {}
//    }
//  ]
//}
//EOF
//}
//
//resource "aws_iam_policy" "state_access_policy" {
//  name        = "state_access_policy"
//  path        = "/"
//  description = "Permit access to Terraform state in shared bucket"
//
//  policy = <<EOF
//{
//    "Version": "2012-10-17",
//    "Statement": [
//        {
//            "Sid": "StoreTerraformStateLocks",
//            "Effect": "Allow",
//            "Action": [
//                "dynamodb:*",
//                "s3:*"
//            ],
//            "Resource": [
//                "arn:aws:dynamodb:eu-west-2:474314003562:table/pablo-terraform-web-state-locks",
//                "arn:aws:s3:::pablo-terraform-web-state-bucket",
//            ]
//        },
//        {
//            "Sid": "ListDynamoTables",
//            "Effect": "Allow",
//            "Action": "dynamodb:ListTables",
//            "Resource": "*"
//        }
//    ]
//}
//EOF
//}