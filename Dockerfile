# Estágio 1: Build (Construção)
FROM maven:3.9.5-openjdk-17 AS build
WORKDIR /app

# Copia os arquivos de build (pom.xml, etc.) primeiro para otimizar o cache do Docker
COPY pom.xml .
# Copia o código fonte
COPY src /app/src

# Comando de Build: Limpa, Compila e Cria o JAR. O -DskipTests é opcional para deploy mais rápido.
RUN mvn clean package -DskipTests

# Estágio 2: Package (Pacote Final)
# Usa uma imagem base leve que só tem o JRE (Java Runtime Environment)
FROM openjdk:17-jre-slim
WORKDIR /app

# Copia o arquivo JAR gerado no estágio de build
# Substitua 'sua-aplicacao-0.0.1-SNAPSHOT.jar' pelo nome real do seu JAR
# O nome do JAR geralmente segue o padrão: <artifactId>-<version>.jar
COPY --from=build /app/target/*.jar sua-aplicacao.jar

# Expõe a porta que o Spring Boot usa (padrão 8080)
EXPOSE 8080

# Comando para iniciar a aplicação quando o contêiner for executado
ENTRYPOINT ["java", "-jar", "sua-aplicacao.jar"]
