import 'package:eqmonitor_api/export.dart' as api;

/// アプリ側の JMA 震度（観測・予想共通）
enum JmaIntensity {
  unknown,
  zero,
  one,
  two,
  three,
  four,
  fiveUnknown,
  fiveLower,
  fiveUpper,
  sixLower,
  sixUpper,
  seven;

  String get label => switch (this) {
        JmaIntensity.unknown => '不明',
        JmaIntensity.zero => '0',
        JmaIntensity.one => '1',
        JmaIntensity.two => '2',
        JmaIntensity.three => '3',
        JmaIntensity.four => '4',
        JmaIntensity.fiveUnknown => '5',
        JmaIntensity.fiveLower => '5-',
        JmaIntensity.fiveUpper => '5+',
        JmaIntensity.sixLower => '6-',
        JmaIntensity.sixUpper => '6+',
        JmaIntensity.seven => '7',
      };

  String get mainText => switch (this) {
        JmaIntensity.fiveUnknown => '5',
        JmaIntensity.fiveLower => '5',
        JmaIntensity.fiveUpper => '5',
        JmaIntensity.sixLower => '6',
        JmaIntensity.sixUpper => '6',
        _ => label.replaceAll('-', '').replaceAll('+', ''),
      };

  String get suffix => switch (this) {
        JmaIntensity.fiveUnknown => '弱以上',
        JmaIntensity.fiveLower => '弱',
        JmaIntensity.fiveUpper => '強',
        JmaIntensity.sixLower => '弱',
        JmaIntensity.sixUpper => '強',
        _ => '',
      };

  /// ソート・比較用の順序（0=最小, 10=最大）
  int get orderIndex => switch (this) {
        JmaIntensity.unknown => -1,
        JmaIntensity.zero => 0,
        JmaIntensity.one => 1,
        JmaIntensity.two => 2,
        JmaIntensity.three => 3,
        JmaIntensity.four => 4,
        JmaIntensity.fiveUnknown => 5,
        JmaIntensity.fiveLower => 6,
        JmaIntensity.fiveUpper => 7,
        JmaIntensity.sixLower => 8,
        JmaIntensity.sixUpper => 9,
        JmaIntensity.seven => 10,
      };

  /// FCM トピック等で使う文字列（lower/upper）
  String get topicSuffix => label
      .replaceAll('-', 'lower')
      .replaceAll('+', 'upper')
      .replaceAll('不明', 'unknown');
}

extension ApiJmaIntensityConverter on api.JmaIntensity {
  JmaIntensity toJmaIntensity() => switch (this) {
        api.JmaIntensity.value0 => JmaIntensity.zero,
        api.JmaIntensity.value1 => JmaIntensity.one,
        api.JmaIntensity.value2 => JmaIntensity.two,
        api.JmaIntensity.value3 => JmaIntensity.three,
        api.JmaIntensity.value4 => JmaIntensity.four,
        api.JmaIntensity.value5unknown => JmaIntensity.fiveUnknown,
        api.JmaIntensity.value5minus => JmaIntensity.fiveLower,
        api.JmaIntensity.value5plus => JmaIntensity.fiveUpper,
        api.JmaIntensity.value6minus => JmaIntensity.sixLower,
        api.JmaIntensity.value6plus => JmaIntensity.sixUpper,
        api.JmaIntensity.value7 => JmaIntensity.seven,
      };
}

extension JmaIntensityToApi on JmaIntensity {
  api.JmaIntensity? toApiJmaIntensity() => switch (this) {
        JmaIntensity.unknown => null,
        JmaIntensity.zero => api.JmaIntensity.value0,
        JmaIntensity.one => api.JmaIntensity.value1,
        JmaIntensity.two => api.JmaIntensity.value2,
        JmaIntensity.three => api.JmaIntensity.value3,
        JmaIntensity.four => api.JmaIntensity.value4,
        JmaIntensity.fiveUnknown => api.JmaIntensity.value5unknown,
        JmaIntensity.fiveLower => api.JmaIntensity.value5minus,
        JmaIntensity.fiveUpper => api.JmaIntensity.value5plus,
        JmaIntensity.sixLower => api.JmaIntensity.value6minus,
        JmaIntensity.sixUpper => api.JmaIntensity.value6plus,
        JmaIntensity.seven => api.JmaIntensity.value7,
      };
}
