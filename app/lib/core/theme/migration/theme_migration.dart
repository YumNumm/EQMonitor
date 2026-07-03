import 'dart:async';
import 'dart:convert';

import 'package:eqmonitor/core/provider/shared_preferences.dart';
import 'package:eqmonitor/core/theme/model/app_theme.dart';
import 'package:eqmonitor/core/theme/model/estimated_intensity_colors.dart';
import 'package:eqmonitor/core/theme/model/intensity_color_entry.dart';
import 'package:eqmonitor/core/theme/model/intensity_colors.dart';
import 'package:eqmonitor/core/theme/model/intensity_text_color.dart';
import 'package:eqmonitor/core/util/converter/color_converter.dart';

const _legacyIntensityColorKey = 'intensity_color';
const _legacyEstimatedIntensityColorKey = 'estimated_intensity_color';

/// 旧震度カラー設定 (`intensity_color` / `estimated_intensity_color`) を
/// 新しい [AppTheme] 形式にマイグレーションする。
///
/// 旧キーが1つも存在しない場合は `null` を返す（マイグレーション不要）。
/// 旧キーが存在する場合は、[AppTheme.eqmonitorDefault] をベースに
/// 震度色のみを旧設定で上書きしたテーマを返し、旧キーを削除する。
///
/// 個々のJSONが不正な形式の場合は、その項目のみデフォルト値にフォールバックする。
AppTheme? migrateFromLegacyIntensityColors(SharedPreferencesAsync prefs) {
  final intensityJson = prefs.getString(_legacyIntensityColorKey);
  final estimatedJson = prefs.getString(_legacyEstimatedIntensityColorKey);

  if (intensityJson == null && estimatedJson == null) {
    return null;
  }

  final defaultTheme = AppTheme.eqmonitorDefault();

  IntensityColors? migratedIntensity;
  if (intensityJson != null) {
    try {
      final decoded = jsonDecode(intensityJson) as Map<String, dynamic>;
      migratedIntensity = _convertLegacyIntensity(decoded);
    } on Exception catch (_) {
      // マイグレーション失敗→デフォルト使用
    }
  }

  EstimatedIntensityColors? migratedEstimatedIntensity;
  if (estimatedJson != null) {
    try {
      final decoded = jsonDecode(estimatedJson) as Map<String, dynamic>;
      migratedEstimatedIntensity = _convertLegacyEstimatedIntensity(decoded);
    } on Exception catch (_) {
      // マイグレーション失敗→デフォルト使用
    }
  }

  var lightSet = defaultTheme.light!;
  var darkSet = defaultTheme.dark!;

  if (migratedIntensity != null) {
    lightSet = lightSet.copyWith(intensity: migratedIntensity);
    darkSet = darkSet.copyWith(intensity: migratedIntensity);
  }
  if (migratedEstimatedIntensity != null) {
    lightSet = lightSet.copyWith(
      estimatedIntensity: migratedEstimatedIntensity,
    );
    darkSet = darkSet.copyWith(estimatedIntensity: migratedEstimatedIntensity);
  }

  // 旧キーを削除（マイグレーションの成否に関わらず、二重変換を防ぐため削除する）
  unawaited(prefs.remove(_legacyIntensityColorKey));
  unawaited(prefs.remove(_legacyEstimatedIntensityColorKey));

  return defaultTheme.copyWith(light: lightSet, dark: darkSet);
}

// 旧 IntensityColorModel のJSON形式:
// { "zero": {"foreground": "#AARRGGBB", "background": "#AARRGGBB"}, ... }
IntensityColors _convertLegacyIntensity(Map<String, dynamic> json) {
  IntensityColorEntry field(String key) =>
      _convertLegacyEntry(json[key]! as Map<String, dynamic>);
  return IntensityColors(
    unknown: field('unknown'),
    zero: field('zero'),
    one: field('one'),
    two: field('two'),
    three: field('three'),
    four: field('four'),
    fiveLower: field('fiveLower'),
    fiveUpper: field('fiveUpper'),
    sixLower: field('sixLower'),
    sixUpper: field('sixUpper'),
    seven: field('seven'),
  );
}

// 旧 estimated_intensity_color も IntensityColorModel と同じ形式
// (unknown〜seven の全キーを持つ) だが、新モデルでは four〜seven のみ使用する。
EstimatedIntensityColors _convertLegacyEstimatedIntensity(
  Map<String, dynamic> json,
) {
  IntensityColorEntry field(String key) =>
      _convertLegacyEntry(json[key]! as Map<String, dynamic>);
  return EstimatedIntensityColors(
    four: field('four'),
    fiveLower: field('fiveLower'),
    fiveUpper: field('fiveUpper'),
    sixLower: field('sixLower'),
    sixUpper: field('sixUpper'),
    seven: field('seven'),
  );
}

// 旧形式: {"foreground": "#AARRGGBB", "background": "#AARRGGBB"}
IntensityColorEntry _convertLegacyEntry(Map<String, dynamic> entry) {
  const converter = ColorJsonConverter();
  return IntensityColorEntry(
    background: converter.fromJson(entry['background']! as String),
    foreground: IntensityTextColor.manual(
      color: converter.fromJson(entry['foreground']! as String),
    ),
  );
}
