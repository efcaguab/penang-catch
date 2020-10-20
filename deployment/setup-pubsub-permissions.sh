#!/usr/bin/env bash

set -e
cd "$(dirname "${BASH_SOURCE[0]}")"
source yaml.sh

create_variables ../params.yaml

# Get project number based on the project id
project_number=$(gcloud projects describe ${project_id} | grep Number | cut -d "'" -f 2)

# 3. Enable Pub/Sub to create authentication tokens in your project
gcloud projects add-iam-policy-binding ${project_id} \
   --member=serviceAccount:service-${project_number}@gcp-sa-pubsub.iam.gserviceaccount.com \
   --role=roles/iam.serviceAccountTokenCreator

# 4. Create or select a service account to represent the Pub/Sub subscription identity.
gcloud iam service-accounts create cloud-run-pubsub-invoker \
   --display-name "Cloud Run Pub/Sub Invoker"
