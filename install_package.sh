#!/bin/bash

# this tries to work out what package you're installing and tries to do the build phase

apt-get update && apt-get -y install \
        make \
        jq \
        git \

if [ "$1" == "splunk-add-on-ucc-framework" ]; then
    echo "Just installing from pip, don't need to do extra things!"
    /venv/bin/python -m pip install "$1"
else
    apt-get -y install \
        curl \
        gnupg2
    apt install curl gpg gnupg2 software-properties-common apt-transport-https lsb-release ca-certificates
    mkdir -p /etc/apt/keyrings
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
    NODE_MAJOR=20
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" > /etc/apt/sources.list.d/nodesource.list

    # curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
    # echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list
    # apt update &&  apt install -y nodejs yarn
    apt-get update && apt-get -y install nodejs

    npm install -g yarn

    #shellcheck disable=SC2046
    git clone $(python parse_package_ref.py "${1}")

    cd package || exit 1

    if [ -f "./build-ui.sh" ]; then
        echo "Running build script"
        ./build-ui.sh || exit 1
    else
        echo "build_ui.sh is missing, this seems weird"
        exit 1
    fi

    /venv/bin/python -m pip install .
fi

apt-get clean