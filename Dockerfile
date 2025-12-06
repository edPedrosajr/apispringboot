# ESTAGIO 1: BUILD (Compilação - Maven + JDK 17 Alpine)
# Usando a tag Alpine para o estágio de build
FROM maven:3-jdk-17-alpine AS build
WORKDIR /app
COPY pom.xml .
COPY src /app/src
RUN mvn clean package -DskipTests

# ESTAGIO 2: PACKAGE (Imagem Final - JRE 17 Alpine)
# Usando a tag Alpine JRE (muito estável e leve)
FROM openjdk:17-jre-alpine
WORKDIR /app

# Altere 'app.jar' se você usou um nome diferente
COPY --from=build /app/target/*.jar app.jar 

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
