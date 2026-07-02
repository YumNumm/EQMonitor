# エラーUIキット（エラー画面・ダイアログ統一） Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** アプリのエラー表示（画面内カード・ダイアログ・SnackBar・致命的エラー画面）をプレゼンテーション層で統一し、赤面をやめたニュートラルなデザインと標準アクション（再試行／詳細／問い合わせ）に刷新する。

**Architecture:** `app/lib/core/component/error/` を「エラーUIキット」として再構築する。例外モデル（sealed 例外階層のアプリ全体展開）には手を入れず、メッセージ生成は既存の `errorMessageBuilderProvider` を使い続ける。新規に「エラー詳細シート」「共通エラーダイアログ」「致命的エラー画面」を追加し、既存の `ErrorCard` を刷新、feature 個別実装のダイアログ3箇所を置換・削除する。

**Tech Stack:** Flutter (Material 3, `useMaterial3: true`), Riverpod + hooks_riverpod（`ConsumerWidget`）, go_router（`go_router_builder` 生成 `$appRoutes` を手動 `GoRouter(...)` に渡す構成）, flutter_test（widget test）。

## Global Constraints

- 対象はプレゼンテーション層のみ。sealed 例外階層（`userMessage`/`isRetryable`）のアプリ全体展開・自動リトライ・オフライン検知は**対象外**。
- 日本語メッセージ生成は必ず既存 `errorMessageBuilderProvider`（`ErrorMessageBuilder.build({required Object error, String? Function(int statusCode)? onDioExceptionStatusOverride})`）を経由する。生の `error.toString()` を UI に直接出さない。
- **赤面を使わない**：背景はニュートラル（`colorScheme.surfaceContainerHighest` 系）、`error` 色はアイコンのみ。EQMonitor では赤は地震の危険度を表す色のため。
- **等幅フォントをやめる**：エラーメッセージ本文は通常のアプリフォント。`FontFamily.googleSansCode` を本文に使わない。
- **スタックトレースは `kDebugMode` のときのみ表示**（`package:flutter/foundation.dart`）。リリースでは要約のみ（フルトレースは Crashlytics 捕捉済み）。
- 標準アクション3種：**再試行（主）／詳細（副）／問い合わせ（副）**。再試行は `onReload` 指定時のみ。詳細は「エラー詳細シート」へ、問い合わせは既存 `openContactProvider` を再利用。
- Import はパッケージ import（`package:eqmonitor/...`）を使う（相対 import ではなく）。
- `dart analyze` が警告ゼロで通ること。`dart format` 準拠。
- コード生成が必要な変更（`@riverpod` 追加等）を行った場合は `melos run generate`（または該当パッケージで `dart run build_runner build`）を実行し、生成物をコミットする。本計画では新規 provider は追加しない想定。
- 既存の日本語コピー・アイコンは、置換後も意味が変わらないようにする（例：詳細シートのコピー完了 SnackBar 文言など）。
- 自明なコメントは書かない（なぜ系のみ）。

### 設計上の注記（実装前に人間へ確認すべき2点）

1. **`showSnackbarOnError`（Task 7）は現状 0 箇所からしか呼ばれていない**（`app/lib/core/extension/async_value.dart` の定義のみ）。修正は未使用コードへの変更であり YAGNI と競合する。本計画では「公開 API の正しさ」を理由に最小修正を含めるが、実行開始前に「修正する／削除する／据え置く」を人間に確認する。
2. **`margin`/`padding` を明示指定している 3 箇所**（`home_feed_sheet.dart:63`, `home_earthquake_history_sheet.dart:119,139`、いずれも `margin: EdgeInsets.zero, padding: EdgeInsets.all(8)`）はシート内で余白を詰める意図。Task 3 でこれらのパラメータを廃止すると統一デフォルト余白になる。デザイン方針（呼び出し側の個別指定を全除去）に従うが、シート内の見た目が許容できるか実行時に確認する。

---

## File Structure

新規作成:
- `app/lib/core/component/error/error_diagnostics.dart` — 詳細シートの「まとめてコピー」テキストを組み立てる純関数（テスト容易性のため widget から分離）
- `app/lib/core/component/error/error_details_sheet.dart` — `showErrorDetailsSheet(...)` と内部 `_ErrorDetailsSheet`
- `app/lib/core/component/error/error_dialog.dart` — `showErrorDialog(...)` と内部 `_ErrorDialogBody`
- `app/lib/core/component/error/fatal_error_screen.dart` — `FatalErrorScreen`（GoRouter 用フルページ）と `buildFatalErrorWidget(...)`（`ErrorWidget.builder` 用の堅牢な最小ウィジェット）

変更:
- `app/lib/core/component/error/error_card.dart` — ニュートラル刷新・標準アクション・`margin`/`padding`/`color` 廃止・`stackTrace`/`showDetails`/`showContact` 追加
- `app/lib/feature/home/ui/component/sheet/home_feed_sheet.dart` / `home_earthquake_history_sheet.dart` — 廃止パラメータの除去
- notification settings 配下 5 ファイル（`showNotificationSettingsErrorDialog` の 18 呼び出し）→ `showErrorDialog` へ移行
- `app/lib/feature/intensity_history/ui/components/intensity_history_error_overlay.dart` — 詳細ダイアログを `showErrorDetailsSheet` に委譲
- `app/lib/feature/onboarding/ui/components/welcome_step_page.dart` — 詳細ダイアログを `showErrorDetailsSheet` に委譲
- `app/lib/core/extension/async_value.dart` — `showSnackbarOnError` を `ErrorMessageBuilder` 経由に
- `app/lib/core/router/router.dart` — `errorBuilder` 追加
- `app/lib/main.dart` — `ErrorWidget.builder` 差し替え（リリースのみ）

削除:
- `app/lib/feature/settings/features/notification_settings/ui/component/notification_error_dialog.dart`
- `app/lib/feature/onboarding/ui/component/onboarding_provisioning_error_details_dialog.dart`

---

## Task 1: エラー診断テキスト生成（純関数）

「まとめてコピー」で一括コピーする診断テキストを組み立てる純関数。widget や platform に依存せず単体テストできるよう、必要な値はすべて引数で受け取る。

