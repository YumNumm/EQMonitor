import 'package:eqmonitor_api/eqmonitor_api.dart' as api;

/// 震源の深さの種別
enum DepthType { shallow, normal, over700, unknown }

extension DepthTypeApiExt on api.DepthType {
  DepthType toDomain() => switch (this) {
    api.DepthType.shallow => DepthType.shallow,
    api.DepthType.normal => DepthType.normal,
    api.DepthType.over700 => DepthType.over700,
    api.DepthType.unknown => DepthType.unknown,
  };
}
