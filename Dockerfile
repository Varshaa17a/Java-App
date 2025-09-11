FROM openjdk:8u151-jdk-alpine3.7
WORKDIR JAVA_APP
COPY target/demo-app-1.0.0.jar ./app.jar
CMD ["java" , "-jar", "app.jar"] 