**Files:**
- Create: `app/lib/core/component/error/error_diagnostics.dart`
- Test: `app/test/core/component/error/error_diagnostics_test.dart`

**Interfaces:**
- Produces:
  ```dart
  String buildErrorDiagnostics({
    required Object error,
    StackTrace? stackTrace,
    required String deviceId,
    required String appVersion,
    required String buildNumber,
    required String os,
    required DateTime occurredAt,
    required bool includeStackTrace,
  });
  ```
  - `includeStackTrace == false` または `stackTrace == null` のときはスタックトレース節を含めない。
  - `error` が `DioException` の場合は HTTP ステータスとレスポンスの概要を含める。
- Consumes: なし（純関数）

- [ ] **Step 1: 失敗するテストを書く**

`app/test/core/component/error/error_diagnostics_test.dart`:
```dart
import 'package:dio/dio.dart';
import 'package:eqmonitor/core/component/error/error_diagnostics.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final occurredAt = DateTime.utc(2026, 7, 3, 12, 34, 56);

  String subject({
    Object error = 'boom',
    StackTrace? stackTrace,
    bool includeStackTrace = false,
  }) => buildErrorDiagnostics(
    error: error,
    stackTrace: stackTrace,
    deviceId: 'device-123',
    appVersion: '2.6.0',
    buildNumber: '4200',
    os: 'iOS 26.1',
    occurredAt: occurredAt,
    includeStackTrace: includeStackTrace,
  );

  test('基本情報をすべて含む', () {
    final text = subject();
    expect(text, contains('device-123'));
    expect(text, contains('2.6.0'));
    expect(text, contains('4200'));
    expect(text, contains('iOS 26.1'));
    expect(text, contains('2026-07-03T12:34:56'));
    expect(text, contains('boom'));
  });

  test('includeStackTrace=false のときスタックトレースを含めない', () {
    final st = StackTrace.fromString('STACK_MARKER');
    expect(subject(stackTrace: st), isNot(contains('STACK_MARKER')));
  });

  test('includeStackTrace=true かつ stackTrace ありでスタックトレースを含む', () {
    final st = StackTrace.fromString('STACK_MARKER');
    expect(
      subject(stackTrace: st, includeStackTrace: true),
      contains('STACK_MARKER'),
    );
  });

  test('DioException の HTTP ステータスを含む', () {
    final dio = DioException(
      requestOptions: RequestOptions(path: '/x'),
      response: Response<dynamic>(
        requestOptions: RequestOptions(path: '/x'),
        statusCode: 503,
      ),
    );
    expect(subject(error: dio), contains('503'));
  });
}
```

- [ ] **Step 2: テストが落ちることを確認**

Run: `cd app && flutter test test/core/component/error/error_diagnostics_test.dart`
Expected: FAIL（`buildErrorDiagnostics` 未定義でコンパイルエラー）

- [ ] **Step 3: 最小実装**

`app/lib/core/component/error/error_diagnostics.dart`:
```dart
import 'package:dio/dio.dart';

/// エラー詳細シートの「まとめてコピー」で共有する診断テキストを組み立てる。
///
/// widget/platform に依存させないため、値はすべて呼び出し側が解決して渡す。
String buildErrorDiagnostics({
  required Object error,
  StackTrace? stackTrace,
  required String deviceId,
  required String appVersion,
  required String buildNumber,
  required String os,
  required DateTime occurredAt,
  required bool includeStackTrace,
}) {
  final buffer = StringBuffer()
    ..writeln('発生時刻: ${occurredAt.toIso8601String()}')
    ..writeln('アプリバージョン: $appVersion ($buildNumber)')
    ..writeln('OS: $os')
    ..writeln('deviceId: $deviceId')
    ..writeln('例外型: ${error.runtimeType}');

  if (error is DioException) {
    final statusCode = error.response?.statusCode;
    if (statusCode != null) {
      buffer.writeln('HTTPステータス: $statusCode');
    }
    buffer.writeln('DioExceptionType: ${error.type.name}');
    final data = error.response?.data;
    if (data != null) {
      buffer.writeln('レスポンス: $data');
    }
  }

  buffer.writeln('メッセージ: $error');

  if (includeStackTrace && stackTrace != null) {
    buffer
      ..writeln('--- StackTrace ---')
      ..writeln(stackTrace.toString());
  }

  return buffer.toString().trimRight();
}
```

- [ ] **Step 4: テストが通ることを確認**

Run: `cd app && flutter test test/core/component/error/error_diagnostics_test.dart`
Expected: PASS（4 tests）

- [ ] **Step 5: analyze**

Run: `cd app && dart analyze lib/core/component/error/error_diagnostics.dart test/core/component/error/error_diagnostics_test.dart`
Expected: No issues（既知の eqmonitor_lints プラグイン競合による exit 4 が出る場合は、当該ファイルに関する warning が無いことを確認）

- [ ] **Step 6: commit**

```bash
git add app/lib/core/component/error/error_diagnostics.dart app/test/core/component/error/error_diagnostics_test.dart
git commit -m "feat(error): 診断テキスト生成の純関数を追加"
```

---

## Task 2: エラー詳細シート（新設）

要約（`ErrorMessageBuilder` 経由）＋ deviceId／アプリバージョン／OS／端末情報／発生時刻を表示し、「まとめてコピー」で一括コピー、フッターに「問い合わせ」ボタン。スタックトレースは `kDebugMode` のみ。

**Files:**
- Create: `app/lib/core/component/error/error_details_sheet.dart`
- Test: `app/test/core/component/error/error_details_sheet_test.dart`

**Interfaces:**
- Produces:
  ```dart
  Future<void> showErrorDetailsSheet(
    BuildContext context, {
    required Object error,
    StackTrace? stackTrace,
  });
  ```
