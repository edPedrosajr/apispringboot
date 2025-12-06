# ==========================================================
# ESTÁGIO 1: BUILD (Compilação e Criação do JAR)
# ... (Este estágio está correto agora) ...
FROM maven:3-openjdk-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src /app/src
RUN mvn clean package -DskipTests

# ==========================================================
# ESTÁGIO 2: PACKAGE (Imagem Final Leve)
# Usa a tag slim mais confiável para o JRE 17
# ==========================================================
FROM openjdk:17-jre-slim-buster  # <--- LINHA CORRIGIDA
WORKDIR /app

# COPIAR AQUI: Substitua 'app.jar' se você usou um nome diferente
COPY --from=build /app/target/*.jar app.jar 

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
