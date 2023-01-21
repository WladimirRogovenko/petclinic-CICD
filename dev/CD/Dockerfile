FROM openjdk:latest
WORKDIR /opt/app
EXPOSE 8082
ENTRYPOINT ["java","-jar","app.jar", "--spring.profiles.active=mysql","--server.port=8082"]
