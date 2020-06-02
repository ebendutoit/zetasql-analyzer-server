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

RUN git clone https://github.com/google/zetasql.git /work/zetasql
COPY CROSSTOOL parser.cc parser.h main.go /work/ 
RUN cd /work/zetasql \
  && rm .bazelversion \
  && bazel build ...

# Install GO
RUN cd /tmp \
  && wget https://dl.google.com/go/go1.11.linux-amd64.tar.gz \
  && sudo tar -xvf go1.11.linux-amd64.tar.gz \
  && sudo mv go /usr/local \
  && export GOROOT=/usr/local/go \
  && export GOPATH=$HOME/go \
  && export PATH=$GOPATH/bin:$GOROOT/bin:$PATH \
  && go version

RUN cd /work \
  && /usr/local/go build -o main .

# FROM gcr.io/distroless/cc
# COPY --from=build-env /work/bazel-bin/linux_amd64_stripped/zetasql-server ./
ENTRYPOINT ["./main"]