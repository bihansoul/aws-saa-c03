#Setup credentials for aws cli using command 'aws configure' and input access key & secret key
#aws credentials store at ~/.aws/credentials

# Set your desired AWS region
provider "aws" {
  region = "ap-southeast-2"
}

module "iam" {
  source = "./modules/iam"
}

module "vpc" {
  source = "./modules/vpc"
}

module "ec2" {
  source = "./modules/ec2"
  vpc_id = module.vpc.vpc_id
  subnet_id = module.vpc.subnet_id
}

# run 'terraform apply' to apply script
