
FROM openjdk:17-oracle

COPY target/*.jar /home/petclinic/

WORKDIR /home/petclinic/

EXPOSE 8080

CMD ["java", "-jar", "spring-petclinic-3.1.0-SNAPSHOT.jar",  "--spring.profiles.active=postgres"]
