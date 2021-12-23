output "dns_name" {
	value = aws_instance.webserver-linux${count.index}.public_dns
}