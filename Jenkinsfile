pipeline {
    agent any

    options {
        buildDiscarder(logRotator(numToKeepStr: '10'))
    }

    // Trigger: in Jenkins job, use "Pipeline from SCM" and set branch to "dev",
    // or configure your Git provider webhook to trigger on push to dev.

    environment {
        DOCKER_IMAGE = 'docker-angular'
        DOCKER_TAG = "${env.BUILD_NUMBER ?: 'latest'}"
        FIREBASE_TOKEN = credentials('FIREBASE_TOKEN')
    }

    stages {
        stage('Checkout') {
            when { branch 'dev' }
            steps {
                checkout scm
            }
        }

        stage('Build with Docker') {
            when { branch 'dev' }
            steps {
                script {
                    docker.build("${DOCKER_IMAGE}:${DOCKER_TAG}", "-f Dockerfile.prod .")
                }
            }
        }

        stage('Extract build artifacts') {
            when { branch 'dev' }
            steps {
                sh '''
                    mkdir -p dist/docker-angular
                    docker create --name extract "${DOCKER_IMAGE}:${DOCKER_TAG}"
                    docker cp extract:/. dist/docker-angular
                    docker rm extract
                '''
            }
        }

        stage('Deploy to Firebase') {
            when { branch 'dev' }
            steps {
                sh 'npm ci --no-audit --no-fund'
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
            echo 'Dev branch: Docker build and Firebase deploy completed successfully'
        }
        failure {
            echo 'Pipeline failed'
        }
    }
}
