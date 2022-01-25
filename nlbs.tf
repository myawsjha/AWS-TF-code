#----------------------------------------------------------------------------------
# Create an NLB
# Note that new EIPs will be assigned to each associated subnet
# !!!NLB has no security groups - it is trasparent source IP is passed to the target
# allowing access to be controlled by the instance sec. groups
#-----------------------------------------------------------------------------------

resource "aws_lb" "ntt43nlb01prd" {
  name               = "${var.ci_prefix}nlb01${var.env}"
  internal           = true
  load_balancer_type = "network"
  subnets            = [ "${aws_subnet.privateAzA.id}", "${aws_subnet.privateAzB.id}" ]


  enable_deletion_protection = false
  enable_cross_zone_load_balancing = false

  tags {
    Description = "APIv2 Gateway Prod VPC Load Balancer"
    EnsonoSupportLevel = "${var.supportlvl_tag}"
  }
}

#------------------------------------------------------------------------------
# Create listeners and routing actions
#------------------------------------------------------------------------------

resource "aws_lb_listener" "nlb01prd-listener-1" {
  load_balancer_arn = "${aws_lb.ntt43nlb01prd.arn}"
  port              = "9094"
  protocol          = "TCP"

  default_action {
    target_group_arn = "${aws_lb_target_group.prd-placesapi-v2.arn}"
    type             = "forward"
  }
  depends_on = ["aws_lb_target_group.prd-placesapi-v2"]
}

resource "aws_lb_listener" "nlb01prd-listener-2" {
  load_balancer_arn = "${aws_lb.ntt43nlb01prd.arn}"
  port              = "9095"
  protocol          = "TCP"

  default_action {
    target_group_arn = "${aws_lb_target_group.prd-eventsapi-v2.arn}"
    type             = "forward"
  }
  depends_on = ["aws_lb_target_group.prd-eventsapi-v2"]
}

resource "aws_lb_listener" "nlb01prd-listener-3" {
  load_balancer_arn = "${aws_lb.ntt43nlb01prd.arn}"
  port              = "9097"
  protocol          = "TCP"

  default_action {
    target_group_arn = "${aws_lb_target_group.prd-taxonomyapi-v2.arn}"
    type             = "forward"
  }
  depends_on = ["aws_lb_target_group.prd-taxonomyapi-v2"]
}

resource "aws_lb_listener" "nlb01prd-listener-4" {
  load_balancer_arn = "${aws_lb.ntt43nlb01prd.arn}"
  port              = "9101"
  protocol          = "TCP"

  default_action {
    target_group_arn = "${aws_lb_target_group.prd-personalisationapi-v2.arn}"
    type             = "forward"
  }
  depends_on = ["aws_lb_target_group.prd-personalisationapi-v2"]
}



resource "aws_lb_listener" "nlb01prd-listener-5" {
  load_balancer_arn = "${aws_lb.ntt43nlb01prd.arn}"
  port              = "9098"
  protocol          = "TCP"

  default_action {
    target_group_arn = "${aws_lb_target_group.eventsapi-v1.arn}"
    type             = "forward"
  }
  depends_on = ["aws_lb_target_group.eventsapi-v1"]
}

resource "aws_lb_listener" "nlb01prd-listener-6" {
  load_balancer_arn = "${aws_lb.ntt43nlb01prd.arn}"
  port              = "9099"
  protocol          = "TCP"

  default_action {
    target_group_arn = "${aws_lb_target_group.placesapi-v1.arn}"
    type             = "forward"
  }
  depends_on = ["aws_lb_target_group.placesapi-v1"]
}




#-------------------------------------------------------------------------------------
# Create Target Groups (instance type) for each listener and attach one or more instances
#-------------------------------------------------------------------------------------

resource "aws_lb_target_group" "prd-eventsapi-v2" {
  name = "${var.env}-eventsapi-v2"
  port = "9095"
  protocol = "TCP"
  vpc_id  = "${aws_vpc.vpc.id}"
  target_type = "instance"
  deregistration_delay = "300"
  slow_start = "0"

  health_check {
    protocol            = "TCP"
    port                = "traffic-port"
    healthy_threshold   = 3
    unhealthy_threshold = 3
    interval            = 30
  }
}


resource "aws_lb_target_group" "prd-personalisationapi-v2" {
  name = "${var.env}-personalisationapi-v2"
  port = "9101"
  protocol = "TCP"
  vpc_id  = "${aws_vpc.vpc.id}"
  target_type = "instance"
  deregistration_delay = "300"
  slow_start = "0"

  health_check {
    protocol            = "TCP"
    port                = "traffic-port"
    healthy_threshold   = 3
    unhealthy_threshold = 3
    interval            = 30
  }
}


resource "aws_lb_target_group" "prd-placesapi-v2" {
  name = "${var.env}-placesapi-v2"
  port = "9094"
  protocol = "TCP"
  vpc_id  = "${aws_vpc.vpc.id}"
  target_type = "instance"
  deregistration_delay = "300"
  slow_start = "0"

  health_check {
    protocol            = "TCP"
    port                = "traffic-port"
    healthy_threshold   = 3
    unhealthy_threshold = 3
    interval            = 30
  }
}


resource "aws_lb_target_group" "prd-taxonomyapi-v2" {
  name = "${var.env}-taxonomyapi-v2"
  port = "9097"
  protocol = "TCP"
  vpc_id  = "${aws_vpc.vpc.id}"
  target_type = "instance"
  deregistration_delay = "300"
  slow_start = "0"

  health_check {
    protocol            = "TCP"
    port                = "traffic-port"
    healthy_threshold   = 3
    unhealthy_threshold = 3
    interval            = 30
  }
}

resource "aws_lb_target_group" "eventsapi-v1" {
  name = "${var.env}-eventsapi-v1"
  port = "9098"
  protocol = "TCP"
  vpc_id  = "${aws_vpc.vpc.id}"
  target_type = "instance"


  health_check {
    healthy_threshold = 3
    unhealthy_threshold = 3
    port = "traffic-port"
    protocol = "TCP"
    interval = 30
  }
}

resource "aws_lb_target_group" "placesapi-v1" {
  name = "${var.env}-placesapi-v1"
  port = "9099"
  protocol = "TCP"
  vpc_id  = "${aws_vpc.vpc.id}"
  target_type = "instance"


  health_check {
    healthy_threshold = 3
    unhealthy_threshold = 3
    port = "traffic-port"
    protocol = "TCP"
    interval = 30
  }
}

### New Target Groups

resource "aws_lb_target_group_attachment" "api-eventsapi-v1-target1" {
  target_group_arn = "${aws_lb_target_group.eventsapi-v1.arn}"
  target_id = "${aws_instance.api01.id}"
  port = "9098"
}

resource "aws_lb_target_group_attachment" "api-eventsapi-v1-target2" {
  target_group_arn = "${aws_lb_target_group.eventsapi-v1.arn}"
  target_id = "${aws_instance.api02.id}"
  port = "9098"
}

resource "aws_lb_target_group_attachment" "api-placesapi-v1-target1" {
  target_group_arn = "${aws_lb_target_group.placesapi-v1.arn}"
  target_id = "${aws_instance.api01.id}"
  port = "9099"
}

resource "aws_lb_target_group_attachment" "api-placesapi-v1-target2" {
  target_group_arn = "${aws_lb_target_group.placesapi-v1.arn}"
  target_id = "${aws_instance.api01.id}"
  port = "9099"
}



#################################################################################################
#####           Target Group Attachments cannot be imported, only created.                  #####
#####     https://www.terraform.io/docs/providers/aws/r/lb_target_group_attachment.html     #####
#################################################################################################

