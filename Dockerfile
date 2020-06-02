FROM ubuntu:18.04 AS build-env

# Avoid warnings by switching to noninteractive
ENV DEBIAN_FRONTEND=noninteractive

# Or your actual UID, GID on Linux if not the default 1000
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

ENV CC /usr/bin/gcc
WORKDIR /work

# Configure apt and install packages
RUN apt-get update \
    && apt-get -y install --no-install-recommends apt-utils dialog 2>&1 \
    # 
    # Verify git, process tools, lsb-release (useful for CLI installs) installed
    && apt-get -y install git procps lsb-release \
    # Some more packages
    && apt-get -y install pkg-config zip g++ zlib1g-dev unzip python python3-distutils wget bash-completion openjdk-8-jdk-headless tzdata \
    #
    # Create a non-root user to use if preferred - see https://aka.ms/vscode-remote/containers/non-root-user.
    && groupadd --gid $USER_GID $USERNAME \
    && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
    # [Optional] Add sudo support for non-root user
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME \
    #
    # Install bazel
    && sudo apt install curl gnupg \
    && curl https://bazel.build/bazel-release.pub.gpg | sudo apt-key add - \
    && echo "deb [arch=amd64] https://storage.googleapis.com/bazel-apt stable jdk1.8" | sudo tee /etc/apt/sources.list.d/bazel.list \
    && sudo apt update \
    && sudo apt install bazel \
    # Clean up
    && apt-get autoremove -y \
    && apt-get clean -y 

RUN git clone https://github.com/google/zetasql.git /work/
COPY CROSSTOOL parser.cc parser.h main.go /work/ 
RUN cd /work/ \
  && rm .bazelversion \
  && bazel build ...

# Abseil
RUN cd /tmp && git clone https://github.com/abseil/abseil-cpp.git abseil && cp -R abseil/absl /work/

# Protobuf
RUN cd /tmp \
  # && git clone https://github.com/protocolbuffers/protobuf protobuf \
  && wget https://github.com/protocolbuffers/protobuf/releases/download/v3.6.1/protobuf-all-3.6.1.tar.gz \
  && sudo tar -xvf protobuf-all-3.6.1.tar.gz \
  && cd /tmp/protobuf-3.6.1 \
  && ls -la \
  && sudo ./configure \
  && sudo make \
  && sudo make check \
  && sudo make install \
  && sudo ldconfig \
  && mkdir /work/google \
  && cp -R src/google /work/ \
  && ls /work/google

# Build the protobuf for zetaSQL
RUN cd /work/zetasql/proto \
  && ls -l \
  && cp /work/zetasql/resolved_ast/resolved_node_kind.proto.template /work/zetasql/resolved_ast/resolved_node_kind.proto \
  && protoc -I=/work/ --cpp_out=/work/zetasql/proto/ /work/zetasql/proto/options.proto
  #&& protoc --cpp_out=/work/zetasql/proto/options.proto 
  #&& protoc -I=internal_error_location.proto --cpp_out=. \
  #&& protoc -I=function.proto --cpp_out=. \
  #&& protoc -I=simple_catalog.proto --cpp_out=.


# Install GO
RUN cd /tmp \
  && wget https://dl.google.com/go/go1.11.linux-amd64.tar.gz \
  && sudo tar -xvf go1.11.linux-amd64.tar.gz \
  && sudo mv go /usr/local \
  && export GOROOT=/usr/local/go  \
  && export GOPATH=$HOME/go \
  && export PATH=$GOPATH/bin:$GOROOT/bin:$PATH \
  && ls ~/ \
  # && . ~/.profile \
  && go version \
  && which go \
  && echo $GOPATH \
  && cd /work \
  && sudo /usr/local/go/bin/go build -o main .

# FROM gcr.io/distroless/cc
# COPY --from=build-env /work/bazel-bin/linux_amd64_stripped/zetasql-server ./
ENTRYPOINT ["./main"]