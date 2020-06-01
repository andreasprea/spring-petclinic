pipeline {
    // agent {
    //     docker {
    //         image 'openjdk:8-jdk-buster' 
    //         args '-v /root/.m2:/root/.m2' 
    //     }
    // }

    agent any

    // parameters {
    //     choice(name: 'AGENT', choices: ['unixxxxxx_container', 'windows_installer'], description: 'Choose the target:')
    // }

    stages {
        // stage('Initial info') {
        //     steps {
        //         sh 'echo "Files in workdir:"'
        //         sh 'ls -lah'
        //         // echo "AGENT: ${params.AGENT}"
        //     }
        // }
        
        stage('Build jar') { 
            steps {
                echo 'Starting to build jar(s)'

                sh './mvnw package' 
            }
        }

        stage('Jacoco Covarage Test'){
            steps {
                jacoco(buildOverBuild: true, deltaBranchCoverage: '1', execPattern: '**/target/*.exec', classPattern: '**/target/classes', sourcePattern: '**/src/main/java', exclusionPattern: '**/src/test*')
            }
        }

        // stage('Build and push image') {
        //     steps {
        //         echo 'Starting to build docker image'

        //         script {
        //             withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: params.JP_DockerMechIdCredential, usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD']]) {
        //                 usr = USERNAME
        //                 pswd = PASSWORD
        //             }
        //             docker.withRegistry("http://172.17.201.247", params.JP_DockerMechIdCredential) {
        //                 sh "docker login -u ${usr} -p ${pswd} http://172.17.201.247"
        //                 def	image = docker.build("172.17.201.247/library/my-petclinic:${env.BUILD_ID}")
        //                 image.push()
        //             }
        //         }
        //     }
        // }
    }
}