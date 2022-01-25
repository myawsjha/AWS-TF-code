#-----------------------------------------------------------------
# IAM Roles
#-----------------------------------------------------------------

#module iam_role_s3_access-efs-backups {
#  source  = "../../modules/aws/iam_role"
#  name    = "S3_Access-EFS-Backups"
#  policy  = "${file("../../blueprints/production/files/iam_policies/:.tf")}"
#}

# Bluprints for IAM-Role module

module iam_role_lambda_submitter {
  source  = "../../modules/aws/iam_role"
  name    = "lambdaSubmitter"
  principal_type = "service"
  principal_service_allowed_service = "lambda.amazonaws.com"
  policy  = "${data.template_file.kms_key_use_policy_template.rendered}"
}

resource "aws_iam_role" "Config_Mgr_DelegatedRole" {
  name = "Config_Mgr_DelegatedRole"
  assume_role_policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "AWS": "arn:aws:iam::066548920687:root"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  }
EOF
}


resource "aws_iam_role_policy" "Config_Mgr_Delegated" {
  name = "Config_Mgr_Delegated"
  role = "${aws_iam_role.Config_Mgr_DelegatedRole.id}"

  policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
  {
      "Sid": "VisualEditor0",
      "Effect": "Allow",
      "Action": [
          "ec2:CreateSnapshot",
          "ec2:CreateTags",
          "ec2:CreateImage",
          "ec2:DescribeAddresses",
          "ec2:DescribeAvailabilityZones",
          "ec2:DescribeInstanceAttribute",
          "ec2:DescribeImages",
          "ec2:DescribeInstanceStatus",
          "ec2:DescribeInstances",
          "ec2:DescribeKeyPairs",
          "ec2:DescribePlacementGroups",
          "ec2:DescribeRegions",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeSnapshotAttribute",
          "ec2:DescribeSnapshots",
          "ec2:DescribeSubnets",
          "ec2:DescribeTags",
          "ec2:DescribeVolumeAttribute",
          "ec2:DescribeVolumeStatus",
          "ec2:DescribeVolumes",
          "ec2:ModifyImageAttribute",
          "ec2:ModifySnapshotAttribute",
          "ec2:ResetSnapshotAttribute"
      ],
      "Resource": [
          "*"
      ]
  },
  {
      "Sid": "VisualEditor1",
      "Effect": "Allow",
      "Action": [
          "iam:CreateAccessKey",
          "iam:DeleteAccessKey",
          "iam:GetAccessKeyLastUsed",
          "iam:ListAccessKeys",
          "iam:UpdateAccessKey"
      ],
      "Resource": [
          "arn:aws:iam::409482329515:user/icinga",
          "arn:aws:iam::409482329515:user/prod-CMSService",
          "arn:aws:iam::409482329515:user/prod-events-editor-service",
          "arn:aws:iam::409482329515:user/prod-EventsETL",
          "arn:aws:iam::409482329515:user/prod-EventsETLAdmin",
          "arn:aws:iam::409482329515:user/prod-EventsETLPoller",
          "arn:aws:iam::409482329515:user/prod-EventsETLScheduler",
          "arn:aws:iam::409482329515:user/prod-PlacesImporter",
          "arn:aws:iam::409482329515:user/prod-SearchContentImporter",
          "arn:aws:iam::409482329515:user/prod-SearchEventsImporter",
          "arn:aws:iam::409482329515:user/prod-SearchHolidaysImporter",
          "arn:aws:iam::409482329515:user/prod-SearchPlacesImporter",
          "arn:aws:iam::409482329515:user/prod-WCS",
          "arn:aws:iam::409482329515:user/prod-cms-service",
          "arn:aws:iam::409482329515:user/prod-eventsapi-etl",
          "arn:aws:iam::409482329515:user/prod-placesapi-importer",
          "arn:aws:iam::409482329515:user/prod-search-content-importer",
          "arn:aws:iam::409482329515:user/prod-search-events-importer",
          "arn:aws:iam::409482329515:user/prod-search-holidays-importer",
          "arn:aws:iam::409482329515:user/prod-search-places-importer",
          "arn:aws:iam::409482329515:user/ss-prod-ugc-service",
          "arn:aws:iam::409482329515:user/ss-prod-UserContentWeb",
          "arn:aws:iam::409482329515:user/prod-OneAdvancedAttendeesReader",
          "arn:aws:iam::409482329515:user/ss-prod-donate",
          "arn:aws:iam::409482329515:user/Jenkins",
          "arn:aws:iam::409482329515:user/prod-vader-service",
          "arn:aws:iam::409482329515:user/ss-prod-donate-stock-images-writer"
      ]
  }
 ]
}
EOF
}
