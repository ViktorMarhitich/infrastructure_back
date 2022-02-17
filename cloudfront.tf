resource "aws_cloudfront_distribution" "cloudfront_distribution" {
  origin {
    domain_name = "${var.bucket_name}.s3.amazonaws.com"
    origin_id   = "S3-${var.bucket_name}"
    /*s3_origin_config {

    }*/
  }
  enabled     = true
  price_class = var.price_class
  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3-${var.bucket_name}"
    forwarded_values {
      query_string = true
      cookies {
        forward = "none"
      }
    }
    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }
  retain_on_delete = var.retain_on_delete
  viewer_certificate {
    cloudfront_default_certificate = true
  }
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}