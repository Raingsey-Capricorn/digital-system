FROM openjdk:17-jdk-slim AS build
LABEL authors="pisethraringsey.suon"
MAINTAINER pisethraringsey.suon <pisethraingsey@yahoo.com>
COPY ../../modules/endpoints/target/endpoints.war /app/endpoints.war
ENTRYPOINT ["java", "-jar","/app/endpoints.war"]
EXPOSE 10000