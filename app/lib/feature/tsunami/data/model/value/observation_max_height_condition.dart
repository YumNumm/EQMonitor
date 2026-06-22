import 'package:eqmonitor_api/eqmonitor_api.dart' as api;

enum ObservationMaxHeightCondition {
  minor,
  observing,
  important,
}

extension ObservationMaxHeightConditionApiExt
    on api.ObservationMaxHeightCondition {
  ObservationMaxHeightCondition toDomain() => switch (this) {
    api.ObservationMaxHeightCondition.minor =>
      ObservationMaxHeightCondition.minor,
    api.ObservationMaxHeightCondition.observing =>
      ObservationMaxHeightCondition.observing,
    api.ObservationMaxHeightCondition.important =>
      ObservationMaxHeightCondition.important,
  };
}
