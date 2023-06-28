FROM openjdk:17
EXPOSE 8761
#RUN wget https://api.github.com/repos/GsBala1729/eureka-server/actions/artifacts/eureka-server/zipball -O artifact.zip \
#    && unzip -j artifact.zip "/home/runner/.m2/repository/com/kanin/admin-microservice/0.0.1-SNAPSHOT/admin-microservice-0.0.1-SNAPSHOT.jar" -d /app \
#    && rm artifact.zip
ADD target/eureka-server-0.0.1-SNAPSHOT.jar eureka-server.jar
ENTRYPOINT ["java", "-jar", "eureka-server.jar"]