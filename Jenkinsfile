pipeline {
    agent any

    environment {
        AWS_REGION = 'us-west-2'
        ECR_REPO = sh(script: "aws secretsmanager get-secret-value --secret-id my-ecr-credentials --query SecretString --output text | jq -r .ECR_REPO", returnStdout: true).trim()
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', changelog: false, poll: false, url: 'https://github.com/arunlalp/java_code.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    def customImage = docker.build("my-app:1.0")
                }
            }
        }

        stage('Push to ECR') {
            steps {
                sh 'aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/c1l9p0p2'
                sh 'docker tag ${ECR_REPO}:latest public.ecr.aws/c1l9p0p2/${ECR_REPO}:1.0'
                sh 'docker push public.ecr.aws/c1l9p0p2/${ECR_REPO}:1.0'
            }
        }
    }
}
