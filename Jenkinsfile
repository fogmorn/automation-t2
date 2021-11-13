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
                ansibleAdHoc('ping') {
                    ansibleName('Ansible')
                    inventoryPath('hosts.ini')
                    credentialsId('ansible')
                    hostPattern('front1')
                    hostKeyChecking(false)
                }
            }
        }
    }
}
