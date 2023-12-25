provider "aws"{
    region = "ap-south-1"
    alias = "env"
}
resource "aws_vpc" "my_vpc"{
    cidr_block = "10.10.0.0/16"
    tags = {
        Name : "my_vpc"
    }
}

resource "aws_subnet" "subnet-task2" {
  vpc_id = aws_vpc.my_vpc.id
  
  cidr_block = "10.10.1.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "task-2-Subnet"
  }
}

resource "aws_internet_gateway" "task2_IGW" {
  vpc_id = aws_vpc.my_vpc.id
    tags = {
        Name = "task-2-IGW"
    }
}

resource "aws_route_table" "task2_route_table" {
    vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "task-2-route-table"
  }
}

resource "aws_route" "task2_route" {

    route_table_id = aws_route_table.task2_route_table.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.task2_IGW.id
}

resource "aws_route_table_association" "associate" {
    route_table_id = aws_route_table.task2_route_table.id
  subnet_id = aws_subnet.subnet-task2.id
}