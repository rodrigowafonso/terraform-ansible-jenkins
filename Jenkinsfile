pipeline {
    agent any

    // tools {
    //     terraform 'terraform'
    // }
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_NAME_BUCKET = credentials('AWS_NAME_BUCKET')
        AWS_REGION = credentials('AWS_REGION')
        AWS_TERRAFORM_TFSTATE = credentials('AWS_TERRAFORM_TFSTATE')
        SSH_PRIVATE_KEY = credentials('SSH_PRIVATE_KEY')
        //PRIVATE_KEY_ANSIBLE = credentials('PRIVATE_KEY_ANSIBLE')
    }

    stages {
        stage ('Realizando Chechout do Código Github') {
            steps {
                git branch: 'main', url: 'https://github.com/rodrigowafonso/terraform-ansible-jenkins.git'
            }
        }
        stage ('Provisionando o Ambiente WebServer com Terraform') {       
            steps {
                sh 'terraform fmt'
                sh 'terraform init -backend-config="bucket=$AWS_NAME_BUCKET" -backend-config="key=$AWS_TERRAFORM_TFSTATE" -backend-config="region=$AWS_REGION"'
                sh 'terraform plan'
                sh 'terraform apply --auto-approve'
                sh 'terraform destroy --auto-approve'
            }
        }
        stage ('Descobrindo o IP Público da Instância') {
            steps {
                script {
                    env.publicIp = sh(script: 'terraform output -raw ip_publico_srv_webserver_rwa', returnStdout: true).trim()
                    env.PUBLIC_IP = publicIp
                    echo '-------------------------------------------------'
                    echo "O IP Público: ${PUBLIC_IP}"
                    echo '-------------------------------------------------'
                }
            }
        }
        stage ('Adicionando a Chave do Host ao known_hosts') {
            steps {
                script {
                    env.known_HostsPath = '/var/lib/jenkins/.ssh/known_hosts'
                    env.checkHost = sh(script: "grep -P '${PUBLIC_IP}' ${known_HostsPath} || echo 'IP não encontrado'", returnStatus: true)
                    echo '-------------------------------------------------'
                    echo "O Valor da variável checkHost: ${checkHost}"
                    echo '-------------------------------------------------'
                    if (checkHost == 0) {
                        sh "ssh-keyscan -H ${PUBLIC_IP} >> ${known_HostsPath}"
                        echo '-------------------------------------------------'
                        echo "IP Público: ${PUBLIC_IP} Adicionado ao arquivo known_hosts"
                        echo '-------------------------------------------------'
                    } else {
                        echo "IP já existe no arquivo known_hosts"
                    }
                }
            }
        }
        stage ('Acessando a Instância via Ansible') {
            steps {
                script {
                    sh 'ansible --version'
                    sh 'ansible-inventory --graph'
                    sh 'ansible-inventory -i inventory_aws_ec2.yml --list'
                    ansiblePlaybook credentialsId: 'PRIVATE_KEY_ANSIBLE', disableHostKeyChecking: true, installation: 'ansible', inventory: 'inventory_aws_ec2.yml', playbook: 'nginx.yml'
                    // sh 'ansible-playbook -i inventory.ini -u "$USER_EC2" --private-key "$SSH_PRIVATE_KEY" --ssh-common-args=\'-o StrictHostKeyChecking=no\' nginx.yml'
                    //sh 'ansible-playbook -i inventory.ini -u "$USER_EC2" --private-key "$SSH_PRIVATE_KEY" nginx.yml'
                }
            }
        }
        // stage ('Adicionando a Chave do Host ao known_hosts') {
        //     steps {
        //         echo 'Known_hosts Original'
        //         echo '-------------------------------------------------'
        //         sh 'cat /var/lib/jenkins/.ssh/known_hosts' 
        //         sh 'ssh-keyscan -H 34.228.208.121 >> /var/lib/jenkins/.ssh/known_hosts'
        //         echo 'Known_hosts modificado'
        //         echo '-------------------------------------------------'
        //         sh 'cat /var/lib/jenkins/.ssh/known_hosts'
        //     }
        // }
    }
}

