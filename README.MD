# GCR Inherit Creds Plugin  

Simple drone plugin for build and push a docker image to GCR inheriting the credentials from the Service Account attached to the GKE cluster.

## Requirements
* It must be running in GCP in a workload with a Service Account associated with it;
* It needs to have a docker service in the pipeline;

## Disclaimer
* It was tested only in GKE;

## Usage Example 

**Harness Continuous Integration Enterprise**

    - step:
        type: Plugin
        name: Docker Build Plugin
        identifier: Docker_Build_Plugin
        spec:
            connectorRef: DockerHub
            image: fjunior87/gcr-inherit-creds-plugin:latest
            privileged: true
            settings:
                registry: us.gcr.io
                tag: latest,123
                dockerfile: Dockerfile
                context: "."
                repository: us.gcr.io/my-gcp-project/test
                debug: "true"
            imagePullPolicy: Always
