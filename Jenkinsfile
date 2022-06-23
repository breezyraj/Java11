pipeline {
  agent any
  tools{
       maven 'Maven_3_5_2'
	   jdk 'java11'
  }
  stages {
        stage("Tools initialization") {
            steps {
                sh "mvn --version"
                sh "jdk -version"
            }
        }
  stages {
    stage('Checkout Code') {
      steps {
        sh 'ls -lrt'
      }
    }

    stage('junit') {
      parallel {
        stage('Sonar cloud') {
          steps {
            echo 'Hello'
          }
        }

        stage('Tagging') {
          steps {
            echo 'Hello'
          }
        }

      }
    }

    stage('Publish artifactory') {
      steps {
        echo 'hell'
      }
    }

    stage('Build Docker image') {
      steps {
        sh 'echo "test"'
      }
    }

    stage('Deploy Docker container') {
      steps {
        echo 'Hello'
      }
    }

    stage('Mail Notification') {
      steps {
        echo 'hello'
      }
    }

  }
}