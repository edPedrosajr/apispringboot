# ESTAGIO 1: BUILD
FROM maven:3-openjdk-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src /app/src
RUN mvn clean package -DskipTests

# ESTAGIO 2: PACKAGE
FROM openjdk:17-jre-slim-buster
WORKDIR /app

# Altere 'app.jar' se você usou um nome diferente
COPY --from=build /app/target/*.jar app.jar 

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
