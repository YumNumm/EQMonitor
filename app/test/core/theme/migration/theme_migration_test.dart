import 'package:eqmonitor/core/provider/shared_preferences.dart' as app_prefs;
import 'package:eqmonitor/core/theme/migration/theme_migration.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _legacyIntensityColorJson = '''
{
  "unknown": {"foreground": "#FFFFFFFF", "background": "#FF000000"},
  "zero": {"foreground": "#FF000000", "background": "#FFFFFFFF"},
  "one": {"foreground": "#FF000000", "background": "#FF03B5FF"},
  "two": {"foreground": "#FF000000", "background": "#FF76FF03"},
  "three": {"foreground": "#FF000000", "background": "#FF00C853"},
  "four": {"foreground": "#FF000000", "background": "#FFFFEB3B"},
  "fiveLower": {"foreground": "#FF000000", "background": "#FFFFC107"},
  "fiveUpper": {"foreground": "#FF000000", "background": "#FFFF6F00"},
  "sixLower": {"foreground": "#FFFFFFFF", "background": "#FFFF2800"},
  "sixUpper": {"foreground": "#FFFFFFFF", "background": "#FFA50021"},
  "seven": {"foreground": "#FFFFFFFF", "background": "#FFC800FF"}
}
''';

const _legacyEstimatedIntensityColorJson = '''
{
  "unknown": {"foreground": "#FFFFFFFF", "background": "#FF90A4AE"},
  "zero": {"foreground": "#FF000000", "background": "#FFB0BEC5"},
  "one": {"foreground": "#FF000000", "background": "#FF4DD0E1"},
  "two": {"foreground": "#FF000000", "background": "#FF29B6F6"},
  "three": {"foreground": "#FF000000", "background": "#FF66BB6A"},
  "four": {"foreground": "#FF000000", "background": "#FFFFEE58"},
  "fiveLower": {"foreground": "#FF000000", "background": "#FFFFA726"},
  "fiveUpper": {"foreground": "#FF000000", "background": "#FFFF7043"},
  "sixLower": {"foreground": "#FFFFFFFF", "background": "#FFEF5350"},
  "sixUpper": {"foreground": "#FFFFFFFF", "background": "#FFF06292"},
  "seven": {"foreground": "#FFFFFFFF", "background": "#FFCE93D8"}
}
''';

Future<app_prefs.SharedPreferencesAsync> _prefs(
  Map<String, Object> initial,
) async {
  SharedPreferences.setMockInitialValues(initial);
  return app_prefs.SharedPreferencesAsync(
    await SharedPreferences.getInstance(),
  );
}

void main() {
  group('migrateFromLegacyIntensityColors', () {
    test('旧キーが無い場合はnullを返す', () async {
      final prefs = await _prefs({});
      expect(migrateFromLegacyIntensityColors(prefs), isNull);
    });

    test('旧intensity_colorキーがある場合はマイグレーションされる', () async {
      final prefs = await _prefs({
        'intensity_color': _legacyIntensityColorJson,
      });

      final result = migrateFromLegacyIntensityColors(prefs);

      expect(result, isNotNull);
      expect(result!.light!.intensity.seven.background.toARGB32(), 0xFFC800FF);
      expect(result.dark!.intensity.seven.background.toARGB32(), 0xFFC800FF);
      expect(result.light!.intensity.one.background.toARGB32(), 0xFF03B5FF);
      // この関数自体は旧キーを削除しない（呼び出し側の保存完了後に削除する）
      expect(prefs.getString('intensity_color'), isNotNull);
    });

    test('旧estimated_intensity_colorキーがある場合はマイグレーションされる', () async {
      final prefs = await _prefs({
        'estimated_intensity_color': _legacyEstimatedIntensityColorJson,
      });

      final result = migrateFromLegacyIntensityColors(prefs);

      expect(result, isNotNull);
      expect(
        result!.light!.estimatedIntensity.seven.background.toARGB32(),
        0xFFCE93D8,
      );
      expect(
        result.dark!.estimatedIntensity.four.background.toARGB32(),
        0xFFFFEE58,
      );
      // この関数自体は旧キーを削除しない（呼び出し側の保存完了後に削除する）
      expect(prefs.getString('estimated_intensity_color'), isNotNull);
    });

    test('両方の旧キーがある場合は両方マイグレーションされる', () async {
      final prefs = await _prefs({
        'intensity_color': _legacyIntensityColorJson,
        'estimated_intensity_color': _legacyEstimatedIntensityColorJson,
      });

      final result = migrateFromLegacyIntensityColors(prefs);

      expect(result, isNotNull);
      expect(result!.light!.intensity.seven.background.toARGB32(), 0xFFC800FF);
      expect(
        result.light!.estimatedIntensity.seven.background.toARGB32(),
        0xFFCE93D8,
      );
      // この関数自体は旧キーを削除しない（呼び出し側の保存完了後に削除する）
      expect(prefs.getString('intensity_color'), isNotNull);
      expect(prefs.getString('estimated_intensity_color'), isNotNull);
    });

    test('不正なJSONの場合はデフォルトのintensityにフォールバックする', () async {
      final prefs = await _prefs({
        'intensity_color': 'not a json',
        'estimated_intensity_color': _legacyEstimatedIntensityColorJson,
      });

      final result = migrateFromLegacyIntensityColors(prefs);

      expect(result, isNotNull);
      // intensity は default のまま (壊れたJSONは無視される)
      final defaultIntensity = result!.light!.intensity.seven.background
          .toARGB32();
      expect(defaultIntensity, 0xFFC800FF); // eqmonitorDefault の seven と同じ
      // estimatedIntensity は正しくマイグレーションされる
      expect(
        result.light!.estimatedIntensity.seven.background.toARGB32(),
        0xFFCE93D8,
      );
      // この関数自体は旧キーを削除しない（呼び出し側の保存完了後に削除する）
      expect(prefs.getString('intensity_color'), isNotNull);
    });
  });
}
