#-------------------------------------------
# Ensono VPC - 6 subnets ( 3 public, 3 private) , internet gateway, 1 nat gateway.
#-------------------------------------------

#-------------------------------------------
# VPC
#-------------------------------------------

resource "aws_vpc" "vpc" {
    lifecycle { prevent_destroy = "true" }
    cidr_block = "${var.cidr}"
    tags { Name = "${var.vpc_name}" }
    enable_dns_support = true
    enable_dns_hostnames = false
}

#-------------------------------------------
# Internet Gateway
#-------------------------------------------

resource "aws_internet_gateway" "gw" {
    vpc_id = "${aws_vpc.vpc.id}"
}

#-------------------------------------------
# Nat Gateway
#-------------------------------------------

resource "aws_eip" "nat1" {
    vpc = true
}

resource "aws_nat_gateway" "gw1" {
    allocation_id = "${aws_eip.nat1.id}"
    subnet_id = "${aws_subnet.publicAzA.id}"
}

resource "aws_eip" "nat2" {
    vpc = true
}

resource "aws_nat_gateway" "gw2" {
    allocation_id = "${aws_eip.nat2.id}"
    subnet_id = "${aws_subnet.publicAzB.id}"
}


#-------------------------------------------
# Public Subnets
#-------------------------------------------
resource "aws_subnet" "publicAzA" {
    lifecycle { prevent_destroy = "true" }
    vpc_id = "${aws_vpc.vpc.id}"
    availability_zone = "${var.region}a"
    cidr_block = "${cidrsubnet(var.cidr,3,0)}"
    tags { Name = "Public Subnet A" }
}

resource "aws_subnet" "publicAzB" {
    lifecycle { prevent_destroy = "true" }
    vpc_id = "${aws_vpc.vpc.id}"
    availability_zone = "${var.region}b"
    cidr_block = "${cidrsubnet(var.cidr,3,1)}"
    tags { Name = "Public Subnet B" }
}

resource "aws_subnet" "publicAzC" {
    lifecycle { prevent_destroy = "true" }
    vpc_id = "${aws_vpc.vpc.id}"
    availability_zone = "${var.region}c"
    cidr_block = "${cidrsubnet(var.cidr,3,2)}"
    tags { Name = "Public Subnet C" }
}

#-------------------------------------------
# Private Subnets
#-------------------------------------------
resource "aws_subnet" "privateAzA" {
    lifecycle { prevent_destroy = "true" }
    vpc_id = "${aws_vpc.vpc.id}"
    availability_zone = "${var.region}a"
    cidr_block = "${cidrsubnet(var.cidr,3,3)}"
    tags { Name = "Private Subnet A" }
}

resource "aws_subnet" "privateAzB" {
    lifecycle { prevent_destroy = "true" }
    vpc_id = "${aws_vpc.vpc.id}"
    availability_zone = "${var.region}b"
    cidr_block = "${cidrsubnet(var.cidr,3,4)}"
    tags { Name = "Private Subnet B" }
}

resource "aws_subnet" "privateAzC" {
    lifecycle { prevent_destroy = "true" }
    vpc_id = "${aws_vpc.vpc.id}"
    availability_zone = "${var.region}c"
    cidr_block = "${cidrsubnet(var.cidr,3,5)}"
    tags { Name = "Private Subnet C" }
}


#-------------------------------------------
# Public Route Tables and associations
#-------------------------------------------
resource "aws_route_table" "public_route_table" {
    vpc_id = "${aws_vpc.vpc.id}"
    route {
      cidr_block = "0.0.0.0/0"
      gateway_id = "${aws_internet_gateway.gw.id}"
    }
    route {
       cidr_block = "${var.pfx_cidr1}"
       vpc_peering_connection_id = "${var.pfx_id1}"
    }
    route {
       cidr_block = "${var.pfx_cidr2}"
       vpc_peering_connection_id = "${var.pfx_id2}"
    }
    route {
       cidr_block = "${var.pfx_cidr3}"
       vpc_peering_connection_id = "${var.pfx_id3}"
    }
		route {
       cidr_block = "${var.pfx_ens_cidr}"
       vpc_peering_connection_id = "${var.pfx_ens_id}"
    }
    propagating_vgws = [ "${var.virtual_gateway_id}" ]
    tags { Name = "Prod VPC Public Route Table" }
}

resource "aws_route_table_association" "publicAzA" {
    subnet_id = "${aws_subnet.publicAzA.id}"
    route_table_id = "${aws_route_table.public_route_table.id}"
}

resource "aws_route_table_association" "publicAzB" {
    subnet_id = "${aws_subnet.publicAzB.id}"
    route_table_id = "${aws_route_table.public_route_table.id}"
}

