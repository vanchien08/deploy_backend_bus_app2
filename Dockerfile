# Build stage - dùng Maven với JDK 21
FROM maven:3.9.6-eclipse-temurin-21 AS build
WORKDIR /app

COPY . .
RUN mvn clean package -DskipTests

# Run stage - chỉ cần JDK 21
FROM openjdk:21-jdk-slim
WORKDIR /app

COPY --from=build /app/target/BusBooking-0.0.1-SNAPSHOT.jar BusBooking.jar
EXPOSE 8080

ENTRYPOINT ["java", "-jar", "BusBooking.war"]