- Consumes:
  - `buildErrorDiagnostics(...)`（Task 1）
  - `errorMessageBuilderProvider`（`app/lib/core/component/error/error_message_builder.dart`、`ref.read(...).build(error: error)`）
  - `deviceIdProvider`（`app/lib/core/provider/device_id.dart`、`Future<String>`）
  - `packageInfoProvider`（`app/lib/core/provider/package_info.dart`、`PackageInfo`）
  - `iosDeviceInfoProvider` / `androidDeviceInfoProvider`（`app/lib/core/provider/device_info.dart`）— OS 文字列組み立て用
  - `openContactProvider`（`app/lib/feature/settings/data/contact/contact_action.dart`、`Provider<Future<void> Function(WidgetRef, BuildContext)>`）

- [ ] **Step 1: 失敗するテストを書く**

OS/端末情報プロバイダは起動時 override 前提（本体は `UnimplementedError`）。テストでは `packageInfoProvider` と `deviceIdProvider` を override し、`Theme` に design-system 拡張が必要な場合に備えて `MaterialApp` でラップする。

`app/test/core/component/error/error_details_sheet_test.dart`:
```dart
import 'package:eqmonitor/core/component/error/error_details_sheet.dart';
import 'package:eqmonitor/core/provider/device_id.dart';
import 'package:eqmonitor/core/provider/package_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('要約とバージョン情報を表示し、まとめてコピーが押せる', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          deviceIdProvider.overrideWith((_) async => 'device-123'),
          packageInfoProvider.overrideWithValue(
            PackageInfo(
              appName: 'EQMonitor',
              packageName: 'app.eqmonitor',
              version: '2.6.0',
              buildNumber: '4200',
            ),
          ),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => showErrorDetailsSheet(
                  context,
                  error: Exception('boom'),
                ),
                child: const Text('open'),
              ),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();

    expect(find.textContaining('まとめてコピー'), findsOneWidget);
    expect(find.textContaining('2.6.0'), findsWidgets);
  });
}
```

- [ ] **Step 2: テストが落ちることを確認**

Run: `cd app && flutter test test/core/component/error/error_details_sheet_test.dart`
Expected: FAIL（`showErrorDetailsSheet` 未定義）

- [ ] **Step 3: 実装**

OS 文字列は platform に応じて `iosDeviceInfoProvider` / `androidDeviceInfoProvider` から組み立てる。詳細シート表示時刻を `occurredAt` として記録する。deviceId は `Future`。`FutureBuilder` ではなく `ref.watch(deviceIdProvider)`（`AsyncValue`）で扱い、未解決時は `'(取得中)'` を用いる。

`app/lib/core/component/error/error_details_sheet.dart`:
```dart
import 'dart:io';

import 'package:eqmonitor/core/component/error/error_diagnostics.dart';
import 'package:eqmonitor/core/component/error/error_message_builder.dart';
import 'package:eqmonitor/core/provider/device_id.dart';
import 'package:eqmonitor/core/provider/device_info.dart';
import 'package:eqmonitor/core/provider/package_info.dart';
import 'package:eqmonitor/feature/settings/data/contact/contact_action.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<void> showErrorDetailsSheet(
  BuildContext context, {
  required Object error,
  StackTrace? stackTrace,
}) {
  final occurredAt = DateTime.now();
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) => _ErrorDetailsSheet(
      error: error,
      stackTrace: stackTrace,
      occurredAt: occurredAt,
    ),
  );
}

class _ErrorDetailsSheet extends ConsumerWidget {
  const _ErrorDetailsSheet({
    required this.error,
    required this.stackTrace,
    required this.occurredAt,
  });

  final Object error;
  final StackTrace? stackTrace;
  final DateTime occurredAt;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final summary = ref.read(errorMessageBuilderProvider).build(error: error);
    final deviceId = ref.watch(deviceIdProvider).valueOrNull ?? '(取得中)';
    final packageInfo = ref.watch(packageInfoProvider);
    final os = _osString(ref);

    final diagnostics = buildErrorDiagnostics(
      error: error,
      stackTrace: stackTrace,
      deviceId: deviceId,
      appVersion: packageInfo.version,
      buildNumber: packageInfo.buildNumber,
      os: os,
      occurredAt: occurredAt,
      includeStackTrace: kDebugMode,
    );

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('エラー詳細', style: theme.textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(summary, style: theme.textTheme.bodyMedium),
            const SizedBox(height: 12),
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 240),
              child: SingleChildScrollView(
                child: SelectableText(
                  diagnostics,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: FilledButton.tonalIcon(
                    onPressed: () async {
                      await Clipboard.setData(
                        ClipboardData(text: diagnostics),
                      );
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('エラー詳細をコピーしました'),
                          ),
                        );
                      }
                    },
                    icon: const Icon(Icons.copy_rounded, size: 18),
                    label: const Text('まとめてコピー'),
                  ),
                ),
                const SizedBox(width: 8),
                TextButton.icon(
                  onPressed: () async {
                    final open = ref.read(openContactProvider);
                    await open(ref, context);
                  },
                  icon: const Icon(Icons.mail_outline_rounded, size: 18),
                  label: const Text('問い合わせ'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _osString(WidgetRef ref) {
    if (Platform.isIOS) {
      return 'iOS ${ref.watch(iosDeviceInfoProvider).systemVersion}';
    }
    if (Platform.isAndroid) {
      return 'Android ${ref.watch(androidDeviceInfoProvider).version.release}';
    }
    return Platform.operatingSystem;
  }
}
```

> 注: `openContactProvider` の関数は `WidgetRef` を要求する。`ConsumerWidget.build` の `ref` は `WidgetRef` なのでそのまま渡せる。テスト環境で `iosDeviceInfoProvider`/`androidDeviceInfoProvider` が override されていない場合、`_osString` が platform 分岐で `UnimplementedError` を投げうるため、テストは iOS/Android 以外（テストは host OS で走るため通常 `Platform.isIOS/isAndroid` は false）で `Platform.operatingSystem` に落ちる。実機・シミュレータでは起動時 override 済み。

- [ ] **Step 4: テストが通ることを確認**

Run: `cd app && flutter test test/core/component/error/error_details_sheet_test.dart`
Expected: PASS

- [ ] **Step 5: analyze**

Run: `cd app && dart analyze lib/core/component/error/error_details_sheet.dart test/core/component/error/error_details_sheet_test.dart`
Expected: 当該ファイルに関する警告なし

- [ ] **Step 6: commit**

