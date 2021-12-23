output "dns_name" {
	value = aws_instance.webserver-[*].public_dns
}