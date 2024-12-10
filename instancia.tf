data "aws_key_pair" "key_devops_rwa" {
  key_name = "key_devops_rodrigoafonso"
  include_public_key = true
}

resource "aws_instance" "srv_webserver_rwa" {
    ami = "ami-0e2c8caa4b6378d8c"
    instance_type = "t2.micro"
    key_name = aws_key_pair.key_devops_rwa.Name

    tags = {
        Name = "srv_webserver_rwa"
        Env = "Dev"
    }
}