FROM        openjdk:17-jdk-slim AS build
LABEL       authors="pisethraringsey.suon"
MAINTAINER  pisethraringsey.suon <pisethraingsey@yahoo.com>
ARG         MODULE=discovery
ARG         FILE=../../modules/${MODULE}/target/${MODULE}.war
COPY        ${FILE} /app/${MODULE}.war
ENTRYPOINT  ["java", "-jar","/app/discovery.war"]
EXPOSE      9999