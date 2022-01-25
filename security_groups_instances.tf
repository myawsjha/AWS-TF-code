#------------------------------------------------------
# API
#------------------------------------------------------
resource "aws_security_group" "API" {
  name = "API"
  description = "Production VPC API (Tomcat APIs) Security Group"
  vpc_id = "vpc-9a1ec4ff"
}

resource "aws_security_group_rule" "API" {
  security_group_id = "${aws_security_group.API.id}"
  type = "ingress"
  from_port = 9090
  to_port = 9099
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.ELB-EVENTS-API.id}"
}

resource "aws_security_group_rule" "API-1" {
  security_group_id = "${aws_security_group.API.id}"
  type = "ingress"
  from_port = 9090
  to_port = 9099
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.ELB-AGGREGATION-API.id}"
}

resource "aws_security_group_rule" "API-2" {
  security_group_id = "${aws_security_group.API.id}"
  type = "ingress"
  from_port = 9090
  to_port = 9099
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.ELB-PLACES-API.id}"
}

resource "aws_security_group_rule" "API-3" {
  security_group_id = "${aws_security_group.API.id}"
  type = "ingress"
  from_port = 9090
  to_port = 9099
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.APP.id}"
}

resource "aws_security_group_rule" "API-4" {
  security_group_id = "${aws_security_group.API.id}"
  type = "ingress"
  from_port = 9090
  to_port = 9099
  protocol = "tcp"
  self = "true"
}

resource "aws_security_group_rule" "API-5" {
  security_group_id = "${aws_security_group.API.id}"
  type = "ingress"
  from_port = 9098
  to_port = 9099
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.WEB.id}" 
}

resource "aws_security_group_rule" "API-6" {
  security_group_id = "${aws_security_group.API.id}"
  type = "ingress"
  from_port = 9097
  to_port = 9097
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.ELB-TaxonomyAPI.id}"
}

resource "aws_security_group_rule" "API-7" {
  security_group_id = "${aws_security_group.API.id}"
  type = "ingress"
  from_port = 9101
  to_port = 9101
  protocol = "tcp"
  cidr_blocks = [ "10.73.27.0/24", "10.73.28.0/24" ]
}

resource "aws_security_group_rule" "API-8" {
  security_group_id = "${aws_security_group.API.id}"
  type = "ingress"
  from_port = 9101
  to_port = 9101
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.ELB-Personalisation-API.id}"
}

resource "aws_security_group_rule" "API-9" {
  security_group_id = "${aws_security_group.API.id}"
  type = "ingress"
  from_port = 9094
  to_port = 9097
  protocol = "tcp"
  cidr_blocks = [ "10.73.27.0/24", "10.73.28.0/24" ]
}

resource "aws_security_group_rule" "API-10" {
  security_group_id = "${aws_security_group.API.id}"
  type = "ingress"
  from_port = 9098
  to_port = 9099
  protocol = "tcp"
  cidr_blocks = [ "10.73.27.0/24", "10.73.28.0/24" ]
}


#------------------------------------------------------
# APP
#------------------------------------------------------
resource "aws_security_group" "APP" {
  name = "APP"
  description = "Production VPC APP (Tomcat Web Apps) Security Group"
  vpc_id = "vpc-9a1ec4ff"
}

resource "aws_security_group_rule" "APP" {
  security_group_id = "${aws_security_group.APP.id}"
  type = "ingress"
  from_port = 8080
  to_port = 8091
  protocol = "tcp"
  cidr_blocks = [ "10.73.51.16/30" ]
}

resource "aws_security_group_rule" "APP-1" {
  security_group_id = "${aws_security_group.APP.id}"
  type = "ingress"
  from_port = 8080
  to_port = 8091
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.WCA.id}"
}

resource "aws_security_group_rule" "APP-2" {
  security_group_id = "${aws_security_group.APP.id}"
  type = "ingress"
  from_port = 8080
  to_port = 8094
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.WEB.id}"
}

resource "aws_security_group_rule" "APP-3" {
  security_group_id = "${aws_security_group.APP.id}"
  type = "ingress"
  from_port = 8090
  to_port = 8091
  protocol = "tcp"
  cidr_blocks = [ "10.73.40.20/32", "10.73.41.20/32" ]
}

