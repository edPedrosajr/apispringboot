# ESTAGIO 1: BUILD (Compilação - Maven + JDK 17)
# Usando 'jdk-17' que é uma tag mais padronizada
FROM maven:3-jdk-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src /app/src
RUN mvn clean package -DskipTests

# ESTAGIO 2: PACKAGE (Imagem Final - JDK 17 Bullseye)
# Usando a tag de distribuição Linux (Bullseye) que é a mais estável e garantida
FROM openjdk:17-jdk-bullseye
WORKDIR /app

# Altere 'app.jar' se você usou um nome diferente
COPY --from=build /app/target/*.jar app.jar 

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
