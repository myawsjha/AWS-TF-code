#------------------------------------------------------
# ELB Security Groups
#------------------------------------------------------

resource "aws_security_group" "ELB-AGGREGATION-API" {
  name = "ELB-AGGREGATION-API"
  description = "Production VPC ELB-AGGREGATION-API Security Group"
  vpc_id = "${aws_vpc.vpc.id}"
}

resource "aws_security_group_rule" "ELB-AGGREGATION-API" {
  security_group_id = "${aws_security_group.ELB-AGGREGATION-API.id}"
  type = "ingress"
  from_port = 9096
  to_port = 9096
  protocol = "tcp"
  cidr_blocks = [ "10.73.51.16/30" ]
}

resource "aws_security_group_rule" "ELB-AGGREGATION-API-1" {
  security_group_id = "${aws_security_group.ELB-AGGREGATION-API.id}"
  type = "ingress"
  from_port = 9096
  to_port = 9096
  protocol = "tcp"
  source_security_group_id = "sg-04f7aa61"
}

resource "aws_security_group_rule" "ELB-AGGREGATION-API-2" {
  security_group_id = "${aws_security_group.ELB-AGGREGATION-API.id}"
  type = "ingress"
  from_port = 9096
  to_port = 9096
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.APP.id}"
}

resource "aws_security_group_rule" "ELB-AGGREGATION-API-3" {
  security_group_id = "${aws_security_group.ELB-AGGREGATION-API.id}"
  type = "ingress"
  from_port = 9096
  to_port = 9096
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.WCA.id}"
}

resource "aws_security_group_rule" "ELB-AGGREGATION-API-from-LAMBDA-GRAPHQL" {
  security_group_id = "${aws_security_group.ELB-AGGREGATION-API.id}"
  type = "ingress"
  from_port = 9096
  to_port = 9096
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.LAMBDA-DEPLOY-GRAPHQL-Prod.id}"
}

resource "aws_security_group_rule" "ELB-AGGREGATION-API-4" {
  security_group_id = "${aws_security_group.ELB-AGGREGATION-API.id}"
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = [ "10.73.24.0/21" ]
}

resource "aws_security_group" "ELB-EVENTS-API" {
  name = "ELB-EVENTS-API"
  description = "Production VPC ELB-EVENTS-API Security Group"
  vpc_id = "${aws_vpc.vpc.id}"
}

resource "aws_security_group_rule" "ELB-EVENTS-API" {
  security_group_id = "${aws_security_group.ELB-EVENTS-API.id}"
  type = "ingress"
  from_port = 9095
  to_port = 9095
  protocol = "tcp"
  cidr_blocks = [ "10.73.51.16/30" ]
}

resource "aws_security_group_rule" "ELB-EVENTS-API-1" {
  security_group_id = "${aws_security_group.ELB-EVENTS-API.id}"
  type = "ingress"
  from_port = 9095
  to_port = 9095
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.APP.id}"
}

resource "aws_security_group_rule" "ELB-EVENTS-API-2" {
  security_group_id = "${aws_security_group.ELB-EVENTS-API.id}"
  type = "ingress"
  from_port = 9095
  to_port = 9095
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.WCA.id}"
}

resource "aws_security_group_rule" "ELB-EVENTS-API-3" {
  security_group_id = "${aws_security_group.ELB-EVENTS-API.id}"
  type = "ingress"
  from_port = 9095
  to_port = 9095
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.API.id}"
}

resource "aws_security_group_rule" "ELB-EVENTS-API-4" {
  security_group_id = "${aws_security_group.ELB-EVENTS-API.id}"
  type = "ingress"
  from_port = 9095
  to_port = 9095
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.ETL.id}"
}

resource "aws_security_group_rule" "ELB-EVENTS-API-5" {
  security_group_id = "${aws_security_group.ELB-EVENTS-API.id}"
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = [ "10.73.24.0/21" ]
}

