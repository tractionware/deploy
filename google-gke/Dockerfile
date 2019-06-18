FROM gcr.io/cloud-builders/gcloud-slim@sha256:7e910b97dd13d8e32acb3e53c5f4d2164c5ea8e93de1ea51e610a1112fa6308e

LABEL "name"="deploy-to-google-gke"
LABEL "maintainer"="David Staheli"
LABEL "version"="1.0.0"

LABEL "com.github.actions.name"="Deploy to Google Kubernetes Engine"
LABEL "com.github.actions.description"=""
LABEL "com.github.actions.icon"="package"
LABEL "com.github.actions.color"="gray-dark"

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
