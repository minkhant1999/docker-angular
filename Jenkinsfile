pipeline {
    agent any

    environment {
        // Set in Jenkins: Credentials ID for Firebase CI token, or use FIREBASE_TOKEN env var
        // Generate token locally: firebase login:ci
        FIREBASE_TOKEN = credentials('FIREBASE_TOKEN')
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Install') {
            steps {
                sh 'npm install'
            }
        }

        stage('Test') {
            steps {
                sh 'npm run test -- --no-watch --no-progress --browsers=ChromeHeadless'
            }
        }

        stage('Build') {
            steps {
                sh 'npm run build'
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
            echo 'Build and deploy to Firebase completed successfully'
        }
        failure {
            echo 'Pipeline failed'
        }
    }
}