```bash
git add app/lib/core/component/error/error_details_sheet.dart app/test/core/component/error/error_details_sheet_test.dart
git commit -m "feat(error): エラー詳細シートを新設"
```

---

## Task 3: ErrorCard 刷新 ＋ 呼び出し側の余白パラメータ除去

`ErrorCard` をニュートラルデザイン（背景 `surfaceContainerHighest`・アイコンのみ `error` 色・通常フォント）へ刷新し、標準アクション（再試行／詳細／問い合わせ）を追加。`margin`/`padding`/`color` を廃止、`stackTrace`/`showDetails`/`showContact` を追加。廃止パラメータを渡していた 3 箇所を修正する（同時に修正しないとコンパイルが壊れる）。

**Files:**
- Modify: `app/lib/core/component/error/error_card.dart`
- Modify: `app/lib/feature/home/ui/component/sheet/home_feed_sheet.dart:63`
- Modify: `app/lib/feature/home/ui/component/sheet/home_earthquake_history_sheet.dart:119,139`
- Test: `app/test/core/component/error/error_card_test.dart`

**Interfaces:**
- Produces（新しい `ErrorCard` コンストラクタ）:
  ```dart
  const ErrorCard({
    required Object error,
    Key? key,
    String? title,
    String? suffixMessage,
    Future<void> Function()? onReload,
    StackTrace? stackTrace,
    bool showDetails = true,
    bool showContact = true,
    String? Function(int statusCode)? onDioExceptionStatusOverride,
  });
  ```
  廃止: `margin`, `padding`, `color`。
- Consumes: `errorMessageBuilderProvider`, `showErrorDetailsSheet`（Task 2）, `openContactProvider`, `FullScreenCircularProgressIndicator.showUntil`（既存, 現行 `error_card.dart` が使用中のものを維持）。

- [ ] **Step 1: 失敗するテストを書く**

`app/test/core/component/error/error_card_test.dart`:
```dart
import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget wrap(Widget child) => ProviderScope(
    child: MaterialApp(home: Scaffold(body: child)),
  );

  testWidgets('onReload 指定時に再試行ボタンを表示する', (tester) async {
    var reloaded = false;
    await tester.pumpWidget(
      wrap(
        ErrorCard(
          error: Exception('boom'),
          onReload: () async => reloaded = true,
        ),
      ),
    );
    await tester.pump();
    expect(find.text('再試行'), findsOneWidget);
    await tester.tap(find.text('再試行'));
    await tester.pumpAndSettle();
    expect(reloaded, isTrue);
  });

  testWidgets('showDetails=true で詳細ボタンを表示する', (tester) async {
    await tester.pumpWidget(wrap(ErrorCard(error: Exception('boom'))));
    await tester.pump();
    expect(find.text('詳細'), findsOneWidget);
  });

  testWidgets('showContact=false で問い合わせボタンを表示しない', (tester) async {
    await tester.pumpWidget(
      wrap(ErrorCard(error: Exception('boom'), showContact: false)),
    );
    await tester.pump();
    expect(find.text('問い合わせ'), findsNothing);
  });
}
```

- [ ] **Step 2: テストが落ちることを確認**

Run: `cd app && flutter test test/core/component/error/error_card_test.dart`
Expected: FAIL（現行 `ErrorCard` は '再試行'/'詳細'/'問い合わせ' を持たない）

- [ ] **Step 3: `error_card.dart` を刷新**

`app/lib/core/component/error/error_card.dart` を次で置き換える（既存 import のうち `FullScreenCircularProgressIndicator` の import パスは現行ファイルのものを維持すること）:
```dart
import 'package:eqmonitor/core/component/error/error_details_sheet.dart';
import 'package:eqmonitor/core/component/error/error_message_builder.dart';
import 'package:eqmonitor/core/component/container/full_screen_circular_progress_indicator.dart';
import 'package:eqmonitor/feature/settings/data/contact/contact_action.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ErrorCard extends ConsumerWidget {
  const ErrorCard({
    required this.error,
    super.key,
    this.title,
    this.suffixMessage,
    this.onReload,
    this.stackTrace,
    this.showDetails = true,
    this.showContact = true,
    this.onDioExceptionStatusOverride,
  });

  final Object error;
  final String? title;
  final String? suffixMessage;
  final Future<void> Function()? onReload;
  final StackTrace? stackTrace;
  final bool showDetails;
  final bool showContact;
  final String? Function(int statusCode)? onDioExceptionStatusOverride;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final message = ref
        .read(errorMessageBuilderProvider)
        .build(
          error: error,
          onDioExceptionStatusOverride: onDioExceptionStatusOverride,
        );

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: colorScheme.surfaceContainerHighest,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.error_outline_rounded, color: colorScheme.error),
            const SizedBox(height: 8),
            Text(
              title ?? 'エラーが発生しました',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(message, style: theme.textTheme.bodyMedium),
            if (suffixMessage case final suffix?) ...[
              const SizedBox(height: 4),
              Text(suffix, style: theme.textTheme.bodyMedium),
            ],
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                if (onReload case final reload?)
                  FilledButton.tonalIcon(
                    onPressed: () => FullScreenCircularProgressIndicator
                        .showUntil(context, reload),
                    icon: const Icon(Icons.refresh_rounded, size: 18),
                    label: const Text('再試行'),
                  ),
                if (showDetails)
                  TextButton(
                    onPressed: () => showErrorDetailsSheet(
                      context,
                      error: error,
                      stackTrace: stackTrace,
                    ),
                    child: const Text('詳細'),
                  ),
                if (showContact)
                  TextButton(
                    onPressed: () async {
                      final open = ref.read(openContactProvider);
                      await open(ref, context);
                    },
                    child: const Text('問い合わせ'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
```

> `FullScreenCircularProgressIndicator` の import パスは現行 `error_card.dart` の記述をそのまま流用すること（上の path は推定）。実装者はまず現行ファイルを読み、既存 import 行をコピーする。

- [ ] **Step 4: 廃止パラメータの呼び出し側を修正**

