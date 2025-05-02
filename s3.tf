resource "aws_s3_bucket" "s3b" {
  bucket = "kaashntr-bucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_acl" "bacl" {
  bucket = aws_s3_bucket.s3b.id
  acl    = "private"
}

resource "aws_s3_bucket_website_configuration" "s3web" {
  bucket = aws_s3_bucket.s3b.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

  routing_rule {
    condition {
      key_prefix_equals = "docs/"
    }
    redirect {
      replace_key_prefix_with = "documents/"
    }
  }
}
resource "aws_s3_bucket_policy" "public_read" {
  bucket = aws_s3_bucket.s3b.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "PublicReadGetObject",
        Effect = "Allow",
        Principal = {
            AWS = aws_iam_role.ec2_role.arn
        },
        Action = "s3:GetObject",
        Resource = "${aws_s3_bucket.s3b.arn}/*"
      }
    ]
  })
}

