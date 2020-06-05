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

        stage('Artifact Collect') {
            steps {
                archiveArtifacts(artifacts: '**/target/*.jar', fingerprint: true, onlyIfSuccessful: true)
            }
        }

        stage('Jacoco Covarage Test'){
            steps {
                jacoco(changeBuildStatus: true, buildOverBuild: true, //deltaInstructionCoverage: '1', 
                // if the coverage is above minimum but below maximum the build becomes UNSTABLE and the next stages get skipped
                maximumInstructionCoverage: '75', maximumLineCoverage: '75', maximumMethodCoverage: '75',
                minimumInstructionCoverage: '99', minimumLineCoverage: '99', minimumMethodCoverage: '99',
                execPattern: '**/target/*.exec', classPattern: '**/target/classes', sourcePattern: '**/src/main/java', exclusionPattern: '**/src/test*')
            }
            post {
                failure {
                    echo "${currentBuild.currentResult}"
                    error 'too low coverage'
                }
            }
        }

        stage('Post Jacoco'){
            steps {
                echo "post jacoco"
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