以下 3 箇所から `margin:` と `padding:` の行を削除する（他の引数はそのまま）:
- `app/lib/feature/home/ui/component/sheet/home_feed_sheet.dart:63` — `margin: EdgeInsets.zero, padding: const EdgeInsets.all(8),` を削除
- `app/lib/feature/home/ui/component/sheet/home_earthquake_history_sheet.dart:119` — 同上
- `app/lib/feature/home/ui/component/sheet/home_earthquake_history_sheet.dart:139` — 同上

修正後の形（例）:
```dart
ErrorCard(
  error: error,
  onReload: () async => ref.invalidate(/* ... 既存のまま ... */),
)
```

- [ ] **Step 5: 全 `ErrorCard(` 呼び出しがコンパイル通過することを確認**

Run: `cd app && dart analyze lib/core/component/error/error_card.dart lib/feature/home/ui/component/sheet/`
Expected: `margin`/`padding`/`color`/未定義引数のエラーが無い。もし他の呼び出し箇所が `color`/`margin`/`padding` を渡していれば analyze が検出するので、その箇所も同様に除去する（調査時点では 3 箇所のみ）。

- [ ] **Step 6: テストが通ることを確認**

Run: `cd app && flutter test test/core/component/error/error_card_test.dart`
Expected: PASS（3 tests）

- [ ] **Step 7: commit**

```bash
git add app/lib/core/component/error/error_card.dart app/lib/feature/home/ui/component/sheet/ app/test/core/component/error/error_card_test.dart
git commit -m "feat(error): ErrorCard をニュートラルデザイン・標準アクションに刷新"
```

---

## Task 4: 共通エラーダイアログ `showErrorDialog`（新設）

`ErrorMessageBuilder` で日本語化したメッセージを表示し、「詳細」からエラー詳細シートへ遷移する共通ダイアログ。タイトルは省略時に DioException のステータス／接続エラーから既定タイトルを組み立てる（既存 `showNotificationSettingsErrorDialog` の挙動を継承）。

**Files:**
- Create: `app/lib/core/component/error/error_dialog.dart`
- Test: `app/test/core/component/error/error_dialog_test.dart`

**Interfaces:**
- Produces:
  ```dart
  Future<void> showErrorDialog(
    BuildContext context, {
    required Object error,
    String? title,
    StackTrace? stackTrace,
  });
  ```
- Consumes: `errorMessageBuilderProvider`, `showErrorDetailsSheet`（Task 2）。

- [ ] **Step 1: 失敗するテストを書く**

`app/test/core/component/error/error_dialog_test.dart`:
```dart
import 'package:dio/dio.dart';
import 'package:eqmonitor/core/component/error/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Future<void> pumpAndOpen(WidgetTester tester, Object error) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => showErrorDialog(context, error: error),
                child: const Text('open'),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
  }

  testWidgets('メッセージと詳細・閉じるを表示する', (tester) async {
    await pumpAndOpen(tester, Exception('boom'));
    expect(find.text('詳細'), findsOneWidget);
    expect(find.text('閉じる'), findsOneWidget);
  });

  testWidgets('DioException のステータスを既定タイトルに含む', (tester) async {
    final dio = DioException(
      requestOptions: RequestOptions(path: '/x'),
      response: Response<dynamic>(
        requestOptions: RequestOptions(path: '/x'),
        statusCode: 503,
      ),
    );
    await pumpAndOpen(tester, dio);
    expect(find.textContaining('503'), findsOneWidget);
  });
}
```

- [ ] **Step 2: テストが落ちることを確認**

Run: `cd app && flutter test test/core/component/error/error_dialog_test.dart`
Expected: FAIL（`showErrorDialog` 未定義）

- [ ] **Step 3: 実装**

`app/lib/core/component/error/error_dialog.dart`:
```dart
import 'package:dio/dio.dart';
import 'package:eqmonitor/core/component/error/error_details_sheet.dart';
import 'package:eqmonitor/core/component/error/error_message_builder.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<void> showErrorDialog(
  BuildContext context, {
  required Object error,
  String? title,
  StackTrace? stackTrace,
}) {
  return showDialog<void>(
    context: context,
    builder: (context) => _ErrorDialogBody(
      error: error,
      title: title,
      stackTrace: stackTrace,
    ),
  );
}

String _defaultTitle(Object error) {
  if (error is DioException) {
    final statusCode = error.response?.statusCode;
    if (statusCode != null) {
      return 'エラーが発生しました ($statusCode)';
    }
    if (error.type == DioExceptionType.connectionError) {
      return 'ネットワークエラー';
    }
  }
  return 'エラーが発生しました';
}

class _ErrorDialogBody extends ConsumerWidget {
  const _ErrorDialogBody({
    required this.error,
    required this.title,
    required this.stackTrace,
  });

  final Object error;
  final String? title;
  final StackTrace? stackTrace;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final message = ref.read(errorMessageBuilderProvider).build(error: error);
    return AlertDialog(
      title: Text(title ?? _defaultTitle(error)),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => showErrorDetailsSheet(
            context,
            error: error,
            stackTrace: stackTrace,
          ),
          child: const Text('詳細'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('閉じる'),
        ),
      ],
    );
  }
}
```

- [ ] **Step 4: テストが通ることを確認**

Run: `cd app && flutter test test/core/component/error/error_dialog_test.dart`
Expected: PASS（2 tests）

- [ ] **Step 5: analyze**

Run: `cd app && dart analyze lib/core/component/error/error_dialog.dart test/core/component/error/error_dialog_test.dart`
Expected: 当該ファイルに関する警告なし

- [ ] **Step 6: commit**

```bash
git add app/lib/core/component/error/error_dialog.dart app/test/core/component/error/error_dialog_test.dart
git commit -m "feat(error): 共通エラーダイアログ showErrorDialog を新設"
```

---

## Task 5: 通知設定のエラーダイアログを `showErrorDialog` に移行

`showNotificationSettingsErrorDialog`（18 呼び出し／5 ファイル）を `showErrorDialog` に置換し、`notification_error_dialog.dart` を削除する。旧 API は `errorMessageBuilder` を引数で受け取っていたが、新 API は provider から読むため不要。

