#!/bin/bash

set -e

export ANSI_YELLOW="\e[1;33m"
export ANSI_GREEN="\e[32m"
export ANSI_RESET="\e[0m"

echo -e "\n $ANSI_YELLOW *** FUNCTIONAL TEST(S) *** $ANSI_RESET \n"

echo -e "$ANSI_YELLOW It can run a Java program: $ANSI_RESET"
docker build 1.15/test/ runs-java-programs
docker run --rm --name runs-java-programs test/run-app/quay.io/ibmz/openjdk
docker rmi test/run-app/quay.io/ibmz/openjdk

echo -e "\n $ANSI_GREEN *** FUNCTIONAL TEST(S) COMPLETED SUCESSFULLY *** $ANSI_RESET \n"
