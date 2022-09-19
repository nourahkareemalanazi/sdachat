terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
}

# vars/tf
 variable env_vars {
  default = ["DB_NAME", "DuiHua", "DB_PASSWORD", "DuiHua2022" ,"DB_PORT" , "3306" , "DB_URL" , "duihua.cwrdytwfs25i.us-east-1.rds.amazonaws.com" , "BD_USERNAME" , "root"]
}
variable "duihuaapp-nnew" {
  default = "duihuaapp-nnew"
}
variable "duihuaenv-nnew" {
  default = "duihuaenv-nnew"
}
variable "solution_stack_name" {
  default = "64bit Amazon Linux 2 v3.4.19 running Docker"
}
variable "tier" {
  default = "WebServer"
}

# Create elastic beanstalk application
resource "aws_elastic_beanstalk_application" "duihuaapp-nnew" {
  name = var.duihuaapp-nnew
}

# Create elastic beanstalk environment
resource "aws_elastic_beanstalk_environment" "duihuaenv-nnew" {
  name                = var.duihuaenv-nnew
  application         = aws_elastic_beanstalk_application.duihuaapp-nnew.name
  solution_stack_name = var.solution_stack_name
  tier                = var.tier

}