resource "aws_security_group" "ELB-Personalisation-API" {
  name = "ELB-Personalisation-API"
  description = "Production VPC ELB-PersonalisationAPI Security Group"
  vpc_id = "${aws_vpc.vpc.id}"
}

resource "aws_security_group_rule" "ELB-Personalisation-API" {
  security_group_id = "${aws_security_group.ELB-Personalisation-API.id}"
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = [ "10.73.24.0/21" ]
}

resource "aws_security_group_rule" "ELB-Personalisation-API-1" {
  security_group_id = "${aws_security_group.ELB-Personalisation-API.id}"
  type = "ingress"
  from_port = 9101
  to_port = 9101
  protocol = "tcp"
  source_security_group_id = "sg-04f7aa61"
}

resource "aws_security_group_rule" "ELB-Personalisation-API-2" {
  security_group_id = "${aws_security_group.ELB-Personalisation-API.id}"
  type = "ingress"
  from_port = 9101
  to_port = 9101
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.APP.id}"
}

resource "aws_security_group" "ELB-PLACES-API" {
  name = "ELB-PLACES-API"
  description = "Production VPC ELB-PLACES-API Security Group"
  vpc_id = "${aws_vpc.vpc.id}"
}

resource "aws_security_group_rule" "ELB-PLACES-API" {
  security_group_id = "${aws_security_group.ELB-PLACES-API.id}"
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = [ "10.73.24.0/21" ]
}

resource "aws_security_group_rule" "ELB-PLACES-API-1" {
  security_group_id = "${aws_security_group.ELB-PLACES-API.id}"
  type = "ingress"
  from_port = 9094
  to_port = 9094
  protocol = "tcp"
  cidr_blocks = [ "10.73.51.16/30" ]
}

resource "aws_security_group_rule" "ELB-PLACES-API-2" {
  security_group_id = "${aws_security_group.ELB-PLACES-API.id}"
  type = "ingress"
  from_port = 9094
  to_port = 9094
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.APP.id}"
}

resource "aws_security_group_rule" "ELB-PLACES-API-3" {
  security_group_id = "${aws_security_group.ELB-PLACES-API.id}"
  type = "ingress"
  from_port = 9094
  to_port = 9094
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.WCA.id}"
}

resource "aws_security_group_rule" "ELB-PLACES-API-4" {
  security_group_id = "${aws_security_group.ELB-PLACES-API.id}"
  type = "ingress"
  from_port = 9094
  to_port = 9094
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.API.id}"
}

resource "aws_security_group_rule" "ELB-PLACES-API-5" {
  security_group_id = "${aws_security_group.ELB-PLACES-API.id}"
  type = "ingress"
  from_port = 9094
  to_port = 9094
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.ETL.id}"
}

resource "aws_security_group_rule" "ELB-PLACES-API-6" {
  security_group_id = "${aws_security_group.ELB-PLACES-API.id}"
  type = "ingress"
  from_port = 9094
  to_port = 9094
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.VADER.id}"
}

resource "aws_security_group" "ELB-TaxonomyAPI" {
  name = "ELB-TaxonomyAPI"
  description = "Production VPC ELB-TaxonomyAPI Security Group"
  vpc_id = "${aws_vpc.vpc.id}"
}

resource "aws_security_group_rule" "ELB-TaxonomyAPI" {
  security_group_id = "${aws_security_group.ELB-TaxonomyAPI.id}"
  type = "ingress"
  from_port = 9097
  to_port = 9097
  protocol = "tcp"
  cidr_blocks = [ "10.90.0.80/32" ]
}

resource "aws_security_group_rule" "ELB-TaxonomyAPI-1" {
  security_group_id = "${aws_security_group.ELB-TaxonomyAPI.id}"
  type = "ingress"
  from_port = 9097
  to_port = 9097
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.APP.id}"
}

resource "aws_security_group_rule" "ELB-TaxonomyAPI-2" {
  security_group_id = "${aws_security_group.ELB-TaxonomyAPI.id}"
  type = "ingress"
  from_port = 9097
  to_port = 9097
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.WCA.id}"
}

