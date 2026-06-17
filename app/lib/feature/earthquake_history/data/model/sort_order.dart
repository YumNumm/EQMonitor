import 'package:eqmonitor_api/eqmonitor_api.dart' as api;

/// ソート順
enum SortOrder {
  asc,
  desc;

  String get label => switch (this) {
    .asc => '昇順',
    .desc => '降順',
  };

  String get arrow => switch (this) {
    .asc => '↑',
    .desc => '↓',
  };
}

extension SortOrderApiExtension on api.SortOrder {
  SortOrder get toSortOrder => switch (this) {
    .asc => .asc,
    .desc => .desc,
  };
}

extension SortOrderToApiExtension on SortOrder {
  api.SortOrder get toApiSortOrder => switch (this) {
    .asc => .asc,
    .desc => .desc,
  };
}
