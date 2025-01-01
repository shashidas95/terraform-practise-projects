
provider "aws" {
  region = "us-east-1"
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "dev"
}

data "aws_availability_zones" "name" {
 state = "available"
  
}
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.17.0"

  name = "sas-vpc"
  cidr = "10.0.0.0/16"
 

  azs             = data.aws_availability_zones.name.names
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

    tags = {
    Terraform = "true"
    Environment = "dev"
    Name = "test-vpc-module"
  }
}