**Files:**
- Delete: `app/lib/feature/settings/features/notification_settings/ui/component/notification_error_dialog.dart`
- Modify（呼び出し 18 箇所）:
  - `.../ui/page/eew_forecast_settings_page.dart:30,39,48,57`
  - `.../ui/page/slot_detail_page.dart:39`
  - `.../ui/page/earthquake_info_settings_page.dart:32,42,51,60`
  - `.../ui/page/notification_settings_page.dart:69,81,399,410,696,706,885`
  - `.../ui/page/sound_interruption_settings_page.dart:25,36`

**Interfaces:**
- Consumes: `showErrorDialog`（Task 4）
- 旧 `showNotificationSettingsErrorDialog({required BuildContext context, required Object error, required ErrorMessageBuilder errorMessageBuilder})` を全廃。

- [ ] **Step 1: 呼び出しを置換**

各呼び出しを次のパターンで置換する（旧→新）:
```dart
// 旧
await showNotificationSettingsErrorDialog(
  context: context,
  error: error,
  errorMessageBuilder: ref.read(errorMessageBuilderProvider),
);

// 新
await showErrorDialog(context, error: error);
```
- `import '.../notification_error_dialog.dart';` を各ファイルから削除し、`import 'package:eqmonitor/core/component/error/error_dialog.dart';` を追加する。
- 置換後 `errorMessageBuilderProvider` を他で使っていないファイルは、その import も削除する（analyze の unused_import に従う）。
- `showNotificationSettingsErrorDialog` の grep が定義ファイル以外でヒットしないことを確認する:
  Run: `cd app && grep -rn "showNotificationSettingsErrorDialog" lib`
  Expected: マッチなし

- [ ] **Step 2: 旧ファイルを削除**

```bash
git rm app/lib/feature/settings/features/notification_settings/ui/component/notification_error_dialog.dart
```

- [ ] **Step 3: analyze**

Run: `cd app && dart analyze lib/feature/settings/features/notification_settings`
Expected: 未使用 import・未定義参照が無い

- [ ] **Step 4: 既存テストが壊れていないことを確認**

Run: `cd app && flutter test test/feature/settings`
Expected: PASS（`test/feature/settings` が存在する範囲。無ければ analyze 通過をもって可とする）

- [ ] **Step 5: commit**

```bash
git add app/lib/feature/settings/features/notification_settings
git commit -m "refactor(error): 通知設定のエラーダイアログを showErrorDialog に統一"
```

---

## Task 6: intensity_history / onboarding の詳細ダイアログを詳細シートに委譲

feature 個別の詳細ダイアログ2箇所を `showErrorDetailsSheet` に置換する。intensity_history のオーバーレイ表示（バナー＋「詳細を見る」）と、onboarding の外側ダイアログ（`DeviceProvisioningException.userMessage` 表示）は維持する。

**Files:**
- Modify: `app/lib/feature/intensity_history/ui/components/intensity_history_error_overlay.dart`
- Modify: `app/lib/feature/onboarding/ui/components/welcome_step_page.dart`（`_showDeviceRegistrationErrorDialog` 内の「詳細」ボタン、`welcome_step_page.dart:156` 付近）
- Delete: `app/lib/feature/onboarding/ui/component/onboarding_provisioning_error_details_dialog.dart`
- Test: `app/test/feature/intensity_history/intensity_history_error_overlay_test.dart`（既存を更新）

**Interfaces:**
- Consumes: `showErrorDetailsSheet(context, {error, stackTrace})`（Task 2）

- [ ] **Step 1: intensity_history のテストを更新（失敗させる）**

既存 `intensity_history_error_overlay_test.dart` に、「詳細を見る」タップで詳細シート（`まとめてコピー` ボタン）が出ることを検証するケースを追加する:
```dart
testWidgets('詳細を見るで詳細シートを開く', (tester) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        prefectureHighestProvider.overrideWith(
          (_) async => throw Exception('prefecture failed'),
        ),
      ],
      child: const MaterialApp(
        home: Scaffold(
          body: Stack(
            children: [SizedBox.expand(), IntensityHistoryErrorOverlay()],
          ),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
  await tester.tap(find.text('詳細を見る'));
  await tester.pumpAndSettle();
  expect(find.textContaining('まとめてコピー'), findsOneWidget);
});
```

- [ ] **Step 2: テストが落ちることを確認**

Run: `cd app && flutter test test/feature/intensity_history/intensity_history_error_overlay_test.dart`
Expected: FAIL（現行は独自ダイアログで「まとめてコピー」は無い）

- [ ] **Step 3: intensity_history_error_overlay.dart を修正**

`IntensityHistoryErrorOverlayAction.showDetails` の本体を、独自 `showDialog` から `showErrorDetailsSheet` 呼び出しに置き換える:
```dart
Future<void> showDetails({
  required BuildContext context,
  required Object error,
  required StackTrace? stackTrace,
}) {
  return showErrorDetailsSheet(context, error: error, stackTrace: stackTrace);
}
```
- 冒頭に `import 'package:eqmonitor/core/component/error/error_details_sheet.dart';` を追加。
- 不要になった `package:flutter/services.dart` の import は analyze に従い除去（他で使っていれば残す）。
- `IntensityHistoryErrorOverlay` ウィジェット本体（バナー＋「詳細を見る」）と `intensityHistoryErrorOverlayActionProvider` は維持。

- [ ] **Step 4: onboarding を修正**

`welcome_step_page.dart` の `_showDeviceRegistrationErrorDialog` 内、「詳細」ボタンで `OnboardingProvisioningErrorDetailsDialog` を push している箇所（`welcome_step_page.dart:156` 付近）を `showErrorDetailsSheet` に置き換える。外側ダイアログ（`DeviceProvisioningException.userMessage` を含む `message` 表示・閉じる／再試行／詳細）は維持:
```dart
// 「詳細」ボタン onPressed
() => showErrorDetailsSheet(
  context,
  error: next.error!,       // 既存で参照している error オブジェクトを渡す
  stackTrace: next.stackTrace,
),
```
- 実装者は現行 `_showDeviceRegistrationErrorDialog` を読み、`error`/`stackTrace` を保持している変数名に合わせて渡す（`details` 文字列ではなく元の `error` オブジェクトを渡す）。
- `import '.../onboarding_provisioning_error_details_dialog.dart';` を削除、`import 'package:eqmonitor/core/component/error/error_details_sheet.dart';` を追加。

