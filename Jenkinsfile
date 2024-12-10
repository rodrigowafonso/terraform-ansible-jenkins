pipeline {
    agent any
    stages {
        stage ('Realizando Chechout do Código Github') {
            steps {
                git branch: 'main', url: 'https://github.com/rodrigowafonso/terraform-ansible-jenkins.git'
            }
        }

        stage ('Provisionando o Ambiente WebServer com Terraform') {       
            environment {
                AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
                AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
                AWS_NAME_BUCKET = credentials('AWS_NAME_BUCKET')
                AWS_REGION = credentials('AWS_REGION')
                AWS_TERRAFORM_TFSTATE = credentials('AWS_TERRAFORM_TFSTATE')
            }

            steps {
                sh 'terraform fmt'
                sh 'terraform init -backend-config="bucket=$AWS_NAME_BUCKET" -backend-config="key=$AWS_TERRAFORM_TFSTATE" -backend-config="region=$AWS_REGION"'
                sh 'terraform plan'
                sh 'terraform apply --auto-approve'
                //sh 'terraform destroy --auto-approve'
            }
        }
    }
}