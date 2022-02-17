resource "aws_s3_bucket" "this" {
  bucket                               = "${var.bucket_name}"
  force_destroy                        = "${var.force_destroy}"
  #region                               = "${var.aws_region}"
  acl = "public-read"
  policy = <<POLICY
{
  "Version":"2012-10-17",
  "Statement":[{
    "Sid":"PublicReadForGetBucketObjects",
      "Effect":"Allow",
      "Principal": "*",
      "Action":"s3:GetObject",
      "Resource":["arn:aws:s3:::${var.bucket_name}/*"
      ]
    }
  ]
}
POLICY
}
