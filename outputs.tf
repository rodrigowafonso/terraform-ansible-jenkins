output "{var.instancia_nome[0]}-rwa-jta" {
    value = aws_instance.srv_webserver_rwa[0].public_ip
}

output "{var.instancia_nome[1]}-rwa-jta" {
    value = aws_instance.srv_webserver_rwa[1].public_ip
}

output "{var.instancia_nome[2]}-rwa-jta" {
    value = aws_instance.srv_webserver_rwa[2].public_ip
}
