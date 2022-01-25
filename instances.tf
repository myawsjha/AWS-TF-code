#-----------------------------------------------------
# API Instances - #1
#-----------------------------------------------------
resource "aws_instance" "api01" {
  lifecycle { prevent_destroy = "true" }
  ami                    = "${var.amzn_lnx_ami}"
  instance_type          = "c5.xlarge"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = [ "${aws_security_group.MANAGEMENT.id}", "${aws_security_group.API.id}" ]
  subnet_id              = "${aws_subnet.privateAzA.id}"
  disable_api_termination = "true"
  ebs_optimized          = "true"

  tags {
    Name                 = "${var.ci_prefix}api01${var.env}"
    Description          = "Prod-WRD API Instance"
    Monitoring           = "${var.monitoring_tag}"
    "cpm backup"         = "${var.backup_tag}"
    EnsonoSupportLevel   = "${var.supportlvl_tag}"
  }

  root_block_device {
    volume_type = "standard"
    volume_size = "20"
    delete_on_termination = "false"
  }

  ebs_block_device {
    device_name           = "/dev/sdf"
    volume_type           = "gp2"
    volume_size           = "40"
	encrypted             = "false"
	delete_on_termination = "true"
  } 
}

#-----------------------------------------------------
# API Instances - #2
#-----------------------------------------------------
resource "aws_instance" "api02" {
  lifecycle { prevent_destroy = "true" }
  ami                    = "${var.amzn_lnx_ami}"
  instance_type          = "c5.xlarge"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = [ "${aws_security_group.MANAGEMENT.id}", "${aws_security_group.API.id}" ]
  subnet_id              = "${aws_subnet.privateAzB.id}"
  disable_api_termination = "true"
  ebs_optimized          = "true"

  tags {
    Name                 = "${var.ci_prefix}api02${var.env}"
    Description          = "Prod-WRD API Instance"
    Monitoring           = "${var.monitoring_tag}"
    "cpm backup"         = "${var.backup_tag}"
    EnsonoSupportLevel   = "${var.supportlvl_tag}"
  }

  root_block_device {
    volume_type = "standard"
    volume_size = "20"
	delete_on_termination = "false"
  }

  ebs_block_device {
    device_name           = "/dev/sdf"
    volume_type           = "gp2"
    volume_size           = "40"
	encrypted             = "false"
	delete_on_termination = "true"
  } 
}

#-----------------------------------------------------
# APP Instances - #1
#-----------------------------------------------------
resource "aws_instance" "app01" {
  lifecycle { prevent_destroy = "true" }
  ami                    = "${var.amzn_lnx_ami}"
  instance_type          = "r4.large"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = [ "${aws_security_group.MANAGEMENT.id}", "${aws_security_group.APP.id}" ]
  subnet_id              = "${aws_subnet.privateAzA.id}"
  disable_api_termination = "true"
  ebs_optimized          = "true"

  tags {
    Name                 = "${var.ci_prefix}app01${var.env}"
    Description          = "Prod-WRD APP Instance"
    Monitoring           = "${var.monitoring_tag}"
    "cpm backup"         = "${var.backup_tag}"
    EnsonoSupportLevel   = "${var.supportlvl_tag}"
  }

  root_block_device {
    volume_type = "standard"
    volume_size = "20"
    delete_on_termination = "false"
  }
}

#-----------------------------------------------------
# APP Instances - #2
#-----------------------------------------------------
resource "aws_instance" "app02" {
  lifecycle { prevent_destroy = "true" }
  ami                    = "${var.amzn_lnx_ami}"
  instance_type          = "r4.large"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = [ "${aws_security_group.MANAGEMENT.id}", "${aws_security_group.APP.id}" ]
  subnet_id              = "${aws_subnet.privateAzB.id}"
  disable_api_termination = "true"
  ebs_optimized          = "true"

  tags {
    Name                 = "${var.ci_prefix}app02${var.env}"
    Description          = "Prod-WRD APP Instance"
    Monitoring           = "${var.monitoring_tag}"
    "cpm backup"         = "${var.backup_tag}"
    EnsonoSupportLevel   = "${var.supportlvl_tag}"
  }

  root_block_device {
    volume_type = "standard"
    volume_size = "20"
    delete_on_termination = "false"
  }
}


