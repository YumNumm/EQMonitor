import 'package:eqmonitor_api/eqmonitor_api.dart' as api;

enum FirstHeightCondition {
  arriving,
  firstWaveConfirmed,
  imminent,
}

extension FirstHeightConditionApiExt on api.FirstHeightCondition {
  FirstHeightCondition toDomain() => switch (this) {
    api.FirstHeightCondition.arriving => FirstHeightCondition.arriving,
    api.FirstHeightCondition.firstWaveConfirmed =>
      FirstHeightCondition.firstWaveConfirmed,
    api.FirstHeightCondition.imminent => FirstHeightCondition.imminent,
  };
}
