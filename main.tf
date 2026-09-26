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
    route_table_id = aws_route_table.RT.id
  
}

#route table association
resource "aws_route_table_association" "rta2" {
    subnet_id = aws_subnet.subnet2.id
    route_table_id = aws_route_table.RT.id
  
}

#security group
resource "aws_security_group" "webSg" {
  name        = "websg"
  vpc_id      = aws_vpc.myvpc.id

  ingress {
    description = "http from VPC"
    from_port = var.from_port
    to_port = var.to_port
    protocol = var.protocal
    cidr_blocks = var.ing1cidr
    
  }

  ingress {
    description = "SSH"
    from_port = var.from_port2
    to_port = var.to_port2
    protocol = var.protocal2
    cidr_blocks = var.ing2cidr
    
  }

  egress {
    from_port        = var.from_port_e
    to_port          = var.to_port_e
    protocol         = var.protocal_e
    cidr_blocks      = var.engcidr
  }

  tags = {
    Name = "web-sg"
  }
}

#s3 bucket
resource "aws_s3_bucket" "example" {
  bucket = "project-test-bucket-demo"
}

#ec2 instance 1
resource "aws_instance" "webserver1" {
    ami = var.ami
    key_name = var.keyname
    subnet_id = aws_subnet.subnet1.id
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.webSg.id]
    user_data = base64decode(file("userdata.sh"))
  
}
#ec2 instance 2
resource "aws_instance" "webserver2" {
    ami = var.ami
    key_name = var.keyname
    subnet_id = aws_subnet.subnet2.id
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.webSg.id]
    user_data = base64decode(file("userdata1.sh"))
  
}

#create loadbalancer

resource "aws_lb" "myalb" {
  name               = "myalb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.webSg.id]
  subnets            = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]

  tags = {
    Name = "web"
  }
}
#alb target group
resource "aws_alb_target_group" "tg" {
    name = "myTG"
    port = var.TGport
    protocol = "HTTP"
    vpc_id = aws_vpc.myvpc.id

    health_check {
      path = "/"
      port = "traffic-port"
    }
}
#alb attach 1
resource "aws_alb_target_group_attachment" "attach1" {
    target_group_arn = aws_alb_target_group.tg.arn
    target_id = aws_instance.webserver1.id
    port = var.TGport
}
#alb attach 2
resource "aws_alb_target_group_attachment" "attach2" {
    target_group_arn = aws_alb_target_group.tg.arn
    target_id = aws_instance.webserver2.id
    port = var.TGport
}
#alb listener
resource "aws_alb_listener" "listener" {
    load_balancer_arn = aws_lb.myalb.arn
    port = var.TGport
    protocol = "HTTP"

    default_action {
      target_group_arn = aws_alb_target_group.tg.arn
      type = "forward"
    }
}

