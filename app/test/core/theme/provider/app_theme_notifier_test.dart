import 'dart:convert';

import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/provider/shared_preferences.dart' as app_prefs;
import 'package:eqmonitor/core/theme/model/app_theme.dart';
import 'package:eqmonitor/core/theme/provider/app_theme_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<ProviderContainer> _container({
  Map<String, Object> initial = const {},
}) async {
  SharedPreferences.setMockInitialValues(initial);
  final prefs = await SharedPreferences.getInstance();
  return ProviderContainer(
    overrides: [
      app_prefs.sharedPreferencesProvider.overrideWithValue(
        app_prefs.SharedPreferencesAsync(prefs),
      ),
    ],
  );
}

AppThemeNotifier _notifier(ProviderContainer container) =>
    container.read(appThemeProvider.notifier);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppThemeNotifier.importFromJson', () {
    test('正常なJSON (eqmonitorDefault) を Success で返す', () async {
      final container = await _container();
      addTearDown(container.dispose);

      final theme = AppTheme.eqmonitorDefault();
      final json = const JsonEncoder.withIndent('  ').convert(theme.toJson());

      final result = _notifier(container).importFromJson(json);
      expect(result, isA<Success<AppTheme, AppThemeImportException>>());
      final success = result as Success<AppTheme, AppThemeImportException>;
      expect(success.value.name, theme.name);
      expect(success.value.version, 1);
      expect(success.value.modes, theme.modes);
    });

    test('不正な文字列 (非JSON) は Failure を返す', () async {
      final container = await _container();
      addTearDown(container.dispose);

      final result = _notifier(container).importFromJson('not json at all!!!');
      expect(result, isA<Failure<AppTheme, AppThemeImportException>>());
      final failure = result as Failure<AppTheme, AppThemeImportException>;
      expect(failure.exception.message, contains('JSON'));
    });

    test('JSONが配列 (Mapではない) の場合は Failure を返す', () async {
      final container = await _container();
      addTearDown(container.dispose);

      final result = _notifier(container).importFromJson('[1, 2, 3]');
      expect(result, isA<Failure<AppTheme, AppThemeImportException>>());
    });

    test('version != 1 の場合は Failure を返す', () async {
      final container = await _container();
      addTearDown(container.dispose);

      final base = AppTheme.eqmonitorDefault();
      final badVersion = base.copyWith(version: 99);
      final json = jsonEncode(badVersion.toJson());

      final result = _notifier(container).importFromJson(json);
      expect(result, isA<Failure<AppTheme, AppThemeImportException>>());
      final failure = result as Failure<AppTheme, AppThemeImportException>;
      expect(failure.exception.message, contains('バージョン'));
    });

    test('modesに light が含まれるが light が null の場合は Failure を返す', () async {
      final container = await _container();
      addTearDown(container.dispose);

      // modes=[light] だが light フィールドを持たないテーマを構築
      const theme = AppTheme(
        name: 'Test',
        version: 1,
        author: 'Test',
        modes: [ThemeBrightnessMode.light],
      );
      final json = jsonEncode(theme.toJson());

      final result = _notifier(container).importFromJson(json);
      expect(result, isA<Failure<AppTheme, AppThemeImportException>>());
      final failure = result as Failure<AppTheme, AppThemeImportException>;
      expect(failure.exception.message, contains('light'));
    });

    test('modesに dark が含まれるが dark が null の場合は Failure を返す', () async {
      final container = await _container();
      addTearDown(container.dispose);

      final base = AppTheme.eqmonitorDefault();
      // dark フィールドを null にして modes には dark を残す
      final theme = base.copyWith(
        modes: const [ThemeBrightnessMode.dark],
        dark: null,
      );
      final json = jsonEncode(theme.toJson());

      final result = _notifier(container).importFromJson(json);
      expect(result, isA<Failure<AppTheme, AppThemeImportException>>());
      final failure = result as Failure<AppTheme, AppThemeImportException>;
      expect(failure.exception.message, contains('dark'));
    });

    test('必須フィールド欠損のJSONは Failure を返す', () async {
      final container = await _container();
      addTearDown(container.dispose);

      final result = _notifier(
        container,
      ).importFromJson(jsonEncode({'name': 'broken'}));
      expect(result, isA<Failure<AppTheme, AppThemeImportException>>());
    });
  });

  group('AppThemeNotifier.exportToJson', () {
    test('exportToJson → importFromJson が成功する (ラウンドトリップ)', () async {
      final container = await _container();
      addTearDown(container.dispose);

      final notifier = _notifier(container);
      final original = AppTheme.eqmonitorDefault();

      final exported = notifier.exportToJson(original);
      expect(exported, isA<String>());
      // pretty-printed なのでインデントが含まれる
      expect(exported, contains('  '));

      final result = notifier.importFromJson(exported);
      expect(result, isA<Success<AppTheme, AppThemeImportException>>());
      final success = result as Success<AppTheme, AppThemeImportException>;
      expect(success.value.name, original.name);
      expect(success.value.version, original.version);
      expect(success.value.modes, original.modes);
    });

    test('exportToJson が有効なJSON文字列を返す', () async {
      final container = await _container();
      addTearDown(container.dispose);

      final exported = _notifier(
        container,
      ).exportToJson(AppTheme.eqmonitorDefault());
      expect(() => jsonDecode(exported), returnsNormally);
    });
  });

  group('AppThemeNotifier.build (初期状態)', () {
    test('SharedPreferences 未設定時はデフォルトテーマを返す', () async {
      final container = await _container();
      addTearDown(container.dispose);

      final state = container.read(appThemeProvider);
      expect(state.lightTheme.name, 'EQMonitor Default');
      expect(state.darkTheme.name, 'EQMonitor Default');
    });

    test('SharedPreferences にテーマが保存されている場合はそれを返す', () async {
      final theme = AppTheme.eqmonitorDefault().copyWith(name: 'Custom');
      final json = jsonEncode(theme.toJson());
      final container = await _container(initial: {'app_theme_light': json});
      addTearDown(container.dispose);

      final state = container.read(appThemeProvider);
      expect(state.lightTheme.name, 'Custom');
      // dark は未設定なのでデフォルト
      expect(state.darkTheme.name, 'EQMonitor Default');
    });

    test('保存済みテーマが構造不正なJSONの場合はデフォルトテーマを返す', () async {
      final container = await _container(initial: {'app_theme_light': '[]'});
      addTearDown(container.dispose);

      final state = container.read(appThemeProvider);

      expect(state.lightTheme.name, 'EQMonitor Default');
      expect(state.darkTheme.name, 'EQMonitor Default');
    });

    test('旧intensity_colorキーがある場合はマイグレーションされた状態を返す', () async {
      const legacyJson = '''
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
        "seven": {"foreground": "#FFFFFFFF", "background": "#FF123456"}
      }
      ''';
      final container = await _container(
        initial: {'intensity_color': legacyJson},
      );
      addTearDown(container.dispose);

      final state = container.read(appThemeProvider);
      expect(
        state.lightTheme.light!.intensity.seven.background.toARGB32(),
        0xFF123456,
      );
      expect(
        state.darkTheme.dark!.intensity.seven.background.toARGB32(),
        0xFF123456,
      );
    });

    test('新形式のテーマが既に保存されている場合はマイグレーションを行わない', () async {
      final theme = AppTheme.eqmonitorDefault().copyWith(name: 'Custom');
      final json = jsonEncode(theme.toJson());
      const legacyJson =
          '{"unknown":{"foreground":"#FFFFFFFF",'
          '"background":"#FF000000"}}';
      final container = await _container(
        initial: {'app_theme_light': json, 'intensity_color': legacyJson},
      );
      addTearDown(container.dispose);

      final state = container.read(appThemeProvider);
      expect(state.lightTheme.name, 'Custom');
    });

    test('旧intensity_colorキーがある場合、新形式の保存完了後に旧キーが削除される', () async {
      const legacyJson = '''
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
          "seven": {"foreground": "#FFFFFFFF", "background": "#FF123456"}
        }
        ''';
      final container = await _container(
        initial: {'intensity_color': legacyJson},
      );
      addTearDown(container.dispose);

      // build() 時点ではまだ非同期の保存/削除処理が完了していない
      final state = container.read(appThemeProvider);
      expect(
        state.lightTheme.light!.intensity.seven.background.toARGB32(),
        0xFF123456,
      );

      // 新形式の保存 → 旧キー削除のチェーンが完了するのを待つ
      await Future<void>.delayed(Duration.zero);
      await Future<void>.delayed(Duration.zero);
      await Future<void>.delayed(Duration.zero);

      final prefs = container.read(app_prefs.sharedPreferencesProvider);
      expect(await prefs.getString('intensity_color'), isNull);
      expect(await prefs.getString('app_theme_light'), isNotNull);
      expect(await prefs.getString('app_theme_dark'), isNotNull);
    });
  });

  group('AppThemeNotifier.setThemeForMode', () {
    test('mode=light で呼ぶと setLightTheme と同じ結果になる', () async {
      final container = await _container();
      addTearDown(container.dispose);

      final theme = AppTheme.eqmonitorDefault().copyWith(name: 'Custom Light');
      await _notifier(
        container,
      ).setThemeForMode(ThemeBrightnessMode.light, theme);

      final state = container.read(appThemeProvider);
      expect(state.lightTheme.name, 'Custom Light');
      expect(state.darkTheme.name, 'EQMonitor Default');
    });

    test('mode=dark で呼ぶと setDarkTheme と同じ結果になる', () async {
      final container = await _container();
      addTearDown(container.dispose);

      final theme = AppTheme.eqmonitorDefault().copyWith(name: 'Custom Dark');
      await _notifier(
        container,
      ).setThemeForMode(ThemeBrightnessMode.dark, theme);

      final state = container.read(appThemeProvider);
      expect(state.darkTheme.name, 'Custom Dark');
      expect(state.lightTheme.name, 'EQMonitor Default');
    });
  });
}
