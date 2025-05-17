# Stage 1: Build the Java application using Maven
FROM maven:3.9.6-eclipse-temurin-8 AS builder

# Clone the repo (optional if Docker context already has the code)
WORKDIR /app
COPY . .

# Build the project
RUN mvn clean package -DskipTests

# Stage 2: Run the app using only JRE
FROM openjdk:8-jre

# Set working directory
WORKDIR /app

# Copy the JAR file from the builder stage
COPY --from=builder /app/target/devops-integration.jar devops-integration.jar

# Expose the app port
EXPOSE 8084

# Run the app
ENTRYPOINT ["java", "-jar", "devops-integration.jar"]
