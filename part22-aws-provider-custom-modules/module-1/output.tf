output "public_ip" {
  value = aws_instance.apache_webserver.public_ip
  
}