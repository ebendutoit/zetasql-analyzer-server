FROM ubuntu:18.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
  && apt-get install -y curl gnupg \
  && echo "deb [arch=amd64] http://storage.googleapis.com/bazel-apt stable jdk1.8" | tee /etc/apt/sources.list.d/bazel.list \
  && curl https://bazel.build/bazel-release.pub.gpg | apt-key add - \
  && apt-get update \
  && apt-get install -y \
    bazel \
    g++ \
    git \
    make \
    openjdk-8-jdk-headless \
    python \
    python3-distutils \
    tzdata \
  && apt-get autoremove -y \
  && apt-get clean -y \
  && rm -rf /var/lib/apt/lists/*
RUN git clone https://github.com/google/zetasql.git /zetasql \
  && cd /zetasql \
  # bazel was locked at 1.00
  && rm -f .bazelversion \
  && bazel build ...