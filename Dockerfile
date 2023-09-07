# Use the official OpenJDK image as the base image
FROM openjdk:17-oracle

# Create a directory inside the container to store the JAR file
RUN mkdir -p /app

# Set the working directory to the newly created directory
WORKDIR /app

# Copy the JAR file from the GitHub Actions workspace into the container
COPY target/*.jar /app/spring-petclinic.jar

# Expose the port that the application will listen on (if applicable)
EXPOSE 8080

# Define the command to run the Java application
CMD ["java", "-jar", "spring-petclinic.jar", "--spring.profiles.active=postgres"]
