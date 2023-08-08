FROM openjdk:17-oracle

RUN mkdir -p /home/petclinic

COPY target/*.jar /home/petclinic/

WORKDIR /home/petclinic/

ENV POSTGRES_URL:jdbc:postgresql://postgres:5432/petclinic

EXPOSE 8080

CMD ["java", "-jar", "spring-petclinic-3.1.0-SNAPSHOT.jar", "--spring.profiles.active=postgres"]
