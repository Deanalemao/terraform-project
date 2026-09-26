resource "aws_vpc" "myvpc" {
    cidr_block = var.cidr
}

# public subnet-1
resource "aws_subnet" "subnet1" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = var.cidr_public1
    availability_zone = var.availability_zone_public_subnet1
    map_public_ip_on_launch = var.map_public_ip_on_launch
  
}

#public subnet-2
resource "aws_subnet" "subnet2" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = var.cidr_public2
    availability_zone = var.availability_zone_public_subnet2
    map_public_ip_on_launch = var.map_public_ip_on_launch
}

#Internet Gateway
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.myvpc.id
}

#Route table
resource "aws_route_table" "RT" {
    vpc_id = aws_vpc.myvpc.id

    route {
        cidr_block = var.cidr_route
        gateway_id = aws_internet_gateway.igw.id
    }

}

#route table association
resource "aws_route_table_association" "rta1" {
    subnet_id = aws_subnet.subnet1.id
    route_table_id = aws_route_table.RT
  
}

#route table association
resource "aws_route_table_association" "rta2" {
    subnet_id = aws_subnet.subnet2.id
    route_table_id = aws_route_table.RT
  
}