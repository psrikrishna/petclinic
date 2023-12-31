FROM eclipse-temurin:20-jdk-alpine as build
COPY . /usr/app
WORKDIR /usr/app
RUN chmod +x mvnw && ./mvnw clean package

FROM eclipse-temurin:20-jre-alpine
RUN mkdir /app
COPY --from=build /usr/app/target/*.jar /app/com.springboot.petclinic.jar
EXPOSE 8080

CMD ["java", "-jar", "/app/com.springboot.petclinic.jar",  "--spring.profiles.active=postgres"]
