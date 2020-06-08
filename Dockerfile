FROM gcr.io/mydata-1470162410749/zetasql-analyzer-base:latest AS build-env
#FROM marketplace.gcr.io/google/bazel:3.2.0 AS build-env

RUN apt-get update \
    && apt-get install -y \
        nmap \
        vim

RUN apt-get install --reinstall make

WORKDIR /work
RUN mkdir /app && mkdir /app/dependencies
RUN cp -R /work/. /app/dependencies

WORKDIR /app
COPY formatsql.cc formatsql.h main.go BUILD WORKSPACE CROSSTOOL .bazelrc /app/

RUN cd /app \
    && bazel build //:zetasql-analyzer-server

FROM gcr.io/distroless/cc
COPY --from=build-env /app/bazel-bin/linux_amd64_stripped/zetasql-server ./
ENTRYPOINT ["./zetasql-analyzer-server"]

# Run a golang server
#####################################
# RUN cd /zetasql \
#   && /usr/local/go/bin/go run main.go

# Execute a query
#####################################
# CMD cd /zetasql && bazel run //zetasql/experimental:execute_query -- "select 1 + 1;"