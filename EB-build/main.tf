terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "~> 2.13.0"
    }
  }
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

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     =  "aws-elasticbeanstalk-ec2-role"
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "LoadBalancerType"
    value     = "application"
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = "t2.medium"
  }
    setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "${element(var.env_vars, 0)}"
    value     = "${element(var.env_vars, 1)}"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "${element(var.env_vars, 2)}"
    value     = "${element(var.env_vars, 3)}"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "${element(var.env_vars, 4)}"
    value     = "${element(var.env_vars, 5)}"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "${element(var.env_vars, 6)}"
    value     = "${element(var.env_vars, 7)}"
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "${element(var.env_vars, 8)}"
    value     = "${element(var.env_vars, 9)}"
  }
}