- [ ] **Step 5: 旧 onboarding ダイアログを削除**

```bash
git rm app/lib/feature/onboarding/ui/component/onboarding_provisioning_error_details_dialog.dart
```
`OnboardingProvisioningErrorDetailsDialog` の grep が定義以外でヒットしないことを確認:
Run: `cd app && grep -rn "OnboardingProvisioningErrorDetailsDialog" lib`
Expected: マッチなし

- [ ] **Step 6: テスト・analyze**

Run: `cd app && flutter test test/feature/intensity_history/intensity_history_error_overlay_test.dart`
Expected: PASS
Run: `cd app && dart analyze lib/feature/intensity_history/ui/components/intensity_history_error_overlay.dart lib/feature/onboarding`
Expected: 未使用 import・未定義参照が無い

- [ ] **Step 7: commit**

```bash
git add app/lib/feature/intensity_history app/lib/feature/onboarding app/test/feature/intensity_history/intensity_history_error_overlay_test.dart
git commit -m "refactor(error): intensity_history/onboarding の詳細ダイアログを詳細シートに統一"
```

---

## Task 7: `showSnackbarOnError` を `ErrorMessageBuilder` 経由に

`app/lib/core/extension/async_value.dart` の `showSnackbarOnError` が `error.toString()` を生表示している問題を修正し、`ErrorMessageBuilder` の日本語メッセージを表示する。provider 参照のため `WidgetRef` を引数に追加する（**現状 0 呼び出しのため移行対象なし**）。

> **実行前確認（Global Constraints の注記1）**: このタスクは未使用コードへの変更。人間の判断が「修正」の場合のみ本タスクを実行する。「削除」なら拡張ごと削除、「据え置き」なら本タスクをスキップする。

**Files:**
- Modify: `app/lib/core/extension/async_value.dart`
- Test: `app/test/core/extension/async_value_test.dart`

**Interfaces:**
- Produces（新シグネチャ）:
  ```dart
  extension AsyncValueX<T> on AsyncValue<T> {
    void showSnackbarOnError(WidgetRef ref, BuildContext context);
  }
  ```
  未使用だった `defaultMessage` 引数は廃止（メッセージは `ErrorMessageBuilder` が生成）。
- Consumes: `errorMessageBuilderProvider`

- [ ] **Step 1: 失敗するテストを書く**

`app/test/core/extension/async_value_test.dart`:
```dart
import 'package:eqmonitor/core/extension/async_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  testWidgets('エラー時に日本語メッセージの SnackBar を出す', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: Consumer(
              builder: (context, ref, _) => ElevatedButton(
                onPressed: () => const AsyncError<int>(
                  'boom',
                  StackTrace.empty,
                ).showSnackbarOnError(ref, context),
                child: const Text('go'),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('go'));
    await tester.pump();
    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.textContaining('エラー'), findsOneWidget);
  });
}
```

- [ ] **Step 2: テストが落ちることを確認**

Run: `cd app && flutter test test/core/extension/async_value_test.dart`
Expected: FAIL（現行シグネチャは `WidgetRef` を取らない）

- [ ] **Step 3: 実装**

`app/lib/core/extension/async_value.dart` の該当拡張メソッドを置き換える:
```dart
import 'package:eqmonitor/core/component/error/error_message_builder.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

extension AsyncValueX<T> on AsyncValue<T> {
  void showSnackbarOnError(WidgetRef ref, BuildContext context) {
    if (!isLoading && hasError) {
      final message = ref
          .read(errorMessageBuilderProvider)
          .build(error: error ?? 'エラーが発生しました');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }
}
```
- 既存 import・他の拡張メンバー（あれば）は維持する。実装者は現行ファイル全体を読み、`AsyncValueX` の他メンバーを壊さないこと。

- [ ] **Step 4: テストが通ることを確認**

Run: `cd app && flutter test test/core/extension/async_value_test.dart`
Expected: PASS

- [ ] **Step 5: analyze**

Run: `cd app && dart analyze lib/core/extension/async_value.dart test/core/extension/async_value_test.dart`
Expected: 当該ファイルに関する警告なし

- [ ] **Step 6: commit**

```bash
git add app/lib/core/extension/async_value.dart app/test/core/extension/async_value_test.dart
git commit -m "fix(error): showSnackbarOnError を ErrorMessageBuilder 経由に"
```

---

## Task 8: 致命的エラー画面（GoRouter errorBuilder ＋ ErrorWidget.builder）

未定義ルート等の GoRouter エラーと、リリースビルドの widget build エラー（Flutter 赤画面）を、落ち着いたエラー表示に差し替える。エラー画面自体が provider に依存して二次クラッシュしないよう、最小依存の堅牢なウィジェットにする。

**Files:**
- Create: `app/lib/core/component/error/fatal_error_screen.dart`
- Modify: `app/lib/core/router/router.dart`（`GoRouter(...)` に `errorBuilder` 追加、`router.dart:123` の `debugLogDiagnostics: kDebugMode,` 直後）
- Modify: `app/lib/main.dart`（`_main()` 内 `FlutterError.onError` 設定後・`runApp` 前で `ErrorWidget.builder` をリリースのみ差し替え）
- Test: `app/test/core/component/error/fatal_error_screen_test.dart`

**Interfaces:**
- Produces:
  ```dart
  // フルページ（Scaffold, ホームへ戻る導線あり）。GoRouter errorBuilder 用。
  class FatalErrorScreen extends StatelessWidget {
    const FatalErrorScreen({required this.error, super.key});
    final Object? error;
  }

  // ErrorWidget.builder 用の堅牢な最小ウィジェット（MaterialApp 祖先が無い状況でも描画可能）。
  Widget buildFatalErrorWidget(FlutterErrorDetails details);
  ```
- Consumes: `kDebugMode`（`package:flutter/foundation.dart`）, `HomeRoute`（`app/lib/core/router/router.dart`、`const HomeRoute().go(context)`）。

- [ ] **Step 1: 失敗するテストを書く**

