pipeline {
    agent {
        docker {
            image 'openjdk:11-jre-buster' 
            args '-v /root/.m2:/root/.m2' 
        }
    }
    stages {
        stage('Build') { 
            steps {
                sh './mvnw package' 
            }
        }
    }
}