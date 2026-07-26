pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "suriyadevops/jenkins-demo"
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

        stage('Docker Login and Push') {
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
    }
}
