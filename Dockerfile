#FROM openjdk:17
#FROM maven:3.8.4-openjdk-11-slim AS builder
## Set the working directory
#WORKDIR /app
#EXPOSE 8761
##RUN docker builder prune --force
##export DOCKER_BUILDKIT=0
##RUN docker build
### Create a directory
##RUN mkdir /var/lib/docker/tmp/buildkit-mount2091164732/target
## Download dependencies and cache them in a separate Docker layer
#RUN mvn dependency:go-offline -B
## Build the project
#RUN mvn clean install -DskipTests
#COPY --from=builder /app/target/eureka-server-0.0.1-SNAPSHOT.jar eureka-server.jar
#ENTRYPOINT ["java", "-jar", "eureka-server.jar"]


# Use a base image with Java and Maven installed
FROM maven:3.8.4-openjdk-11-slim AS builder

# Set the working directory
WORKDIR /app

# Copy the project's pom.xml file
COPY pom.xml .

## Download the project dependencies
#RUN mvn dependency:go-offline -B

# Copy the source code
COPY src ./src

# Build the project
RUN mvn clean install -DskipTests

# Use a lightweight base image with Java
FROM openjdk:17

# Set the working directory
WORKDIR /app

# Copy the built JAR file from the builder stage to the final container
COPY --from=builder /app/target/eureka-server-0.0.1-SNAPSHOT.jar ./eureka-server.jar

# Specify the command to run when the container starts
CMD ["java", "-jar", "eureka-server.jar"]