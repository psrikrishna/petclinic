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

      stage('Docker Image creation') {
           steps {
      	withCredentials([usernamePassword(credentialsId: 'dockercred', passwordVariable: 'dockercredPassword', usernameVariable: 'dockercredUser')]) {
        	 sh "docker login -u ${env.dockercredUser} -p ${env.dockercredPassword}"
           sh "docker build -t petclinic_img ."
           sh "docker tag petclinic_img:latest srikp/images:petclinic_img"
           sh "docker push srikp/images:petclinic_img"
           sh "docker run -d -p 9081:8080 petclinic_img"
           sh 'docker-compose --profile postgres up -d'
        }
      }
    }

  }
}
