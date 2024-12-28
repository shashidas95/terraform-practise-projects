output "instance_public_ip" {
 description = "This is public ip of the instance"
  value = aws_instance.tf_ec2_instance.public_ip
}

output "instance_url" {
 description = "This is url to access the nginx server"
  value = "http://${aws_instance.tf_ec2_instance.public_ip}"
}
output "instance_id" {
  value = aws_instance.tf_ec2_instance.id
}
output "ssh_to_ec2_instance" {
  value = "ssh -i ~/.ssh/terraform-ec2-key.pem ubuntu@${aws_instance.tf_ec2_instance.public_ip}"
}