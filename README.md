# digital-system
Spring framework - clouds (eureka - microservices) &amp; security, hibernate

https://stackoverflow.com/questions/24537340/docker-adding-a-file-from-a-parent-directory
</br>To build the docker image for each module, make sure the start command from the root directory, by specifying the path to Dockerfile as below:

docker build --build-arg --tag=dig-sys-config:latest -f deploy/Dockerfile .

running maven with specified setting.xml</br>
mvn -s settings.xml clean package

