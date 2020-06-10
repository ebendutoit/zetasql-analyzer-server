# zetasql-analyzer-server

zetaSQL is a parser used by Google to parse queries for Google BigQuery and Cloud Spanner. 

# What is this repo about?

This repository solves a few needs:
- A [Dockerfile](https://github.com/ebendutoit/zetasql-analyzer-server/blob/master/Dockerfile.base) based on Ubuntu 18.04 that serves as base in order to build the very latest version of zetaSQL
- A [Dockerfile](https://github.com/ebendutoit/zetasql-analyzer-server/blob/master/Dockerfile) to build a service that offers the syntax checking functionality of zetaSQL

# Input repositories and references
Input repositories to this one:
- The Google base repository for zetaSQL: https://github.com/google/zetasql
- A nice docker application to server the formatter function of zetaSQL: https://github.com/apstndb/zetasql-format-server

