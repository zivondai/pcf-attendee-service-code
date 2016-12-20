#!/bin/bash

set -ex

pushd attendee-service-source
  echo "Packaging JAR"
  ./mvnw clean package -DskipTests
popd

jar_count=`find attendee-service-source/target -type f -name *.jar | wc -l`

if [ $jar_count -gt 1 ]; then
  echo "More than one jar found, don't know which one to deploy. Exiting"
  exit 1
fi

find attendee-service-source/target -type f -name *.jar -exec cp "{}" build-artifacts/attendee-service.jar \;
cp attendee-service-source/manifest.yml build-artifacts/manifest.yml

echo "Done packaging"
exit 0
