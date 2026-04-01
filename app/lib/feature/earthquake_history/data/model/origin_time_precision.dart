import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum(fieldRename: FieldRename.screamingSnake)
enum OriginTimePrecision {
  millisecond,
  second,
  minute,
  hour,
  day,
  month,
}

extension OriginTimePrecisionApiExtension on api.OriginTimePrecision {
  OriginTimePrecision get toOriginTimePrecision => switch (this) {
    .millisecond => .millisecond,
    .second => .second,
    .minute => .minute,
    .hour => .hour,
    .day => .day,
    .month => .month,
  };
}

extension OriginTimePrecisionToApiExtension on OriginTimePrecision {
  api.OriginTimePrecision get toApiOriginTimePrecision => switch (this) {
    .millisecond => .millisecond,
    .second => .second,
    .minute => .minute,
    .hour => .hour,
    .day => .day,
    .month => .month,
  };
}
