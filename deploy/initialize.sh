#!/bin/sh
echo "📡"
echo "📡📡"
echo "📡📡📡 BUILDING DOCKER IMAGE ..."
name='pisethraingsey'
version='1.0-SNAPSHOT'
packages=('configuration' 'discovery' 'endpoints')
echo "🚧-🚧-🚧-🚧 Start cleaning and packaging 🚧-🚧-🚧-🚧"
mvn -s settings.xml clean package
for pgk in "${packages[@]}"
do
  echo $pgk "is ready."
  echo "🏗️ Preparing docker image"
  echo "🛠 >>> Create docker image of $pgk"
    docker build --tag=$name/$pgk:$version -f deploy/$pgk/Dockerfile .
  echo "🗃️ Create docker images $pgk is completed."
  echo "🧳 Preparing pushing to docker hub"
  echo "🏷️ Create tag $version for $pgk"
    docker tag $version $name/$pgk:$version
  echo "🚀 >>> Pushing docker images $pgk to docker hub '$name/$pgk'"
    docker push $name/$pgk:$version
  echo "🏢 Pushed completed"
done
echo "🚧-🚧-🚧-🚧 Finished cleaning and packaging 🚧-🚧-🚧-🚧"
echo "🙌🎉🎉 OPERATION SUCCEED 🎉🎉🙌"
echo "Enjoy 🏔️...🏕️...🏖️...🏜️...🏝️"