# vpc
variable "cidr" {
    description = "value for cidr block"
}

#public subnet-1
variable "cidr_public1" {
    description = "Cidr block value for public subnet 1"
  
}
variable "availability_zone_public_subnet1" {
    description = "value for availability zone public-subnet-1"
  
}
variable "map_public_ip_on_launch"  {
    description = "value for map_public_ip_on_launch"
  
}

#public subnet-2
variable "cidr_public2" {
    description = "Cidr block value for public subnet 2"
  
}
variable "availability_zone_public_subnet2" {
    description = "value for availability zone public-subnet-2"
  
}

#Route table
variable "cidr_route" {
    description = "route cidr block value"
  
}

#security group
#ingress 1
variable "from_port" {
    description = "from_port value for first inbound rule"
  
}
variable "to_port" {
    description = "to_port value for first inbound rule"
  
}
variable "protocal" {
    description = "protocal type for first inbound rule"
  
}
variable "ing1cidr" {
    description = "cidr block for first inbound rule"
  
}
#ingress 2
variable "from_port2" {
    description = "from_port value for first inbound rule"
  
}
variable "to_port2" {
    description = "to_port value for first inbound rule"
  
}
variable "protocal2" {
    description = "protocal type for first inbound rule"
  
}
variable "ing2cidr" {
    description = "cidr block for first inbound rule"
  
}
#engress
variable "from_port_e" {
    description = "from_port value for first inbound rule"
  
}
variable "to_port_e" {
    description = "to_port value for first inbound rule"
  
}
variable "protocal_e" {
    description = "protocal type for first inbound rule"
  
}
variable "engcidr" {
    description = "cidr block for first inbound rule"
  
}

#ec2 instance 
variable "ami" {
    description = "ami value"
  
}
variable "keyname" {
  description = "keyname value"
}