FROM        openjdk:17-jdk-slim AS build
LABEL       authors="pisethraringsey.suon"
MAINTAINER  pisethraringsey.suon <pisethraingsey@yahoo.com>
ARG         MODULE=applications
ARG         FILE=../../modules/${MODULE}/target/${MODULE}.jar
COPY        ${FILE} /app/${MODULE}.jar
ENTRYPOINT  ["java", "-jar","/app/applications.jar"]
EXPOSE      9000