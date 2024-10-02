###########
### RDS ###
###########

resource "aws_security_group" "rds" {
  name        = "${var.name}-host-rds-sg"
  description = "Manage inbound and outbound traffic for ${var.name}-host-rds"
  vpc_id      = aws_vpc.host.id

  tags = {
    Name      = "Security Group for ${var.name}-host-rds"
    Template  = "sg.tf"
  }
}

resource "aws_vpc_security_group_ingress_rule" "rds-private" {
  security_group_id            = aws_security_group.rds.id
  referenced_security_group_id = aws_security_group.host.id
  ip_protocol                  = "tcp"
  from_port                    = "3306"
  to_port                      = "3306"
}

# resource "aws_vpc_security_group_egress_rule" "rds-outbound" {
#   security_group_id = aws_security_group.rds.id
#   cidr_ipv4         = "0.0.0.0/0"
#   ip_protocol       = "-1"
# }

###########
### EC2 ###
###########

resource "aws_security_group" "host" {
  name        = "${var.name}-host-sg"
  description = "Manage inbound and outbound traffic for ${var.name}-host"
  vpc_id      = aws_vpc.host.id

  tags = {
    Name      = "Security Group for ${var.name}-host"
    Template  = "sg.tf"
  }
}

resource "aws_vpc_security_group_ingress_rule" "host-ssh-ipv6" {
  security_group_id = aws_security_group.host.id
  prefix_list_id    = data.aws_ec2_managed_prefix_list.aws-ec2-instance-connect-ipv6.id
  ip_protocol       = "tcp"
  from_port         = "22"
  to_port           = "22"
}

resource "aws_vpc_security_group_ingress_rule" "host-ssh-ipv4" {
  security_group_id = aws_security_group.host.id
  cidr_ipv4         = local.my_public_ip_cidr
  ip_protocol       = "tcp"
  from_port         = "22"
  to_port           = "22"
}

resource "aws_vpc_security_group_ingress_rule" "host-https-ipv4" {
  security_group_id = aws_security_group.host.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = "443"
  to_port           = "443"
}

resource "aws_vpc_security_group_ingress_rule" "host-https-ipv6" {
  security_group_id = aws_security_group.host.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "tcp"
  from_port         = "443"
  to_port           = "443"
}

resource "aws_vpc_security_group_egress_rule" "host-ipv4" {
  security_group_id = aws_security_group.host.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_egress_rule" "host-ipv6" {
  security_group_id = aws_security_group.host.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1"
}
