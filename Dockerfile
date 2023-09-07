# Use the official OpenJDK image as the base image
FROM openjdk:17-oracle

RUN mkdir -p /home/petclinic

WORKDIR /home/runner/work/petclinic/petclinic/

COPY target/*.jar /home/petclinic/

# Expose the port that the application will listen on (if applicable)
EXPOSE 8080

# Define the command to run the Java application
CMD ["java", "-jar", "/home/petclinic/spring-petclinic.jar", "--spring.profiles.active=postgres"]
