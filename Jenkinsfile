pipeline {
    agent {
        docker {
            image 'openjdk:8-jdk-buster' 
            args '-v /root/.m2:/root/.m2' 
        }
    }
    stages {
        stage('Initial info') {
            steps {
                sh 'echo "Files in workdir:"'
                sh 'ls -lah'
            }
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
                    docker.withRegistry('http://172.17.201.247', 'harbor') {
                        def customImage = docker.build("172.17.201.247/library/my-petclinic:${env.BUILD_ID}")
                        echo "pushing image to harbor registry:"
                        customImage.push()
                    }
                }
            }
        }
    }
}