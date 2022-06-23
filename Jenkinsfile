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
                sh "java -version"
            }
        }
    stage('Build') {
      steps {
        sh 'mvn clean install'
      }
	  post {
                success {
                    junit(allowEmptyResults: true, testResults: '**/target/surefire-reports/*.xml')
					junit(allowEmptyResults: true, testResults: '**/target/maven-failsafe-plugin/*.xml')
					jacoco(
                    execPattern: '**/target/**.exec',
                    classPattern: '**/target/classes',
                    sourcePattern: '**/src',
                    changeBuildStatus: true,
                    minimumInstructionCoverage: '30',
                    maximumInstructionCoverage: '80')
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