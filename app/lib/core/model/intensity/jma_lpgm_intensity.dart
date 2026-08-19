import 'package:eqmonitor_api/eqmonitor_api.dart' as api;

/// 長周期地震動階級
enum JmaLpgmIntensity {
  unknown,
  zero,
  one,
  two,
  three,
  four;

  String get label => switch (this) {
    .unknown => '不明',
    .zero => '0',
    .one => '1',
    .two => '2',
    .three => '3',
    .four => '4',
  };

  int get orderIndex => switch (this) {
    .unknown => -1,
    .zero => 0,
    .one => 1,
    .two => 2,
    .three => 3,
    .four => 4,
  };
}

extension ApiLpgmIntensityConverter on api.JmaLpgmIntensity {
  JmaLpgmIntensity get toJmaLpgmIntensity => switch (this) {
    .value0 => .zero,
    .value1 => .one,
    .value2 => .two,
    .value3 => .three,
    .value4 => .four,
  };
}

extension JmaLpgmIntensityToApi on JmaLpgmIntensity {
  api.JmaLpgmIntensity? get toApiJmaLpgmIntensity => switch (this) {
    .unknown => null,
    .zero => .value0,
    .one => .value1,
    .two => .value2,
    .three => .value3,
    .four => .value4,
  };
}