`app/test/core/component/error/fatal_error_screen_test.dart`:
```dart
import 'package:eqmonitor/core/component/error/fatal_error_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('FatalErrorScreen はメッセージを表示する', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: FatalErrorScreen(error: 'boom')),
    );
    expect(find.textContaining('問題が発生しました'), findsOneWidget);
  });

  testWidgets('buildFatalErrorWidget は MaterialApp 祖先なしでも描画できる', (
    tester,
  ) async {
    final details = FlutterErrorDetails(exception: Exception('boom'));
    await tester.pumpWidget(buildFatalErrorWidget(details));
    expect(tester.takeException(), isNull);
  });
}
```

- [ ] **Step 2: テストが落ちることを確認**

Run: `cd app && flutter test test/core/component/error/fatal_error_screen_test.dart`
Expected: FAIL（`FatalErrorScreen`/`buildFatalErrorWidget` 未定義）

- [ ] **Step 3: 実装**

`app/lib/core/component/error/fatal_error_screen.dart`:
```dart
import 'package:eqmonitor/core/router/router.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FatalErrorScreen extends StatelessWidget {
  const FatalErrorScreen({required this.error, super.key});

  final Object? error;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error_outline_rounded,
                size: 48,
                color: theme.colorScheme.error,
              ),
              const SizedBox(height: 16),
              Text('問題が発生しました', style: theme.textTheme.titleLarge),
              const SizedBox(height: 8),
              Text(
                'お手数ですが、アプリを再操作してください。',
                style: theme.textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              if (kDebugMode && error != null) ...[
                const SizedBox(height: 16),
                Text(
                  '$error',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: () => const HomeRoute().go(context),
                icon: const Icon(Icons.home_rounded),
                label: const Text('ホームへ戻る'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// [ErrorWidget.builder] 用。MaterialApp 祖先が無い状況でも安全に描画する。
Widget buildFatalErrorWidget(FlutterErrorDetails details) {
  return Directionality(
    textDirection: TextDirection.ltr,
    child: Container(
      color: const Color(0xFF1C1B1F),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.error_outline_rounded,
            size: 40,
            color: Color(0xFFB0AEB8),
          ),
          const SizedBox(height: 12),
          const Text(
            '問題が発生しました',
            style: TextStyle(color: Color(0xFFE6E1E5), fontSize: 16),
          ),
          if (kDebugMode) ...[
            const SizedBox(height: 8),
            Text(
              '${details.exception}',
              style: const TextStyle(color: Color(0xFFB0AEB8), fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    ),
  );
}
```

- [ ] **Step 4: GoRouter に errorBuilder を追加**

`app/lib/core/router/router.dart` の `GoRouter(...)`、`debugLogDiagnostics: kDebugMode,`（`router.dart:123` 付近）の直後に追加:
```dart
errorBuilder: (context, state) => FatalErrorScreen(error: state.error),
```
- ファイル冒頭に `import 'package:eqmonitor/core/component/error/fatal_error_screen.dart';` を追加。
- 生成ファイル（`router.g.dart`）はルート定義を変えていないため再生成不要。ただし念のため analyze で確認する。

- [ ] **Step 5: main.dart に ErrorWidget.builder を追加**

`app/lib/main.dart` の `_main()` 内、`FlutterError.onError` 設定後（`main.dart:139` 付近）・`runApp` 前に追加:
```dart
if (!kDebugMode) {
  ErrorWidget.builder = buildFatalErrorWidget;
}
```
- `import 'package:eqmonitor/core/component/error/fatal_error_screen.dart';` を追加。
- デバッグ時は Flutter 標準の赤画面を残す（開発診断のため。Global Constraints「リリースのみ差し替え」）。

- [ ] **Step 6: テスト・analyze**

Run: `cd app && flutter test test/core/component/error/fatal_error_screen_test.dart`
Expected: PASS（2 tests）
Run: `cd app && dart analyze lib/core/component/error/fatal_error_screen.dart lib/core/router/router.dart lib/main.dart`
Expected: 当該ファイルに関する警告なし

- [ ] **Step 7: commit**

```bash
git add app/lib/core/component/error/fatal_error_screen.dart app/lib/core/router/router.dart app/lib/main.dart app/test/core/component/error/fatal_error_screen_test.dart
git commit -m "feat(error): 致命的エラー画面(GoRouter/ErrorWidget)を整備"
```

---

## 最終確認（全タスク完了後）

- [ ] 全体 analyze: `cd app && dart analyze lib` — 本変更由来の警告ゼロ（既知の eqmonitor_lints プラグイン競合 exit 4 は無視可、当該由来の warning が無いことを確認）
- [ ] 関連テスト一括: `cd app && flutter test test/core/component/error test/core/extension test/feature/intensity_history`
- [ ] `git grep -n "ErrorCard(" app/lib` の全箇所が新 API（`margin`/`padding`/`color` 不使用）であること
- [ ] `git grep -n "showNotificationSettingsErrorDialog\|OnboardingProvisioningErrorDetailsDialog" app/lib` がマッチ 0

---

## Self-Review 結果

- **Spec coverage**: 設計 doc の Step1（ErrorCard 刷新）=Task3、Step2（詳細シート）=Task1+2、Step3（共通ダイアログ＋3置換）=Task4+5+6、Step4（SnackBar）=Task7、Step5（致命的エラー）=Task8。全 Step を網羅。
- **Placeholder scan**: 各コード step に実コードを記載。migration タスクは旧→新パターンと全対象箇所を明示。
- **Type consistency**: `showErrorDetailsSheet(context, {error, stackTrace})`・`showErrorDialog(context, {error, title, stackTrace})`・`buildErrorDiagnostics(...)`・`FatalErrorScreen(error:)`・`buildFatalErrorWidget(details)` を Task 間で一貫使用。`errorMessageBuilderProvider.build(...)` のシグネチャは調査済みのものと一致。
- **既知の外部依存の不確かさ**（実装者が現行ファイルを読んで解決すべき点）: `error_card.dart` の `FullScreenCircularProgressIndicator` import パス、`welcome_step_page.dart` の error/stackTrace 変数名。各タスクに明記済み。
