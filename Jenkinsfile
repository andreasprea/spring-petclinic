pipeline {
    agent {
        docker {
            image 'openjdk:8-jdk-buster' 
            args '-v /root/.m2:/root/.m2' 
        }
    }
    stages {
        stage('Initial info') {
            sh 'echo "Files in ${pwd}:"'
            sh 'ls -lah'
        }
        
        stage('Build jar') { 
            steps {
                echo 'Starting to build jar(s)'

                sh './mvnw package' 
            }
        }

        stage('Build and push image') {
            steps {
                echo 'Starting to build docker image'

                script {
                    docker.withRegistry('172.17.201.247:443', 'harbor') {
                        def customImage = docker.build("172.17.201.247/library/my-petclinic:${env.BUILD_ID}")
                        sh 'echo "pushing image to harbor registry:"'
                        customImage.push()
                    }
                }
            }
        }
    }
}