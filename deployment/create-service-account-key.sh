#!/usr/bin/env bash

set -e
cd "$(dirname "${BASH_SOURCE[0]}")"
source yaml.sh

create_variables ../params.yaml

gcloud iam service-accounts keys create ~/key.json \
  --iam-account ${service_account_name}@${project_id}.iam.gserviceaccount.com
