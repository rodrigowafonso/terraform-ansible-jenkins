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
        stage ('Adicionando a Chave do Host ao known_hosts') {
            steps {
                echo 'Known_hosts Original'
                echo '-------------------------------------------------'
                sh 'cat /var/lib/jenkins/.ssh/known_hosts' 
                sh 'ssh-keyscan -H 34.228.208.121 >> /var/lib/jenkins/.ssh/known_hosts'
                echo 'Known_hosts modificado'
                echo '-------------------------------------------------'
                sh 'cat /var/lib/jenkins/.ssh/known_hosts'
            }
        }
        stage ('Acessando a Instância via Ansible') {
            environment {
                SSH_PRIVATE_KEY = credentials('SSH_PRIVATE_KEY')
                USER_EC2 = credentials('USER_EC2')
            }
            steps {
                script {
                    sh ''
                    sh 'ansible-playbook -i inventory.ini -u "$USER_EC2" --private-key "$SSH_PRIVATE_KEY" --ssh-common-args=\'-o StrictHostKeyChecking=no\' nginx.yml'
                }
            }
        }
    }
}