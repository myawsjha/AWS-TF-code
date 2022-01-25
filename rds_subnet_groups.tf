resource "aws_db_subnet_group" "rds-taxonomy" {
    name = "rds-taxonomy"
    description = "Prod Taxonomy subnet group"
    subnet_ids = [ "${aws_subnet.privateAzA.id}", "${aws_subnet.privateAzB.id}" ]
}

resource "aws_db_subnet_group" "oraclerds" {
    name = "oraclerds"
    description = "DB Subnet Group"
    subnet_ids = [ "${aws_subnet.privateAzA.id}", "${aws_subnet.privateAzB.id}" ]
}

resource "aws_db_subnet_group" "rds-postgres" {
    name = "rds-postgres"
    description = "Prod Vader Subnet groups"
    subnet_ids = [ "${aws_subnet.privateAzA.id}", "${aws_subnet.privateAzB.id}" ]
}