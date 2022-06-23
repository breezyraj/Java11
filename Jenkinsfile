pipeline {
  agent any
  tools{
       maven 'Maven_3_5_2'
	   jdk 'Java11'
  }
  stages {
        stage("Tools initialization") {
            steps {
                sh "mvn -version"
                sh "jdk -version"
            }
        }
    stage('Build') {
      steps {
        sh 'mvn clean install'
      }
	  post {
                success {
                    junit 'target/surefire-reports/*.xml' 
					junit 'target/failsafe-reports/*.xml'
                }
            }
    }

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