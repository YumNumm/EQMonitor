import 'dart:convert';

import 'package:eqmonitor/core/theme/model/app_theme.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppTheme', () {
    test('eqmonitorDefault のJSON往復', () {
      final original = AppTheme.eqmonitorDefault();
      final json = original.toJson();
      final jsonStr = jsonEncode(json);
      final restored = AppTheme.fromJson(
        jsonDecode(jsonStr) as Map<String, dynamic>,
      );
      expect(restored.name, 'EQMonitor Default');
      expect(restored.modes.length, 2);
      expect(restored.light, isNotNull);
      expect(restored.dark, isNotNull);
    });

    test('colorSetFor light', () {
      final theme = AppTheme.eqmonitorDefault();
      final colorSet = theme.colorSetFor(Brightness.light);
      expect(colorSet, theme.light);
    });

    test('colorSetFor dark', () {
      final theme = AppTheme.eqmonitorDefault();
      final colorSet = theme.colorSetFor(Brightness.dark);
      expect(colorSet, theme.dark);
    });

    test('不正なJSON は例外をスローする', () {
      expect(
        () => AppTheme.fromJson({'name': 'bad'}),
        throwsA(anything),
      );
    });

    test('jmaStandard の震度色はJMA標準配色と一致する', () {
      final theme = AppTheme.jmaStandard();
      for (final colorSet in [theme.light!, theme.dark!]) {
        final intensity = colorSet.intensity;
        expect(intensity.unknown.background, const Color(0xFF000000));
        expect(intensity.zero.background, const Color(0xFFFFFFFF));
        expect(intensity.one.background, const Color(0xFFF2F2F2));
        expect(intensity.two.background, const Color(0xFF00AAFF));
        expect(intensity.three.background, const Color(0xFF0041FF));
        expect(intensity.four.background, const Color(0xFFFAE6A0));
        expect(intensity.fiveLower.background, const Color(0xFFFFE600));
        expect(intensity.fiveUpper.background, const Color(0xFFFF9900));
        expect(intensity.sixLower.background, const Color(0xFFFF2800));
        expect(intensity.sixUpper.background, const Color(0xFFA50021));
        expect(intensity.seven.background, const Color(0xFFB40068));
      }
    });

    test('jmaStandard の震度2は震度3より明るい', () {
      final intensity = AppTheme.jmaStandard().light!.intensity;
      expect(
        intensity.two.background.computeLuminance(),
        greaterThan(intensity.three.background.computeLuminance()),
      );
    });

    test('light の地図背景は白ベースの明るい色', () {
      final mapColors = AppTheme.eqmonitorDefault().light!.mapColors;
      expect(mapColors.background.computeLuminance(), greaterThan(0.7));
    });
  });
}
