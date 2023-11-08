#!/bin/sh
echo "📡📡📡 CREATING DOCKER IMAGE 📡📡📡📡"
name='pisethraingsey'
version='1.0-SNAPSHOT'
packages=('configuration' 'discovery' 'endpoints')
echo "... Cleaning and packaging "
mvn -s settings.xml clean package
for pgk in "${packages[@]}"
do echo $pgk "is ready."
  echo "Preparing docker image building.........."
  echo " 🛠>🛠>🛠 >>>> Create docker image of $pgk >>>>>"
    docker build --tag=$name/$pgk:$version -f deploy/$pgk/Dockerfile .
  echo "<<<<<< Create docker images $pgk is completed."
  echo "Preparing pushing to docker hub.........."
  echo "🧰 > 🧰 > 🧰 >>>> Creat tag name $pgk"
    docker tag $version $name/$pgk:$version
  echo "🗃 > 🗃 > 🗃 >>>> Pushing docker images $pgk to docker hub 🚢"
    docker push $name/$pgk:$version
done
echo "🎉🙌🎉🙌🎉🙌🎉🙌🎉🙌🎉🙌🎉🙌🎉🙌🎉🙌🎉🙌🎉🙌🎉🙌"
echo "🙌🎉🎉 CREATING DOCKER IMAGE COMPLETED       🎉🎉🙌  "
echo "🎉🙌🎉🙌🎉🙌🎉🙌🎉🙌🎉🙌🎉🙌🎉🙌🎉🙌🎉🙌🎉🙌🎉🙌"
