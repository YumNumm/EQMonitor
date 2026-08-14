import 'package:eqmonitor_api/eqmonitor_api.dart' as api;

/// 地震の規模（マグニチュード）の種別
enum MagnitudeType { normal, unknown, overM8 }

extension MagnitudeTypeApiExt on api.MagnitudeType {
  MagnitudeType toDomain() => switch (this) {
    api.MagnitudeType.normal => MagnitudeType.normal,
    api.MagnitudeType.unknown => MagnitudeType.unknown,
    api.MagnitudeType.overM8 => MagnitudeType.overM8,
  };
}
