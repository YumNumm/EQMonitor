import 'dart:convert';

import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:eqmonitor/core/theme/model/app_theme.dart';
import 'package:eqmonitor/core/theme/model/estimated_intensity_colors.dart';
import 'package:eqmonitor/core/theme/model/intensity_color_entry.dart';
import 'package:eqmonitor/core/theme/model/intensity_colors.dart';
import 'package:eqmonitor/core/theme/model/intensity_text_color.dart';
import 'package:eqmonitor/core/util/converter/color_converter.dart';

/// 旧震度カラー設定 (`intensity_color` / `estimated_intensity_color`) を
/// 新しい [AppTheme] 形式にマイグレーションする。
class ThemeMigration {
  const new _();

  /// 旧キーが1つも存在しない場合は `null` を返す（マイグレーション不要）。
  /// 旧キーが存在する場合は、[AppTheme.eqmonitorDefault] をベースに
  /// 震度色のみを旧設定で上書きしたテーマを返す。
  ///
  /// この関数自体は旧キーを削除しない。呼び出し側が新形式の保存に
  /// 成功したことを確認したうえで、旧キーの削除を行うこと
  /// （プロセスが途中で終了しても、旧キーが残っていればマイグレーションを
  /// 再試行できるようにするため）。
  ///
  /// 個々のJSONが不正な形式の場合は、その項目のみデフォルト値にフォールバックする。
  static Future<AppTheme?> migrateFromLegacyIntensityColors(
    SharedPreferencesDataSource dataSource,
  ) async {
    final intensityJson = await dataSource.getString(
      key: SharedPreferencesKey.intensityColor,
    );
    final estimatedJson = await dataSource.getString(
      key: SharedPreferencesKey.estimatedIntensityColor,
    );

    if (intensityJson == null && estimatedJson == null) {
      return null;
    }

    final defaultTheme = AppTheme.eqmonitorDefault();

    IntensityColors? migratedIntensity;
    if (intensityJson != null) {
      try {
        final decoded = jsonDecode(intensityJson) as Map<String, dynamic>;
        migratedIntensity = _convertLegacyIntensity(decoded);
      } on Object catch (_) {
        // マイグレーション失敗→デフォルト使用
      }
    }

    EstimatedIntensityColors? migratedEstimatedIntensity;
    if (estimatedJson != null) {
      try {
        final decoded = jsonDecode(estimatedJson) as Map<String, dynamic>;
        migratedEstimatedIntensity = _convertLegacyEstimatedIntensity(decoded);
      } on Object catch (_) {
        // マイグレーション失敗→デフォルト使用
      }
    }

    // eqmonitorDefault() は light/dark を必ず設定するファクトリであるため、
    // ここで null になることはない（テーマ移行元がユーザーカスタム値を
    // 保持していないデフォルトテーマであるという前提）。
    final defaultLight = defaultTheme.light;
    final defaultDark = defaultTheme.dark;
    if (defaultLight == null || defaultDark == null) {
      throw StateError(
        'AppTheme.eqmonitorDefault() は light/dark を必ず設定する前提が崩れています',
      );
    }
    var lightSet = defaultLight;
    var darkSet = defaultDark;

    if (migratedIntensity != null) {
      lightSet = lightSet.copyWith(intensity: migratedIntensity);
      darkSet = darkSet.copyWith(intensity: migratedIntensity);
    }
    if (migratedEstimatedIntensity != null) {
      lightSet = lightSet.copyWith(
        estimatedIntensity: migratedEstimatedIntensity,
      );
      darkSet = darkSet.copyWith(
        estimatedIntensity: migratedEstimatedIntensity,
      );
    }

    return defaultTheme.copyWith(light: lightSet, dark: darkSet);
  }

  // 旧 IntensityColorModel のJSON形式:
  // { "zero": {"foreground": "#AARRGGBB", "background": "#AARRGGBB"}, ... }
  static IntensityColors _convertLegacyIntensity(Map<String, dynamic> json) {
    IntensityColorEntry field(String key) =>
        _convertLegacyEntry(json[key] as Map<String, dynamic>);
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
  static EstimatedIntensityColors _convertLegacyEstimatedIntensity(
    Map<String, dynamic> json,
  ) {
    IntensityColorEntry field(String key) =>
        _convertLegacyEntry(json[key] as Map<String, dynamic>);
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
  static IntensityColorEntry _convertLegacyEntry(Map<String, dynamic> entry) {
    const converter = ColorJsonConverter();
    return IntensityColorEntry(
      background: converter.fromJson(entry['background'] as String),
      foreground: IntensityTextColor.manual(
        color: converter.fromJson(entry['foreground'] as String),
      ),
    );
  }
}
