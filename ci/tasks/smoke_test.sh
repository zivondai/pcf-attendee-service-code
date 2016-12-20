#!/bin/bash

set -e +x

if [ ! -e deployment-artifacts/url.txt ]; then
  echo "Failed to find deployment url"
  exit 1
fi

attendee_service_url=`cat deployment-artifacts/url.txt`
pushd attendee-service-source
  echo "Running smoke tests for Attendee Service deployed at $attendee_service_url"
  smoke_tests/bin/test $attendee_service_url
popd

exit 0
