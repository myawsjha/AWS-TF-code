#------------------------------------------------------
# RDS-Postgres-Taxonomy
#------------------------------------------------------
resource "aws_security_group" "RDSPostGresTaxonomy" {
  name = "RDS-Postgres-Taxonomy"
  description = "Production RDS-Postgres Taxonomy Security Group"
  vpc_id = "${aws_vpc.vpc.id}"
}

resource "aws_security_group_rule" "RDSPostGresTaxonomy" {
  security_group_id = "${aws_security_group.RDSPostGresTaxonomy.id}"
  type = "ingress"
  from_port = 5432
  to_port = 5432
  protocol = "tcp"
  cidr_blocks = [ "10.0.0.0/8" ]
}

resource "aws_security_group_rule" "RDSPostGresTaxonomy-1" {
  security_group_id = "${aws_security_group.RDSPostGresTaxonomy.id}"
  type = "ingress"
  from_port = 5432
  to_port = 5432
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.API.id}"
}

resource "aws_security_group_rule" "RDSPostGresTaxonomy-2" {
  security_group_id = "${aws_security_group.RDSPostGresTaxonomy.id}"
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = [ "0.0.0.0/0" ]
}

resource "aws_security_group" "RDS-EXTCIE01" {
  name = "RDS-EXTCIE01"
  description = "Production VPC RDS-EXTCIE01 Security Group"
  vpc_id = "${aws_vpc.vpc.id}"
}

resource "aws_security_group_rule" "RDS-EXTCIE01" {
  security_group_id = "${aws_security_group.RDS-EXTCIE01.id}"
  type = "ingress"
  from_port = 1522
  to_port = 1529
  protocol = "tcp"
  cidr_blocks = [ "10.90.0.0/16", "10.34.64.0/24", "10.138.80.0/24", "10.139.0.0/22", "172.19.248.0/23", "10.142.120.0/22", "10.142.124.0/22", "10.91.0.0/16", "10.143.0.0/16" ]
}

resource "aws_security_group_rule" "RDS-EXTCIE01-1" {
  security_group_id = "${aws_security_group.RDS-EXTCIE01.id}"
  type = "ingress"
  from_port = 1522
  to_port = 1522
  protocol = "tcp"
  cidr_blocks = [ "10.73.19.11/32", "10.44.245.85/32", "10.73.19.10/32" ]
}

resource "aws_security_group_rule" "RDS-EXTCIE01-2" {
  security_group_id = "${aws_security_group.RDS-EXTCIE01.id}"
  type = "ingress"
  from_port = 1522
  to_port = 1522
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.WCD.id}"
}


resource "aws_security_group_rule" "RDS-EXTCIE01-3" {
  security_group_id = "${aws_security_group.RDS-EXTCIE01.id}"
  type = "ingress"
  from_port = 1522
  to_port = 1522
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.API.id}"
}


resource "aws_security_group_rule" "RDS-EXTCIE01-4" {
  security_group_id = "${aws_security_group.RDS-EXTCIE01.id}"
  type = "ingress"
  from_port = 1522
  to_port = 1522
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.ETL.id}"
}


resource "aws_security_group_rule" "RDS-EXTCIE01-5" {
  security_group_id = "${aws_security_group.RDS-EXTCIE01.id}"
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = [ "0.0.0.0/0" ]
}



resource "aws_security_group" "RDS-INTCIE01" {
  name = "RDS-INTCIE01"
  description = "Production VPC RDS-INTCIE01 Security Group"
  vpc_id = "${aws_vpc.vpc.id}"
}

resource "aws_security_group_rule" "RDS-INTCIE01" {
  security_group_id = "${aws_security_group.RDS-INTCIE01.id}"
  type = "ingress"
  from_port = 1522
  to_port = 1529
  protocol = "tcp"
  cidr_blocks = [ "10.138.80.0/24", "10.139.0.0/22", "10.142.120.0/22", "10.142.124.0/22", "10.34.64.0/24", "10.90.0.0/16", "10.91.0.0/16", "10.143.0.0/16", "172.19.248.0/23" ]
}

resource "aws_security_group_rule" "RDS-INTCIE01-1" {
  security_group_id = "${aws_security_group.RDS-INTCIE01.id}"
  type = "ingress"
  from_port = 1522
  to_port = 1522
  protocol = "tcp"
  cidr_blocks = [ "10.44.245.85/32", "10.73.19.10/32", "10.73.19.11/32" ]
}

