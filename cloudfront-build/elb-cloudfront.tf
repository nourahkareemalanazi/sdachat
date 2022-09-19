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

resource "aws_cloudfront_distribution" "alb_beanstalk" {
  origin {
    domain_name = "awseb-AWSEB-1RTU7A6N7Q7YH-127164989.us-east-1.elb.amazonaws.com"
    origin_id   = "awseb-AWSEB-1RTU7A6N7Q7YH"

  custom_origin_config {
        http_port              = 80
        https_port             = 443
        origin_protocol_policy = "http-only"
        origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "CloudFront For Elastic BeansTalk"
  default_root_object = "index.html"

    
  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "awseb-AWSEB-1RTU7A6N7Q7YH"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  price_class = "PriceClass_200"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = {
    Environment = "production"
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}
