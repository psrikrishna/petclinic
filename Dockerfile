# Use the official OpenJDK image as the base image
FROM openjdk:17-oracle as builder

ARG PROFILE
ENV PROFILE_VAR=$PROFILE
VOLUME /tmp
## Add the built jar for docker image building
COPY --from=builder target/spring-petclinic-3.1.0-SNAPSHOT.jar spring-petclinic.jar
# ADD 
EXPOSE 8080
ENTRYPOINT ["/bin/bash", "-c", "java","-Dspring.profiles.active=postgres","-jar","/spring-petclinic.jar"]

# Expose the port that the application will listen on (if applicable)


# Define the command to run the Java application
# CMD ["java", "-jar", "spring-petclinic.jar", "--spring.profiles.active=postgres"]
