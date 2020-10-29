set -e

export ANSI_YELLOW="\e[1;33m"
export ANSI_GREEN="\e[32m"
export ANSI_RESET="\e[0m"

echo -e "\n $ANSI_YELLOW *** testing docker run - golang *** $ANSI_RESET \n"

echo -e "$ANSI_YELLOW Download, install via go get: $ANSI_RESET"
docker build . --tag local/golang:1.15
docker run -i --rm --name some-golang local/golang:1.15 helloworld
docker rmi local/golang:1.15

echo -e "\n $ANSI_GREEN *** TEST COMPLETED SUCESSFULLY *** $ANSI_RESET \n"
