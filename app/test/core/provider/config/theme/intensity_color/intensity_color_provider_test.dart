import 'dart:convert';

import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_configuration.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_scheme_type.dart';
import 'package:eqmonitor/core/provider/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../test_utils/create_container.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  group('IntensityColorConfiguration プロバイダーのテスト', () {
    late MockSharedPreferences mockSharedPreferences;

    setUp(() {
      mockSharedPreferences = MockSharedPreferences();
    });

    group('初期化テスト', () {
      test('新規設定時 - デフォルトのEQMonitor配色が設定される', () {
        // 新規ユーザーの場合（設定値なし）
        when(() => mockSharedPreferences.getString(any())).thenReturn(null);
        when(
          () => mockSharedPreferences.setString(any(), any()),
        ).thenAnswer((_) async => true);

        final container = createContainer(
          overrides: [
            sharedPreferencesProvider
                .overrideWithValue(mockSharedPreferences),
          ],
        );

        final config = container.read(intensityColorConfigurationProvider);

        expect(
          config.schemeType,
          const IntensityColorSchemeType.predefined(
            scheme: PredefinedScheme.eqmonitor,
          ),
        );
        expect(config.customColors, isNull);
      });

      test('既存の新形式設定がある場合 - そのまま読み込まれる', () {
        final savedConfig = IntensityColorConfiguration(
          schemeType: const IntensityColorSchemeType.predefined(
            scheme: PredefinedScheme.jma,
          ),
        );

        when(
          () => mockSharedPreferences
              .getString('intensity_color_configuration'),
        ).thenReturn(jsonEncode(savedConfig.toJson()));
        when(() => mockSharedPreferences.getString('intensity_color'))
            .thenReturn(null);
        when(
          () => mockSharedPreferences.setString(any(), any()),
        ).thenAnswer((_) async => true);

        final container = createContainer(
          overrides: [
            sharedPreferencesProvider
                .overrideWithValue(mockSharedPreferences),
          ],
        );

        final config = container.read(intensityColorConfigurationProvider);

        expect(
          config.schemeType,
          const IntensityColorSchemeType.predefined(
            scheme: PredefinedScheme.jma,
          ),
        );
        expect(config.customColors, isNull);
      });
    });

    group('レガシー形式からの移行テスト', () {
      test('EQMonitor配色の移行 - 正しく検出され移行される', () {
        final legacyModel = IntensityColorModel.eqmonitor();

        // 新形式の設定なし、レガシー形式あり
        when(
          () => mockSharedPreferences
              .getString('intensity_color_configuration'),
        ).thenReturn(null);
        when(() => mockSharedPreferences.getString('intensity_color'))
            .thenReturn(jsonEncode(legacyModel.toJson()));
        when(
          () => mockSharedPreferences.setString(any(), any()),
        ).thenAnswer((_) async => true);

        final container = createContainer(
          overrides: [
            sharedPreferencesProvider
                .overrideWithValue(mockSharedPreferences),
          ],
        );

        final config = container.read(intensityColorConfigurationProvider);

        expect(
          config.schemeType,
          const IntensityColorSchemeType.predefined(
            scheme: PredefinedScheme.eqmonitor,
          ),
        );
        expect(config.customColors, isNull);
      });

      test('JMA配色の移行 - 正しく検出され移行される', () {
        final legacyModel = IntensityColorModel.jma();

        when(
          () => mockSharedPreferences
              .getString('intensity_color_configuration'),
        ).thenReturn(null);
        when(() => mockSharedPreferences.getString('intensity_color'))
            .thenReturn(jsonEncode(legacyModel.toJson()));
        when(
          () => mockSharedPreferences.setString(any(), any()),
        ).thenAnswer((_) async => true);

        final container = createContainer(
          overrides: [
            sharedPreferencesProvider
                .overrideWithValue(mockSharedPreferences),
          ],
        );

        final config = container.read(intensityColorConfigurationProvider);

        expect(
          config.schemeType,
          const IntensityColorSchemeType.predefined(
            scheme: PredefinedScheme.jma,
          ),
        );
        expect(config.customColors, isNull);
      });

      test('EarthQuickly配色の移行 - 正しく検出され移行される', () {
        final legacyModel = IntensityColorModel.earthQuickly();

        when(
          () => mockSharedPreferences
              .getString('intensity_color_configuration'),
        ).thenReturn(null);
        when(() => mockSharedPreferences.getString('intensity_color'))
            .thenReturn(jsonEncode(legacyModel.toJson()));
        when(
          () => mockSharedPreferences.setString(any(), any()),
        ).thenAnswer((_) async => true);

        final container = createContainer(
          overrides: [
            sharedPreferencesProvider
                .overrideWithValue(mockSharedPreferences),
          ],
        );

        final config = container.read(intensityColorConfigurationProvider);

        expect(
          config.schemeType,
          const IntensityColorSchemeType.predefined(
            scheme: PredefinedScheme.earthQuickly,
          ),
        );
        expect(config.customColors, isNull);
      });

      test('NHK配色の移行 - 正しく検出され移行される', () {
        final legacyModel = IntensityColorModel.nhk();

        when(
          () => mockSharedPreferences
              .getString('intensity_color_configuration'),
        ).thenReturn(null);
        when(() => mockSharedPreferences.getString('intensity_color'))
            .thenReturn(jsonEncode(legacyModel.toJson()));
        when(
          () => mockSharedPreferences.setString(any(), any()),
        ).thenAnswer((_) async => true);

        final container = createContainer(
          overrides: [
            sharedPreferencesProvider
                .overrideWithValue(mockSharedPreferences),
          ],
        );

        final config = container.read(intensityColorConfigurationProvider);

        expect(
          config.schemeType,
          const IntensityColorSchemeType.predefined(
            scheme: PredefinedScheme.nhk,
          ),
        );
        expect(config.customColors, isNull);
      });

      test('カスタム配色の移行 - カスタムスキームとして移行される', () {
        // カスタム配色（既存の配色とは異なる色を使用）
        final customLegacyModel = IntensityColorModel.fromBaseColors(
          unknwon: Colors.grey.shade300,
          zero: Colors.blue.shade100,
          one: Colors.green.shade200,
          two: Colors.yellow.shade300,
          three: Colors.orange.shade400,
          four: Colors.red.shade500,
          fiveLower: Colors.purple.shade600,
          fiveUpper: Colors.indigo.shade700,
          sixLower: Colors.pink.shade800,
          sixUpper: Colors.teal.shade900,
          seven: Colors.brown.shade900,
        );

        when(
          () => mockSharedPreferences
              .getString('intensity_color_configuration'),
        ).thenReturn(null);
        when(() => mockSharedPreferences.getString('intensity_color'))
            .thenReturn(jsonEncode(customLegacyModel.toJson()));
        when(
          () => mockSharedPreferences.setString(any(), any()),
        ).thenAnswer((_) async => true);

        final container = createContainer(
          overrides: [
            sharedPreferencesProvider
                .overrideWithValue(mockSharedPreferences),
          ],
        );

        final config = container.read(intensityColorConfigurationProvider);

        expect(
          config.schemeType,
          const IntensityColorSchemeType.custom(),
        );
        expect(config.customColors, isNotNull);
        expect(config.customColors, equals(customLegacyModel));
      });

      test('不正なレガシーデータ - デフォルト設定が使用される', () {
        when(
          () => mockSharedPreferences
              .getString('intensity_color_configuration'),
        ).thenReturn(null);
        when(() => mockSharedPreferences.getString('intensity_color'))
            .thenReturn('invalid_json');
        when(
          () => mockSharedPreferences.setString(any(), any()),
        ).thenAnswer((_) async => true);

        final container = createContainer(
          overrides: [
            sharedPreferencesProvider
                .overrideWithValue(mockSharedPreferences),
          ],
        );

        final config = container.read(intensityColorConfigurationProvider);

        expect(
          config.schemeType,
          const IntensityColorSchemeType.predefined(
            scheme: PredefinedScheme.eqmonitor,
          ),
        );
        expect(config.customColors, isNull);
      });
    });

    group('移行後のデータ整合性テスト', () {
      test('移行されたEQMonitor配色 - オリジナルと同じ色が取得できる', () {
        final original = IntensityColorModel.eqmonitor();

        when(
          () => mockSharedPreferences
              .getString('intensity_color_configuration'),
        ).thenReturn(null);
        when(() => mockSharedPreferences.getString('intensity_color'))
            .thenReturn(jsonEncode(original.toJson()));
        when(
          () => mockSharedPreferences.setString(any(), any()),
        ).thenAnswer((_) async => true);

        final container = createContainer(
          overrides: [
            sharedPreferencesProvider
                .overrideWithValue(mockSharedPreferences),
          ],
        );

        final config = container.read(intensityColorConfigurationProvider);
        final colorModel = container.read(intensityColorProvider);

        // 移行後のカラーモデルがオリジナルと同じであることを確認
        expect(colorModel.zero.background, original.zero.background);
        expect(colorModel.one.background, original.one.background);
        expect(colorModel.two.background, original.two.background);
        expect(colorModel.three.background, original.three.background);
        expect(colorModel.four.background, original.four.background);
        expect(colorModel.fiveLower.background, original.fiveLower.background);
        expect(colorModel.fiveUpper.background, original.fiveUpper.background);
        expect(colorModel.sixLower.background, original.sixLower.background);
        expect(colorModel.sixUpper.background, original.sixUpper.background);
        expect(colorModel.seven.background, original.seven.background);
        expect(colorModel.unknown.background, original.unknown.background);
      });

      test('移行されたカスタム配色 - すべての色情報が保持される', () {
        final customColors = IntensityColorModel.fromBaseColors(
          unknwon: const Color(0xFF123456),
          zero: const Color(0xFF234567),
          one: const Color(0xFF345678),
          two: const Color(0xFF456789),
          three: const Color(0xFF56789A),
          four: const Color(0xFF6789AB),
          fiveLower: const Color(0xFF789ABC),
          fiveUpper: const Color(0xFF89ABCD),
          sixLower: const Color(0xFF9ABCDE),
          sixUpper: const Color(0xFFABCDEF),
          seven: const Color(0xFFBCDEF0),
        );

        when(
          () => mockSharedPreferences
              .getString('intensity_color_configuration'),
        ).thenReturn(null);
        when(() => mockSharedPreferences.getString('intensity_color'))
            .thenReturn(jsonEncode(customColors.toJson()));
        when(
          () => mockSharedPreferences.setString(any(), any()),
        ).thenAnswer((_) async => true);

        final container = createContainer(
          overrides: [
            sharedPreferencesProvider
                .overrideWithValue(mockSharedPreferences),
          ],
        );

        final config = container.read(intensityColorConfigurationProvider);
        final colorModel = container.read(intensityColorProvider);

        // カスタム配色が完全に保持されていることを確認
        expect(
          colorModel.unknown.background.value,
          customColors.unknown.background.value,
        );
        expect(
          colorModel.zero.background.value,
          customColors.zero.background.value,
        );
        expect(
          colorModel.one.background.value,
          customColors.one.background.value,
        );
        expect(
          colorModel.two.background.value,
          customColors.two.background.value,
        );
        expect(
          colorModel.three.background.value,
          customColors.three.background.value,
        );
        expect(
          colorModel.four.background.value,
          customColors.four.background.value,
        );
        expect(
          colorModel.fiveLower.background.value,
          customColors.fiveLower.background.value,
        );
        expect(
          colorModel.fiveUpper.background.value,
          customColors.fiveUpper.background.value,
        );
        expect(
          colorModel.sixLower.background.value,
          customColors.sixLower.background.value,
        );
        expect(
          colorModel.sixUpper.background.value,
          customColors.sixUpper.background.value,
        );
        expect(
          colorModel.seven.background.value,
          customColors.seven.background.value,
        );
      });
    });

    group('設定更新テスト', () {
      test('予定配色への更新 - 正しく保存される', () async {
        when(() => mockSharedPreferences.getString(any())).thenReturn(null);
        when(
          () => mockSharedPreferences.setString(any(), any()),
        ).thenAnswer((_) async => true);

        final container = createContainer(
          overrides: [
            sharedPreferencesProvider
                .overrideWithValue(mockSharedPreferences),
          ],
        );

        final notifier =
            container.read(intensityColorConfigurationProvider.notifier);

        // JMA配色に変更
        await notifier.updatePredefinedScheme(PredefinedScheme.jma);

        final config = container.read(intensityColorConfigurationProvider);

        expect(
          config.schemeType,
          const IntensityColorSchemeType.predefined(
            scheme: PredefinedScheme.jma,
          ),
        );

        // SharedPreferencesに保存されたことを確認
        verify(
          () => mockSharedPreferences.setString(
            'intensity_color_configuration',
            any(),
          ),
        ).called(1);
      });

      test('カスタム配色への更新 - 正しく保存される', () async {
        when(() => mockSharedPreferences.getString(any())).thenReturn(null);
        when(
          () => mockSharedPreferences.setString(any(), any()),
        ).thenAnswer((_) async => true);

        final container = createContainer(
          overrides: [
            sharedPreferencesProvider
                .overrideWithValue(mockSharedPreferences),
          ],
        );

        final notifier =
            container.read(intensityColorConfigurationProvider.notifier);

        final customColors = IntensityColorModel.fromBaseColors(
          unknwon: Colors.red,
          zero: Colors.blue,
          one: Colors.green,
          two: Colors.yellow,
          three: Colors.orange,
          four: Colors.purple,
          fiveLower: Colors.pink,
          fiveUpper: Colors.teal,
          sixLower: Colors.indigo,
          sixUpper: Colors.brown,
          seven: Colors.grey,
        );

        // カスタム配色に変更
        await notifier.updateCustomColors(customColors);

        final config = container.read(intensityColorConfigurationProvider);

        expect(
          config.schemeType,
          const IntensityColorSchemeType.custom(),
        );
        expect(config.customColors, equals(customColors));

        // SharedPreferencesに保存されたことを確認
        verify(
          () => mockSharedPreferences.setString(
            'intensity_color_configuration',
            any(),
          ),
        ).called(1);
      });
    });

    group('例外処理テスト', () {
      test('新形式設定の読み込み失敗 - レガシー移行を試行', () {
        final legacyModel = IntensityColorModel.eqmonitor();

        when(
          () => mockSharedPreferences
              .getString('intensity_color_configuration'),
        ).thenReturn('invalid_json');
        when(() => mockSharedPreferences.getString('intensity_color'))
            .thenReturn(jsonEncode(legacyModel.toJson()));
        when(
          () => mockSharedPreferences.setString(any(), any()),
        ).thenAnswer((_) async => true);

        final container = createContainer(
          overrides: [
            sharedPreferencesProvider
                .overrideWithValue(mockSharedPreferences),
          ],
        );

        final config = container.read(intensityColorConfigurationProvider);

        // レガシー移行が成功していることを確認
        expect(
          config.schemeType,
          const IntensityColorSchemeType.predefined(
            scheme: PredefinedScheme.eqmonitor,
          ),
        );
      });

      test('全設定読み込み失敗 - デフォルト設定を使用', () {
        when(
          () => mockSharedPreferences
              .getString('intensity_color_configuration'),
        ).thenReturn('invalid_json');
        when(() => mockSharedPreferences.getString('intensity_color'))
            .thenReturn('also_invalid_json');
        when(
          () => mockSharedPreferences.setString(any(), any()),
        ).thenAnswer((_) async => true);

        final container = createContainer(
          overrides: [
            sharedPreferencesProvider
                .overrideWithValue(mockSharedPreferences),
          ],
        );

        final config = container.read(intensityColorConfigurationProvider);

        // デフォルト設定が使用されることを確認
        expect(
          config.schemeType,
          const IntensityColorSchemeType.predefined(
            scheme: PredefinedScheme.eqmonitor,
          ),
        );
        expect(config.customColors, isNull);
      });
    });
  });
}