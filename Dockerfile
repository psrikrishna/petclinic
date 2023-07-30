FROM openjdk:17-oracle

RUN mkdir -p /home/petclinic

COPY target/*.jar /home/petclinic/

WORKDIR /home/petclinic/

EXPOSE 8080

ENV SPRING_DATASOURCE_URL=jdbc:postgresql://your_postgres_host:5432/petclinic
ENV SPRING_DATASOURCE_USERNAME=petclinic
ENV SPRING_DATASOURCE_PASSWORD=petclinic

CMD ["java", "-jar", "spring-petclinic-3.1.0-SNAPSHOT.jar", "--spring.profiles.active=postgres"]
