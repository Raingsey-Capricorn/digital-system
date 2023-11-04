FROM openjdk:17-jdk-slim AS build
LABEL authors="pisethraringsey.suon"
MAINTAINER pisethraringsey.suon <pisethraingsey@yahoo.com>
COPY ../../modules/discovery/target/discovery.war /app/discovery.war
ENTRYPOINT ["java", "-jar", "/app/discovery.war"]
EXPOSE 9999