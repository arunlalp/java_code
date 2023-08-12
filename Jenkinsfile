pipeline {
    agent {
        docker {
            image 'maven:3.9.3-ibm-semeru-17-focal'
            args '-v $PWD/.m2/repository:/root/.m2/repository'
        }
    }
    
    environment {
        MAVEN_OPTS = '-Dmaven.repo.local=.m2/repository'
    }
    
    stages {
        stage('Build') {
            steps {
                echo "Maven compile started"
                sh 'mvn compile'
            }
        }
        
        stage('Test') {
            steps {
                echo "Maven test started"
                sh 'mvn test'
            }
        }
        
        stage('Package') {
            steps {
                echo "Maven packaging started"
                sh 'mvn package'
            }
            
            post {
                always {
                    archiveArtifacts artifacts: ['target/*.jar', 'target/*.war'], allowEmptyArchive: true
                }
            }
        }
        
        stage('Deploy') {
            steps {
                echo "Maven deploy started"
                // Your deploy steps here
            }
        }
    }
    
    post {
        always {
            cleanWs()
        }
    }
}
