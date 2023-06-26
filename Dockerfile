FROM openjdk:17
EXPOSE 8761
RUN docker builder prune --force \
export DOCKER_BUILDKIT=0
RUN docker build
# Create a directory
#RUN mkdir /var/lib/docker/tmp/buildkit-mount2091164732/target
# Download dependencies and cache them in a separate Docker layer
RUN mvn dependency:go-offline -B
# Build the project
RUN mvn clean install -DskipTests
#ADD target/eureka-server-0.0.1-SNAPSHOT.jar eureka-server.jar
ENTRYPOINT ["java", "-jar", "eureka-server-0.0.1-SNAPSHOT.jar"]