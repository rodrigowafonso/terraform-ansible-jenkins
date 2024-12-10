# Criando VPC do projeto "jta" --> Jenkins Terraform e Ansible 
resource "aws_vpc" "vpc_rwa_jta" {
    cidr_block = var.vpc_cidr_block
    
    tags = {
      Name = "vpc_rwa_jta"
      Env = "Dev"
    } 
}

# Provisionando a Subnet do Projeto
resource "aws_subnet" "subnet_rwa_jta" {
    vpc_id = aws_vpc.vpc_rwa_jta.id
    cidr_block = var.subnet_cidr_block

    tags = {
      Name = "subnet_rwa_jta"
      Env = "Dev"
    }
}

# Provisionando o Internet Gateway do Projeto
resource "aws_internet_gateway" "internet_gateway_rwa_jta" {
    vpc_id = aws_vpc.vpc_rwa_jta.id

    tags = {
      Name = "internet_gateway_rwa_jta"
      Env = "Dev"
    } 
}

# Provisionando a Tabela de Rota do Projeto
resource "aws_route_table" "tabela_rota_rwa_jta" {
    vpc_id = aws_vpc.vpc_rwa_jta.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.internet_gateway_rwa_jta.id
    }

    tags = {
      Name = "tabela_rota_rwa_jta"
      Env = "Dev"
    }

}

# Associando a Tabela de Rota e Subnet ao Internet Gateway
resource "aws_route_table_association" "associa_rt_gw_rwa_jta" {
    subnet_id = aws_subnet.subnet_rwa_jta.id
    route_table_id = aws_route_table.tabela_rota_rwa_jta.id
  
}