pipeline {
  agent any
   tools {
    maven 'maven-3.9.3'
    jdk 'Java17'
  }
  environment{
    PETCLINIC_CREDS = credentials('postgrescred')

  }

  stages {

/*      stage("aws jenkins") {
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
       }*/
     
      stage('Maven Compile and Build') {
            steps {
              sh "mvn clean"
              sh "mvn compile"
              sh "mvn package -DskipTests -Dspring.profiles.active=postgres" 
              }
            }  
 /*    stage('Snyk Security Test') {
      steps {
        echo 'Testing...'
        snykSecurity(
          snykInstallation: 'Snyk',
          snykTokenId: 'snyktoken',
          failOnIssues: 'false'
        )
      }
    }*/

stage('Docker login') {
    steps {
      script {
        withCredentials([string(credentialsId: 'dockercred', variable: 'PASSWORD', masking: true)]) {
            sh "echo '${PASSWORD}' | docker login --username 'srikp' --password-stdin"
                      
            sh "docker build -t petclinic-app ."
            sh "docker tag petclinic-app:latest srikp/images:petclinic-app"
            sh "docker push srikp/images:petclinic-app"
        }
      }
    }
}

    stage('Build and Deploy') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'postgrescred', passwordVariable: 'PETCLINIC_DB_PASSWORD', usernameVariable: 'PETCLINIC_DB_USERNAME')]) {
                      sh "docker-compose up -d"
                    }
                }
            }
        }

    

  }
}
