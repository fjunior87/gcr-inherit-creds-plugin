#! /bin/bash

if ($PLUGIN_DEBUG = "true"); then
    echo "Tags: ${PLUGIN_TAG}"
    echo "Context: $PLUGIN_CONTEXT"
    echo "Repository: $PLUGIN_REPOSITORY"
    echo "Registry: $PLUGIN_REGISTRY"
fi

METADATA=http://metadata.google.internal./computeMetadata/v1
SVC_ACCT=$METADATA/instance/service-accounts/default
ACCESS_TOKEN=$(curl -H 'Metadata-Flavor: Google' $SVC_ACCT/token \
    | cut -d'"' -f 4)

docker login -u '_token' -p $ACCESS_TOKEN https://$PLUGIN_REGISTRY

TAGS=${PLUGIN_TAG:-""}
DOCKER_CTX=${PLUGIN_CONTEXT:-"."}
REPO=${PLUGIN_REPOSITORY:-""}

#build image and get the image ID
ID=$(docker build -f ${PLUGIN_DOCKERFILE:-"Dockerfile"} -q  $DOCKER_CTX)
echo "Built Image id: $ID"
IFS=","
for v in $TAGS
do
  docker tag $ID $REPO:$v
done

for v in $TAGS
do
  docker push $REPO:$v
done