# zetasql-analyzer-server

zetaSQL is a parser used by Google to parse queries for Google BigQuery and Cloud Spanner. 

## What is this repo about?

This repository solves a few needs:
- A [Dockerfile](https://github.com/ebendutoit/zetasql-analyzer-server/blob/master/Dockerfile.base) based on Ubuntu 18.04 that serves as base in order to build the very latest version of zetaSQL
- A [Dockerfile](https://github.com/ebendutoit/zetasql-analyzer-server/blob/master/Dockerfile) to build a service that offers the syntax checking functionality of zetaSQL
- A reference [Dockerfile](https://github.com/ebendutoit/zetasql-analyzer-server/blob/master/Dockerfile.latest) that you can use to compile the latest zetaSQL from sources if you want to

## How to build

1. First, build `Dockerfile.base`. You can name it `gcr.io/<your google project id>/zetasql-analyzer-base:latest`. It is suggested that this is built on a Compute Engine instance or machine with > 8 cores, 100Gb of disk space and 32Gb of memory to be safe.

From the repo root folder, run
```
docker build -f Dockerfile.base -t gcr.io/<your google project id>/zetasql-analyzer-base:latest .
```
2. Push the base image to `gcr.io`

```
docker push gcr.io/<your google project id>/zetasql-analyzer-base:latest
```
3. Build `Dockerfile`. You can name it `gcr.io/<your google project id>/zetasql-analyzer-server:latest`

```
docker build -t gcr.io/<your google project id>/zetasql-analyzer-server:latest .
```
If the compiled binary cannot be found, you can log into the docker container with 
```
docker run -t <imageId> bash 
```
and browse the `/app/bazel-out` directory to search for the binary `zetasql-analyzer-server`. Adjust the last COPY step of the Dockerfile with this location if necessary and rebuild

4. Deploy `gcr.io/<your google project id>/zetasql-analyzer-base:latest` on Google Cloud Run.

5. Send a SQL statement to the Cloud Run endpoint to test
```
curl -X POST -H 'Content-type: application/text' --data 'SLECT 1, ' https://<your endpoint goes here>
```
and it should respond with
```
generic::invalid_argument: Syntax error: Unexpected identifier "SLECT" [zetasql.ErrorLocation] { line: 1 column: 1 }
```


## References
Input repositories to this one:
- The Google base repository for zetaSQL: https://github.com/google/zetasql
- A nice docker application to server the formatter function of zetaSQL: https://github.com/apstndb/zetasql-format-server

