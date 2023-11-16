FROM        openjdk:17-jdk-slim AS build
LABEL       authors="pisethraringsey.suon"
MAINTAINER  pisethraringsey.suon <pisethraingsey@yahoo.com>
ARG         MODULE=configuration
ARG         FILE=../../modules/${MODULE}/target/${MODULE}.jar
COPY        ${FILE} /app/${MODULE}.jar
ENTRYPOINT  ["java", "-jar","/app/configuration.jar"]
EXPOSE      7777