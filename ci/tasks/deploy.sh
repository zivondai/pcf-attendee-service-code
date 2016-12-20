#!/bin/bash

set -e +x

apt-get update
apt-get -y install apt-transport-https wget
# installtion instructions from https://github.com/cloudfoundry/cli
# first add the Cloud Foundry Foundation public key and package repository to your system
wget -q -O - https://packages.cloudfoundry.org/debian/cli.cloudfoundry.org.key | apt-key add -
echo "deb http://packages.cloudfoundry.org/debian stable main" | tee /etc/apt/sources.list.d/cloudfoundry-cli.list
# then, update your local package index, then finally install the cf CLI
apt-get update
apt-get install -y cf-cli

if [ ! `which cf` ]; then
  echo 'CF Installation Failed'
  exit 1
fi

pushd build-artifacts
echo "Deploying to Cloud Foundry"
cf login -a $CF_API -o $CF_ORG -s $CF_SPACE -u $CF_USER -p $CF_PASSWORD
cf push -f manifest.yml -p attendee-service.jar
popd

attendee_service_url=`cf apps | grep ^attendee-service | awk '{print $6}'`

if [ -z $attendee_service_url ]; then
  echo "Failed to fetch url that Attendee Service deployed to"
  exit 1
fi

echo $attendee_service_url > deployment_artifacts/url.txt

echo "Deployment Succeeded"
exit 0
