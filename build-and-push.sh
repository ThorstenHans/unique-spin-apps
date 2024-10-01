#! /bin/bash

OCI_ARTIFACT=${OCI_ARTIFACT:-thorstenhans/unique-spin-app}
set -euo pipefail

if [ -z "${REGISTRY_USER:-}" ]; then
     echo "Error: REGISTRY_PASSWORD is not set."
     exit 1
fi

if [ -z "${REGISTRY_PASSWORD:-}" ]; then
     echo "Error: REGISTRY_PASSWORD is not set."
     exit 1
fi

spin registry login -u $REGISTRY_USER -p $REGISTRY_PASSWORD $REGISTRY_LOGIN_SERVER

cd app

for i in {1..5000}; do
     if (( i % 1000 == 0 )); then
          spin registry login -u $REGISTRY_USER -p $REGISTRY_PASSWORD $REGISTRY_LOGIN_SERVER
     fi
     echo "Building and pushing Spin App: $i"
     sed "s/APP_ID/$i/g" ./src/lib.rs.tpl > ./src/lib.rs
     spin registry push $OCI_ARTIFACT:$i --build 

done
