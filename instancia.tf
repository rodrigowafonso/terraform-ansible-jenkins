// Recuperando o key Pair existente no ambiente
data "aws_key_pair" "key_devops_rwa" {
  key_name = "key_devops_rodrigoafonso"
  include_public_key = true
}

// Provisionando a Instância EC2 na AWS
resource "aws_instance" "srv_webserver_rwa" {
    ami = "ami-0e2c8caa4b6378d8c"
    instance_type = "t2.micro"
    count = 3
    key_name = data.aws_key_pair.key_devops_rwa.key_name
    subnet_id = aws_subnet.subnet_rwa_jta.id
    vpc_security_group_ids = [aws_security_group.security_gropu_rwa_jta.id]
    associate_public_ip_address = true

    tags = {
        Name = "${element(var.instancia_nome, count.index)}-rwa-jta"
        Env = "Dev"
    }
}