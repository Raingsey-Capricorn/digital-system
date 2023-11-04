#!/bin/sh
echo "########################################################"
echo "##                                                    ##"
echo "##              CREATING DOCKER IMAGE                 ##"
echo "##                                                    ##"
echo "########################################################"
packages=('configuration' 'discovery' 'endpoints')
echo "... Cleaning and packaging "
mvn -s settings.xml clean package
for pgk in "${packages[@]}"
  do echo $pgk "is ready."
      echo ">>>>>> Create docker image of $pgk >>>>>"
      docker build --tag=$pgk:1.0-SNAPSHOT -f deploy/$pgk/Dockerfile .
      echo ">>>>>> Create docker images $pgk is completed."
done