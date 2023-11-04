# digital-system
Spring framework - clouds (eureka - microservices) &amp; security, hibernate

https://stackoverflow.com/questions/24537340/docker-adding-a-file-from-a-parent-directory
</br>To build the docker image for each module, make sure the start command from the root directory, by specifying the path to Dockerfile as below:

docker build --build-arg --tag=dig-sys-config:latest -f deploy/Dockerfile .
docker build --build-arg MODULE=configuration --build-arg FILE=digsys-config.jar --tag=dig-sys-config:1.0-SNAPSHOT -f deploy/Dockerfile .

https://medium.com/jinternals/build-docker-images-with-and-maven-901ec0d9de58

running maven with specified setting.xml</br>
mvn -s settings.xml clean package

