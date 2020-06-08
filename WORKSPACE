load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "io_bazel_rules_go",
    sha256 = "a8d6b1b354d371a646d2f7927319974e0f9e52f73a2452d2b3877118169eb6bb",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/rules_go/releases/download/v0.23.3/rules_go-v0.23.3.tar.gz",
        "https://github.com/bazelbuild/rules_go/releases/download/v0.23.3/rules_go-v0.23.3.tar.gz",
    ],
)

load("@io_bazel_rules_go//go:deps.bzl", "go_rules_dependencies", "go_register_toolchains")

go_rules_dependencies()

go_register_toolchains()

load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

http_archive(
   name = "com_google_zetasql",
   strip_prefix = "zetasql-2020.04.1",
   urls = [
      "https://github.com/google/zetasql/archive/2020.04.1.tar.gz",
   ],
   sha256 = "b1eab290101a3e4899a30f459579c590b0168bdd82fceede8bde1214eb01843d"
)

load("@com_google_zetasql//bazel:zetasql_deps_step_1.bzl", "zetasql_deps_step_1")

# Download and Build dependencies.
zetasql_deps_step_1()

load("@com_google_zetasql//bazel:zetasql_deps_step_2.bzl", "zetasql_deps_step_2")

# Download and Build dependencies.
zetasql_deps_step_2()

load("@com_google_zetasql//bazel:zetasql_deps_step_3.bzl", "zetasql_deps_step_3")

# Download and Build dependencies.
zetasql_deps_step_3()

load("@com_google_zetasql//bazel:zetasql_deps_step_4.bzl", "zetasql_deps_step_4")

# Download and Build dependencies.
zetasql_deps_step_4()