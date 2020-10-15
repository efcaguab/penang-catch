#!/usr/bin/env bash

set -e
cd "$(dirname "${BASH_SOURCE[0]}")"
source yaml.sh

create_variables ../params.yaml

gcloud iam service-accounts create $service_account_sa_name \
    --description="${service_account_sa_description}" \
    --display-name="${service_account_sa_display_name}"
