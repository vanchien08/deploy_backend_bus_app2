# Build stage - dùng Maven với JDK 21
FROM maven:3.9.6-eclipse-temurin-21 AS build
WORKDIR /app

COPY . .
RUN mvn clean package -DskipTests

# Run stage - chỉ cần JDK 21
FROM openjdk:21-jdk-slim
WORKDIR /app

# Copy JAR đã build sang image (dùng wildcard để tránh lỗi version)
COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080

# Chạy JAR
ENTRYPOINT ["java", "-jar", "app.jar"]
