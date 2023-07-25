pipeline {
  agent any
   tools {
    maven 'maven-3.5.2'
    jdk 'open-jdk17'
  }
   environment {
   	AWS_ACCESS = credentials('AWS_ACCESS_KEY_ID')
    AWS_SECRET = credentials('AWS_SECRET_ACCESS_KEY')
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
