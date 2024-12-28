resource "aws_instance" "tf_ec2_instance" {
 ami = var.ami_id
 instance_type = var.instance_type

 key_name = var.key_name
 vpc_security_group_ids = [aws_security_group.tf_nginx_sg.id]
 subnet_id = aws_subnet.tf_public_subnet.id
 associate_public_ip_address = true
 user_data = <<-EOF
  #!/bin/bash
  sudo apt install nginx -y
  sudo systemctl start nginx

 EOF
 tags = {
   Name = var.app_name
 }
}

