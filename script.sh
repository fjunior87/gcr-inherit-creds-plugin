#! /bin/bash

if ($PLUGIN_DEBUG = "true"); then
    echo "Tags: ${PLUGIN_TAG}"
    echo "Context: $PLUGIN_CONTEXT"
    echo "Repository: $PLUGIN_REPOSITORY"
    echo "Registry: $PLUGIN_REGISTRY"
fi

#using gcloud to authenticate against gcr
gcloud auth configure-docker --quiet

TAGS=${PLUGIN_TAG:-""}
DOCKER_CTX=${PLUGIN_CONTEXT:-"."}
REPO=${PLUGIN_REPOSITORY:-""}

docker build -f ${PLUGIN_DOCKERFILE:-"Dockerfile"} -t $REPO $DOCKER_CTX
IFS=","
for v in $TAGS
do
  docker tag $REPO $REPO:$v
done

for v in $TAGS
do
  docker push $REPO:$v
done
