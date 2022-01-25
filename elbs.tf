#-----------------------------------
#    ntt43elb01prd-web-internal    
#-----------------------------------

resource "aws_elb" "ntt43elb01prd-web-internal" {
  name = "${var.ci_prefix}elb01${var.env}-web-internal"
  subnets = [ "${aws_subnet.publicAzA.id}", "${aws_subnet.publicAzB.id}" ]
  security_groups = [ "${aws_security_group.ELB-WEB-INTERNAL.id}" ]

  listener {
    instance_port = 84
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }

  listener {
    instance_port = 84
    instance_protocol = "http"
    lb_port = 443
    lb_protocol = "https"
    ssl_certificate_id = "${var.elb_ssl_arn}"
  }

  health_check {
    target = "HTTP:84/cs/HelloCS"
	timeout = 4
	interval = 5
	unhealthy_threshold = 3
	healthy_threshold = 3
  }

  cross_zone_load_balancing = true
  idle_timeout = 60
  connection_draining = true
  connection_draining_timeout = 300

 instances = [ "${aws_instance.web01.id}", "${aws_instance.web02.id}" ]

  tags {
    Name                    = "${var.ci_prefix}elb01${var.env}-web-internal"
    Description             = "Production WRD internal ELB"
    EnsonoSupportLevel      = "${var.supportlvl_tag}"
	ELB_Usage               = "ntt43elb01-prd-internal"
  }
}


#-----------------------------------
#    ntt43elb02prd-web-external
#         internet-facing
#-----------------------------------

resource "aws_elb" "ntt43elb02prd-web-external" {
  name = "${var.ci_prefix}elb02${var.env}-web-external"
  subnets = [ "${aws_subnet.publicAzA.id}", "${aws_subnet.publicAzB.id}" ]
  security_groups = [ "${aws_security_group.ELB-WEB-EXTERNAL.id}", "${aws_security_group.ReSRCIt.id}" ]

  listener {
    instance_port = 84
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }

  listener {
    instance_port = 84
    instance_protocol = "http"
    lb_port = 443
    lb_protocol = "https"
    ssl_certificate_id = "${var.elb_ssl_arn}"
  }

  health_check {
    target = "HTTP:84/cs/HelloCS"
	timeout = 4
	interval = 5
	unhealthy_threshold = 3
	healthy_threshold = 3
  }

  cross_zone_load_balancing = true
  idle_timeout = 60
  connection_draining = true
  connection_draining_timeout = 300

 instances = [ "${aws_instance.web01.id}", "${aws_instance.web02.id}" ]

  tags {
    Name                    = "${var.ci_prefix}elb02${var.env}-web-external"
    Description             = "Production WRD public ELB"
    EnsonoSupportLevel      = "${var.supportlvl_tag}"
	ELB_Usage               = "ntt43elb02prd-web-external"
  }
}


#-----------------------------------
#   ntt43elb03prd-AggregationAPI
#-----------------------------------

resource "aws_elb" "ntt43elb03prd-AggregationAPI" {
  name = "${var.ci_prefix}elb03${var.env}-AggregationAPI"
  subnets = [ "${aws_subnet.privateAzA.id}", "${aws_subnet.privateAzB.id}" ]
  security_groups = [ "${aws_security_group.ELB-AGGREGATION-API.id}" ]

  listener {
    instance_port = 9096
    instance_protocol = "TCP"
    lb_port = 9096
    lb_protocol = "TCP"
  }

  health_check {
    target = "HTTP:9096/searchapi/health/application"
	timeout = 4
	interval = 5
	unhealthy_threshold = 3
	healthy_threshold = 3
  }

  cross_zone_load_balancing = true
  idle_timeout = 60
  connection_draining = true
  connection_draining_timeout = 300

 instances = [ "${aws_instance.api01.id}", "${aws_instance.api02.id}" ]

  tags {
    Name                    = "${var.ci_prefix}elb03${var.env}-AggregationAPI"
    Description             = "Production WRD ELB for Aggregation API"
    EnsonoSupportLevel      = "${var.supportlvl_tag}"
	ELB_Usage               = "ntt43elb03prd-AggregationAPI"
  }
}


#-----------------------------------
#     ntt43elb04prd-PlacesAPI
#-----------------------------------

resource "aws_elb" "ntt43elb04prd-PlacesAPI" {
  name = "${var.ci_prefix}elb04${var.env}-PlacesAPI"
  subnets = [ "${aws_subnet.privateAzA.id}", "${aws_subnet.privateAzB.id}" ]
  security_groups = [ "${aws_security_group.ELB-PLACES-API.id}" ]

  listener {
    instance_port = 9094
    instance_protocol = "TCP"
    lb_port = 9094
    lb_protocol = "TCP"
  }

  health_check {
    target = "HTTP:9094/health/application"
	timeout = 4
	interval = 5
	unhealthy_threshold = 3
	healthy_threshold = 3
  }

  cross_zone_load_balancing = true
  idle_timeout = 60
  connection_draining = true
  connection_draining_timeout = 300

 instances = [ "${aws_instance.api01.id}", "${aws_instance.api02.id}" ]

  tags {
    Name                    = "${var.ci_prefix}elb04${var.env}-PlacesAPI"
    Description             = "Production WRD ELB for Places API"
    EnsonoSupportLevel      = "${var.supportlvl_tag}"
	ELB_Usage               = "ntt43elb04prd-PlacesAPI"
  }
}

#-----------------------------------
#     ntt43elb05prd-EventsAPI
#-----------------------------------

