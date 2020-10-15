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

  - [Create a service account for this
    domain](deployment/create-service-account.sh)
  - Create a key for the service account
  - Upload the
  - Create a storage bucket
  - Upload data to bucket

## Requirements

  - Docker \>= 18.0
  - [Google Cloud SDK](https://cloud.google.com/sdk/docs/install)