resource "aws_security_group_rule" "APP-4" {
  security_group_id = "${aws_security_group.APP.id}"
  type = "ingress"
  from_port = 8086
  to_port = 8086
  protocol = "tcp"
  cidr_blocks = [ "10.73.40.20/32", "10.73.41.20/32" ]
}

#------------------------------------------------------
# EFS
#------------------------------------------------------
resource "aws_security_group" "EFS" {
  name = "EFS"
  description = "Production VPC EFS Security Group"
  vpc_id = "vpc-9a1ec4ff"
}

resource "aws_security_group_rule" "EFS" {
  security_group_id = "${aws_security_group.EFS.id}"
  type = "ingress"
  from_port = 2049
  to_port = 2049
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.WCA.id}"
}

resource "aws_security_group_rule" "EFS-1" {
  security_group_id = "${aws_security_group.EFS.id}"
  type = "ingress"
  from_port = 2049
  to_port = 2049
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.WCD.id}"
}

resource "aws_security_group_rule" "EFS-egress-to-WCA" {
  security_group_id = "${aws_security_group.EFS.id}"
  type = "egress"
  from_port = 665
  to_port = 1023
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.WCA.id}"
}

resource "aws_security_group_rule" "EFS-egress-to-WCD" {
  security_group_id = "${aws_security_group.EFS.id}"
  type = "egress"
  from_port = 665
  to_port = 1023
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.WCD.id}"
}


#------------------------------------------------------
# ELASTICACHE-WEBSITE
#------------------------------------------------------
resource "aws_security_group" "ELASTICACHE-WEBSITE" {
  name = "ELASTICACHE-WEBSITE"
  description = "Production VPC ELASTICACHE-WEBSITE Security Group"
  vpc_id = "vpc-9a1ec4ff"
}

resource "aws_security_group_rule" "ELASTICACHE-WEBSITE" {
  security_group_id = "${aws_security_group.ELASTICACHE-WEBSITE.id}"
  type = "ingress"
  from_port = 11000
  to_port = 11000
  protocol = "tcp"
  cidr_blocks = [ "10.73.19.10/32", "10.73.19.11/32" ]
}

resource "aws_security_group_rule" "ELASTICACHE-WEBSITE-1" {
  security_group_id = "${aws_security_group.ELASTICACHE-WEBSITE.id}"
  type = "ingress"
  from_port = 11000
  to_port = 11000
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.APP.id}"
}

resource "aws_security_group_rule" "ELASTICACHE-WEBSITE-2" {
  security_group_id = "${aws_security_group.ELASTICACHE-WEBSITE.id}"
  type = "ingress"
  from_port = 11000
  to_port = 11000
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.API.id}"
}

#------------------------------------------------------
# ELASTICSEARCH
#------------------------------------------------------
resource "aws_security_group" "ELASTICSEARCH" {
  name = "ELASTICSEARCH"
  description = "Production VPC ELASTIC SEARCH Security Group"
  vpc_id = "vpc-9a1ec4ff"
}

resource "aws_security_group_rule" "ELASTICSEARCH" {
  security_group_id = "${aws_security_group.ELASTICSEARCH.id}"
  type = "ingress"
  from_port = 9300
  to_port = 9300
  protocol = "tcp"
  self = "true"
}

resource "aws_security_group_rule" "ELASTICSEARCH-1" {
  security_group_id = "${aws_security_group.ELASTICSEARCH.id}"
  type = "ingress"
  from_port = 9300
  to_port = 9300
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.API.id}"
}

resource "aws_security_group_rule" "ELASTICSEARCH-2" {
  security_group_id = "${aws_security_group.ELASTICSEARCH.id}"
  type = "ingress"
  from_port = 9300
  to_port = 9300
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.ETL.id}"
}
resource "aws_security_group_rule" "ELASTICSEARCH-3" {
  security_group_id = "${aws_security_group.ELASTICSEARCH.id}"
  type = "ingress"
  from_port = 9200
  to_port = 9200
  protocol = "tcp"
  self = "true"
}

resource "aws_security_group_rule" "ELASTICSEARCH-4" {
  security_group_id = "${aws_security_group.ELASTICSEARCH.id}"
  type = "ingress"
  from_port = 9200
  to_port = 9200
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.API.id}"
}

