
FROM openjdk:17-oracle

RUN mkdir -p /home/petclinic

COPY /home/runner/work/petclinic/petclinic/target/spring-petclinic-3.1.0-SNAPSHOT.jar /home/petclinic/

WORKDIR /home/petclinic/

EXPOSE 8080

CMD ["java", "-jar", "spring-petclinic-3.1.0-SNAPSHOT.jar",  "--spring.profiles.active=postgres"]
