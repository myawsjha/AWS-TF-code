#------------------------------------------------
# S3_Access-EFS-Backups IAM Role
#------------------------------------------------
resource "aws_iam_role" "s3-efs-backups" {
  name = "S3_Access-EFS-Backups"
  description = "Allow EC2 access to S3 to backup EFS"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

data "aws_iam_policy_document" "s3-efs-backups_iam_policy" {
    statement {
            sid = "S3Access"
            effect= "Allow"
            actions = [
                "s3:Get*",
                "s3:List*"
            ]
            resources = ["*"]
    }

	statement {
            sid = "EC2Access"
            effect = "Allow"
            actions =  [
                "ec2:DescribeTags"
            ]
            resources =  ["*"]
    }
    
	statement {
            effect = "Allow"
            actions = [
                "s3:PutObject",
                "s3:GetObject",
                "s3:DeleteObject"
            ]
            resources = [
                "arn:aws:s3:::fs*"
            ]
    }
    
	statement {
            sid = "AllowCWPutCustomMetrics"
            effect = "Allow"
            actions = ["cloudwatch:PutMetricData"]
            resources = ["*"]
    }
}

resource "aws_iam_instance_profile" "s3-efs-backups_instance_profile" {
    name = "S3_Access-EFS-Backups"
    roles = ["${aws_iam_role.s3-efs-backups.name}"]
}

resource "aws_iam_policy" "s3-efs-backups_policy" {
    name = "S3-Access-EFSBackups"
    path = "/"
    policy = "${data.aws_iam_policy_document.s3-efs-backups_iam_policy.json}"
}

#Unable to import attachment information - left for reference
#resource "aws_iam_policy_attachment" "s3-efs-backups_attachment" {
#    name = "XXX"
#    roles = ["${aws_iam_role.s3-efs-backups.name}"]
#    policy_arn = "${aws_iam_policy.s3-efs-backups_policy.arn}"
#}