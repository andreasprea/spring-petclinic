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

    options {
        skipStagesAfterUnstable()
    }

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

        // stage('Artifact Collect') {
        //     steps {
        //         archiveArtifacts(artifacts: '**/target/*.jar', fingerprint: true, onlyIfSuccessful: true)
        //     }
        // }

        stage('Jacoco Coverage Test'){
            // if the coverage is above minimum but below maximum the build status is UNSTABLE
            // if the coverage is below minimum and below maximum the build status is FAILURE
            // if the coverage is above minimum and above maximum the build becomes SUCCESS
            steps {
                jacoco(changeBuildStatus: true, buildOverBuild: true, 
                deltaBranchCoverage: '1', deltaClassCoverage: '99', deltaComplexityCoverage: '99', deltaInstructionCoverage: '99', deltaLineCoverage: '99', deltaMethodCoverage: '99', 
                //maximumInstructionCoverage: '99', maximumLineCoverage: '99', maximumMethodCoverage: '99',
                //minimumInstructionCoverage: '75', minimumLineCoverage: '75', minimumMethodCoverage: '75',
                execPattern: '**/target/*.exec', classPattern: '**/target/classes', sourcePattern: '**/src/main/java', exclusionPattern: '**/src/test*')
            }
            post {
                always {
                    echo "${currentBuild.currentResult}"

                    sh 'printenv'
                }
                failure {
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