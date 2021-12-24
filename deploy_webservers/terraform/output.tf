output "dns_name_webserver_linux" {
  value = ["${aws_instance.webserver-linux.*.public_dns}"]
}
output "dns_name_webserver_windows" {
  value = ["${aws_instance.webserver-win.*.public_dns}"]
}