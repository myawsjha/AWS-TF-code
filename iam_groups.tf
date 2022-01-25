data "aws_iam_group" "S3_Website_Content_Mgmt" {
  group_name = "S3_Website_Content_Mgmt"
}

data "aws_iam_policy_document" "S3_Website_Content_Mgmt_Policy" {
    statement {
            sid = "Stmt1499780265000"
            effect = "Allow"
            actions = [
                "s3:DeleteObject",
                "s3:GetBucketWebsite",
                "s3:GetObject",
                "s3:ListBucket",
                "s3:PutObject",
                "s3:RestoreObject"
            ]
            resources = [
                "arn:aws:s3:::static.nationaltrust.org.uk",
                "arn:aws:s3:::static.nationaltrust.org.uk/*"
            ]
        }
}

resource "aws_iam_policy" "S3_Website_Content_Mgmt_Policy" {
    name = "S3_Website_Content_Mgmt_Policy"
    path = "/"
    description = "Policy to allow NTT users to administer s3 bucket - panoramas.nationaltrust.org.uk / static.nationaltrust.org.uk"
    policy = "${data.aws_iam_policy_document.S3_Website_Content_Mgmt_Policy.json}"
}

resource "aws_iam_policy_attachment" "S3_Website_Content_Mgmt_attachment" {
    name = "S3_Website_Content_Mgmt_attachment"
    groups = ["S3_Website_Content_Mgmt"]
    policy_arn = "${aws_iam_policy.S3_Website_Content_Mgmt_Policy.arn}"
}