resource "aws_security_group_rule" "ELB-TaxonomyAPI-3" {
  security_group_id = "${aws_security_group.ELB-TaxonomyAPI.id}"
  type = "ingress"
  from_port = 9097
  to_port = 9097
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.VADER.id}"
}

resource "aws_security_group_rule" "ELB-TaxonomyAPI-4" {
  security_group_id = "${aws_security_group.ELB-TaxonomyAPI.id}"
  type = "ingress"
  from_port = 9097
  to_port = 9097
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.API.id}"
}

resource "aws_security_group_rule" "ELB-TaxonomyAPI-5" {
  security_group_id = "${aws_security_group.ELB-TaxonomyAPI.id}"
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = [ "10.73.24.0/21" ]
}

resource "aws_security_group" "ELB-WCA" {
  name = "ELB-WCA"
  description = "Production VPC ELB-WCA (Web Center Authoring) Security Group"
  vpc_id = "${aws_vpc.vpc.id}"
}

resource "aws_security_group_rule" "ELB-WCA" {
  security_group_id = "${aws_security_group.ELB-WCA.id}"
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = [ "10.0.0.0/8" ]
}

resource "aws_security_group_rule" "ELB-WCA-1" {
  security_group_id = "${aws_security_group.ELB-WCA.id}"
  type = "ingress"
  from_port = 443
  to_port = 443
  protocol = "tcp"
  cidr_blocks = [ "10.0.0.0/8" ]
}

resource "aws_security_group_rule" "ELB-WCA-2" {
  security_group_id = "${aws_security_group.ELB-WCA.id}"
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = [ "10.73.24.0/21" ]
}

resource "aws_security_group" "ELB-WEB-EXTERNAL" {
  name = "ELB-WEB-EXTERNAL"
  description = "Production VPC ELB-WEB-EXTERNAL Security Group"
  vpc_id = "${aws_vpc.vpc.id}"
}

resource "aws_security_group_rule" "ELB-WEB-EXTERNAL" {
  security_group_id = "${aws_security_group.ELB-WEB-EXTERNAL.id}"
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = [ "0.0.0.0/0" ]
}

resource "aws_security_group_rule" "ELB-WEB-EXTERNAL-1" {
  security_group_id = "${aws_security_group.ELB-WEB-EXTERNAL.id}"
  type = "ingress"
  from_port = 443
  to_port = 443
  protocol = "tcp"
  cidr_blocks = [ "0.0.0.0/0" ]
}

resource "aws_security_group_rule" "ELB-WEB-EXTERNAL-2" {
  security_group_id = "${aws_security_group.ELB-WEB-EXTERNAL.id}"
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = [ "10.73.24.0/21" ]
}

resource "aws_security_group" "ELB-WEB-INTERNAL" {
  name = "ELB-WEB-INTERNAL"
  description = "Production VPC ELB-WEB-INTERNAL Security Group"
  vpc_id = "${aws_vpc.vpc.id}"
}


resource "aws_security_group_rule" "ELB-WEB-INTERNAL" {
  security_group_id = "${aws_security_group.ELB-WEB-INTERNAL.id}"
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = [ "10.0.0.0/8" ]
}

resource "aws_security_group_rule" "ELB-WEB-INTERNAL-1" {
  security_group_id = "${aws_security_group.ELB-WEB-INTERNAL.id}"
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.ETL.id}"
}

resource "aws_security_group_rule" "ELB-WEB-INTERNAL-2" {
  security_group_id = "${aws_security_group.ELB-WEB-INTERNAL.id}"
  type = "ingress"
  from_port = 443
  to_port = 443
  protocol = "tcp"
  cidr_blocks = [ "10.0.0.0/8" ]
}

resource "aws_security_group_rule" "ELB-WEB-INTERNAL-3" {
  security_group_id = "${aws_security_group.ELB-WEB-INTERNAL.id}"
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = [ "10.73.24.0/21" ]
}
