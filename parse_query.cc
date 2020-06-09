#include <memory>
#include <iostream>
#include <string.h>


#include "zetasql/public/sql_formatter.h"
#include "zetasql/public/parse_helpers.h"
#include "zetasql/public/analyzer.h"
#include "parse_query.h"

char *formatSqlC(char* sql) {
  std::string formatted_sql;
  const auto result = zetasql::FormatSql(std::string(sql), &formatted_sql);
  return strdup(formatted_sql.c_str());
}

char *parseStatement(char* sql) {
  absl::Status status = IsValidStatementSyntax(sql, ERROR_MESSAGE_WITH_PAYLOAD);
  return strdup(status.c_str());
}

