import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_level.dart';

/// Unified Live Activity の JSON 境界で型と値を検証する reader。
class UnifiedLiveActivityJsonReader {
  const new(this.json, {required this.label});

  final Map<String, dynamic> json;
  final String label;

  bool contains(String key) => json.containsKey(key);

  void requireOnlyKeys(Set<String> allowed) {
    final extra = json.keys.where((key) => !allowed.contains(key));
    if (extra.isNotEmpty) {
      throw FormatException('$label に未定義のキーがあります: ${extra.first}');
    }
  }

  String requiredString(String key, {bool nonEmpty = false}) {
    final value = json[key];
    if (!json.containsKey(key) || value is! String) {
      throw FormatException('$label.$key は文字列である必要があります');
    }
    if (nonEmpty && value.isEmpty) {
      throw FormatException('$label.$key は空にできません');
    }
    return value;
  }

  String? requiredNullableString(String key) {
    if (!json.containsKey(key)) {
      throw FormatException('$label.$key がありません');
    }
    final value = json[key];
    if (value != null && value is! String) {
      throw FormatException('$label.$key は文字列または null である必要があります');
    }
    return value as String?;
  }

  bool requiredBool(String key) {
    final value = json[key];
    if (!json.containsKey(key) || value is! bool) {
      throw FormatException('$label.$key は bool である必要があります');
    }
    return value;
  }

  int requiredInt(String key, {int? minimum}) {
    final value = json[key];
    if (!json.containsKey(key) || value is! num || !value.isFinite) {
      throw FormatException('$label.$key は有限の整数である必要があります');
    }
    final integer = value.toInt();
    if (integer.toDouble() != value.toDouble()) {
      throw FormatException('$label.$key は整数である必要があります');
    }
    if (minimum != null && integer < minimum) {
      throw FormatException('$label.$key は $minimum 以上である必要があります');
    }
    return integer;
  }

  double? requiredNullableFiniteDouble(String key) {
    if (!json.containsKey(key)) {
      throw FormatException('$label.$key がありません');
    }
    final value = json[key];
    if (value == null) {
      return null;
    }
    if (value is! num || !value.isFinite) {
      throw FormatException('$label.$key は有限数または null である必要があります');
    }
    return value.toDouble();
  }

  double requiredFiniteDouble(String key) {
    final value = json[key];
    if (!json.containsKey(key) || value is! num || !value.isFinite) {
      throw FormatException('$label.$key は有限数である必要があります');
    }
    return value.toDouble();
  }

  Map<String, dynamic>? requiredNullableMap(String key) {
    if (!json.containsKey(key)) {
      throw FormatException('$label.$key がありません');
    }
    final value = json[key];
    if (value == null) {
      return null;
    }
    if (value is! Map<String, dynamic>) {
      throw FormatException('$label.$key はオブジェクトまたは null である必要があります');
    }
    return value;
  }

  List<String> requiredStringList(String key) {
    final value = json[key];
    if (!json.containsKey(key) || value is! List) {
      throw FormatException('$label.$key は文字列配列である必要があります');
    }
    if (value.any((element) => element is! String)) {
      throw FormatException('$label.$key は文字列配列である必要があります');
    }
    return value.cast<String>();
  }

  DateTime requiredDateTime(String key) =>
      UnifiedLiveActivityWire.dateTimeFromJson(requiredString(key));

  DateTime? requiredNullableDateTime(String key) {
    final value = requiredNullableString(key);
    return value == null
        ? null
        : UnifiedLiveActivityWire.dateTimeFromJson(value);
  }

  String? optionalNonNullString(String key) {
    if (!json.containsKey(key)) {
      return null;
    }
    return requiredString(key);
  }

  bool? optionalNonNullBool(String key) {
    if (!json.containsKey(key)) {
      return null;
    }
    return requiredBool(key);
  }

  DateTime? optionalNonNullDateTime(String key) {
    final value = optionalNonNullString(key);
    return value == null
        ? null
        : UnifiedLiveActivityWire.dateTimeFromJson(value);
  }
}

