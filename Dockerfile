# ==========================================================
# ESTÁGIO 1: BUILD (Compilação e Criação do JAR)
# Usa uma tag válida: Maven 3 com OpenJDK 17
# ==========================================================
FROM maven:3-openjdk-17 AS build
WORKDIR /app

# Copia os arquivos de build (pom.xml, etc.) primeiro para otimizar o cache
COPY pom.xml .

# Copia todo o código fonte
COPY src /app/src

# Comando de Build: Limpa, Compila e Cria o JAR (pulando testes para deploy mais rápido)
RUN mvn clean package -DskipTests

# ==========================================================
# ESTÁGIO 2: PACKAGE (Imagem Final Leve)
# Usa uma imagem base leve que contém apenas o JRE 17
# ==========================================================
FROM openjdk:17-jre-slim
WORKDIR /app

# COPIAR AQUI: Substitua 'nome-do-seu-jar.jar' pelo nome exato do arquivo que o seu projeto gera
# Ele é o JAR que foi gerado em /app/target/ no estágio de build
COPY --from=build /app/target/*.jar app.jar

# A maioria dos ambientes Cloud injeta a porta, mas esta linha é boa para documentação
EXPOSE 8080

# Comando para iniciar a aplicação Spring Boot
ENTRYPOINT ["java", "-jar", "app.jar"]
