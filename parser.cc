#include <memory>
#include <iostream>
#include <string.h>

#include "zetasql/public/analyzer.h"
#include "parser.h"

char *parseQuery(char* sql) {

  const std::string parser_output(sql);

  std::unique_ptr<ParserOutput> parser_output;
  ParserOptions parser_options = options_.GetParserOptions();
  const auto result = ZETASQL_ASSERT_OK(zetasql::ParseStatement(sql, parser_options, &parser_output));
  return strdup(parser_output.c_str());
}

