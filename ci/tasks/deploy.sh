#!/bin/bash

set -e +x

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
