#!/usr/bin/env bash

set -e
cd "$(dirname "${BASH_SOURCE[0]}")"
source yaml.sh

create_variables ../params.yaml

gcloud iam service-accounts keys create ${secret_file} \
  --iam-account ${service_account_name}@${project_id}.iam.gserviceaccount.com
