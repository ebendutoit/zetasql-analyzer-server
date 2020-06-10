# zetasql-analyzer-server

zetaSQL is a parser used by Google to parse queries for Google BigQuery and Cloud Spanner. 

# What is this repo about?

The base repository is here: This repository solves a few needs:
- A dockerfile based on Ubuntu 18.04 that serves as base to use the latest version of zetaSQL
- A dockerfile to build a service that offers the syntax checking functionality of zetaSQL

# Input repositories and references
Input respositories to this one:
- The Google base repository for zetaSQL: https://github.com/google/zetasql
- A nice docker application to server the formatter function of zetaSQL: https://github.com/apstndb/zetasql-format-server

