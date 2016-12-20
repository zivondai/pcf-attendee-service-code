#!/bin/bash

set -e +x

if [ ! -e deployment-artifacts/url.txt ]; then
  echo "Failed to find deployment url"
  exit 1
fi

attendee_service_url=`cat deployment_artifacts/url.txt`

pushd attendee-service-source
  puts "Running smoke tests"
  smoke_test/bin/test $attendee_service_url
popd

exit 0
