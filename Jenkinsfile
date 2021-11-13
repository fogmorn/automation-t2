pipeline {
    agent any

    stages {
        stage('Prebuild') {
            steps {
                sh '/usr/local/bin/docker-compose down --volumes'
            }
        }
        stage('Build') {
            steps {
                echo 'Building a docker-compose.yml'
                sh '/usr/local/bin/docker-compose up -d --build'
            }
        }
        stage('Test') {
            steps {
                ansiblePlaybook credentialsId: 'ansible1', disableHostKeyChecking: true, installation: 'Ansible', inventory: 'hosts.ini', playbook: 'ping.yml'
            }
        }
        stage('Deploy') {
            steps {
                ansiblePlaybook credentialsId: 'ansible1', disableHostKeyChecking: true, installation: 'Ansible', inventory: 'hosts.ini', playbook: 'deploy.yml'
            }
        }
    }
}