resource "aws_security_group_rule" "ELASTICSEARCH-5" {
  security_group_id = "${aws_security_group.ELASTICSEARCH.id}"
  type = "ingress"
  from_port = 9200
  to_port = 9200
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.ETL.id}"
}

#------------------------------------------------------
# ETL
#------------------------------------------------------
resource "aws_security_group" "ETL" {
  name = "ETL"
  description = "Production VPC ETL Security Group"
  vpc_id = "vpc-9a1ec4ff"
}

resource "aws_security_group_rule" "ETL" {
  security_group_id = "${aws_security_group.ETL.id}"
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = [ "10.90.0.0/16","10.34.64.0/24","10.138.80.0/24","10.139.0.0/22","172.19.248.0/23","10.142.120.0/22","10.142.124.0/22","10.91.0.0/16", "10.143.0.0/16" ]
}

#------------------------------------------------------
# MANAGEMENT
#------------------------------------------------------
resource "aws_security_group" "MANAGEMENT" {
  name = "MANAGEMENT"
  description = "Production VPC MANAGEMENT Access Security Group - e.g. from Hub/Attenda"
  vpc_id = "vpc-9a1ec4ff"
  tags = {
    Group = "ensmgt"
  }
  
}

resource "aws_security_group_rule" "MANAGEMENT" {
  security_group_id = "${aws_security_group.MANAGEMENT.id}"
  type = "ingress"
  from_port = 0
  to_port = 65535
  protocol = "tcp"
  cidr_blocks = [ "10.73.19.11/32" ]
}

resource "aws_security_group_rule" "MANAGEMENT-1" {
  security_group_id = "${aws_security_group.MANAGEMENT.id}"
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = [ "10.248.21.24/32", "10.73.19.10/32", "10.73.20.12/32", "10.64.11.0/24", "10.248.1.0/24" ]
}

resource "aws_security_group_rule" "MANAGEMENT-2" {
  security_group_id = "${aws_security_group.MANAGEMENT.id}"
  type = "ingress"
  from_port = -1
  to_port = -1
  protocol = "icmp"
  cidr_blocks = [ "10.73.19.11/32", "10.90.0.0/16", "10.34.64.0/24", "10.55.253.0/24", "10.55.250.0/24", "10.31.226.0/24", "10.73.0.0/16", "172.19.248.0/23", "10.91.0.0/16", "10.143.0.0/16" ]
}

resource "aws_security_group_rule" "MANAGEMENT-3" {
  security_group_id = "${aws_security_group.MANAGEMENT.id}"
  type = "egress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = [ "0.0.0.0/0" ]
}

resource "aws_security_group_rule" "MANAGEMENT-4" {
  security_group_id = "${aws_security_group.MANAGEMENT.id}"
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = [ "10.0.0.0/8" ]
}

resource "aws_security_group_rule" "MANAGEMENT-5" {
  security_group_id = "${aws_security_group.MANAGEMENT.id}"
  type = "egress"
  from_port = 123
  to_port = 123
  protocol = "udp"
  cidr_blocks = [ "0.0.0.0/0" ]
}

resource "aws_security_group_rule" "MANAGEMENT-6" {
  security_group_id = "${aws_security_group.MANAGEMENT.id}"
  type = "egress"
  from_port = 443
  to_port = 443
  protocol = "tcp"
  cidr_blocks = [ "0.0.0.0/0" ]
}

resource "aws_security_group_rule" "MANAGEMENT-ens" {
  security_group_id = "${aws_security_group.MANAGEMENT.id}"
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = [ "10.72.0.0/21" ]
}


#------------------------------------------------------
# MONGODB
#------------------------------------------------------
resource "aws_security_group" "MONGODB" {
  name = "MONGODB"
  description = "Production VPC MongoDB Security Group"
  vpc_id = "vpc-9a1ec4ff"
}

resource "aws_security_group_rule" "MONGODB" {
  security_group_id = "${aws_security_group.MONGODB.id}"
  type = "ingress"
  from_port = 27017
  to_port = 27017
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.API.id}"
}

resource "aws_security_group_rule" "MONGODB-1" {
  security_group_id = "${aws_security_group.MONGODB.id}"
  type = "ingress"
  from_port = 27017
  to_port = 27017
  protocol = "tcp"
  self = "true"
}

