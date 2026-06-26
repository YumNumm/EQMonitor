import 'package:eqmonitor_api/eqmonitor_api.dart' as api;

enum QualitativeHeight {
  enormous,
  high,
}

extension QualitativeHeightApiExt on api.QualitativeHeight {
  QualitativeHeight toDomain() => switch (this) {
    api.QualitativeHeight.enormous => QualitativeHeight.enormous,
    api.QualitativeHeight.high => QualitativeHeight.high,
  };
}
