#!/bin/bash
set -e -u -o pipefail

echo "Installing the gcloud CLI..."
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
sudo apt-get update && sudo apt-get install -y google-cloud-sdk

echo "Deploying..."
echo "${GCLOUD_KEY_FILE}" | base64 --decode > gcloud.json
gcloud auth activate-service-account "${GCLOUD_SERVICE_ACCOUNT}" --key-file=gcloud.json
gcloud config set project "${GCLOUD_PROJECT}"
gcloud config set compute/zone "${GCLOUD_ZONE}"
gcloud container clusters get-credentials "${GCLOUD_KUBERNETES_CLUSTER}"
kubectl set image deployments/"${GCLOUD_KUBE_SERVICE_NAME}" "${GCLOUD_KUBE_SERVICE_NAME}"="${CONTAINER_IMAGE_NAME}"
kubectl patch deployment "${GCLOUD_KUBE_SERVICE_NAME}" -p "{\"spec\":{\"template\":{\"metadata\":{\"labels\":{\"date\":\"`date +'%s'`\"}}}}}"