resource "aws_elb" "ntt43elb05prd-EventsAPI" {
  name = "${var.ci_prefix}elb05${var.env}-EventsAPI"
  subnets = [ "${aws_subnet.privateAzA.id}", "${aws_subnet.privateAzB.id}" ]
  security_groups = [ "${aws_security_group.ELB-EVENTS-API.id}" ]

  listener {
    instance_port = 9095
    instance_protocol = "TCP"
    lb_port = 9095
    lb_protocol = "TCP"
  }

  health_check {
    target = "HTTP:9095/eventsapi/health/application"
	timeout = 4
	interval = 5
	unhealthy_threshold = 3
	healthy_threshold = 3
  }

  cross_zone_load_balancing = true
  idle_timeout = 60
  connection_draining = true
  connection_draining_timeout = 300

 instances = [ "${aws_instance.api01.id}", "${aws_instance.api02.id}" ]

  tags {
    Name                    = "${var.ci_prefix}elb05${var.env}-EventsAPI"
    Description             = "Production WRD ELB for Events API"
    EnsonoSupportLevel      = "${var.supportlvl_tag}"
	ELB_Usage               = "ntt43elb05prd-EventsAPI"
  }
}

#-----------------------------------
#    ntt43elb06prd-wca-internal
#-----------------------------------

resource "aws_elb" "ntt43elb06prd-wca-internal" {
  name = "${var.ci_prefix}elb06${var.env}-wca-internal"
  subnets = [ "${aws_subnet.privateAzA.id}", "${aws_subnet.privateAzB.id}" ]
  security_groups = [ "${aws_security_group.ELB-WCA.id}" ]

  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }
  
  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 443
    lb_protocol = "https"
    ssl_certificate_id = "${var.elb_ssl_arn}"
  }
  
  health_check {
    target = "HTTP:80/cs/CatalogManager?ftcmd=pingdb"
	timeout = 4
	interval = 5
	unhealthy_threshold = 3
	healthy_threshold = 3
  }

  cross_zone_load_balancing = true
  idle_timeout = 600
  connection_draining = true
  connection_draining_timeout = 300

 instances = [ "${aws_instance.wca01.id}", "${aws_instance.wca02.id}" ]

  tags {
    Name                    = "${var.ci_prefix}elb06${var.env}-wca-internal"
    Description             = "Production WRD Internal CMS ELB"
    EnsonoSupportLevel      = "${var.supportlvl_tag}"
	ELB_Usage               = "ntt43elb06prd-wca-internal"
  }
}

#------------------------------------------------
# Cookie Stickiness Policy - cannot be imported
#------------------------------------------------

resource "aws_lb_cookie_stickiness_policy" "lb-ntt43elb06prd-wca-internal-policy" {
  name = "lb-ntt43elb06prd-wca-internal-policy"
  load_balancer = "${aws_elb.ntt43elb06prd-wca-internal.id}"
  lb_port = 443
  cookie_expiration_period = 86400
}



#-----------------------------------
#    ntt43elb07prd-TaxonomyAPI
#-----------------------------------

resource "aws_elb" "ntt43elb07prd-TaxonomyAPI" {
  name = "${var.ci_prefix}elb07${var.env}-TaxonomyAPI"
  subnets = [ "${aws_subnet.privateAzA.id}", "${aws_subnet.privateAzB.id}" ]
  security_groups = [ "${aws_security_group.ELB-TaxonomyAPI.id}" ]

  listener {
    instance_port = 9097
    instance_protocol = "TCP"
    lb_port = 9097
    lb_protocol = "TCP"
  }
  
  health_check {
    target = "HTTP:9097/health/application"
	timeout = 4
	interval = 5
	unhealthy_threshold = 3
	healthy_threshold = 3
  }

  cross_zone_load_balancing = true
  idle_timeout = 60
  connection_draining = true
  connection_draining_timeout = 300

 instances = [ "${aws_instance.api01.id}", "${aws_instance.api02.id}" ]

  tags {
    Name                    = "${var.ci_prefix}elb07${var.env}-TaxonomyAPI"
    Description             = "Production WRD ELB for Taxonomy API"
    EnsonoSupportLevel      = "${var.supportlvl_tag}"
	ELB_Usage               = "ntt43elb07prd-TaxonomyAPI"
  }
}

#-----------------------------------
#  ntt43elb08prd-PersonalisationAPI
#-----------------------------------

resource "aws_elb" "ntt43elb08prd-PersonalisationAPI" {
  name = "${var.ci_prefix}elb08${var.env}-PersonalisationAPI"
  subnets = [ "${aws_subnet.privateAzA.id}", "${aws_subnet.privateAzB.id}" ]
  security_groups = [ "${aws_security_group.ELB-Personalisation-API.id}" ]

  listener {
    instance_port = 9101
    instance_protocol = "TCP"
    lb_port = 9101
    lb_protocol = "TCP"
  }
  
  health_check {
    target = "HTTP:9101/management/health"
	timeout = 4
	interval = 5
	unhealthy_threshold = 3
	healthy_threshold = 3
  }

  cross_zone_load_balancing = true
  idle_timeout = 60
  connection_draining = true
  connection_draining_timeout = 60

 instances = [ "${aws_instance.api01.id}", "${aws_instance.api02.id}" ]

  tags {
    Name                    = "${var.ci_prefix}elb08${var.env}-PersonalisationAPI"
    Description             = "Production WRD ELB for Personalisation API"
    EnsonoSupportLevel      = "${var.supportlvl_tag}"
	ELB_Usage               = "ntt43elb08prd-PersonalisationAPI"
  }
}


