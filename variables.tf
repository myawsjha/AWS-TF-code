#------------------------------------------------
# VPC Variables
#------------------------------------------------

variable "env"                         { default="Production"               description=" e.g. Prod" }
variable "region"                      { default="eu-west-1"      		 description="e.g. eu-west-1" }
variable "vpn_customer_gateway_id"     {}
variable "ci_prefix"                   {}            #  e.g. ntt43
variable "backup_tag"                  {}            #  e.g. ntt_poc_daily
variable "backuphourly_tag"            {}
variable "monitoring_tag"              {}
variable "s3_bucket"                   {}            #  e.g. ntt-poc
variable "key_name"                    {}            #  e.g. ntt-poc
variable "supportlvl_tag"              {}		     #  e.g. premium
variable "virtual_gateway_id"          {}
variable "prod_env"                    {}
variable "vpc_name"                    {}
variable "cidr"                        {}

variable "pfx_cidr1"                   {}
variable "pfx_id1"                     {}
variable "pfx_cidr2"                   {}
variable "pfx_id2"                     {}
variable "pfx_cidr3"                   {}
variable "pfx_id3"                     {}
variable "pfx_cidr4"                   {}
variable "pfx_id4"                     {}
variable "pfx_cidr5"                   {}
variable "pfx_id5"                     {}
variable "pfx_ens_cidr"                {}
variable "pfx_ens_id"                  {}

variable "elb_ssl_arn"                 {}
variable "amzn_lnx_ami"                {}	        #  e.g. ami-123abc
variable "redhat_65_ami"               {}
variable "redhat_69_ami"               {}
