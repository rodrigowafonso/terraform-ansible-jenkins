// Provisionando o Grupo de Segurança do Ambiente
resource "aws_security_group" "security_gropu_rwa_jta" {
    name = "security_gropu_rwa_jta"
    vpc_id = aws_vpc.vpc_rwa_jta.id

    tags = {
      Name = "security_gropu_rwa_jta"
      Env = "Dev"
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }
  

}