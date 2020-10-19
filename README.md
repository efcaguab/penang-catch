Penang catch
================

This repository contains code for the Penang catch data pipeline.

## Pipeline description

*Pipeline input(s)*: A manually updated excel sheet containing catch
information at Penangs landing sites.

*Pipeline product(s)*: A BigQuery dataset with clean catch data. The
dataset includes tables with *(i)* the full clean dataset, *(ii)*
aggregated summaries, summaries per *(iii)* fisher, and *(iv)* species.

**Stages**:

1.  Input data (excel format) is stored in Google Storage. Updates are
    manual.
2.  Changes in the storage file are automatically detected and trigger a
    Google pub/sub notification.
3.  The pub/sub message triggers a call to an API processing function
    that reads the data from the storage. The function then validates,
    cleans, and transforms, the data. Finally, the clean data is
    deposited in a Google BigQuery table. The processing function runs
    serverless in Google CloudRun.

## Deployment steps

  - [Create a service
    account](https://cloud.google.com/iam/docs/creating-managing-service-accounts)
    for this domain:
    [`deployment/create-service-account.sh`](deployment/create-service-account.sh)

  - [Create a
    key](https://cloud.google.com/iam/docs/creating-managing-service-account-keys)
    for the service account:
    [`deployment/create-service-account-key.sh`](deployment/create-service-account-key.sh)

  - [Upload the
    key](https://cloud.google.com/secret-manager/docs/creating-and-accessing-secrets#secretmanager-create-secret-cli)
    to Google Secret Manager to simplify reuse:
    [`deployment/create-secret.sh`](deployment/create-secret.sh)

  - [Create the
    storage](https://cloud.google.com/storage/docs/creating-buckets)
    bucket:
    [`deployment/create-storage-bucket.sh`](deployment/create-storage-bucket.sh)

  - [Create topic](https://cloud.google.com/pubsub/docs/admin) for
    message passing between the storage bucket and the validation API:
    [`deployment/create-pubsub-topic.sh`](deployment/create-pubsub-topic.sh)

  - [Enable
    notifications](https://cloud.google.com/storage/docs/gsutil/commands/notification)
    for raw data updates to the validation topic:
    [`deployment/create-raw-data-notification.sh`](deployment/create-raw-data-notification.sh)

## Requirements

  - Docker \>= 18.0
  - [Google Cloud SDK](https://cloud.google.com/sdk/docs/install) \>=
    311.0.0
