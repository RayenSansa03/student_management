# Étape 1 : Image de build avec Maven
FROM maven:3.9.0-eclipse-temurin-17 AS build

# Définir le répertoire de travail dans le conteneur
WORKDIR /app

# Copier le pom.xml et le code source
COPY pom.xml .
COPY src ./src

# Compiler le projet et créer le JAR
RUN mvn clean package -DskipTests

# Étape 2 : Image finale pour exécuter l'application
FROM eclipse-temurin:17-jre

WORKDIR /app

# Copier le JAR compilé depuis l'image de build
COPY --from=build /app/target/*.jar app.jar

# Exposer le port sur lequel l'application va tourner
EXPOSE 8080

# Commande pour démarrer l'application
ENTRYPOINT ["java", "-jar", "app.jar"]
