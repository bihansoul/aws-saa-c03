#Setup credentials for aws cli using command 'aws configure' and input access key & secret key
#aws credentials store at ~/.aws/credentials

# Set your desired AWS region
provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_s3_bucket" "aws_study_bucket_lesson_1" {
  bucket = "aws-study-bucket-lesson-1"

  tags = {
    Name        = "aws-study-bucket-tag"
    Environment = "development"
  }
}

# run 'terraform apply' to apply script
