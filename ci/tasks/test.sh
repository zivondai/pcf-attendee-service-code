#!/bin/bash

set -e +x

pushd attendee-service-source
  echo "Fetching Dependencies"
  ./mvnw clean compile > /dev/null

  echo "Running Tests"
  ./mvnw test
popd

exit 0
