<<<<<<< HEAD
<<<<<<< HEAD
# zetasql-analyzer-server
zetaSQL analyzer
=======
# GoogleSQL dialect format server using ZetaSQL
=======
# zetasql-format-server

<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
It is GoogleSQL dialect format server using ZetaSQL. It runs on Cloud Run(and Knative Serving).
>>>>>>> Add description to README.md
=======
It is GoogleSQL dialect format server using [ZetaSQL](https://github.com/google/zetasql). It runs on Cloud Run(and Knative Serving).
>>>>>>> Fix reference
=======
It is GoogleSQL(BigQuery, Cloud SQL) dialect format server using [ZetaSQL](https://github.com/google/zetasql). It runs on Cloud Run(and Knative Serving).
>>>>>>> Add desc of GoogleSQL
=======
It is GoogleSQL(BigQuery, Cloud Spanner) dialect format server using [ZetaSQL](https://github.com/google/zetasql). It runs on Cloud Run(and Knative Serving).
>>>>>>> Fix typo

[![Run on Google Cloud](https://storage.googleapis.com/cloudrun/button.png)](https://console.cloud.google.com/cloudshell/editor?shellonly=true&cloudshell_image=gcr.io/cloudrun/button&cloudshell_git_repo=https://github.com/apstndb/zetasql-format-server.git)

(Note: It takes very long time. Consider to use [Boost mode](https://cloud.google.com/shell/docs/features?hl=en#boost_mode) or build on more powerful machine.)

## Usage

```sh
$ SERVICE_URL=$(gcloud beta run services describe --format="value(status.domain)" ${REPO_NAME})
$ curl ${SERVICE_URL} --data 'SELECT * FROM tbl'
SELECT
  *
FROM
  tbl
```

## References

<<<<<<< HEAD
- https://github.com/google/zetasql/
- https://github.com/jamesward/cloud-run-button
>>>>>>> Add references
=======
- https://github.com/google/zetasql
- https://github.com/jamesward/cloud-run-button
<<<<<<< HEAD
>>>>>>> Fix reference
=======
>>>>>>> Fix typo
