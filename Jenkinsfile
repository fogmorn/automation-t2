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
                ansiblePlaybook credentialsId: 'ansible', disableHostKeyChecking: true, installation: 'Ansible', inventory: 'hosts.ini', limit: 'front1', playbook: 'ping.yml'
            }
        }
    }
}
