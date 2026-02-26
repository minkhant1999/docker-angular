pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'docker-angular'
        DOCKER_TAG = "${env.BUILD_NUMBER ?: 'latest'}"
        FIREBASE_TOKEN = credentials('FIREBASE_TOKEN')
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build with Docker') {
            steps {
                script {
                    // Dockerfile runs: npm ci, npm run build (install + build inside image)
                    docker.build("${DOCKER_IMAGE}:${DOCKER_TAG}")
                }
            }
        }

        stage('Extract build artifacts') {
            steps {
                sh '''
                    mkdir -p dist
                    docker create --name extract "${DOCKER_IMAGE}:${DOCKER_TAG}"
                    docker cp extract:/usr/share/nginx/html dist/docker-angular
                    docker rm extract
                '''
            }
        }

        stage('Deploy to Firebase') {
            steps {
                sh '''
                    npx firebase-tools deploy --only hosting --token "$FIREBASE_TOKEN" --non-interactive
                '''
            }
        }
    }

    post {
        always {
            cleanWs()
        }
        success {
            echo 'Build and deploy completed successfully'
        }
        failure {
            echo 'Pipeline failed'
        }
    }
}
