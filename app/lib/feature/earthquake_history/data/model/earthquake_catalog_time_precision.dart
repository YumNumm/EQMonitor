import 'package:eqmonitor/core/util/date_time_format.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;

enum EarthquakeCatalogTimePrecision {
  minute,
  second,
  decisecond;

  String format({required DateTime value}) => switch (this) {
    minute => value.formatWithTz(.yearMonthDayHourMinute),
    second => value.formatWithTz(.yearMonthDayHourMinuteSecond),
    decisecond => value.formatWithTzDecisecond(),
  };
}

extension CatalogTimePrecisionConverter on api.CatalogTimePrecision {
  EarthquakeCatalogTimePrecision get toDomain => switch (this) {
    .minute => .minute,
    .second => .second,
    .decisecond => .decisecond,
  };
}
