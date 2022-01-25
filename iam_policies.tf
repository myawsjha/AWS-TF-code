# Data source for the Account_id
data "aws_caller_identity" "current" {}

# SQS Owner IAM policy

data "template_file" "usercontent_sqs_owner_policy_template" {
  template = "${file("../../blueprints/production/templates/iam_policies/sqs_owner_policy")}"
  vars {
    aws_sqs_q = "${aws_sqs_queue.usercontentweb.arn}"
    }
}

resource "aws_iam_policy" "usercontent_sqs_owner_policy" {
    name = "ss-prod-UGCOwner"
    description = "Policy to acecss SQS queue"
    policy = "${data.template_file.usercontent_sqs_owner_policy_template.rendered}"
}

# Create the policy to use the KMS key for SQS encrypt/decrypt

data "template_file" "kms_key_use_policy_template" {
  template = "${file("../../blueprints/common_templates/iam_policies/kms_use_policy")}"
  vars {
    aws_account_id = "${data.aws_caller_identity.current.account_id}"
    kms_key_id = "${aws_kms_key.sqs_kms_key.key_id}"
  }
}

resource "aws_iam_policy" "sqs_kms_decrypt" {
    name = "prod-sqs-kms-decrypt-policy"
    description = "Policy to decrypt SQS using KMS key"
    policy = "${data.template_file.kms_key_use_policy_template.rendered}"
}

# Access Key Self-Manage IAM policy

data "template_file" "iam_key_mgmt_policy_template" {
  template = "${file("../../blueprints/common_templates/iam_policies/iam_key_mgmt_policy")}"
  vars {
    aws_account_id = "${data.aws_caller_identity.current.account_id}"
  }
}

resource "aws_iam_policy" "iam_key_mgmt_policy" {
    name = "access-key-self-manage"
    description = "Policy to manage owned IAM access keys"
    policy = "${data.template_file.iam_key_mgmt_policy_template.rendered}"
}

# ACM certificate-import IAM policy

data "template_file" "acm_cert_import_policy_template" {
  template = "${file("../../blueprints/common_templates/iam_policies/acm_cert_import_policy")}"
  vars {
    aws_account_id = "${data.aws_caller_identity.current.account_id}"
  }
}

resource "aws_iam_policy" "acm_cert_import_policy" {
    name = "acm_cert_import"
    description = "Policy to allow NTWebops users to import certificates into ACM"
    policy = "${data.template_file.acm_cert_import_policy_template.rendered}"
}

############################################
# NT Web Ops - CloudWatch Dashboard Access #
############################################

data "aws_iam_policy_document" "CloudWatch_Dash_Admin_Policy_Doc" {
    statement {
            sid = "CWDashAdm"
            effect = "Allow"
            actions = [
                "cloudwatch:GetDashboard",
				"cloudwatch:ListDashboards",
				"cloudwatch:PutDashboard",
				"cloudwatch:DeleteDashboards"
            ]
            resources = [ "*" ]
        }
}

resource "aws_iam_policy" "CloudWatch_Dash_Admin_Policy" {
    name = "CloudWatch_Dash_Admin_Policy"
    path = "/"
    description = "CloudWatch Dash Admin Policy"
    policy = "${data.aws_iam_policy_document.CloudWatch_Dash_Admin_Policy_Doc.json}"
}

resource "aws_iam_policy_attachment" "CloudWatch_Dash_Admin_Policy_Attachment" {
    name = "CloudWatch_Dash_Admin_Policy_Attachment"
    groups = ["NT_Web_Operations"]
    policy_arn = "${aws_iam_policy.CloudWatch_Dash_Admin_Policy.arn}"
}