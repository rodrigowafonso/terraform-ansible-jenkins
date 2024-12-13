pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_NAME_BUCKET = credentials('AWS_NAME_BUCKET')
        AWS_REGION = credentials('AWS_REGION')
        AWS_TERRAFORM_TFSTATE = credentials('AWS_TERRAFORM_TFSTATE')
        SSH_PRIVATE_KEY = credentials('SSH_PRIVATE_KEY')
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
                // sh 'terraform apply --auto-approve'
                sh 'terraform destroy --auto-approve'
            }
        }
        // stage('Wait the instance stay Status OK') {
        //     steps {
        //         script {
        //             id = sh(script: 'aws ec2 describe-instances --region ${AWS_REGION} --filters Name=instance-state-name,Values=running --query Reservations[*].Instances[*].InstanceId --output text',  returnStdout:true).trim()
        //             if (id) {
        //                 echo '-----------------------------------------------------------'
        //                 echo 'Aguardando até que as instâncias estejam com Status OK'
        //                 echo "$id"
        //                 echo '-----------------------------------------------------------'
        //                 sh 'aws ec2 wait instance-status-ok --region ${AWS_REGION} --instance-ids $id'
        //             } else {
        //                 echo '-----------------------------------------------------------'
        //                 echo 'Não existem instâncias provisionadas'
        //                 echo '-----------------------------------------------------------'
        //             }
        //         }
        //     }
        // }
        // stage ('Store known hosts of all the hosts in the arquivo known_hosts') {
        //     steps {
        //         script {
        //             ansiblePlaybook credentialsId: 'PRIVATE_KEY_ANSIBLE', disableHostKeyChecking: true, installation: 'ansible', inventory: 'inventory_aws_ec2.yml', playbook: 'ssh_known_hosts.yml'
        //         }
        //     }
        // }
        // stage ('Provisionando o Ambiente do Wordpress') {
        //     steps {
        //         script {
        //             sh 'ansible --version'
        //             sh 'ansible-inventory --graph'
        //             ansiblePlaybook credentialsId: 'PRIVATE_KEY_ANSIBLE', disableHostKeyChecking: false, installation: 'ansible', inventory: 'inventory_aws_ec2.yml', playbook: './playbooks/wordpress.yml'
        //             //sh 'ansible-inventory -i inventory_aws_ec2.yml --list'
        //             //sh 'ansible-playbook -i inventory.ini -u "$USER_EC2" --private-key "$SSH_PRIVATE_KEY" --ssh-common-args=\'-o StrictHostKeyChecking=no\' nginx.yml'
        //             //sh 'ansible-playbook -i inventory.ini -u "$USER_EC2" --private-key "$SSH_PRIVATE_KEY" nginx.yml'
        //         }
        //     }
        // }
    }
}

