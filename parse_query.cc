#include <memory>
#include <iostream>
#include <string.h>
#include "zetasql/public/sql_formatter.h"
#include "zetasql/public/parse_helpers.h"
#include "zetasql/public/analyzer.h"
#include "absl/status/status.h"
#include "absl/memory/memory.h"
#include "absl/strings/cord.h"
#include "absl/strings/str_cat.h"
#include "absl/strings/strip.h"
#include "zetasql/common/status_payload_utils.h"
#include "parse_query.h"

char *parseStatement(char* sql) {
  absl::Status status = zetasql::IsValidStatementSyntax(sql, zetasql::ERROR_MESSAGE_WITH_PAYLOAD);
  std::string return_status = zetasql::internal::StatusToString(status);
  return strdup(return_status.c_str());
}