resource "aws_security_group_rule" "MONGODB-2" {
  security_group_id = "${aws_security_group.MONGODB.id}"
  type = "ingress"
  from_port = 27017
  to_port = 27017
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.ETL.id}"
}

#------------------------------------------------------
# ReSRCIt
#------------------------------------------------------
resource "aws_security_group" "ReSRCIt" {
  name = "ReSRCIt"
  description = "Production VPC Access for NT  3rd part - ReSRC.it "
  vpc_id = "vpc-9a1ec4ff"
  tags = {
    Name = "ReSRCIt"
  }
}

resource "aws_security_group_rule" "ReSRCIt" {
  security_group_id = "${aws_security_group.ReSRCIt.id}"
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = [ "108.170.50.154/32", "108.170.50.186/32", "136.243.34.82/32", "136.243.7.141/32", "144.76.102.101/32", "144.76.65.11/32", "144.76.69.149/32", "144.76.85.210/32", "148.251.127.246/32", "148.251.246.169/32", "148.251.98.178/32", "184.164.130.210/32", "184.95.36.34/32", "198.15.102.90/32", "198.15.106.2/32", "198.15.70.170/32", "198.24.157.2/32", "198.24.170.226/32", "209.188.12.170/32", "209.188.12.186/32", "5.148.132.132/32" ]
}

#------------------------------------------------------
# STORAGESERVER
#------------------------------------------------------
resource "aws_security_group" "STORAGESERVER" {
  name = "STORAGESERVER"
  description = "Production VPC Redhat Storage Server Security Group"
  vpc_id = "vpc-9a1ec4ff"
}

resource "aws_security_group_rule" "STORAGESERVER" {
  security_group_id = "${aws_security_group.STORAGESERVER.id}"
  type = "ingress"
  from_port = 38465
  to_port = 38469
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.WCA.id}"
}

resource "aws_security_group_rule" "STORAGESERVER-1" {
  security_group_id = "${aws_security_group.STORAGESERVER.id}"
  type = "ingress"
  from_port = 38465
  to_port = 38469
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.WCD.id}"
}

resource "aws_security_group_rule" "STORAGESERVER-2" {
  security_group_id = "${aws_security_group.STORAGESERVER.id}"
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = [ "0.0.0.0/0" ]
}


#------------------------------------------------------
# VADER
#------------------------------------------------------
resource "aws_security_group" "VADER" {
  name = "VADER"
  description = "Production VPC VADER Security Group"
  vpc_id = "vpc-9a1ec4ff"
}

resource "aws_security_group_rule" "VADER" {
  security_group_id = "${aws_security_group.VADER.id}"
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = [ "10.0.0.0/8" ]
}

resource "aws_security_group_rule" "VADER-1" {
  security_group_id = "${aws_security_group.VADER.id}"
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = [ "10.73.27.14/32" ]
  description = "ntt43etl01prd"
}

resource "aws_security_group_rule" "VADER-2" {
  security_group_id = "${aws_security_group.VADER.id}"
  type = "ingress"
  from_port = 443
  to_port = 443
  protocol = "tcp"
  cidr_blocks = [ "10.0.0.0/8" ]
}

#------------------------------------------------------
# WCA
#------------------------------------------------------
resource "aws_security_group" "WCA" {
  name = "WCA"
  description = "Production VPC WCA (Web Center Authoring) Security Group"
  vpc_id = "vpc-9a1ec4ff"
}


resource "aws_security_group_rule" "WCA" {
  security_group_id = "${aws_security_group.WCA.id}"
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = [ "10.138.80.0/24", "10.139.0.0/22", "10.142.120.0/22", "10.142.124.0/22", "10.34.64.0/24", "10.73.19.10/32", "10.90.0.0/16", "10.91.0.0/16", "10.143.0.0/16", "172.19.248.0/23" ]
  description = "F1160587"
}

resource "aws_security_group_rule" "WCA-1" {
  security_group_id = "${aws_security_group.WCA.id}"
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.ELB-WCA.id}"
}

resource "aws_security_group_rule" "WCA-2" {
  security_group_id = "${aws_security_group.WCA.id}"
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.WEB.id}"
}

