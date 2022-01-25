# Custom Key policy template

data "template_file" "kms_key_policy_template" {
  template = "${file("../../blueprints/common_templates/iam_policies/kms_key_policy")}"
  vars {
    aws_account_id = "${data.aws_caller_identity.current.account_id}"
    env_prefix = "ss-prod"
  }
}


# Blueprint for the custom KMS keys

resource "aws_kms_key" "sqs_kms_key" {
  description = "SQS Encryption key"
  policy = "${data.template_file.kms_key_policy_template.rendered}"			
}