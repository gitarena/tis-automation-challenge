output "dns_name" {
	value = ["${aws_instance.webserver-linux.*.public_dns}"]
}