resource "aws_route_table_association" "publicAzC" {
    subnet_id = "${aws_subnet.publicAzC.id}"
    route_table_id = "${aws_route_table.public_route_table.id}"
}


#-------------------------------------------
# Private Route Tables and associations
#-------------------------------------------
resource "aws_route_table" "private_route_table_a" {
    vpc_id = "${aws_vpc.vpc.id}"
    route {
      cidr_block = "0.0.0.0/0"
      nat_gateway_id = "${aws_nat_gateway.gw1.id}"
    }
    route {
       cidr_block = "${var.pfx_cidr1}"
       vpc_peering_connection_id = "${var.pfx_id1}"
    }
    route {
       cidr_block = "${var.pfx_cidr2}"
       vpc_peering_connection_id = "${var.pfx_id2}"
    }
    route {
       cidr_block = "${var.pfx_cidr3}"
       vpc_peering_connection_id = "${var.pfx_id3}"
    }
	  route {
       cidr_block = "${var.pfx_cidr4}"
       vpc_peering_connection_id = "${var.pfx_id4}"
    }
	  route {
       cidr_block = "${var.pfx_cidr5}"
       vpc_peering_connection_id = "${var.pfx_id5}"
    }
    route {
       cidr_block = "${var.pfx_ens_cidr}"
       vpc_peering_connection_id = "${var.pfx_ens_id}"
    }
    propagating_vgws = [ "${var.virtual_gateway_id}" ]
    tags { Name = "Prod VPC Private Route Table AZa" }
}

resource "aws_route_table" "private_route_table_b" {
    vpc_id = "${aws_vpc.vpc.id}"
    route {
      cidr_block = "0.0.0.0/0"
      nat_gateway_id = "${aws_nat_gateway.gw2.id}"
    }
    route {
       cidr_block = "${var.pfx_cidr1}"
       vpc_peering_connection_id = "${var.pfx_id1}"
    }
    route {
       cidr_block = "${var.pfx_cidr2}"
       vpc_peering_connection_id = "${var.pfx_id2}"
    }
    route {
       cidr_block = "${var.pfx_cidr3}"
       vpc_peering_connection_id = "${var.pfx_id3}"
    }
	  route {
       cidr_block = "${var.pfx_cidr4}"
       vpc_peering_connection_id = "${var.pfx_id4}"
    }
	  route {
       cidr_block = "${var.pfx_cidr5}"
       vpc_peering_connection_id = "${var.pfx_id5}"
    }
    route {
       cidr_block = "${var.pfx_ens_cidr}"
       vpc_peering_connection_id = "${var.pfx_ens_id}"
    }
    propagating_vgws = [ "${var.virtual_gateway_id}" ]
    tags { Name = "Prod VPC Private Route Table AZb" }
}

resource "aws_route_table" "private_route_table_c" {
    vpc_id = "${aws_vpc.vpc.id}"
    route {
      cidr_block = "0.0.0.0/0"
      nat_gateway_id = "${aws_nat_gateway.gw2.id}"
    }
    route {
       cidr_block = "${var.pfx_cidr1}"
       vpc_peering_connection_id = "${var.pfx_id1}"
    }
    route {
       cidr_block = "${var.pfx_cidr2}"
       vpc_peering_connection_id = "${var.pfx_id2}"
    }
    route {
       cidr_block = "${var.pfx_cidr3}"
       vpc_peering_connection_id = "${var.pfx_id3}"
    }
	  route {
       cidr_block = "${var.pfx_cidr4}"
       vpc_peering_connection_id = "${var.pfx_id4}"
    }
	  route {
       cidr_block = "${var.pfx_cidr5}"
       vpc_peering_connection_id = "${var.pfx_id5}"
    }
    route {
       cidr_block = "${var.pfx_ens_cidr}"
       vpc_peering_connection_id = "${var.pfx_ens_id}"
    }
    propagating_vgws = [ "${var.virtual_gateway_id}" ]
    tags { Name = "Prod VPC Private Route Table AZc" }
}

resource "aws_route_table_association" "privateAzA" {
    subnet_id = "${aws_subnet.privateAzA.id}"
    route_table_id = "${aws_route_table.private_route_table_a.id}"
}

resource "aws_route_table_association" "privateAzB" {
    subnet_id = "${aws_subnet.privateAzB.id}"
    route_table_id = "${aws_route_table.private_route_table_b.id}"
}

resource "aws_route_table_association" "privateAzC" {
    subnet_id = "${aws_subnet.privateAzC.id}"
    route_table_id = "${aws_route_table.private_route_table_c.id}"
}

