#------------------------------------------------
# S3 buckets
#------------------------------------------------

#------------------------------------------------
# Create nt-mobile-app-editorial
#------------------------------------------------
resource "aws_s3_bucket" "nt-mobile-app-editorial" {
  bucket = "nt-mobile-app-editorial"
  acl    = "public-read"
  policy = "${data.aws_iam_policy_document.nt-mobile-app-editorial.json}"
  region = "${var.region}"

  tags {
    Name        = "nt-mobile-app-editorial"
    Environment = "${var.prod_env}"
  }
}

data "aws_iam_policy_document" "nt-mobile-app-editorial" {
	statement {
            sid = "Allow get requests originating from referer"
			principals {
               type = "AWS"
               identifiers = ["*"]
            }
            effect =  "Allow"
            actions =  [
                  "s3:GetObject"
                  ]
            resources =  [
               "arn:aws:s3:::nt-mobile-app-editorial/*"
            ]
	}
        statement {
            sid = "Stmt1559809615145"
                        principals {
               type = "AWS"
               identifiers = [
                               "225427562671",
                               "091618815818",
                               "582959973301",
                               "409482329515",
                               "arn:aws:iam::582959973301:user/preprod-WCS",
                               "arn:aws:iam::091618815818:user/test-WCS",
                               "arn:aws:iam::091618815818:user/devint-WCS",
                               "arn:aws:iam::225427562671:user/cie-WCS"
                             ]
            }
            effect =  "Allow"
            actions =  [
                  "s3:GetObject",
                  "s3:ListBucket"
                  ]
            resources =  [
               "arn:aws:s3:::nt-mobile-app-editorial/*",
               "arn:aws:s3:::nt-mobile-app-editorial"
            ]
        }
}

resource "aws_s3_bucket_object" "nt-mobile-app-editorial-app-folder" {
 bucket = "${aws_s3_bucket.nt-mobile-app-editorial.id}"
 acl    = "public-read"
 key    = "app/"
 source = "/dev/null"
}

#------------------------------------------------
# Create nt-mobile-app-delivery
#------------------------------------------------

resource "aws_s3_bucket" "nt-mobile-app-delivery" {
  bucket = "nt-mobile-app-delivery"
  acl    = "public-read"
  policy = "${data.aws_iam_policy_document.nt-mobile-app-delivery.json}"
  region = "${var.region}"

  tags {
    Name        = "nt-mobile-app-delivery"
    Environment = "${var.prod_env}"
  }
}

data "aws_iam_policy_document" "nt-mobile-app-delivery" {
        statement {
            sid = "Allow get requests originating from referer"
                        principals {
               type = "AWS"
               identifiers = ["*"]
            }
            effect =  "Allow"
            actions =  [
                  "s3:GetObject"
                  ]
            resources =  [
               "arn:aws:s3:::nt-mobile-app-delivery/*"
            ]
        }
}

resource "aws_s3_bucket_object" "nt-mobile-app-delivery-app-folder" {
 bucket = "${aws_s3_bucket.nt-mobile-app-delivery.id}"
 acl    = "public-read"
 key    = "app/"
 source = "/dev/null"
}

#------------------------------------------------
# Create s3 static web site
#------------------------------------------------

resource "aws_s3_bucket" "static_prd" {
  bucket = "static.nationaltrust.org.uk"
  acl    = "private"

  tags {
    Name            = "static.nationaltrust.org.uk"
    Enviornment     = "${var.prod_env}"
   }
  
  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  logging {
    target_bucket = "${aws_s3_bucket.static_prd-logs.id}"
    target_prefix = "log/"
  }
}

resource "aws_s3_bucket_policy" "static_prd_bucket_policy" {
  bucket = "${aws_s3_bucket.static_prd.id}"
  policy =<<POLICY
{
    "Version": "2012-10-17",
    "Id": "Policy1499961163009",
    "Statement": [
        {
            "Sid": "Stmt1499961157682",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::static.nationaltrust.org.uk/*"
        }
    ]
}
POLICY
}

#------------------------------------------------
# Create Static bucket logging Bucket
#------------------------------------------------

resource "aws_s3_bucket" "static_prd-logs" {
  bucket = "static-prd-logs"
  acl    = "log-delivery-write"
  
    lifecycle_rule {
    id = "Expire objects older than 14 days"
    enabled = true
    
	expiration {
      days = 14
	}
  }

  tags {
    Name            = "static-prd-logs"
    Enviornment     = "${var.prod_env}"
   }
}

#------------------------------------------------
# Create ntt-prod-oneadvanced-attendees Bucket
#------------------------------------------------

resource "aws_s3_bucket" "ntt-prod-oneadvanced-attendees" {
  bucket = "ntt-prod-oneadvanced-attendees"
  acl    = "private"
  
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "AES256"
      }
    }
  }

  logging {
    target_bucket = "${aws_s3_bucket.ntt_prod_S3_logging.id}"
    target_prefix = "log/"
  }
    
  tags {
    Name        = "ntt-prod-oneadvanced-attendees"
	Environment = "${var.env}"
  }
}

#------------------------------------------------
# Create ntt-prod-oneadvanced-archive Bucket
#------------------------------------------------

resource "aws_s3_bucket" "ntt-prod-oneadvanced-archive" {
  bucket = "ntt-prod-oneadvanced-archive"
  acl    = "private"
  
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "AES256"
      }
    }
  }

  logging {
    target_bucket = "${aws_s3_bucket.ntt_prod_S3_logging.id}"
    target_prefix = "log/"
  }

  versioning {
    enabled = true
  }
    
  tags {
    Name        = "ntt-prod-oneadvanced-archive"
	Environment = "${var.env}"
  }
}

resource "aws_s3_bucket" "ntt_prod_S3_logging" {
   bucket = "ntt-prod-s3-logging"
   acl    = "log-delivery-write"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "AES256"
      }
    }
  }
  
  lifecycle_rule {
    id = "Expire objects older than 14 days"
    enabled = true
    
	expiration {
      days = 14
	}
  }

  tags {
    Name = "ntt-prod-s3-logging"
    Environment = "${var.env}"
  }

}

#------------------------------------------------
# Create nt-fastly-logs-prod Bucket
#------------------------------------------------

resource "aws_s3_bucket" "nt-fastly-logs-prod" {
  bucket = "nt-fastly-logs-prod"
  acl    = "private"
  lifecycle_rule {
  enabled = true
    expiration {
      days = 14
    }
  }
  tags {
        Name        = "nt-fastly-logs-prod"
        Environment = "${var.env}"
  }
}
