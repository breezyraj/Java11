pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        echo 'Hello'
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