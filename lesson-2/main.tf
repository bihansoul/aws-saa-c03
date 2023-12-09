#Setup credentials for aws cli using command 'aws configure' and input access key & secret key
#aws credentials store at ~/.aws/credentials

# Set your desired AWS region
provider "aws" {
  region = "ap-southeast-2"
}

#module "iam" {
#  source = "./modules/iam"
#}

module "vpc" {
  source = "./modules/vpc"
}

# run 'terraform apply' to apply script
