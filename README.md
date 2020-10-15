Penang catch
================

This repository contains code for the Penang catch data pipeline.

## Pipeline description

**Inputs**:

1.  A manually updated excel sheet containing catch information at
    Penangs landing sites

**Outputs**:

1.  A BigQuery dataset with clean catch data
2.  A private API that provides data summaries and analytics on the
    catch data

**Stages**:

1.  Input data (excel format) is stored in Google Storage. Updates are
    manual.
2.  Changes in the storage file are automatically detected and trigger a
    pub/sub message
3.  The pub/sub message trigger a call to a CloudRun function that
    validates, cleans, and transforms, the data. The clean data is
    deposited in a private BigQuery table.
4.  An analytics

## Deployment steps

  - Create a service account for this domain
  - Create a storage bucket
  - Upload data to bucket
