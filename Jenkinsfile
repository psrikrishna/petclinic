pipeline {
  agent any
   tools {
    maven 'maven-3.9.3'
    jdk 'Java17'
  }

  stages {

      stage("aws jenkins") {
         steps {
                  withCredentials([[
                        $class: 'AmazonWebServicesCredentialsBinding',
                        credentialsId: 'aws',
                        accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                        secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
                                 ]]) {
                    sh "aws s3 ls"
                }
               }
       }
     
      stage('Maven Compile and Build') {
            steps {
              sh "mvn clean"
              sh "mvn compile"
              sh "mvn package -DskipTests=true -Dcheckstyle.skip" 
              }
            }  
     stage('Snyk Security Test') {
      steps {
        echo 'Testing...'
        snykSecurity(
          snykInstallation: 'Snyk',
          snykTokenId: 'snyktoken'
          monitorProjectOnBuild: false,
          failOnIssues: 'false'
        )
      }
    }

     }
}
