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