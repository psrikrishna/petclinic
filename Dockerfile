
FROM openjdk:17-oracle

WORKDIR /home/runner/work/petclinic/petclinic/target/

EXPOSE 8080

CMD ["java", "-jar", "spring-petclinic-3.1.0-SNAPSHOT.jar",  "--spring.profiles.active=postgres"]
