#!/bin/bash

set -e +x

pushd attendee-service
  echo "Resolving Maven dependencies"
  ./mvnw clean compile > /dev/null

  echo "Running tests"
  ./mvnw test

  echo "Packaging JAR"
  ./mvnw package -Dmaven.test.skip=true
popd

jar_count=`find attendee-service/target -type f -name *.jar | wc -l`

if [ $jar_count -gt 1 ]; then
  echo "More than one jar found, don't know which one to deploy. Exiting"
  exit 1
fi

find attendee-service/target -type f -name *.jar -exec cp "{}" package-output/attendee-service.jar \;

echo "Contents of package-output"
ls package-output

echo "Done packaging"
exit 0
