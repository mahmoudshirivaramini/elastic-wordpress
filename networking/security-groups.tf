resource "aws_security_group" "BastionSG" {
  name        = "BastionSG"
  description = "used for access to the bastion instances"
  vpc_id      = aws_vpc.ewp_vpc.id
}

resource "aws_security_group" "LoadBalancerSG" {
  name        = "LoadBalancerSG"
  description = "used for access to the loadbalancer using HTTP, HTTPS"
  vpc_id      = aws_vpc.ewp_vpc.id
}

 resource "aws_security_group" "WebServerSG" {
   name        = "WebServerSG"
   description = "used for access from loadbalancer using HTTP, HTTPS and SSH form bastion hosts"
   vpc_id      = aws_vpc.ewp_vpc.id
}
 
 resource "aws_security_group" "DatabaseSG" {
  name        = "DatabaseSG"
  description = "used for access to the database from webservers"
  vpc_id      = aws_vpc.ewp_vpc.id
}

resource "aws_security_group_rule" "BastionSG_ssh" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = [var.accessip]
  security_group_id = aws_security_group.BastionSG.id
}

resource "aws_security_group_rule" "BastionSG_egress" {
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = [var.accessip]
  security_group_id = aws_security_group.BastionSG.id
}

resource "aws_security_group_rule" "LoadBalancerSG_http" {
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = [var.accessip]
  security_group_id = aws_security_group.LoadBalancerSG.id
}

resource "aws_security_group_rule" "LoadBalancerSG_https" {
  type = "ingress"
  from_port = 443
  to_port = 443
  protocol = "tcp"
  cidr_blocks = [var.accessip]
  security_group_id = aws_security_group.LoadBalancerSG.id
}

resource "aws_security_group_rule" "LoadBalancerSG_egress" {
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = [var.accessip]
  security_group_id = aws_security_group.LoadBalancerSG.id
}

resource "aws_security_group_rule" "WebServerSG_ssh" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  source_security_group_id = aws_security_group.BastionSG.id
  security_group_id = aws_security_group.WebServerSG.id
}

resource "aws_security_group_rule" "WebServerSG_http" {
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  source_security_group_id = aws_security_group.LoadBalancerSG.id
  security_group_id = aws_security_group.WebServerSG.id
}

resource "aws_security_group_rule" "WebServerSG_https" {
  type = "ingress"
  from_port = 443
  to_port = 443
  protocol = "tcp"
  source_security_group_id = aws_security_group.LoadBalancerSG.id
  security_group_id = aws_security_group.WebServerSG.id
}

resource "aws_security_group_rule" "WebServerSG_egress" {
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = [var.accessip]
  security_group_id = aws_security_group.WebServerSG.id
}

resource "aws_security_group_rule" "DatabaseSG_MySQL" {
  type = "ingress"
  from_port = 3306
  to_port = 3306
  protocol = "tcp"
  source_security_group_id = aws_security_group.WebServerSG.id
  security_group_id = aws_security_group.DatabaseSG.id
}

resource "aws_security_group_rule" "DatabaseSG_egress" {
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = [var.accessip]
  security_group_id = aws_security_group.DatabaseSG.id
}