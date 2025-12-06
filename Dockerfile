# ESTAGIO 1: BUILD (Compilação - Maven + JDK 17)
FROM maven:3-openjdk-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src /app/src
RUN mvn clean package -DskipTests

# ESTAGIO 2: PACKAGE (Imagem Final - JRE 17 Padrão Slim)
# Usando a tag openjdk:17-jdk-slim, que é muito mais comum e robusta.
FROM openjdk:17-jdk-slim
WORKDIR /app

# Altere 'app.jar' se você usou um nome diferente
COPY --from=build /app/target/*.jar app.jar 

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