/// 既存 domain enum と統合 Wire 値の変換。
abstract final class UnifiedLiveActivityWire {
  static const intensityValues = <String>[
    '0',
    '1',
    '2',
    '3',
    '4',
    '!5-',
    '5-',
    '5+',
    '!6-',
    '6-',
    '6+',
    '7',
  ];
  static const lpgmValues = <String>['0', '1', '2', '3', '4'];
  static const shakeLevelValues = <String>[
    'Weaker',
    'Weak',
    'Medium',
    'Strong',
    'Stronger',
  ];

  static final timestampPattern = RegExp(
    r'^(\d{4})-(\d{2})-(\d{2})T(\d{2}):(\d{2}):(\d{2})(?:\.(\d+))?(Z|[+-]\d{2}:\d{2})$',
  );

  static DateTime dateTimeFromJson(String value) {
    final match = timestampPattern.firstMatch(value);
    if (match == null) {
      throw FormatException('日時の形式が不正です: $value');
    }
    final year = int.parse(match.group(1) ?? '');
    final month = int.parse(match.group(2) ?? '');
    final day = int.parse(match.group(3) ?? '');
    final hour = int.parse(match.group(4) ?? '');
    final minute = int.parse(match.group(5) ?? '');
    final second = int.parse(match.group(6) ?? '');
    final zone = match.group(8) ?? '';
    final zoneHour = zone == 'Z' ? 0 : int.parse(zone.substring(1, 3));
    final zoneMinute = zone == 'Z' ? 0 : int.parse(zone.substring(4, 6));
    final monthStart = DateTime.utc(year, month);
    final nextMonth = DateTime.utc(year, month + 1);
    final daysInMonth = nextMonth.difference(monthStart).inDays;
    if (month < 1 ||
        month > 12 ||
        day < 1 ||
        day > daysInMonth ||
        hour > 23 ||
        minute > 59 ||
        second > 59 ||
        zoneHour > 23 ||
        zoneMinute > 59) {
      throw FormatException('存在しない日時です: $value');
    }
    try {
      return DateTime.parse(value);
    } on FormatException {
      throw FormatException('日時の形式が不正です: $value');
    }
  }

  static String dateTimeToJson(DateTime value) =>
      value.toUtc().toIso8601String();

  static JmaIntensity intensityFromJson(String value) => switch (value) {
    '0' => .zero,
    '1' => .one,
    '2' => .two,
    '3' => .three,
    '4' => .four,
    '!5-' => .fiveUnknown,
    '5-' => .fiveLower,
    '5+' => .fiveUpper,
    '!6-' => .sixUnknown,
    '6-' => .sixLower,
    '6+' => .sixUpper,
    '7' => .seven,
    _ => throw FormatException('震度が不正です: $value'),
  };

  static String intensityToJson(JmaIntensity value) => switch (value) {
    .zero => '0',
    .one => '1',
    .two => '2',
    .three => '3',
    .four => '4',
    .fiveUnknown => '!5-',
    .fiveLower => '5-',
    .fiveUpper => '5+',
    .sixUnknown => '!6-',
    .sixLower => '6-',
    .sixUpper => '6+',
    .seven => '7',
    .unknown => throw const FormatException('不明震度は Wire 値にできません'),
  };

  static JmaLpgmIntensity lpgmFromJson(String value) => switch (value) {
    '0' => .zero,
    '1' => .one,
    '2' => .two,
    '3' => .three,
    '4' => .four,
    _ => throw FormatException('長周期地震動階級が不正です: $value'),
  };

  static String lpgmToJson(JmaLpgmIntensity value) => switch (value) {
    .zero => '0',
    .one => '1',
    .two => '2',
    .three => '3',
    .four => '4',
    .unknown => throw const FormatException('不明階級は Wire 値にできません'),
  };

  static ShakeDetectionLevel shakeLevelFromJson(String value) =>
      switch (value) {
        'Weaker' => .weaker,
        'Weak' => .weak,
        'Medium' => .medium,
        'Strong' => .strong,
        'Stronger' => .stronger,
        _ => throw FormatException('揺れ検知レベルが不正です: $value'),
      };

  static String shakeLevelToJson(ShakeDetectionLevel value) => switch (value) {
    .weaker => 'Weaker',
    .weak => 'Weak',
    .medium => 'Medium',
    .strong => 'Strong',
    .stronger => 'Stronger',
  };
}
