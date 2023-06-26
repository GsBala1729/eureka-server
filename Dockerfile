FROM openjdk:17
EXPOSE 8761
# Download dependencies and cache them in a separate Docker layer
RUN mvn dependency:go-offline -B
# Build the project
RUN mvn clean install -DskipTests
ADD target/eureka-server-0.0.1-SNAPSHOT.jar eureka-server.jar
ENTRYPOINT ["java", "-jar", "eureka-server.jar"]