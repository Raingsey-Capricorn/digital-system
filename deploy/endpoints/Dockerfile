FROM        openjdk:17-jdk-slim AS build
LABEL       authors="pisethraringsey.suon"
MAINTAINER  pisethraringsey.suon <pisethraingsey@yahoo.com>
ARG         MODULE=endpoints
ARG         FILE=../../modules/${MODULE}/target/${MODULE}.war
COPY        ${FILE} /app/${MODULE}.war
ENTRYPOINT  ["java", "-jar","/app/endpoints.war"]
EXPOSE      10000