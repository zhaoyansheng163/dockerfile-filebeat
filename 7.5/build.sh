#!/bin/bash
_filebeat_version=$1
_filebeat_tag=$2
_release_build=false

if [ -z "${_filebeat_version}" ]; then
	source FILEBEAT_VERSION
	_filebeat_version=$FILEBEAT_VERSION
	_filebeat_tag=$FILEBEAT_VERSION
	_release_build=true
fi

echo "FILEBEAT_VERSION: ${_filebeat_version}"
echo "DOCKER TAG: ${_filebeat_tag}"
echo "RELEASE BUILD: ${_release_build}"

docker build --build-arg FILEBEAT_VERSION=${_filebeat_version} --tag "stakater/filebeat:${_filebeat_tag}"  --no-cache=true .

if [ $_release_build == true ]; then
	docker tag "stakater/filebeat:${_filebeat_tag}" "stakater/filebeat:latest"
fi