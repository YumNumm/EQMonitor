import 'package:eqmonitor_api/export.dart' as api;

/// アプリ側の長周期地震動階級（観測・予想共通）
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

  /// ソート・比較用の順序
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
