resource "aws_vpc" "terrefvpc" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "terrefpubsub" {
  vpc_id = aws_vpc.terrefvpc.id
  cidr_block = var.publicsunet_cidr_block
  availability_zone = var.availability_zone
  map_public_ip_on_launch = true
  tags = {
      Name = var.public_subnet_name
  } 
}

resource "aws_subnet" "terrefprisub" {
    vpc_id = aws_vpc.terrefvpc.id
    cidr_block = var.privatesubnet_cidr_block
    availability_zone = var.availability_zone
    tags = {
      Name = var.private_subnet_name
    } 
}


resource "aws_internet_gateway" "terrefigw" {
  vpc_id = aws_vpc.terrefvpc.id

  tags = {
    Name = "myinternetgw"
  }
}

resource "aws_eip" "terrefeip" {
  domain = "vpc"

  tags = {
    Name = "my-elastic-ip"
  }
}

resource "aws_nat_gateway" "terrefnatgw" {
  allocation_id = aws_eip.terrefeip.id
  subnet_id     = aws_subnet.terrefpubsub.id
  depends_on = [ aws_internet_gateway.terrefigw]

  tags = {
    Name = "mynat"
  }
}

resource "aws_route_table" "terrefpubrt" {
  vpc_id = aws_vpc.terrefvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terrefigw.id
  }

  tags = {
    Name = "PublicRouteTable"
  }
}


resource "aws_route_table" "terrefprirt" {
  vpc_id = aws_vpc.terrefvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.terrefnatgw.id
  }

  tags = {
    Name = "PrivateRouteTable"
  }
}

resource "aws_route_table_association" "terrefpubtrtassoc" {
  subnet_id      = aws_subnet.terrefpubsub.id
  route_table_id = aws_route_table.terrefpubrt.id
}

resource "aws_route_table_association" "terrefprirouassoci" {
  subnet_id      = aws_subnet.terrefprisub.id
  route_table_id = aws_route_table.terrefprirt.id
}

resource "aws_security_group" "terrefsg" {
  name        = "mynewsg"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.terrefvpc.id

  tags = {
    Name = "mynewsg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "terrefsgigr1" {
  security_group_id = aws_security_group.terrefsg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "terrefsgigr2" {
  security_group_id = aws_security_group.terrefsg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "terrefsgigr3" {
  security_group_id = aws_security_group.terrefsg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "terrefsgigr4" {
  security_group_id = aws_security_group.terrefsg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 8080
  ip_protocol       = "tcp"
  to_port           = 8080
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.terrefsg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
