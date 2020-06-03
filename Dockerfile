FROM gcr.io/mydata-1470162410749/zetasql-analyzer:latest
COPY formatsql.cc formatsql.h main.go /zetasql/

# Abseil
RUN cd /tmp && git clone https://github.com/abseil/abseil-cpp.git abseil && cp -R abseil/absl /zetasql/

RUN cd /tmp \
  && apt-get update \
  && apt-get install wget \
  && wget https://dl.google.com/go/go1.11.linux-amd64.tar.gz \
  && tar -xvf go1.11.linux-amd64.tar.gz \
  && mv go /usr/local \
  && export GOROOT=/usr/local/go  \
  && export GOPATH=$HOME/go \
  && export PATH=$GOPATH/bin:$GOROOT/bin:$PATH \
  && go version \
  && which go \
  && echo $GOPATH 

RUN cd /zetasql \
  && /usr/local/go/bin/go build main.go

RUN cd /zetasql \
  && /usr/local/go/bin/go run main.go
# CMD cd /zetasql && bazel run //zetasql/experimental:execute_query -- "select 1 + 1;"