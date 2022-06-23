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


    stage('Publish artifactory') {
      steps {
        rtServer (
                    id: "Jfrog_Server",
                    url: "http://ec2-13-232-166-125.ap-south-1.compute.amazonaws.com:8082/artifactory",
                    credentialsId: "jfrog_server"
                )
	    rtMavenDeployer (
                    id: 'maven-deployer',
                    serverId: 'Jfrog_Server',
                    releaseRepo: ARTIFACTORY_LOCAL_RELEASE_REPO,
                    snapshotRepo: ARTIFACTORY_LOCAL_SNAPSHOT_REPO,
                    threads: 6
                )
	     rtMavenRun (
                    tool: 'Maven_3_5_2',
                    pom: 'pom.xml',
					goals: '-U clean install',
                    deployerId: "maven-deployer"
                )
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