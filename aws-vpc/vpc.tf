
# create an vpc
resource "aws_vpc" "tf_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "sas_pvc"
  }
}

# create public subnet
resource "aws_subnet" "tf_public_subnet" {
 vpc_id = aws_vpc.tf_vpc.id
 cidr_block = "10.0.1.0/24"
 tags = {
   Name = "sas_public_subnet"
 }
}
# create private subnet
resource "aws_subnet" "tf_private_subnet" {
 vpc_id = aws_vpc.tf_vpc.id
 cidr_block = "10.0.2.0/24"
 tags = {
   Name = "sas_private_subnet"
 }
}
resource "aws_internet_gateway" "tf_igw" {
 vpc_id = aws_vpc.tf_vpc.id
 tags = {
   Name= "sas_igw"
 }
 
}
resource "aws_route_table" "tf_route_table" {
  vpc_id = aws_vpc.tf_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf_igw.id
  }

  tags = {
    Name = "sas_route_table"
  }
}
resource "aws_route_table_association" "tf_rta_pub_sub" {
 route_table_id = aws_route_table.tf_route_table.id
 subnet_id= aws_subnet.tf_public_subnet.id
  
}

output "vpc_id" {
  value = aws_vpc.tf_vpc.id
  
}