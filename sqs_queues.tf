resource "aws_sqs_queue" "CMS-SERVICE-Q" {
  name                       = "prod-CMS-SERVICE-Q"
  delay_seconds              = 0
  visibility_timeout_seconds = 30
  max_message_size           = 65536
  message_retention_seconds  = 1209600
  receive_wait_time_seconds  = 20
  redrive_policy             = "{\"deadLetterTargetArn\":\"arn:aws:sqs:eu-west-1:409482329515:prod-DEAD-LETTER-Q\",\"maxReceiveCount\":10}"

}

resource "aws_sqs_queue" "DEAD-LETTER-Q" {
  name                       = "prod-DEAD-LETTER-Q"
  delay_seconds              = 0
  visibility_timeout_seconds = 30
  max_message_size           = 65536
  message_retention_seconds  = 1209600
  receive_wait_time_seconds  = 0
}

resource "aws_sqs_queue" "PLACE-IMPORTER-Q" {
  name                       = "prod-PLACE-IMPORTER-Q"
  delay_seconds              = 0
  visibility_timeout_seconds = 30
  max_message_size           = 65536
  message_retention_seconds  = 1209600
  receive_wait_time_seconds  = 20
  redrive_policy             = "{\"deadLetterTargetArn\":\"arn:aws:sqs:eu-west-1:409482329515:prod-DEAD-LETTER-Q\",\"maxReceiveCount\":10}"
}

resource "aws_sqs_queue" "SEARCH-CONTENT-IMPORTER-Q" {
  name                       = "prod-SEARCH-CONTENT-IMPORTER-Q"
  delay_seconds              = 0
  visibility_timeout_seconds = 30
  max_message_size           = 65536
  message_retention_seconds  = 1209600
  receive_wait_time_seconds  = 20
  redrive_policy             = "{\"deadLetterTargetArn\":\"arn:aws:sqs:eu-west-1:409482329515:prod-DEAD-LETTER-Q\",\"maxReceiveCount\":10}"
}

resource "aws_sqs_queue" "SEARCH-EVENTS-IMPORTER-Q" {
  name                       = "prod-SEARCH-EVENTS-IMPORTER-Q"
  delay_seconds              = 0
  visibility_timeout_seconds = 30
  max_message_size           = 65536
  message_retention_seconds  = 1209600
  receive_wait_time_seconds  = 20
  redrive_policy             = "{\"deadLetterTargetArn\":\"arn:aws:sqs:eu-west-1:409482329515:prod-DEAD-LETTER-Q\",\"maxReceiveCount\":10}"
}

resource "aws_sqs_queue" "SEARCH-HOLIDAYS-IMPORTER-Q" {
  name                       = "prod-SEARCH-HOLIDAYS-IMPORTER-Q"
  delay_seconds              = 0
  visibility_timeout_seconds = 30
  max_message_size           = 65536
  message_retention_seconds  = 1209600
  receive_wait_time_seconds  = 20
  redrive_policy             = "{\"deadLetterTargetArn\":\"arn:aws:sqs:eu-west-1:409482329515:prod-DEAD-LETTER-Q\",\"maxReceiveCount\":10}"
}

resource "aws_sqs_queue" "SEARCH-PLACES-IMPORTER-Q" {
  name                       = "prod-SEARCH-PLACES-IMPORTER-Q"
  delay_seconds              = 0
  visibility_timeout_seconds = 30
  max_message_size           = 65536
  message_retention_seconds  = 1209600
  receive_wait_time_seconds  = 20
  redrive_policy             = "{\"deadLetterTargetArn\":\"arn:aws:sqs:eu-west-1:409482329515:prod-DEAD-LETTER-Q\",\"maxReceiveCount\":10}"
}


resource "aws_sqs_queue" "DEAD-LETTER-Q-fifo" {
  name                       = "ss-prod-DEAD-LETTER-Q.fifo"
  delay_seconds              = 0
  visibility_timeout_seconds = 30
  max_message_size           = 65536
  message_retention_seconds  = 1209600
  receive_wait_time_seconds  = 0
  fifo_queue                 = true
}

resource "aws_sqs_queue" "MARKETING-PREFERENCES-SUBMITTER-BKP-Q-fifo" {
  name                       = "ss-prod-MARKETING-PREFERENCES-SUBMITTER-BKP-Q.fifo"
  delay_seconds              = 0
  visibility_timeout_seconds = 30
  max_message_size           = 65536
  message_retention_seconds  = 1209600
  receive_wait_time_seconds  = 20
  fifo_queue                 = true
  redrive_policy             = "{\"deadLetterTargetArn\":\"arn:aws:sqs:eu-west-1:409482329515:ss-prod-DEAD-LETTER-Q.fifo\",\"maxReceiveCount\":10}"
}

resource "aws_sqs_queue" "MARKETING-PREFERENCES-SUBMITTER-Q-fifo" {
  name                       = "ss-prod-MARKETING-PREFERENCES-SUBMITTER-Q.fifo"
  delay_seconds              = 0
  visibility_timeout_seconds = 30
  max_message_size           = 65536
  message_retention_seconds  = 1209600
  receive_wait_time_seconds  = 20
  fifo_queue                 = true
  redrive_policy             = "{\"deadLetterTargetArn\":\"arn:aws:sqs:eu-west-1:409482329515:ss-prod-DEAD-LETTER-Q.fifo\",\"maxReceiveCount\":10}"
}

resource "aws_sqs_queue" "usercontentweb" {
  name                      = "ss-prod-USERCONTENTWEB-Q"
  delay_seconds             = 0
  visibility_timeout_seconds = 30
  max_message_size          = 65536
  message_retention_seconds = 1209600
  receive_wait_time_seconds = 20
  kms_master_key_id         = "${aws_kms_key.sqs_kms_key.key_id}"
  kms_data_key_reuse_period_seconds = 1800
}

resource "aws_sqs_queue" "EVENTS-ETL-Q" {
  name                       = "prod-EVENTS-ETL-Q"
  delay_seconds              = 0
  visibility_timeout_seconds = 30
  max_message_size           = 65536
  message_retention_seconds  = 1209600
  receive_wait_time_seconds  = 20
  redrive_policy             = "{\"deadLetterTargetArn\":\"arn:aws:sqs:eu-west-1:409482329515:prod-DEAD-LETTER-Q\",\"maxReceiveCount\":10}"
}

resource "aws_sqs_queue" "EVENTS-CONTACTS-ETL-Q" {
  name                       = "prod-EVENTS-CONTACTS-ETL-Q"
  delay_seconds              = 0
  visibility_timeout_seconds = 30
  max_message_size           = 65536
  message_retention_seconds  = 1209600
  receive_wait_time_seconds  = 20
  redrive_policy             = "{\"deadLetterTargetArn\":\"arn:aws:sqs:eu-west-1:409482329515:prod-DEAD-LETTER-Q\",\"maxReceiveCount\":10}"
}







