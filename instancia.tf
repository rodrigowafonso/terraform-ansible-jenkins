data "aws_key_pair" "key_devops_rwa" {
  key_name = "key_devops_rodrigoafonso"
  include_public_key = true
}

resource "aws_instance" "srv_webserver_rwa" {
    ami = "ami-0e2c8caa4b6378d8c"
    instance_type = "t2.micro"
    key_name = data.aws_key_pair.key_devops_rwa.key_name
    subnet_id = aws_subnet.subnet_rwa_jta.id
    vpc_security_group_ids = [aws_security_group.security_gropu_rwa_jta.id]

    tags = {
        Name = "srv_webserver_rwa"
        Env = "Dev"
    }
}