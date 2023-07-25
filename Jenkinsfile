pipeline {
  agent any
   tools {
    maven 'Maven-3.9.1'
    jdk 'open-jdk17'
  }
   environment {
   	AWS_ACCESS = credentials('AWS_ACCESS_KEY_ID')
    AWS_SECRET = credentials('AWS_SECRET_ACCESS_KEY')
	  }

  stages {
      stage('Snyk Scan') {
            steps {
                snykSecurity( 
                    snykInstallation: 'snyk', 
                    snykTokenId: 'snyk_api_token', 
                    monitorProjectOnBuild: false,
                    failOnIssues: 'false', 
                    additionalArguments: '--json-file-output=all-vulnerabilities.json'
                )
                sh 'snyk-filter -i all-vulnerabilities.json -f /usr/local/bin/exploitable_cvss_9.yml'
            }
      }
      stage('Maven Compile and Build') {
            steps {
              sh "mvn clean"
              sh "mvn compile"
              sh "mvn package -DskipTests=true -Dcheckstyle.skip" 
              }
            }  
      stage('Maven Test') {
            steps {
              sh "mvn test -Dcheckstyle.skip"
            }
            post{
              always{
                junit 'target/surefire-reports/*.xml'
              }
            }
        }
     }
}