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
    stage('Build & Test execution') {
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

    stage('SonarCloud') {
        environment {
          SCANNER_HOME = tool 'Sonar'
          ORGANIZATION = "breezyraj"
          PROJECT_NAME = "breezyraj_Java11"
      }
		steps {
         withSonarQubeEnv('SonarCloud') {
          sh '''$SCANNER_HOME/bin/sonar-scanner -Dsonar.organization=$ORGANIZATION \
          -Dsonar.java.binaries=target \
          -Dsonar.projectKey=$PROJECT_NAME \
		  -Dsonar.host.url=https://sonarcloud.io \
		  -Dsonar.login=2b473196771131debaad265214c1205b66ae0b84 \
          -Dsonar.sources=src'''
		  }
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