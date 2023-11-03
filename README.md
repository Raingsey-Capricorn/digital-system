# digital-system
Spring framework - clouds (eureka - microservices) &amp; security, hibernate

To build the docker image for each module, make sure the start command from the root directory, by specifying the path to Dockerfile as below:

docker build --build-arg --tag=dig-sys-config:latest -f deploy/Dockerfile .