#-----------------------------------------------------
# ELS Instances - #1
#-----------------------------------------------------
resource "aws_instance" "els01" {
  lifecycle { prevent_destroy = "true" }
  ami                    = "${var.redhat_65_ami}"
  instance_type          = "t2.large"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = [ "${aws_security_group.MANAGEMENT.id}", "${aws_security_group.MONGODB.id}", "${aws_security_group.ELASTICSEARCH.id}" ]
  subnet_id              = "${aws_subnet.privateAzA.id}"
  disable_api_termination = "true"
  ebs_optimized          = "false"

  tags {
    Name                 = "${var.ci_prefix}els01${var.env}"
    Description          = "Prod-WRD ElasticSearch Instance"
    Monitoring           = "${var.monitoring_tag}"
    "cpm backup"         = "${var.backup_tag}"
    EnsonoSupportLevel   = "${var.supportlvl_tag}"
  }

  root_block_device {
    volume_type = "gp2"
    volume_size = "20"
    delete_on_termination = "false"
  }
    
  ebs_block_device {
    device_name           = "/dev/xvdb"
    volume_type           = "standard"
    volume_size           = "20"
	encrypted             = "false"
	delete_on_termination = "false"
  } 
  ebs_block_device {
    device_name           = "/dev/xvdc"
    volume_type           = "gp2"
    volume_size           = "20"
	encrypted             = "false"
	delete_on_termination = "false"
  }
  
}

#-----------------------------------------------------
# ELS Instances - #2
#-----------------------------------------------------
resource "aws_instance" "els02" {
  lifecycle { prevent_destroy = "true" }
  ami                    = "${var.redhat_65_ami}"
  instance_type          = "t2.large"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = [ "${aws_security_group.MANAGEMENT.id}", "${aws_security_group.MONGODB.id}", "${aws_security_group.ELASTICSEARCH.id}" ]
  subnet_id              = "${aws_subnet.privateAzB.id}"
  disable_api_termination = "true"
  ebs_optimized          = "false"

  tags {
    Name                 = "${var.ci_prefix}els02${var.env}"
    Description          = "Prod-WRD ElasticSearch Instance"
    Monitoring           = "${var.monitoring_tag}"
    "cpm backup"         = "${var.backup_tag}"
    EnsonoSupportLevel   = "${var.supportlvl_tag}"
  }

  root_block_device {
    volume_type = "gp2"
    volume_size = "20"
    delete_on_termination = "true"
  }
  
  ebs_block_device {
    device_name           = "/dev/xvdb"
    volume_type           = "standard"
    volume_size           = "20"
	encrypted             = "false"
	delete_on_termination = "false"
  } 
  
  ebs_block_device {
    device_name           = "/dev/xvdc"
    volume_type           = "gp2"
    volume_size           = "20"
	encrypted             = "false"
	delete_on_termination = "false"
  }
}

#-----------------------------------------------------
# ELS Instances - #3
#-----------------------------------------------------
resource "aws_instance" "els03" {
  lifecycle { prevent_destroy = "true" }
  ami                    = "${var.redhat_65_ami}"
  instance_type          = "t2.large"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = [ "${aws_security_group.MANAGEMENT.id}", "${aws_security_group.MONGODB.id}", "${aws_security_group.ELASTICSEARCH.id}", "${aws_security_group.IP-SLA.id}" ]
  subnet_id              = "${aws_subnet.privateAzC.id}"
  disable_api_termination = "true"
  ebs_optimized          = "false"

  tags {
    Name                 = "${var.ci_prefix}els03${var.env}"
    Description          = "Prod-WRD ElasticSearch Instance"
    Monitoring           = "${var.monitoring_tag}"
    "cpm backup"         = "${var.backup_tag}"
    EnsonoSupportLevel   = "${var.supportlvl_tag}"
  }

  root_block_device {
    volume_type = "gp2"
    volume_size = "20"
    delete_on_termination = "true"
  }
  
  ebs_block_device {
    device_name           = "/dev/xvdb"
    volume_type           = "standard"
    volume_size           = "20"
	encrypted             = "false"
	delete_on_termination = "false"
  }
  
  ebs_block_device {
    device_name           = "/dev/xvdc"
    volume_type           = "gp2"
    volume_size           = "20"
	encrypted             = "false"
	delete_on_termination = "false"
  }
  
}

