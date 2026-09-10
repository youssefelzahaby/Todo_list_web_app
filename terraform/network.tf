# ==========================================
# VPC
# ==========================================

resource "aws_vpc" "to_do_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "to_do_vpc"
  }
}


# ==========================================
# Subnets - AZ A
# ==========================================

resource "aws_subnet" "public_a" {
  vpc_id            = aws_vpc.to_do_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "public-a"
  }
}

resource "aws_subnet" "private_app_a" {
  vpc_id            = aws_vpc.to_do_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "private-app-a"
  }
}

resource "aws_subnet" "private_db_a" {
  vpc_id            = aws_vpc.to_do_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "private-db-a"
  }
}


# ==========================================
# Subnets - AZ B
# ==========================================

resource "aws_subnet" "public_b" {
  vpc_id            = aws_vpc.to_do_vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "public-b"
  }
}

resource "aws_subnet" "private_app_b" {
  vpc_id            = aws_vpc.to_do_vpc.id
  cidr_block        = "10.0.5.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "private-app-b"
  }
}

resource "aws_subnet" "private_db_b" {
  vpc_id            = aws_vpc.to_do_vpc.id
  cidr_block        = "10.0.6.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "private-db-b"
  }
}


# ==========================================
# Internet Gateway
# ==========================================

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.to_do_vpc.id

  tags = {
    Name = "main-igw"
  }
}


# ==========================================
# NAT Gateway - AZ A
# ==========================================

resource "aws_eip" "nat_a" {
  domain = "vpc"

  tags = {
    Name = "nat-eip-a"
  }
}

resource "aws_nat_gateway" "nat_a" {
  allocation_id = aws_eip.nat_a.id
  subnet_id     = aws_subnet.public_a.id

  tags = {
    Name = "nat-gateway-a"
  }

  depends_on = [aws_internet_gateway.igw]
}


# ==========================================
# NAT Gateway - AZ B
# ==========================================

resource "aws_eip" "nat_b" {
  domain = "vpc"

  tags = {
    Name = "nat-eip-b"
  }
}

resource "aws_nat_gateway" "nat_b" {
  allocation_id = aws_eip.nat_b.id
  subnet_id     = aws_subnet.public_b.id

  tags = {
    Name = "nat-gateway-b"
  }

  depends_on = [aws_internet_gateway.igw]
}


# ==========================================
# Public Route Table
# ==========================================

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.to_do_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-rt"
  }
}


# ==========================================
# Private Route Table - AZ A
# ==========================================

resource "aws_route_table" "private_a" {
  vpc_id = aws_vpc.to_do_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_a.id
  }

  tags = {
    Name = "private-rt-a"
  }
}


# ==========================================
# Private Route Table - AZ B
# ==========================================

resource "aws_route_table" "private_b" {
  vpc_id = aws_vpc.to_do_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_b.id
  }

  tags = {
    Name = "private-rt-b"
  }
}


# ==========================================
# Public Route Table Associations
# ==========================================

resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public.id
}


# ==========================================
# Private Route Table Associations - AZ A
# ==========================================

resource "aws_route_table_association" "private_app_a" {
  subnet_id      = aws_subnet.private_app_a.id
  route_table_id = aws_route_table.private_a.id
}

resource "aws_route_table_association" "private_db_a" {
  subnet_id      = aws_subnet.private_db_a.id
  route_table_id = aws_route_table.private_a.id
}


# ==========================================
# Private Route Table Associations - AZ B
# ==========================================

resource "aws_route_table_association" "private_app_b" {
  subnet_id      = aws_subnet.private_app_b.id
  route_table_id = aws_route_table.private_b.id
}

resource "aws_route_table_association" "private_db_b" {
  subnet_id      = aws_subnet.private_db_b.id
  route_table_id = aws_route_table.private_b.id
}