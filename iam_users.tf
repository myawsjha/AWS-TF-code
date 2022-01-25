############################
# IAM USER - Vader Service #
############################

resource "aws_iam_user" "prod-vader-service" {
  name = "prod-vader-service"
  path = "/"
}

resource "aws_iam_user_policy" "prod-vader-service-policy" {
  name = "prod-vader-service-policy"
  user = "${aws_iam_user.prod-vader-service.name}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "sqs:SendMessage",
        "sqs:GetQueueUrl",
        "sqs:GetQueueAttributes"
      ],
      "Resource": [
        "arn:aws:sqs:*:409482329515:prod-PLACE-IMPORTER-Q"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF
}

########################################
# IAM USER - prod-events-editor-service #
########################################

resource "aws_iam_user" "prod-events-editor-service" {
  name = "prod-events-editor-service"
  path = "/"
}

resource "aws_iam_user_policy" "prod-events-editor-service-policy" {
  name = "prod-events-editor-service-policy"
  user = "${aws_iam_user.prod-events-editor-service.name}"

  policy = <<EOF
{
      "Version": "2012-10-17",
      "Statement": [
          {
              "Action": [
                  "sqs:SendMessage",
                  "sqs:GetQueueUrl",
                  "sqs:GetQueueAttributes"
              ],
              "Resource": [
                  "arn:aws:sqs:*:409482329515:prod-EVENTS-ETL-Q",
                  "arn:aws:sqs:*:409482329515:prod-EVENTS-CONTACTS-ETL-Q"
              ],
              "Effect": "Allow"
          }
      ]
}
EOF
}

#####################################
# IAM USER - prod-fastly-logging #
#####################################

resource "aws_iam_user" "prod-fastly-logging" {
  name = "prod-fastly-logging"
  path = "/"
}

resource "aws_iam_user_policy" "prod-fastly-logging-policy" {
  name = "prod-fastly-logging-policy"
  user = "${aws_iam_user.prod-fastly-logging.name}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Stmt1561380347281",
            "Action": [
                "s3:GetObject",
                "s3:ListBucket",
                "s3:PutObject"
            ],
            "Effect": "Allow",
            "Resource": [
                "arn:aws:s3:::nt-fastly-logs-prod",
                "arn:aws:s3:::nt-fastly-logs-prod/*"
            ]
        }
    ]
}
EOF
}