#-----------------------------------------------------
# ETL Instance
#-----------------------------------------------------
resource "aws_instance" "etl01" {
  lifecycle { prevent_destroy = "true" }
  ami                    = "${var.amzn_lnx_ami}"
  instance_type          = "m5.large"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = [ "${aws_security_group.IP-SLA.id}", "${aws_security_group.MANAGEMENT.id}", "${aws_security_group.ETL.id}" ]
  subnet_id              = "${aws_subnet.privateAzA.id}"
  disable_api_termination = "true"
  ebs_optimized          = "false"

  tags {
    Name                 = "${var.ci_prefix}etl01${var.env}"
    Description          = "Prod-WRD ETL Instance"
    Monitoring           = "${var.monitoring_tag}"
    "cpm backup"         = "${var.backup_tag}"
    EnsonoSupportLevel   = "${var.supportlvl_tag}"
  }

  root_block_device {
    volume_type = "standard"
    volume_size = "20"
    delete_on_termination = "false"
  }
}

#-----------------------------------------------------
# Vader Instance
#-----------------------------------------------------
resource "aws_instance" "vad01" {
  lifecycle { prevent_destroy = "true" }
  ami                    = "${var.amzn_lnx_ami}"
  instance_type          = "m5.xlarge"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = [ "${aws_security_group.VADER.id}", "${aws_security_group.MANAGEMENT.id}" ]
  subnet_id              = "${aws_subnet.privateAzA.id}"
  disable_api_termination = "true"
  ebs_optimized          = "false"

  tags {
    Name                 = "${var.ci_prefix}vad01${var.env}"
    Description          = "Prod-WRD Vader Instance"
    Monitoring           = "${var.monitoring_tag}"
    "cpm backup"         = "${var.backup_tag}"
    EnsonoSupportLevel   = "${var.supportlvl_tag}"
  }

  root_block_device {
    volume_type = "standard"
    volume_size = "20"
    delete_on_termination = "false"
  }
}

#-----------------------------------------------------
# WCA Instances - #1
#-----------------------------------------------------
resource "aws_instance" "wca01" {
  lifecycle { prevent_destroy = "true" }
  ami                    = "${var.redhat_69_ami}"
  instance_type          = "m3.xlarge"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = [ "${aws_security_group.WCA.id}", "${aws_security_group.MANAGEMENT.id}" ]
  subnet_id              = "${aws_subnet.privateAzA.id}"
  iam_instance_profile   = "${aws_iam_instance_profile.s3-efs-backups_instance_profile.name}"
  disable_api_termination = "true"
  ebs_optimized          = "false"

  tags {
    Name                 = "${var.ci_prefix}wca01${var.env}"
    Description          = "Prod-WRD WCA Instance"
    Monitoring           = "${var.monitoring_tag}"
    "cpm backup"         = "${var.backuphourly_tag}"
    EnsonoSupportLevel   = "${var.supportlvl_tag}"
  }

  root_block_device {
    volume_type = "gp2"
    volume_size = "50"
    delete_on_termination = "false"
  }
}

#-----------------------------------------------------
# WCA Instances - #2
#-----------------------------------------------------
resource "aws_instance" "wca02" {
  lifecycle { prevent_destroy = "true" }
  ami                    = "${var.redhat_69_ami}"
  instance_type          = "m3.xlarge"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = [ "${aws_security_group.WCA.id}", "${aws_security_group.MANAGEMENT.id}" ]
  subnet_id              = "${aws_subnet.privateAzB.id}"
  iam_instance_profile   = "${aws_iam_instance_profile.s3-efs-backups_instance_profile.name}"
  disable_api_termination = "true"
  ebs_optimized          = "false"

  tags {
    Name                 = "${var.ci_prefix}wca02${var.env}"
    Description          = "Prod-WRD WCA Instance"
    Monitoring           = "${var.monitoring_tag}"
    "cpm backup"         = "${var.backuphourly_tag}"
    EnsonoSupportLevel   = "${var.supportlvl_tag}"
  }

  root_block_device {
    volume_type = "gp2"
    volume_size = "50"
    delete_on_termination = "false"
  }
}


#-----------------------------------------------------
# WCD Instances - #1
#-----------------------------------------------------
resource "aws_instance" "wcd01" {
  lifecycle { prevent_destroy = "true" }
  ami                    = "${var.redhat_65_ami}"
  instance_type          = "r3.xlarge"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = [ "${aws_security_group.WCD.id}", "${aws_security_group.MANAGEMENT.id}" ]
  subnet_id              = "${aws_subnet.privateAzA.id}"
  iam_instance_profile   = "${aws_iam_instance_profile.s3-efs-backups_instance_profile.name}"
  disable_api_termination = "false"
  ebs_optimized          = "true"

  tags {
    Name                 = "${var.ci_prefix}wcd01${var.env}"
    Description          = "Prod-WRD WCD Instance"
    Monitoring           = "${var.monitoring_tag}"
    "cpm backup"         = "${var.backuphourly_tag}"
    EnsonoSupportLevel   = "${var.supportlvl_tag}"
  }

  root_block_device {
    volume_type = "gp2"
    volume_size = "333"
    delete_on_termination = "false"
  }
}

