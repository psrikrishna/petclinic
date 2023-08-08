pipeline {
  agent any
   tools {
    maven 'maven-3.9.3'
    jdk 'Java17'
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
        withCredentials([string(credentialsId: 'dockercred', variable: 'DOCKER_CREDENTIALS', masking: true)]) {
                    def creds = DOCKER_CREDENTIALS.split(':')
                    def username = creds[0]
                    def password = creds[1]
                    
                    sh "echo '${password}' | docker login --username '${username}' --password-stdin"
            sh "docker build -t petclinic-app ."
            sh "docker tag petclinic-app:latest srikp/images:petclinic-app"
            sh "docker push srikp/images:petclinic-app"
            sh "docker-compose up -d"
        }
      }
    }
}

  }
}