resource "aws_security_group_rule" "RDS-INTCIE01-2" {
  security_group_id = "${aws_security_group.RDS-INTCIE01.id}"
  type = "ingress"
  from_port = 1522
  to_port = 1522
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.VADER.id}"
}

resource "aws_security_group_rule" "RDS-INTCIE01-3" {
  security_group_id = "${aws_security_group.RDS-INTCIE01.id}"
  type = "ingress"
  from_port = 1522
  to_port = 1522
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.WCA.id}"
}

resource "aws_security_group_rule" "RDS-INTCIE01-4" {
  security_group_id = "${aws_security_group.RDS-INTCIE01.id}"
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = [ "0.0.0.0/0" ]
}





resource "aws_security_group" "RDS-Postgres-EVENTS" {
  name = "RDS-Postgres-EVENTS"
  description = "Production VPC RDS-Postgres Events Security Group"
  vpc_id = "${aws_vpc.vpc.id}"
}

resource "aws_security_group_rule" "RDS-Postgres-EVENTS" {
  security_group_id = "${aws_security_group.RDS-Postgres-EVENTS.id}"
  type = "ingress"
  from_port = 5432
  to_port = 5432
  protocol = "tcp"
  cidr_blocks = [ "10.90.0.0/16", "10.142.120.0/22", "10.142.124.0/22", "10.34.64.0/24", "10.138.80.0/24", "10.139.0.0/22", "172.19.248.0/23", "10.73.19.11/32", "10.44.245.85/32", "10.91.0.0/16", "10.143.0.0/16" ]
}

resource "aws_security_group_rule" "RDS-Postgres-EVENTS-1" {
  security_group_id = "${aws_security_group.RDS-Postgres-EVENTS.id}"
  type = "ingress"
  from_port = 5432
  to_port = 5432
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.VADER.id}"
}

resource "aws_security_group_rule" "RDS-Postgres-EVENTS-2" {
  security_group_id = "${aws_security_group.RDS-Postgres-EVENTS.id}"
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = [ "0.0.0.0/0" ]
}



resource "aws_security_group" "RDS-Postgres-EVENTS-DBS08" {
  name = "RDS-Postgres-EVENTS-DBS08"
  description = "Production VPC RDS-Postgres Events Security Group-RDS-DBS08"
  vpc_id = "${aws_vpc.vpc.id}"
}

resource "aws_security_group_rule" "RDS-Postgres-EVENTS-DBS08" {
  security_group_id = "${aws_security_group.RDS-Postgres-EVENTS-DBS08.id}"
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = [ "0.0.0.0/0" ]
}

resource "aws_security_group_rule" "RDS-Postgres-EVENTS-DBS08-1" {
  security_group_id = "${aws_security_group.RDS-Postgres-EVENTS-DBS08.id}"
  type = "ingress"
  from_port = 5432
  to_port = 5432
  protocol = "tcp"
  cidr_blocks = [ "10.73.19.10/32", "10.73.19.11/32", "10.73.27.15/32", "10.73.27.14/32", "10.90.0.0/16", "10.142.120.0/22", "10.142.124.0/22", "10.91.0.0/16", "10.143.0.0/16" ]
}




resource "aws_security_group" "RDS-Postgres-VADER" {
  name = "RDS-Postgres-VADER"
  description = "Production VPC RDS-Postgres Security Group"
  vpc_id = "${aws_vpc.vpc.id}"
}

resource "aws_security_group_rule" "RDS-Postgres-VADER" {
  security_group_id = "${aws_security_group.RDS-Postgres-VADER.id}"
  type = "ingress"
  from_port = 5432
  to_port = 5432
  protocol = "tcp"
  cidr_blocks = [ "10.90.0.0/16", "10.34.64.0/24", "10.138.80.0/24", "10.139.0.0/22", "172.19.248.0/23", "10.73.19.11/32", "10.44.245.85/32", "10.142.120.0/22", "10.142.124.0/22", "10.91.0.0/16", "10.143.0.0/16", "10.73.19.10/32" ]
}

resource "aws_security_group_rule" "RDS-Postgres-VADER-1" {
  security_group_id = "${aws_security_group.RDS-Postgres-VADER.id}"
  type = "ingress"
  from_port = 5432
  to_port = 5432
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.VADER.id}"
}

resource "aws_security_group_rule" "RDS-Postgres-VADER-2" {
  security_group_id = "${aws_security_group.RDS-Postgres-VADER.id}"
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = [ "0.0.0.0/0" ]
}