resource "aws_instance" "tf_ec2_instance" {
 ami = var.ami_id
 instance_type = var.instance_type
 associate_public_ip_address = true
 key_name = var.key_name
 subnet_id = aws_subnet.tf_public_subnet.id
 tags = {
   Name = var.app_name
 }
}