#-----------------------------------------------------
# WCD Instances - #2
#-----------------------------------------------------
resource "aws_instance" "wcd02" {
  lifecycle { prevent_destroy = "true" }
  ami                    = "${var.redhat_65_ami}"
  instance_type          = "r3.xlarge"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = [ "${aws_security_group.WCD.id}", "${aws_security_group.MANAGEMENT.id}" ]
  subnet_id              = "${aws_subnet.privateAzB.id}"
  iam_instance_profile   = "${aws_iam_instance_profile.s3-efs-backups_instance_profile.name}"
  disable_api_termination = "false"
  ebs_optimized          = "true"

  tags {
    Name                 = "${var.ci_prefix}wcd02${var.env}"
    Description          = "Prod-WRD WCD Instance"
    Monitoring           = "${var.monitoring_tag}"
    "cpm backup"         = "${var.backuphourly_tag}"
    EnsonoSupportLevel   = "${var.supportlvl_tag}"
  }

  root_block_device {
    volume_type = "gp2"
    volume_size = "333"
    delete_on_termination = "false"
  }
}


#-----------------------------------------------------
# Web Instances - #1
#-----------------------------------------------------
resource "aws_instance" "web01" {
  lifecycle { prevent_destroy = "true" }
  ami                    = "${var.amzn_lnx_ami}"
  instance_type          = "m5.large"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = [ "${aws_security_group.WEB.id}", "${aws_security_group.MANAGEMENT.id}" ]
  subnet_id              = "${aws_subnet.publicAzA.id}"
  iam_instance_profile   = "iam_WEB"
  disable_api_termination = "true"
  ebs_optimized          = "true"

  tags {
    Name                 = "${var.ci_prefix}web01${var.env}"
    Description          = "Prod-WRD Varnish Instance"
    Monitoring           = "${var.monitoring_tag}"
    "cpm backup"         = "${var.backup_tag}"
    EnsonoSupportLevel   = "${var.supportlvl_tag}"
  }

  root_block_device {
    volume_type = "standard"
    volume_size = "20"
    delete_on_termination = "false"
  }
}



resource "aws_eip" "web01" {
    vpc = true
}

#-----------------------------------------------------
# Web Instances - #2
#-----------------------------------------------------
resource "aws_instance" "web02" {
  lifecycle { prevent_destroy = "true" }
  ami                    = "${var.amzn_lnx_ami}"
  instance_type          = "m5.large"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = [ "${aws_security_group.WEB.id}", "${aws_security_group.MANAGEMENT.id}" ]
  subnet_id              = "${aws_subnet.publicAzB.id}"
  iam_instance_profile   = "iam_WEB"
  disable_api_termination = "true"
  ebs_optimized          = "true"

  tags {
    Name                 = "${var.ci_prefix}web02${var.env}"
    Description          = "Prod-WRD Varnish Instance"
    Monitoring           = "${var.monitoring_tag}"
    "cpm backup"         = "${var.backup_tag}"
    EnsonoSupportLevel   = "${var.supportlvl_tag}"
  }

  root_block_device {
    volume_type = "standard"
    volume_size = "20"
    delete_on_termination = "false"
  }
}

#-----------------------------------------------------
# Web Instances - #3
#-----------------------------------------------------
#resource "aws_instance" "web03" {
#  lifecycle { prevent_destroy = "true" }
#  ami                    = "ami-4fddcaa5"
#  instance_type          = "c5.xlarge"
#  key_name               = "${var.key_name}"
#  vpc_security_group_ids = [ "${aws_security_group.WEB.id}", "${aws_security_group.MANAGEMENT.id}" ]
#  subnet_id              = "${aws_subnet.publicAzA.id}"
#  iam_instance_profile   = "iam_WEB"
#  disable_api_termination = "false"
#  ebs_optimized          = "false"
#
#  tags {
#    Name                 = "${var.ci_prefix}web03${var.env}"
#    Description          = "Web clone for Testing - F1169442"
#    EnsonoSupportLevel   = "${var.supportlvl_tag}"
#  }
#
#  root_block_device {
#    volume_type = "gp2"
#    volume_size = "20"
#    delete_on_termination = "true"
#  }
#}


