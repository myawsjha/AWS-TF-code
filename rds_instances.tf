#-----------------------------------------------------
# Prod - Postgres Taxonomy DB
#-----------------------------------------------------
resource "aws_db_instance" "rds12" {
  identifier                = "${var.ci_prefix}rds12${var.env}"
  engine                    = "postgres"
  engine_version            = "9.6.11"
  instance_class            = "db.t3.micro"
  parameter_group_name      = "default.postgres9.6"
  username                  = "rds_adm"
#  password                  = "${var.rds12-pw}"
  name                      = "taxonomyapi"
  db_subnet_group_name      = "${aws_db_subnet_group.rds-taxonomy.id}"
  backup_retention_period   = 28
  storage_type              = "gp2"
  allocated_storage         = "20"
  vpc_security_group_ids    = [ "${aws_security_group.RDSPostGresTaxonomy.id}" ]
  multi_az                  = "false"
  backup_window             = "02:31-03:01"
  publicly_accessible       = "false"
  storage_encrypted         = "false"
  auto_minor_version_upgrade = "false"
  skip_final_snapshot       = "true"
  copy_tags_to_snapshot     = "true"

  tags {
    Name                    = "${var.ci_prefix}rds12${var.env}"
    Description             = "Production Postgres RDS Taxonomy"
    EnsonoSupportLevel      = "${var.supportlvl_tag}"
	workload-type           = "other"
  }

}

#-----------------------------------------------------
# Prod - WRD - Delivery - Oracle DB
#-----------------------------------------------------
resource "aws_db_instance" "rds01" {
  identifier                = "${var.ci_prefix}rds01${var.env}"
  engine                    = "oracle-se"
  engine_version            = "11.2.0.4.v3"
  instance_class            = "db.m5.2xlarge"
  parameter_group_name      = "default.oracle-se-11.2"
  username                  = "rds_adm"
  name                      = "EXTPRD01"
  db_subnet_group_name      = "${aws_db_subnet_group.oraclerds.id}"
  backup_retention_period   = 28
  storage_type              = "gp2"
  allocated_storage         = "50"
  vpc_security_group_ids    = [ "${aws_security_group.RDS-EXTCIE01.id}" ]
  multi_az                  = "true"
  backup_window             = "03:15-03:45"
  publicly_accessible       = "false"
  storage_encrypted         = "false"
  auto_minor_version_upgrade = "false"
  skip_final_snapshot       = "true"
  copy_tags_to_snapshot     = "false"

  tags {
    Name                    = "${var.ci_prefix}rds01${var.env}"
    Description             = "Production Oracle RDS database instance for WRD - Delivery"
    EnsonoSupportLevel      = "${var.supportlvl_tag}"
	workload-type           = "production"
  }
}


#-----------------------------------------------------
# Prod - WRD - Editorial - Oracle DB
#-----------------------------------------------------
resource "aws_db_instance" "rds02" {
  identifier                = "${var.ci_prefix}rds02${var.env}"
  engine                    = "oracle-se"
  engine_version            = "11.2.0.4.v3"
  instance_class            = "db.m5.xlarge"
  parameter_group_name      = "default.oracle-se-11.2"
  username                  = "rds_adm"
  name                      = "INTPRD01"
  db_subnet_group_name      = "${aws_db_subnet_group.oraclerds.id}"
  backup_retention_period   = 28
  storage_type              = "gp2"
  allocated_storage         = "50"
  vpc_security_group_ids    = [ "${aws_security_group.RDS-INTCIE01.id}" ]
  multi_az                  = "true"
  backup_window             = "03:15-03:45"
  publicly_accessible       = "false"
  storage_encrypted         = "false"
  auto_minor_version_upgrade = "false"
  skip_final_snapshot       = "true"
  copy_tags_to_snapshot     = "false"

  tags {
    Name                    = "${var.ci_prefix}rds02${var.env}"
    Description             = "Production Oracle RDS database instance for WRD - Editorial"
    EnsonoSupportLevel      = "${var.supportlvl_tag}"
	workload-type           = "production"
  }
}


#-----------------------------------------------------
# Prod - Postgres VADER DB
#-----------------------------------------------------
resource "aws_db_instance" "rds07" {
  identifier                = "${var.ci_prefix}rds07${var.env}"
  engine                    = "postgres"
  engine_version            = "9.5.15"
  instance_class            = "db.m4.large"
  parameter_group_name      = "default.postgres9.5"
  username                  = "rds_adm"
  name                      = "VADER"
  db_subnet_group_name      = "${aws_db_subnet_group.rds-postgres.id}"
  backup_retention_period   = 28
  storage_type              = "standard"
  allocated_storage         = "20"
  vpc_security_group_ids    = [ "${aws_security_group.RDS-Postgres-VADER.id}" ]
  multi_az                  = "false"
  backup_window             = "02:01-02:31"
  publicly_accessible       = "false"
  storage_encrypted         = "false"
  auto_minor_version_upgrade = "false"
  skip_final_snapshot       = "true"
  copy_tags_to_snapshot     = "false"

  tags {
    Name                    = "${var.ci_prefix}rds07${var.env}"
    Description             = "Prod Postgres RDS"
    EnsonoSupportLevel      = "${var.supportlvl_tag}"
  }
}

#-----------------------------------------------------
# Prod - Postgres EVENTS DB
#-----------------------------------------------------
resource "aws_db_instance" "rds08" {
  identifier                = "${var.ci_prefix}rds08${var.env}"
  engine                    = "postgres"
  engine_version            = "9.5.15"
  instance_class            = "db.t2.medium"
  parameter_group_name      = "default.postgres9.5"
  username                  = "rds_adm"
  name                      = "EVENTS"
  db_subnet_group_name      = "${aws_db_subnet_group.rds-postgres.id}"
  backup_retention_period   = 28
  storage_type              = "standard"
  allocated_storage         = "100"
  vpc_security_group_ids    = [ "${aws_security_group.RDS-Postgres-EVENTS-DBS08.id}" ]
  multi_az                  = "false"
  backup_window             = "02:01-02:31"
  publicly_accessible       = "false"
  storage_encrypted         = "false"
  auto_minor_version_upgrade = "false"
  skip_final_snapshot       = "true"
  copy_tags_to_snapshot     = "false"

  tags {
    Name                    = "${var.ci_prefix}rds08${var.env}"
    Description             = "Prod Postgres RDS VADER-EVENTS"
    EnsonoSupportLevel      = "${var.supportlvl_tag}"
  }
}
