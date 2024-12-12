# output "instance_public_ips" {
#   value = { for i in aws_instance.aws_instance.srv_webserver_rwa : i.tags["Name"] => i.public_ip }
# }
