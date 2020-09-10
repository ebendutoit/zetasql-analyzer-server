FROM docker.io/eebsidian/zetasql-base:latest AS build-env

RUN apt-get update \
    && apt-get install -y \
        nmap \
        vim

RUN apt-get install --reinstall make

RUN mkdir /app
WORKDIR /app
#RUN mkdir /app && mkdir /app/dependencies
#RUN cp -R /work/. /app/dependencies

#WORKDIR /app
COPY parse_query.cc parse_query.h main.go BUILD WORKSPACE CROSSTOOL .bazelrc /app/

RUN cd /app \
    && bazel build ...

FROM gcr.io/distroless/cc
## Replace k8-fastbuild-ST-f6ff168d88b985c1411feb6f1fd6ce141962ad61a58c3dbc03d4d6b9b3c2d4a3 with your local build. 
## You can analyse this with an interactive shell: docker run -it <image hash> bash
COPY --from=build-env /app/bazel-out/k8-fastbuild-ST-f6ff168d88b985c1411feb6f1fd6ce141962ad61a58c3dbc03d4d6b9b3c2d4a3/bin/zetasql-analyzer-server_/zetasql-analyzer-server ./

ENTRYPOINT ["./zetasql-analyzer-server"]

# Run a golang server
#####################################
# RUN cd /zetasql \
#   && /usr/local/go/bin/go run main.go

# Execute a query
#####################################
# CMD cd /zetasql && bazel run //zetasql/experimental:execute_query -- "select 1 + 1;"
