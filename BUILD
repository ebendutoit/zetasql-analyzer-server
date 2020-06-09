load("@io_bazel_rules_go//go:def.bzl", "go_binary")

go_binary(name = "zetasql-analyzer-server",
	  srcs = ["main.go", "parse_query.cc", "parse_query.h"],
	  pure = "off",
	  cgo = True,
	  cxxopts = ['-std=c++1z'],
	  cdeps=["@com_google_zetasql//zetasql/public:sql_formatter", "@com_google_zetasql//zetasql/public:parse_helpers", "@com_google_zetasql//zetasql/public:analyzer"])