load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
   name = "rules_foreign_cc",
   strip_prefix = "rules_foreign_cc-e3f4b5e0bc9dac9cf036616c13de25e6cd5051a2",
   urls = [
      "https://github.com/bazelbuild/rules_foreign_cc/archive/e3f4b5e0bc9dac9cf036616c13de25e6cd5051a2.tar.gz",
   ],
   sha256 = "136470a38dcd00c7890230402b43004dc947bf1e3dd0289dd1bd2bfb1e0a3484"
)

load("@rules_foreign_cc//:workspace_definitions.bzl", "rules_foreign_cc_dependencies")

rules_foreign_cc_dependencies()

http_archive(
    name = "io_bazel_rules_go",
    sha256 = "0c10738a488239750dbf35336be13252bad7c74348f867d30c3c3e0001906096",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/rules_go/releases/download/v0.23.2/rules_go-v0.23.2.tar.gz",
        "https://github.com/bazelbuild/rules_go/releases/download/v0.23.2/rules_go-v0.23.2.tar.gz",
    ],
)

load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains", "go_rules_dependencies")

go_rules_dependencies()

go_register_toolchains()







