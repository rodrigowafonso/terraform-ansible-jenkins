output "imprime_ip_publico" {
    value = aws_instance.srv_webserver_rwa[0].public_ip
}