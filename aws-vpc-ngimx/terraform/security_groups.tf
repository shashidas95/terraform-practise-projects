resource "aws_security_group" "tf_nginx_sg" {
  description = "Allow HTTP and HTTPS traffic"
  vpc_id = aws_vpc.tf_vpc.id

  #inbound rules
  ingress{
   from_port = 80
   to_port = 80
   protocol = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
  }
   #Http traffic
  ingress{
   from_port = 443
   to_port = 443
   protocol = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
  }
  #outbound rules
  egress{
    from_port = 0
   to_port = 0
   protocol = "-1"
   cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "nginx-sg"
  }

}