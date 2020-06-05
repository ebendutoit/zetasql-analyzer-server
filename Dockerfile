FROM gcr.io/mydata-1470162410749/zetasql-analyzer-base:latest AS build-env
COPY formatsql.cc formatsql.h main.go /zetasql/

RUN apt-get update \
    && apt-get install -y \
        nmap \
        vim

RUN cd /zetasql \
  && /usr/local/go/bin/go build -o zetasql-server .

FROM gcr.io/distroless/cc
COPY --from=build-env /zetasql/zetasql-server ./
ENTRYPOINT ["./zetasql-server"]

# Run the Go server
#####################################
# RUN cd /zetasql \
#   && /usr/local/go/bin/go run main.go

# Execute a query
#####################################
# CMD cd /zetasql && bazel run //zetasql/experimental:execute_query -- "select 1 + 1;"