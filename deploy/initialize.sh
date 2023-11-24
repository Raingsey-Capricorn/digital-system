#!/bin/zsh

# High Intensity
I_BLUE='\033[0;94m'
I_CYAN='\033[0;96m'
I_WHITE='\033[0;97m'
I_PURPLE='\033[0;95m'
#Bold + Intensity
DEFAULT='\033[0m'
B_I_GREEN='\033[1;92m'      # Green
B_I_YELLOW='\033[1;93m'

NAME='pisethraingsey'
VERSION='1.0-SNAPSHOT'
PACKAGES=('configuration' 'discovery' 'endpoints')
DOCKER_HUB_URL=https://hub.docker.com/repository/docker

echo -e "📡 ${B_I_YELLOW} Building Docker Images ...${DEFAULT}"
echo -e "🚧-🚧-🚧-🚧 ${I_CYAN}Start cleaning and packaging${DEFAULT} 🚧-🚧-🚧-🚧"
  mvn -s settings.xml clean package
for pgk in "${PACKAGES[@]}"
  do
    TAG=$pgk:$VERSION
    printf "${B_I_GREEN}->✅  ${I_PURPLE}$pgk - ${I_WHITE}is ready\n${B_I_GREEN}#-1:${B_I_YELLOW} 🏗️... Preparing ${BIBLUE}Building${I_WHITE} docker image\n${B_I_GREEN}#-2: 🛠 >>> Create docker image of $pgk"
      docker build --tag=$TAG -f deploy/$pgk/Dockerfile .
    printf "\n${B_I_GREEN}->   🗃️'${I_PURPLE}$NAME/$pgk${DEFAULT}' ${I_WHITE}image is ready ✅   \n${B_I_GREEN}->${B_I_YELLOW}   🗜️... Preparing ${BIBLUE}Pushing${I_WHITE} to docker hub\n${B_I_GREEN}#-3: 🏷️>>> Create tag $pgk:$VERSION for '$pgk'"
      docker tag $TAG $NAME/$pgk:$VERSION
    printf "\n${B_I_GREEN}#-4:${B_I_YELLOW} 🚀 ... Pushing '$NAME/$pgk' ${I_WHITE}image to${DEFAULT} ${I_BLUE}${DOCKER_HUB_URL}$NAME/$pgk/general"
      docker push $NAME/$TAG
    printf "\n${B_I_GREEN}>>>>${BICYAN} 🏢 Pushed completed ✅   "
  done
echo ""
for pgk in "${PACKAGES[@]}";do  printf "${I_PURPLE}🏭 ✅ '$NAME/$pgk:$VERSION'${I_WHITE} image is ready for pulling at ${DEFAULT}${I_BLUE}\t${DOCKER_HUB_URL}/$NAME/$pgk/general\n" ;done
echo "🚧-🚧-🚧-🚧 Finished cleaning and packaging 🚧-🚧-🚧-🚧"
echo "🏆🏆🙌🎉🎉   OPERATION SUCCEED 🎉🎉🙌🏆🏆"
echo "Enjoy 🏔️...🏕️...🏖️...🏜️...🏝️"