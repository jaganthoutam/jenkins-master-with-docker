pipeline {
   agent any  
    stages {
        stage('Start') {
            steps {
                script {
                  env.GIT_COMMIT = sh (
                      script: 'git rev-parse HEAD',
                      returnStdout: true
                  ).trim()
                }
            }
        }
        stage('Build') {
            steps {
                sh "docker build --no-cache -f docker/Dockerfile -t jaganthoutam/jenkins-master-docker ."
                sh "docker tag jaganthoutam/velocityship jaganthoutam/jenkins-master-docker:latest"
                sh "docker tag jaganthoutam/velocityship jaganthoutam/jenkins-master-docker:${env.GIT_COMMIT}"      
            }
        }
                stage('Push') {
            steps {
                withDockerRegistry(
                    registry: [
                        credentialsId: 'dockerhub',
                        url: ''
                    ]
                ){
                sh "docker push jaganthoutam/jenkins-master-docker:${env.GIT_COMMIT}"
                sh "docker push jaganthoutam/jenkins-master-docker:latest"
                }
            }
        }        
     }
   }
