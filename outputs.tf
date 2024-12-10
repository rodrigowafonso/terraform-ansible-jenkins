output "ip_publico_srv_webserver_rwa" {
    description = "Imprime o IP Público da Instância Provisionada"
    value = aws_instance.srv_webserver_rwa.public_ip
}