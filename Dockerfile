# ESTAGIO 1: BUILD (Compilação - Maven + JDK 11)
FROM maven:3-jdk-11 AS build
WORKDIR /app
COPY pom.xml .
COPY src /app/src
RUN mvn clean package -DskipTests

# ESTAGIO 2: PACKAGE (Imagem Final - JRE 11 Slim)
FROM openjdk:11-jre-slim
WORKDIR /app

# Altere 'app.jar' se você usou um nome diferente
COPY --from=build /app/target/*.jar app.jar 

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
