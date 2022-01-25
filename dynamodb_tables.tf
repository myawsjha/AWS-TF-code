#-----------------------------------------------------
# DynamoDB Tables - COMMEMORATIVE_MAP_PIN
#-----------------------------------------------------

resource "aws_dynamodb_table" "COMMEMORATIVE_MAP_PIN" {
  name           = "COMMEMORATIVE_MAP_PIN"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "PLACE_ID"
  range_key      = "DONATION_ID"

  attribute {
    name = "PLACE_ID"
    type = "S"
  }

  attribute {
    name = "DONATION_ID"
    type = "S"
  }

  attribute {
    name = "MODERATION_STATUS"
    type = "S"
  }

  attribute {
    name = "CREATED"
    type = "S"
  }

  ttl {
    attribute_name = "EXPIRY_TIMESTAMP"
    enabled        = true
  }

  global_secondary_index {
    name               = "MODERATION_STATUS_BY_CREATED_IDX"
    hash_key           = "MODERATION_STATUS"
    range_key          = "CREATED"
    projection_type    = "ALL"
  }

  global_secondary_index {
    name               = "DONATION_ID_IDX"
    hash_key           = "DONATION_ID"
    projection_type    = "ALL"
  }

  local_secondary_index {
    name               = "PLACE_ID_BY_CREATED_IDX"
    range_key          = "CREATED"
    projection_type    = "ALL"
  }

  point_in_time_recovery {
    enabled            = true
  }

}

#-----------------------------------------------------
# DynamoDB Tables - UGC_CHANGELOG
#-----------------------------------------------------

resource "aws_dynamodb_table" "UGC_CHANGELOG" {
  name           = "UGC_CHANGELOG"
  billing_mode   = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "changeId"

  attribute {
    name = "changeId"
    type = "S"
  }

  point_in_time_recovery {
    enabled      = true
  }

}

#-----------------------------------------------------
# DynamoDB Tables - UGC_LOCK
#-----------------------------------------------------

resource "aws_dynamodb_table" "UGC_LOCK" {
  name           = "UGC_LOCK"
  billing_mode   = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "lockId"

  attribute {
    name = "lockId"
    type = "S"
  }

  ttl {
    attribute_name = "lockedTimestamp"
    enabled        = true
  }

  point_in_time_recovery {
    enabled        = true
  }

}

#-----------------------------------------------------
# DynamoDB Tables - YOUR_STORY
#-----------------------------------------------------

resource "aws_dynamodb_table" "YOUR_STORY" {
  name           = "YOUR_STORY"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }

  attribute {
    name = "CREATED"
    type = "S"
  }

  attribute {
    name = "MODERATION_STATUS"
    type = "S"
  }

  global_secondary_index {
    name               = "UGC_YOUR_STORY_CREATION_IDX"
    hash_key           = "MODERATION_STATUS"
    range_key          = "CREATED"
    projection_type    = "ALL"
  }

  point_in_time_recovery {
    enabled            = true
  }

}

#-----------------------------------------------------
# DynamoDB Tables - YOUR_STORY_SEQUENCE
#-----------------------------------------------------

resource "aws_dynamodb_table" "YOUR_STORY_SEQUENCE" {
  name           = "YOUR_STORY_SEQUENCE"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "ID"

  attribute {
    name = "ID"
    type = "N"
  }

  point_in_time_recovery {
    enabled      = true
  }

}
