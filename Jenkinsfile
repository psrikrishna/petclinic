pipeline {
  agent any
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
      stage('Build Artifact') {
            steps {
              withMaven(maven: 'maven') {
              sh "mvn clean package -DskipTests=true -Dcheckstyle.skip" 
              archive 'target/*.jar'
              }
            }  
       }
      stage('Test Maven - JUnit') {
            steps {
              withMaven(maven: 'maven') {
              sh "mvn test -Dcheckstyle.skip"
              }
            }
            post{
              always{
                junit 'target/surefire-reports/*.xml'
              }
            }
        }
     }
}