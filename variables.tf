variable "regiao_projeto" {
    description = "Define a região do Projeto"
    type = string
    default = "us-east-1"
}

variable "vpc_cidr_block" {
    description = "Cidr Block da VPC projeto jta"
    type = string
    default = "10.0.0.0/16"
}

variable "subnet_cidr_block" {
    description = "Cidr Block da Subnet projeto jta"
    type = string
    default = "10.0.1.0/24" 
}

variable "prefix" {
    description = "Criando Role"
    type = string
    default = "rwa_jta"
  
}

variable "instancia_nome" {
    description = "Definindo o nome das instâncias"
    type = list(string)
    default = ["srv-web", "srv-db", "srv-app"]
}

variable "quantidade_instancia" {
    description = "Define a quantidade de instâncais"
    type = number
    default = 1  
}