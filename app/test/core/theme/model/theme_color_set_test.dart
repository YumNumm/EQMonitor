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

    test(
      'toColorScheme は secondary/tertiary/error が暗い背景色の場合、'
      'onSecondary/onTertiary/onError に白を設定する',
      () {
        final colorSet = AppTheme.eqmonitorDefault().light!.copyWith(
          secondary: Colors.black,
          tertiary: Colors.black,
          error: Colors.black,
        );
        final scheme = colorSet.toColorScheme(Brightness.light);
        expect(scheme.onSecondary, Colors.white);
        expect(scheme.onTertiary, Colors.white);
        expect(scheme.onError, Colors.white);
      },
    );

    test(
      'toColorScheme は secondary/tertiary/error が明るい背景色の場合、'
      'onSecondary/onTertiary/onError に黒を設定する',
      () {
        final colorSet = AppTheme.eqmonitorDefault().light!.copyWith(
          secondary: Colors.white,
          tertiary: Colors.white,
          error: Colors.white,
        );
        final scheme = colorSet.toColorScheme(Brightness.light);
        expect(scheme.onSecondary, Colors.black);
        expect(scheme.onTertiary, Colors.black);
        expect(scheme.onError, Colors.black);
      },
    );

    test(
      'toColorScheme は onSurface が暗い場合、保持されている onInverseSurface '
      'を無視し、実効的な反転背景色（onSurface）から導出した白を設定する',
      () {
        final colorSet = AppTheme.eqmonitorDefault().light!.copyWith(
          onSurface: Colors.black,
          // 実効的な反転背景色（onSurface = 黒）とのコントラストペアリング
          // に失敗する値をあえて保持させ、schemeがこれを無視することを示す。
          onInverseSurface: Colors.black,
        );
        final scheme = colorSet.toColorScheme(Brightness.light);
        expect(scheme.onInverseSurface, Colors.white);
      },
    );

    test(
      'toColorScheme は onSurface が明るい場合、保持されている onInverseSurface '
      'を無視し、実効的な反転背景色（onSurface）から導出した黒を設定する',
      () {
        final colorSet = AppTheme.eqmonitorDefault().light!.copyWith(
          onSurface: Colors.white,
          // 実効的な反転背景色（onSurface = 白）とのコントラストペアリング
          // に失敗する値をあえて保持させ、schemeがこれを無視することを示す。
          onInverseSurface: Colors.white,
        );
        final scheme = colorSet.toColorScheme(Brightness.light);
        expect(scheme.onInverseSurface, Colors.black);
      },
    );
  });

  group('onColorForBackground', () {
    test('明るい背景色の場合は黒を返す', () {
      expect(onColorForBackground(Colors.white), Colors.black);
    });

    test('暗い背景色の場合は白を返す', () {
      expect(onColorForBackground(Colors.black), Colors.white);
    });

    test(
      '輝度が0.5未満でも黒の方がコントラスト比が高い中間色の場合は黒を返す',
      () {
        // 輝度 ≈ 0.469。白とのコントラスト比 ≈ 2.0:1、黒とのコントラスト比 ≈ 10:1。
        const midtone = Color(0xFF8FB7FF);
        expect(onColorForBackground(midtone), Colors.black);
      },
    );
  });
}
