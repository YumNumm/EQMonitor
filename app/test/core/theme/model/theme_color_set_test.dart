import 'dart:convert';

import 'package:eqmonitor/core/theme/model/theme_color_set.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:eqmonitor/core/theme/model/app_theme.dart';

void main() {
  group('ThemeColorSet', () {
    test('JSON往復で値が保持される', () {
      final original = AppTheme.eqmonitorDefault().light!;
      final json = original.toJson();
      final jsonStr = jsonEncode(json);
      final restored = ThemeColorSet.fromJson(
        jsonDecode(jsonStr) as Map<String, dynamic>,
      );
      expect(restored.primary, original.primary);
      expect(restored.status.success, original.status.success);
      expect(
        restored.intensity.seven.background,
        original.intensity.seven.background,
      );
      expect(restored.mapColors.japanLand, original.mapColors.japanLand);
    });

    test('toColorScheme は正しいBrightnessを設定', () {
      final colorSet = AppTheme.eqmonitorDefault().light!;
      final scheme = colorSet.toColorScheme(Brightness.light);
      expect(scheme.brightness, Brightness.light);
      expect(scheme.primary, colorSet.primary);
    });
  });
}
