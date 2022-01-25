#------------------------------------------------------
# IP-SLA
#------------------------------------------------------
resource "aws_security_group" "IP-SLA" {
  name = "IP-SLA"
  description = "Secure IP-SLA Security Group"
  vpc_id = "vpc-9a1ec4ff"
}

resource "aws_security_group_rule" "IP-SLA" {
  security_group_id = "${aws_security_group.IP-SLA.id}"
  type = "ingress"
  from_port = -1
  to_port = -1
  protocol = "icmp"
  cidr_blocks = [ "10.142.252.2/32", "10.142.252.3/32" ]
}

resource "aws_security_group" "LAMBDA-DEPLOY-GRAPHQL-Prod" {
  name = "LAMBDA-DEPLOY-GRAPHQL-Prod"
  description = "Prod LAMBDA-DEPLOY-GRAPHQL Security Group"
  vpc_id = "${aws_vpc.vpc.id}"
}

  resource "aws_security_group_rule" "LAMBDA-DEPLOY-GRAPHQL-to-API-ELB" {
    security_group_id = "${aws_security_group.LAMBDA-DEPLOY-GRAPHQL-Prod.id}"
    type = "egress"
    from_port = 9096
    to_port = 9096
    protocol = "tcp"
    source_security_group_id = "${aws_security_group.ELB-AGGREGATION-API.id}"
  }
