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
        JmaLpgmIntensity.unknown => '不明',
        JmaLpgmIntensity.zero => '0',
        JmaLpgmIntensity.one => '1',
        JmaLpgmIntensity.two => '2',
        JmaLpgmIntensity.three => '3',
        JmaLpgmIntensity.four => '4',
      };

  /// ソート・比較用の順序
  int get orderIndex => switch (this) {
        JmaLpgmIntensity.unknown => -1,
        JmaLpgmIntensity.zero => 0,
        JmaLpgmIntensity.one => 1,
        JmaLpgmIntensity.two => 2,
        JmaLpgmIntensity.three => 3,
        JmaLpgmIntensity.four => 4,
      };
}

extension ApiLpgmIntensityConverter on api.LpgmIntensity {
  JmaLpgmIntensity toJmaLpgmIntensity() => switch (this) {
        api.LpgmIntensity.value0 => JmaLpgmIntensity.zero,
        api.LpgmIntensity.value1 => JmaLpgmIntensity.one,
        api.LpgmIntensity.value2 => JmaLpgmIntensity.two,
        api.LpgmIntensity.value3 => JmaLpgmIntensity.three,
        api.LpgmIntensity.value4 => JmaLpgmIntensity.four,
      };
}

extension JmaLpgmIntensityToApi on JmaLpgmIntensity {
  api.LpgmIntensity? toApiLpgmIntensity() => switch (this) {
        JmaLpgmIntensity.unknown => null,
        JmaLpgmIntensity.zero => api.LpgmIntensity.value0,
        JmaLpgmIntensity.one => api.LpgmIntensity.value1,
        JmaLpgmIntensity.two => api.LpgmIntensity.value2,
        JmaLpgmIntensity.three => api.LpgmIntensity.value3,
        JmaLpgmIntensity.four => api.LpgmIntensity.value4,
      };
}