resource "aws_security_group_rule" "WCA-3" {
  security_group_id = "${aws_security_group.WCA.id}"
  type = "ingress"
  from_port = 8080
  to_port = 8080
  protocol = "tcp"
  cidr_blocks = [ "10.73.67.16/32", "10.73.68.16/32" ]
}


resource "aws_security_group_rule" "WCA-4" {
  security_group_id = "${aws_security_group.WCA.id}"
  type = "ingress"
  from_port = 8080
  to_port = 8080
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.ELB-WCA.id}"
}

resource "aws_security_group_rule" "WCA-5" {
  security_group_id = "${aws_security_group.WCA.id}"
  type = "ingress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  self = "true"
}

resource "aws_security_group_rule" "WCA-Rule-EFS" {
  security_group_id = "${aws_security_group.WCA.id}"
  type = "ingress"
  from_port = 665
  to_port = 1023
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.EFS.id}"
}

#------------------------------------------------------
# WCD
#------------------------------------------------------
resource "aws_security_group" "WCD" {
  name = "WCD"
  description = "Production VPC WCD (Web Center Delivery) Security Group"
  vpc_id = "vpc-9a1ec4ff"
}

resource "aws_security_group_rule" "WCD" {
  security_group_id = "${aws_security_group.WCD.id}"
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = [ "10.90.0.0/16", "10.34.64.0/24", "10.138.80.0/24", "10.139.0.0/22", "172.19.248.0/23", "10.73.40.20/32", "10.73.41.20/32", "10.142.120.0/22", "10.142.124.0/22", "10.91.0.0/16", "10.143.0.0/16" ]
}

resource "aws_security_group_rule" "WCD-1" {
  security_group_id = "${aws_security_group.WCD.id}"
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.WEB.id}"
}

resource "aws_security_group_rule" "WCD-2" {
  security_group_id = "${aws_security_group.WCD.id}"
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.ETL.id}"
}

resource "aws_security_group_rule" "WCD-3" {
  security_group_id = "${aws_security_group.WCD.id}"
  type = "ingress"
  from_port = 8080
  to_port = 8080
  protocol = "tcp"
  cidr_blocks = [ "10.31.226.94/32" ]
}

resource "aws_security_group_rule" "WCD-4" {
  security_group_id = "${aws_security_group.WCD.id}"
  type = "ingress"
  from_port = 8080
  to_port = 8080
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.WCA.id}"
}

resource "aws_security_group_rule" "WCD-5" {
  security_group_id = "${aws_security_group.WCD.id}"
  type = "ingress"
  from_port = 8080
  to_port = 8080
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.ETL.id}"
}

resource "aws_security_group_rule" "WCD-6" {
  security_group_id = "${aws_security_group.WCD.id}"
  type = "ingress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  self = "true"
}

resource "aws_security_group_rule" "WCD-7" {
  security_group_id = "${aws_security_group.WCD.id}"
  type = "ingress"
  from_port = 665
  to_port = 1023
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.EFS.id}"
}

#------------------------------------------------------
# Web
#------------------------------------------------------
resource "aws_security_group" "WEB" {
  name = "WEB"
  description = "Production VPC WEB (VARNISH) Security Group"
  vpc_id = "vpc-9a1ec4ff"
}

resource "aws_security_group_rule" "WEB" {
  security_group_id = "${aws_security_group.WEB.id}"
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = [ "0.0.0.0/0" ]
}

resource "aws_security_group_rule" "WEB-1" {
  security_group_id = "${aws_security_group.WEB.id}"
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = [ "10.73.27.14/32" ]
  description = "ntt43etl01prd"
}

resource "aws_security_group_rule" "WEB-2" {
  security_group_id = "${aws_security_group.WEB.id}"
  type = "ingress"
  from_port = 80
  to_port = 84
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.ELB-WEB-EXTERNAL.id}"
}

resource "aws_security_group_rule" "WEB-3" {
  security_group_id = "${aws_security_group.WEB.id}"
  type = "ingress"
  from_port = 80
  to_port = 84
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.ELB-WEB-INTERNAL.id}"
}

resource "aws_security_group_rule" "WEB-4" {
  security_group_id = "${aws_security_group.WEB.id}"
  type = "ingress"
  from_port = 443
  to_port = 443
  protocol = "tcp"
  cidr_blocks = [ "0.0.0.0/0" ]
}