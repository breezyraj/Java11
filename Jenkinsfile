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
    stage('Junit Test execution') {
      steps {
        sh 'mvn clean test'
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


    stage('Build & Publish artifactory') {
      steps {
        rtServer (
                    id: "Jfrog_Server",
                    url: "http://ec2-3-108-254-235.ap-south-1.compute.amazonaws.com:8082/artifactory",
                    credentialsId: "jfrog_server"
                )
	    rtMavenDeployer (
                    id: 'maven-deployer',
                    serverId: 'Jfrog_Server',
                    releaseRepo:'libs-release-local',
                    snapshotRepo: 'libs-snapshot-local',
                    threads: 6
                )
	     rtMavenRun (
                    tool: 'Maven_3_5_2',
                    pom: 'pom.xml',
					goals: '-U clean install -Dmaven.test.skip=true',
                    deployerId: "maven-deployer"
                )
      }
    }
	
	stage("Tag and Push") { 
			steps {
                    sh('''   
                    VERSION=$(mvn help:evaluate -Dexpression=project.version -q -DforceStdout)
                    git config user.name 'Mohanraj'
                    git config user.email 'breezyraj@gmail.com'
                ''')
			sshagent (credentials: ['2ba71e6a-c6a1-4c32-a86a-adf10364b35b']) {
                    sh("""
                        #!/usr/bin/env bash
                        set +x
                        export GIT_SSH_COMMAND="ssh -oStrictHostKeyChecking=no"
						git tag -d \${VERSION}
						git tag -a \${VERSION} -m "[Jenkins CI] New Tag"
                        git push \$VERSION
                     """)
                }
        }
	}	

    stage('Docker image build & Deploy container') {
      steps {
        sh 'docker build -t pipeline_demo .'
		sh 'docker run --rm --name Demo pipeline_demo'		
      }
    }
		
	stage ('Push Image to Artifactory') {
            steps {
                script {""
                    docker.withRegistry('http://ec2-3-108-254-235.ap-south-1.compute.amazonaws.com:8082', 'jfrog_server') {
                        docker.image("docker-quickstart-local/pipeline_demo:${TAG}").push()
                        docker.image("docker-quickstart-local/pipeline_demo:${TAG}").push("latest")
                    }
            }
        }
     }
  }
  
  post{
        always{
            emailext to: "breezyraj@gmail.com",
            subject: "jenkins build:${currentBuild.currentResult}: ${env.JOB_NAME}",
            body: "${currentBuild.currentResult}: Job ${env.JOB_NAME}\nMore Info can be found here: ${env.BUILD_URL}"
        }
    }
}