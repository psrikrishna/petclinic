pipeline {
  agent any
   tools {
    maven 'maven-3.9.3'
    jdk 'Java17'
  }
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

  stages {
     
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
