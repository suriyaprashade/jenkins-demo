pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "suriyadevops/jenkins-demo"
        APP_SERVER = "18.215.118.239"
    }

    stages {

        stage('Checkout') {
            steps {
                echo 'Getting source code from GitHub'
            }
        }

        stage('Docker Build') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE:latest .'
            }
        }

        stage('Docker Push') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'dockerhub-credentials',
                        usernameVariable: 'DOCKER_USERNAME',
                        passwordVariable: 'DOCKER_PASSWORD'
                    )
                ]) {
                    sh '''
                        echo "$DOCKER_PASSWORD" | docker login \
                        -u "$DOCKER_USERNAME" \
                        --password-stdin

                        docker push $DOCKER_IMAGE:latest
                    '''
                }
            }
        }

        stage('Deploy to App Server') {
            steps {
                sshagent(['app-ec2-ssh']) {
                    sh '''
                        ssh -o StrictHostKeyChecking=no ubuntu@$APP_SERVER "
                            docker pull $DOCKER_IMAGE:latest &&
                            docker stop jenkins-demo-app || true &&
                            docker rm jenkins-demo-app || true &&
                            docker run -d \
                            --name jenkins-demo-app \
                            -p 80:80 \
                            $DOCKER_IMAGE:latest
                        "
                    '''
                }
            }
        }
    }
}
