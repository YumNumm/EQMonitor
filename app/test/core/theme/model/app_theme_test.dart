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
  });
}
