#!/bin/bash
set -e -u -o pipefail

echo "Installing the AWS CLI..."
curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
unzip awscli-bundle.zip
sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws

echo "Deploying..."
echo -e "[appservices]\naws_access_key_id = ${AWS_ECS_TASK_DEFINITION}\naws_secret_access_key = ${AWS_ECS_TASK_DEFINITION}\n" > ~/.aws
aws ecs describe-task-definition --task-definition "${AWS_ECS_TASK_DEFINITION}"
aws ecs update-service --cluster ${AWS_ECS_CLUSTER} --service ${AWS_ECS_SERVICE} --force-new-deployment
