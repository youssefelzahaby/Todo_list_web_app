
resource "aws_security_group" "ALB-SG" {
  name        = "ALB-SG"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.to_do_vpc.id

  tags = {
    Name = "ALB-SG"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ALB-SG_ipv4" {
  security_group_id = aws_security_group.ALB-SG.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}


resource "aws_vpc_security_group_egress_rule" "ALB-SG_to_EC2" {

  security_group_id = aws_security_group.ALB-SG.id

  referenced_security_group_id = aws_security_group.EC2-SG.id

  from_port = 80

  ip_protocol = "tcp"

  to_port = 80

}

# ec2 security group

resource "aws_security_group" "EC2-SG" {
  name        = "EC2-SG"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.to_do_vpc.id

  tags = {
    Name = "EC2-SG"
  }
}


resource "aws_vpc_security_group_ingress_rule" "EC2-SG_ipv4" {
  security_group_id = aws_security_group.EC2-SG.id

  referenced_security_group_id = aws_security_group.ALB-SG.id

  from_port   = 80
  to_port     = 80
  ip_protocol = "tcp"
}


resource "aws_vpc_security_group_egress_rule" "EC2-SG_to_RDS-SG" {

  security_group_id = aws_security_group.EC2-SG.id

  referenced_security_group_id = aws_security_group.RDS-SG.id

  from_port = 3306

  ip_protocol = "tcp"

  to_port = 3306
}





resource "aws_security_group" "RDS-SG" {
  name        = "RDS-SG"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.to_do_vpc.id

  tags = {
    Name = "RDS-SG"
  }
}


resource "aws_vpc_security_group_ingress_rule" "RDS-SG_ipv4" {
  security_group_id = aws_security_group.RDS-SG.id

  referenced_security_group_id = aws_security_group.EC2-SG.id

  from_port   = 3306
  to_port     = 3306
  ip_protocol = "tcp"
}


resource "aws_vpc_security_group_egress_rule" "RDS-SG_to_EC2" {

  security_group_id = aws_security_group.RDS-SG.id

  referenced_security_group_id = aws_security_group.EC2-SG.id

  from_port = 3306

  ip_protocol = "tcp"

  to_port = 3306
}