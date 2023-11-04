FROM openjdk:17-jdk-slim AS build
LABEL authors="pisethraringsey.suon"
MAINTAINER pisethraringsey.suon <pisethraingsey@yahoo.com>
COPY ../../modules/configuration/target/configuration.jar /app/configuration.jar
ENTRYPOINT ["java", "-jar","/app/configuration.jar"]
EXPOSE 7777