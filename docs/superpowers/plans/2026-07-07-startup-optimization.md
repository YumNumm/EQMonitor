# 起動最適化 Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** アプリ起動 (Splash 含む) を、重い初期化でナビゲーションをブロックしない体験へ転換し、効果を定量計測できる基盤を備える。

**Architecture:** 計測基盤 (`StartupProfiler` + telemetry イベント + デバッグページ) を先に入れ、Splash ゲートを解体して即 Home 遷移させ、消費側で await/graceful degradation する。main.dart の副作用 init を runApp 後へ遅延 (例外はガードして記録)。パースは計測で効果を確認できる形で compute 化する。

**Tech Stack:** Flutter 3.44 / Dart 3.11, Riverpod (riverpod_annotation, keepAlive), Freezed, telemetry_store パッケージ (Drift), flutter_test。

## Global Constraints

- Riverpod 公開 Provider は 1 ファイル 1 つまで。
- 新規 class/関数を作る前に、この計画で定義済みのインターフェースに従う (勝手に増やさない)。
- コメントは「なぜ」のみ。コードから自明なコメントを書かない。
- 必要性を論証できない冗長フィールド/抽象を足さない (YAGNI)。
- パッケージ間 import は package import を使う (相対 import 不可)。
- Freezed/Riverpod のアノテーション変更後は該当パッケージで `dart run build_runner build --delete-conflicting-outputs` を実行し、生成物 (`*.g.dart` / `*.freezed.dart`) をコミットする。
- 計測値の内部保持はマイクロ秒 (int)。UI 表示は ms。
- `unawaited` する処理は必ず try/catch で `talker.error` に記録する (例外を握りつぶさない)。
- テストは `flutter test` (app) / `dart test` (package) で緑にしてからコミットする。
- コミットメッセージ末尾に `Claude-Session: https://claude.ai/code/session_016kNc5tMmW5x7a4A4ms83EB` を付ける。

---

### Task 1: StartupProfiler (純粋 Dart クラス)

起動フェーズごとの所要時間をマイクロ秒で記録・保持・シリアライズする、Flutter 非依存の純粋クラス。時刻源を注入可能にして単体テストで決定的に検証する。

**Files:**
- Create: `app/lib/core/startup/startup_profiler.dart`
- Test: `app/test/core/startup/startup_profiler_test.dart`

**Interfaces:**
- Consumes: なし
- Produces:
  - `class StartupProfiler`
    - `StartupProfiler({int Function()? clockMicros})` — `clockMicros` 省略時は内部 `Stopwatch` の `elapsedMicroseconds` を使用。
    - `void mark(String phase)` — 生成時刻からの経過マイクロ秒を `phase` 名で記録。
    - `void measure(String phase, int micros)` — 区間長 (マイクロ秒) を直接記録 (isolate/非同期区間用)。
    - `Map<String, int> get timingsMicros` — 記録済みタイミングの読み取り専用コピー。
    - `Map<String, dynamic> toPayload()` — `{'phases': {phase: micros...}}` を返す (telemetry payload 用)。

- [ ] **Step 1: 失敗するテストを書く**

`app/test/core/startup/startup_profiler_test.dart`:

```dart
import 'package:eqmonitor/core/startup/startup_profiler.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('mark records elapsed micros from injected clock', () {
    var now = 0;
    final profiler = StartupProfiler(clockMicros: () => now);
    now = 1500;
    profiler.mark('firebase_init');
    now = 4200;
    profiler.mark('run_app');

    expect(profiler.timingsMicros, {
      'firebase_init': 1500,
      'run_app': 4200,
    });
  });

  test('measure records an explicit interval', () {
    final profiler = StartupProfiler(clockMicros: () => 0);
    profiler.measure('travel_time_parse', 9000);
    expect(profiler.timingsMicros['travel_time_parse'], 9000);
  });

  test('toPayload nests timings under phases', () {
    var now = 0;
    final profiler = StartupProfiler(clockMicros: () => now);
    now = 300;
    profiler.mark('home_first_frame');
    expect(profiler.toPayload(), {
      'phases': {'home_first_frame': 300},
    });
  });

  test('timingsMicros returns an unmodifiable copy', () {
    final profiler = StartupProfiler(clockMicros: () => 0);
    profiler.mark('a');
    expect(() => profiler.timingsMicros['b'] = 1, throwsUnsupportedError);
  });
}
```

- [ ] **Step 2: 失敗を確認**

Run: `cd app && flutter test test/core/startup/startup_profiler_test.dart`
Expected: FAIL (`StartupProfiler` 未定義)

- [ ] **Step 3: 最小実装**

`app/lib/core/startup/startup_profiler.dart`:

```dart
/// 起動フェーズごとの所要時間をマイクロ秒で記録する。
///
/// [clockMicros] を注入するとテストで決定的に検証できる。省略時は内部の
/// [Stopwatch] を時刻源に使う。
class StartupProfiler {
  StartupProfiler({int Function()? clockMicros})
    : _clockMicros = clockMicros ?? _defaultClock();

  static int Function() _defaultClock() {
    final stopwatch = Stopwatch()..start();
    return () => stopwatch.elapsedMicroseconds;
  }

  final int Function() _clockMicros;
  final Map<String, int> _timings = {};

  void mark(String phase) => _timings[phase] = _clockMicros();

  void measure(String phase, int micros) => _timings[phase] = micros;

  Map<String, int> get timingsMicros => Map.unmodifiable(_timings);

  Map<String, dynamic> toPayload() => {'phases': Map<String, int>.from(_timings)};
}
```

- [ ] **Step 4: テスト成功を確認**

Run: `cd app && flutter test test/core/startup/startup_profiler_test.dart`
Expected: PASS (4 件)

- [ ] **Step 5: コミット**

```bash
git add app/lib/core/startup/startup_profiler.dart app/test/core/startup/startup_profiler_test.dart
git commit -m "feat: 起動フェーズ計測用 StartupProfiler を追加"
```

---

### Task 2: startup_timing TelemetryEvent 追加

起動計測をサーバへ送るための telemetry イベント種別を追加する。バックエンドは `app_launch` 以外の event_type を汎用 `client_telemetry` に格納するため、バックエンド変更は不要。

**Files:**
- Modify: `packages/telemetry_store/lib/src/models/telemetry_event.dart`
- Test: `packages/telemetry_store/test/startup_timing_event_test.dart`

**Interfaces:**
- Consumes: 既存 `TelemetryEvent` sealed class
- Produces:
  - `TelemetryEvent.startupTiming({required Map<String, int> phasesMicros})` → `StartupTimingEvent`
  - `eventType` == `'startup_timing'`
  - `toPayload()` == `{'phases_micros': phasesMicros}`

- [ ] **Step 1: 失敗するテストを書く**

`packages/telemetry_store/test/startup_timing_event_test.dart`:

```dart
import 'package:telemetry_store/telemetry_store.dart';
import 'package:test/test.dart';

void main() {
  test('startupTiming has correct eventType', () {
    const event = TelemetryEvent.startupTiming(phasesMicros: {'run_app': 1200});
    expect(event.eventType, 'startup_timing');
  });

  test('startupTiming toPayload nests phases_micros', () {
    const event = TelemetryEvent.startupTiming(
      phasesMicros: {'firebase_init': 1500, 'run_app': 4200},
    );
    expect(event.toPayload(), {
      'phases_micros': {'firebase_init': 1500, 'run_app': 4200},
    });
  });

  test('startupTiming eventId is null', () {
    const event = TelemetryEvent.startupTiming(phasesMicros: {});
    expect(event.eventId, isNull);
  });
}
```

- [ ] **Step 2: 失敗を確認**

Run: `cd packages/telemetry_store && dart test test/startup_timing_event_test.dart`
Expected: FAIL (`startupTiming` 未定義)

- [ ] **Step 3: sealed class にファクトリと分岐を追加**

`packages/telemetry_store/lib/src/models/telemetry_event.dart` の `error` ファクトリの直後 (48 行目付近、`= ErrorTelemetryEvent;` の次) に追加:

```dart
  const factory TelemetryEvent.startupTiming({
    required Map<String, int> phasesMicros,
  }) = StartupTimingEvent;
```

`eventType` の switch に追加:

```dart
    StartupTimingEvent() => 'startup_timing',
```

`toPayload()` の switch に追加:

```dart
    StartupTimingEvent(:final phasesMicros) => {
      'phases_micros': phasesMicros,
    },
```

`eventId` の switch は `_ => null` があるため変更不要 (StartupTimingEvent は eventId を持たない)。

- [ ] **Step 4: build_runner で freezed 再生成**

Run: `cd packages/telemetry_store && dart run build_runner build --delete-conflicting-outputs`
Expected: `telemetry_event.freezed.dart` が更新される

- [ ] **Step 5: テスト成功を確認**

Run: `cd packages/telemetry_store && dart test test/startup_timing_event_test.dart`
Expected: PASS (3 件)

- [ ] **Step 6: コミット**

```bash
git add packages/telemetry_store/lib/src/models/telemetry_event.dart packages/telemetry_store/lib/src/models/telemetry_event.freezed.dart packages/telemetry_store/test/startup_timing_event_test.dart
git commit -m "feat: startup_timing テレメトリイベントを追加"
```

---

### Task 3: guardedUnawaited ヘルパー

`unawaited` する非同期処理の例外を握りつぶさず `talker.error` に記録する共通ヘルパー。Task 5 と Task 3 の telemetry 送信で使う。

**Files:**
- Create: `app/lib/core/util/guarded_unawaited.dart`
- Test: `app/test/core/util/guarded_unawaited_test.dart`

**Interfaces:**
- Consumes: なし (talker はコールバック注入でテスト可能にする)
- Produces:
  - `void guardedUnawaited(Future<void> Function() action, {required void Function(Object error, StackTrace stack) onError})`
    — `action()` を実行し、投げられた例外/非同期エラーを `onError` に渡す。呼び出しは同期的に戻る (待たない)。

- [ ] **Step 1: 失敗するテストを書く**

`app/test/core/util/guarded_unawaited_test.dart`:

```dart
import 'package:eqmonitor/core/util/guarded_unawaited.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('captures async error via onError', () async {
    Object? captured;
    guardedUnawaited(
      () async => throw StateError('boom'),
      onError: (error, _) => captured = error,
    );
    await Future<void>.delayed(Duration.zero);
    expect(captured, isA<StateError>());
  });

  test('captures synchronous throw in action', () async {
    Object? captured;
    guardedUnawaited(
      () => throw ArgumentError('bad'),
      onError: (error, _) => captured = error,
    );
    await Future<void>.delayed(Duration.zero);
    expect(captured, isA<ArgumentError>());
  });

  test('does not call onError on success', () async {
    var called = false;
    guardedUnawaited(
      () async {},
      onError: (_, _) => called = true,
    );
    await Future<void>.delayed(Duration.zero);
    expect(called, isFalse);
  });
}
```

- [ ] **Step 2: 失敗を確認**

Run: `cd app && flutter test test/core/util/guarded_unawaited_test.dart`
Expected: FAIL (`guardedUnawaited` 未定義)

- [ ] **Step 3: 最小実装**

`app/lib/core/util/guarded_unawaited.dart`:

```dart
import 'dart:async';

/// [action] を fire-and-forget で実行し、例外/非同期エラーを [onError] に渡す。
///
/// `unawaited` の代替。エラーを握りつぶさず必ず記録経路へ流すために使う。
void guardedUnawaited(
  Future<void> Function() action, {
  required void Function(Object error, StackTrace stack) onError,
}) {
  unawaited(
    Future<void>.sync(action).catchError(onError),
  );
}
```

- [ ] **Step 4: テスト成功を確認**

Run: `cd app && flutter test test/core/util/guarded_unawaited_test.dart`
Expected: PASS (3 件)

- [ ] **Step 5: コミット**

```bash
git add app/lib/core/util/guarded_unawaited.dart app/test/core/util/guarded_unawaited_test.dart
git commit -m "feat: 例外を記録する guardedUnawaited ヘルパーを追加"
```

---

### Task 4: main.dart に計測を組み込み + telemetry 送信

`_main()` の各フェーズを `StartupProfiler` で計測し、Home 初回フレーム後に `startup_timing` を fire-and-forget 記録する。あわせて Provider から profiler を参照できるようにする。

**Files:**
- Create: `app/lib/core/startup/startup_profiler_provider.dart`
- Modify: `app/lib/main.dart`

**Interfaces:**
- Consumes: `StartupProfiler` (Task 1), `guardedUnawaited` (Task 3), `telemetryRecorderProvider` (既存), `TelemetryEvent.startupTiming` (Task 2)
- Produces:
  - `startupProfilerProvider` — `Provider<StartupProfiler>` (keepAlive)。`_main()` で生成した単一インスタンスを `overrideWithValue` で注入。
  - Home 初回フレーム捕捉用に、`main.dart` 内で `WidgetsBinding.instance.addPostFrameCallback` を使い `home_first_frame` を mark。

**注意:** `startupProfilerProvider` は 1 ファイル 1 公開 Provider ルールに従い専用ファイルへ。

- [ ] **Step 1: profiler provider を作成**

`app/lib/core/startup/startup_profiler_provider.dart`:

```dart
import 'package:eqmonitor/core/startup/startup_profiler.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// `_main()` で生成した [StartupProfiler] を注入する。
/// override されない場合は空のインスタンスを返す (テスト等)。
final startupProfilerProvider = Provider<StartupProfiler>(
  (ref) => StartupProfiler(),
);
```

- [ ] **Step 2: main.dart に Stopwatch ベースの profiler を導入**

`_main()` 冒頭 (L93 直後) で profiler を生成し、主要フェーズを mark する。以下を挿入:

- `_main()` の先頭に `final profiler = StartupProfiler();`
- `await Firebase.initializeApp(...)` の直後に `profiler.mark('firebase_init');`
- 大きな `.wait` ブロック (`final results = await (...).wait;`) の直後に `profiler.mark('parallel_init');`
- `runApp(...)` の直前に `profiler.mark('before_run_app');`

- [ ] **Step 3: profiler を override に追加**

`ProviderContainer` の `overrides` リスト (L234-252) に追加:

```dart
      startupProfilerProvider.overrideWithValue(profiler),
```

`main.dart` 冒頭に import を追加:

```dart
import 'package:eqmonitor/core/startup/startup_profiler.dart';
import 'package:eqmonitor/core/startup/startup_profiler_provider.dart';
import 'package:eqmonitor/core/util/guarded_unawaited.dart';
import 'package:telemetry_store/telemetry_store.dart';
```

- [ ] **Step 4: Home 初回フレーム後に telemetry 送信**

`runApp(...)` の直後 (L283 の後) に、初回フレームで `home_first_frame` を mark し `startup_timing` を記録する処理を追加:

```dart
  WidgetsBinding.instance.addPostFrameCallback((_) {
    profiler.mark('home_first_frame');
    if (!kIsWeb) {
      guardedUnawaited(
        () async {
          final recorder = container.read(telemetryRecorderProvider);
          await recorder.record(
            TelemetryEvent.startupTiming(phasesMicros: profiler.timingsMicros),
          );
        },
        onError: (error, stack) => talker.error(error, stack),
      );
    }
  });
```

import 追加: `import 'package:eqmonitor/feature/telemetry/data/provider/telemetry_recorder_provider.dart';`

- [ ] **Step 5: analyze で確認**

Run: `cd app && dart analyze lib/main.dart lib/core/startup/`
Expected: No issues

- [ ] **Step 6: コミット**

```bash
git add app/lib/main.dart app/lib/core/startup/startup_profiler_provider.dart
git commit -m "feat: main.dart に起動計測と startup_timing 送信を組み込み"
```

---

### Task 5: 起動計測デバッグページ

記録済みの起動計測を ms 単位で表示するデバッグページを追加し、既存デバッグ画面のルーティングに登録する。

**Files:**
- Create: `app/lib/feature/settings/children/config/debug/startup/debug_startup_timing_page.dart`
- Modify: `app/lib/core/router/router.dart` (import + ルート定義追加)
- Modify: `app/lib/feature/settings/children/config/debug/debug_page.dart` (一覧に導線追加)

**Interfaces:**
- Consumes: `startupProfilerProvider` (Task 4)
- Produces: `DebugStartupTimingPage` widget と対応する GoRoute。

**実装メモ:** 既存 `debug_telemetry_page.dart` / `router.dart` の debug ルート定義・`debug_page.dart` の ListTile 導線パターンにそのまま倣うこと。ルート名・パス・クラス名の命名は近傍の debug ページ (例: `DebugTelemetryPage`) に合わせる。

- [ ] **Step 1: デバッグページを作成**

`app/lib/feature/settings/children/config/debug/startup/debug_startup_timing_page.dart`:

```dart
import 'package:eqmonitor/core/startup/startup_profiler_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DebugStartupTimingPage extends ConsumerWidget {
  const DebugStartupTimingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timings = ref.watch(startupProfilerProvider).timingsMicros;
    final entries = timings.entries.toList()
      ..sort((a, b) => a.value.compareTo(b.value));

    return Scaffold(
      appBar: AppBar(title: const Text('Startup Timing')),
      body: ListView(
        children: [
          for (final entry in entries)
            ListTile(
              title: Text(entry.key),
              trailing: Text('${(entry.value / 1000).toStringAsFixed(2)} ms'),
            ),
          if (entries.isEmpty)
            const ListTile(title: Text('計測データがありません')),
        ],
      ),
    );
  }
}
```

- [ ] **Step 2: ルートを登録**

`router.dart` の既存 debug ルート定義群 (例: `DebugTelemetryRoute` 付近) に倣い、`DebugStartupTimingRoute` を追加する。import も debug ページ群 (L41-59 付近) に合わせて追加する。近傍の TypedGoRoute 定義と同じ書式に厳密に合わせること。

- [ ] **Step 3: デバッグ一覧に導線を追加**

`debug_page.dart` の ListTile 群に、`DebugStartupTimingRoute().push(context)` (近傍の遷移方法に合わせる) を呼ぶ「Startup Timing」項目を 1 つ追加する。

- [ ] **Step 4: build_runner でルート生成物を更新**

Run: `cd app && dart run build_runner build --delete-conflicting-outputs`
Expected: `router.g.dart` が更新される

- [ ] **Step 5: analyze で確認**

Run: `cd app && dart analyze lib/feature/settings/children/config/debug/startup/ lib/core/router/router.dart lib/feature/settings/children/config/debug/debug_page.dart`
Expected: No issues

- [ ] **Step 6: コミット**

```bash
git add app/lib/feature/settings/children/config/debug/startup/ app/lib/core/router/router.dart app/lib/core/router/router.g.dart app/lib/feature/settings/children/config/debug/debug_page.dart
git commit -m "feat: 起動計測デバッグページを追加"
```

---

### Task 6: main.dart の副作用 init を runApp 後へ遅延

override 値を生まない副作用初期化 (MobileAds / ローカル通知 init / 通知チャンネル登録 / FCM 表示オプション) を `.wait` バリアと逐次 await から外し、runApp 後に `guardedUnawaited` で実行する。例外は必ず記録する。

**Files:**
- Modify: `app/lib/main.dart`

**Interfaces:**
- Consumes: `guardedUnawaited` (Task 3), `StartupProfiler` (Task 4 で導入済み)
- Produces: なし (起動フローの変更のみ)

**設計判断:**
- `MobileAds.instance.initialize()` (L167-169): runApp 後の `guardedUnawaited` へ移す。
- `.wait` ブロック内の副作用 3 つ (`_registerNotificationChannelIfNeeded()` / `FlutterLocalNotificationsPlugin().initialize(...)` / `FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(...)`) を `.wait` から外し、runApp 後の `guardedUnawaited` へ移す。これらは override 値を生まない。
- **`FirebaseAppCheck.instance.activate()` (L171-178) は変更しない。** API interceptor が App Check トークンを使うため runApp 前に残す (安全側)。
- 通知プラグイン init を遅延することで、コールドスタート直後の通知タップ処理 (`firebaseMessagingInteractionProvider` / deep link) が init 前に走らないか確認する。`firebaseMessagingInteractionProvider` は `container.listen` (L263) で runApp 後に登録されるため、init を runApp 直後に発火すれば順序は保たれる。懸念があれば通知 init のみ runApp 前へ戻す。

- [ ] **Step 1: MobileAds を runApp 後へ移動**

L167-169 の `if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) { await MobileAds.instance.initialize(); }` を削除し、runApp 後 (L283 以降) に移す:

```dart
  if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
    guardedUnawaited(
      () => MobileAds.instance.initialize(),
      onError: (error, stack) => talker.error(error, stack),
    );
  }
```

- [ ] **Step 2: 通知系副作用を .wait から外す**

`.wait` の第 1 タプル (L183-217) から次の 3 要素を削除する:
- `_registerNotificationChannelIfNeeded()` (L190)
- `FlutterLocalNotificationsPlugin().initialize(...)` (L192-208)
- `FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(...)` (L209-216)

タプルの要素を削除するため、後続の `results.$1.$N` インデックス参照 (L238-247) がずれる。**インデックスのずれを正しく追従すること。** 削除後の第 1 タプルは `(SharedPreferences.getInstance(), PackageInfo.fromPlatform(), androidInfo, iosInfo, getApplicationDocumentsDirectory())` の 5 要素になり、override 参照は:
- `results.$1.$1` → SharedPreferences
- `results.$1.$2` → PackageInfo
- `results.$1.$3` → androidInfo
- `results.$1.$4` → iosInfo
- `results.$1.$5` → appDir (旧 `results.$1.$6`)

に変わる。`applicationDocumentsDirectoryProvider.overrideWithValue(appDir)` の参照を `results.$1.$5` へ修正する。

- [ ] **Step 3: 通知系副作用を runApp 後へ移動**

runApp 後 (L283 以降、MobileAds の隣) に追加:

```dart
  if (!kIsWeb) {
    guardedUnawaited(
      () async {
        await _registerNotificationChannelIfNeeded();
        await FlutterLocalNotificationsPlugin().initialize(
          settings: const InitializationSettings(
            iOS: DarwinInitializationSettings(
              requestAlertPermission: false,
              requestSoundPermission: false,
              requestBadgePermission: false,
            ),
            android: AndroidInitializationSettings('mipmap/ic_launcher'),
            macOS: DarwinInitializationSettings(
              requestAlertPermission: false,
              requestSoundPermission: false,
              requestBadgePermission: false,
            ),
          ),
        );
        await FirebaseMessaging.instance
            .setForegroundNotificationPresentationOptions(
          alert: true,
          sound: true,
          badge: true,
        );
      },
      onError: (error, stack) => talker.error(error, stack),
    );
  }
```

- [ ] **Step 4: analyze で確認**

Run: `cd app && dart analyze lib/main.dart`
Expected: No issues (特に `results.$1.$N` の型エラーがないこと)

- [ ] **Step 5: 既存の起動関連テストがあれば実行**

Run: `cd app && flutter test test/core/startup/ test/core/util/`
Expected: PASS

- [ ] **Step 6: コミット**

```bash
git add app/lib/main.dart
git commit -m "perf: 広告/通知の副作用初期化を runApp 後へ遅延 (例外はガード記録)"
```

---

### Task 7: Splash ゲート解体 (トリガーのみで即 Home 遷移)

Splash が 3 Provider の完了を待つのをやめ、トリガーだけして即 Home へ遷移する。ロードは keepAlive でバックグラウンド継続。

**Files:**
- Modify: `app/lib/page/splash_page.dart`

**Interfaces:**
- Consumes: `kyoshinMonitorInternalObservationPointsConvertedProvider`, `travelTimeInternalProvider`, `earthquakeHistoryConfigProvider`, `startProvider` (すべて既存)
- Produces: なし

**設計判断:** Splash は「初期化をトリガーし即遷移する」役割に変える。3 Provider を `ref.read` で温め (keepAlive のため破棄されない)、初回フレームで Home へ `context.go`。`hasValue` 待機・`ErrorCard` 分岐は削除する (各消費画面側でローディング/エラーを扱う)。deep link 処理は現状の流れを保持する。

- [ ] **Step 1: splash_page.dart を書き換え**

`app/lib/page/splash_page.dart` の `build` を次の方針で書き換える:
- 3 Provider を `ref.read(...)` でトリガー (戻り値は使わない)。`travelTimeInternalProvider` / `kyoshinMonitorInternalObservationPointsConvertedProvider` は `.future` を read して温める (`unawaited`)。`earthquakeHistoryConfigProvider` も read。
- `useEffect` (初回のみ) で `ref.read(startProvider)` を呼び、`WidgetsBinding.instance.addPostFrameCallback` で `context.go(const HomeRoute().location)` と deep link 処理 (現状 L45-54) をそのまま実行する。
- `hasError` / `allLoaded` / `ErrorCard` 分岐を削除。body は常に `CircularProgressIndicator.adaptive()` (一瞬のみ表示)。

書き換え後:

```dart
import 'package:eqmonitor/core/fcm/notification_deep_link.dart';
import 'package:eqmonitor/core/provider/app_links_interaction.dart';
import 'package:eqmonitor/core/provider/firebase/firebase_messaging_interaction.dart';
import 'package:eqmonitor/core/provider/kmoni_observation_points/provider/kyoshin_observation_points_provider.dart';
import 'package:eqmonitor/core/provider/travel_time/provider/travel_time_provider.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_config_notifier.dart';
import 'package:eqmonitor/feature/start/data/notifier/start_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class SplashPage extends HookConsumerWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(
      () {
        // 重い初期化はトリガーのみ行い、完了を待たずに Home へ遷移する。
        // keepAlive のためバックグラウンドでロードは継続し、各消費画面が
        // 個別にローディング/エラーを表示する。
        ref
          ..read(travelTimeInternalProvider.future).ignore()
          ..read(kyoshinMonitorInternalObservationPointsConvertedProvider.future)
              .ignore()
          ..read(earthquakeHistoryConfigProvider)
          ..read(startProvider);
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          context.go(const HomeRoute().location);
          final pending =
              consumePendingNotificationDeepLink() ?? consumePendingAppLink();
          switch (pending) {
            case NotificationRouteLink(:final location):
              await GoRouter.of(context).push<void>(location);
            case NotificationUrlLink(:final uri):
              await launchUrl(uri, mode: LaunchMode.externalApplication);
            case null:
              break;
          }
        });
        return null;
      },
      const [],
    );

    return const Scaffold(
      body: SafeArea(
        child: Center(child: CircularProgressIndicator.adaptive()),
      ),
    );
  }
}
```

- [ ] **Step 2: analyze で確認**

Run: `cd app && dart analyze lib/page/splash_page.dart`
Expected: No issues (未使用 import が残らないこと)

- [ ] **Step 3: コミット**

```bash
git add app/lib/page/splash_page.dart
git commit -m "perf: Splash を待機なしのトリガー即遷移に変更"
```

---

### Task 8: 走時表消費側の非同期安全化 (graceful degradation)

Splash が待たなくなったため、走時表未ロード時に `.requireValue` が例外を投げないよう消費側を安全化する。EEW 推定震度は await、P/S 波レイヤー・揺れ検知は未ロード時にスキップ。

**Files:**
- Modify: `app/lib/feature/eew/data/provider/eew_estimated_region_intensity_provider.dart:45`
- Modify: `app/lib/core/provider/travel_time/provider/travel_time_provider.dart` (`travelTimeDepthMap` を null 許容の安全版に)
- Modify: `app/lib/feature/shake_detection/data/provider/shake_detection_merge_provider.dart:21`
- Modify: `app/lib/feature/home/ui/component/map/layer/eew_ps_wave_layer.dart:202`
- Modify: `app/lib/feature/eew/ui/components/eew_simulation_ps_wave_layer.dart:28,127`
- Modify: `app/lib/feature/eew/ui/components/eew_static_ps_wave_layer.dart:31`
- Test: `app/test/feature/eew/eew_estimated_region_intensity_travel_time_test.dart` (可能な範囲で)

**Interfaces:**
- Consumes: `travelTimeInternalProvider` (`Future<TravelTimeTables>`, 既存)
- Produces:
  - `travelTimeProvider` は現状維持 (`.requireValue`) だが、直接消費するのは深いレイヤーのみとする。
  - `travelTimeDepthMap(Ref)` の戻り型を `TravelTimeDepthMap?` に変更: `ref.watch(travelTimeInternalProvider).valueOrNull` が null なら null を返す。**この破壊的変更に伴い、全消費者を null 対応させる (下記)。**

**設計判断:** 走時表は EEW/揺れ検知イベント (起動後のネットワーク受信) 時にのみ使われる。未ロード時は「波を描かない/マージしない」で degrade し、例外は投げない。EEW 推定震度計算 (安全上重要) は確実に await する。

- [ ] **Step 1: eew_estimated_region_intensity_provider を await 化**

`eew_estimated_region_intensity_provider.dart:45` を変更:

```dart
  // 変更前: final travelTimeTables = ref.read(travelTimeProvider);
  final travelTimeTables = await ref.watch(travelTimeInternalProvider.future);
```

import に `travel_time_provider.dart` が既にあることを確認 (L8)。`travelTimeProvider` 参照が他に無ければ import はそのまま (同ファイルに `travelTimeInternalProvider` も定義されている)。

- [ ] **Step 2: travelTimeDepthMap を null 許容に変更**

`travel_time_provider.dart` の `travelTimeDepthMap`:

```dart
@Riverpod(keepAlive: true)
TravelTimeDepthMap? travelTimeDepthMap(Ref ref) {
  final tables = ref.watch(travelTimeInternalProvider).valueOrNull;
  if (tables == null) {
    return null;
  }
  return tables.table.groupListsBy((e) => e.depth);
}
```

- [ ] **Step 3: 消費側を null 対応**

各消費箇所で `travelTimeDepthMapProvider` の値が null の場合に描画/処理をスキップする:
- `shake_detection_merge_provider.dart:21`: `final travelTimeMap = ref.watch(travelTimeDepthMapProvider);` が null なら、走時に依存する enrich をスキップし従来の非走時結果を返す (近傍ロジックに合わせる)。
- `eew_ps_wave_layer.dart:202`: null なら空レイヤー (波なし) を返す。
- `eew_simulation_ps_wave_layer.dart:28,127`: null ガードを追加し、null なら波描画をスキップ。
- `eew_static_ps_wave_layer.dart:31`: null なら空レイヤーを返す。

**各ファイルの近傍の返却パターン (空レイヤーの作り方) に厳密に合わせること。**

- [ ] **Step 4: build_runner で再生成**

Run: `cd app && dart run build_runner build --delete-conflicting-outputs`
Expected: `travel_time_provider.g.dart` / `eew_estimated_region_intensity_provider.g.dart` が更新される

- [ ] **Step 5: analyze で確認**

Run: `cd app && dart analyze lib/feature/eew/ lib/core/provider/travel_time/ lib/feature/shake_detection/ lib/feature/home/ui/component/map/layer/`
Expected: No issues (null 非対応の消費者が残っていないこと)

- [ ] **Step 6: テスト実行**

Run: `cd app && flutter test test/feature/eew/`
Expected: PASS (既存 + 追加分)

- [ ] **Step 7: コミット**

```bash
git add app/lib/feature/eew/ app/lib/core/provider/travel_time/ app/lib/feature/shake_detection/ app/lib/feature/home/ui/component/map/layer/ app/test/feature/eew/
git commit -m "fix: 走時表未ロード時に例外を投げず degrade する消費側対応"
```

---

### Task 9: 走時表 CSV パースの compute 化 + パース区間計測

走時表 CSV パースを短命 isolate (`compute`) へ移し、メインスレッドのジャンクを解消する。パース区間を計測して効果を可視化する。

**Files:**
- Modify: `app/lib/core/provider/travel_time/data/travel_time_data_source.dart`
- Test: `app/test/core/provider/travel_time/travel_time_parse_test.dart`

**Interfaces:**
- Consumes: `StartupProfiler` は使わず、パース区間の計測は `travelTimeInternalProvider` 側で `Stopwatch` により行い `startupProfilerProvider.measure('travel_time_parse', micros)` で記録する (Task 4 の profiler を利用)。
- Produces:
  - top-level 関数 `TravelTimeTables parseTravelTimeCsv(String raw)` — compute に渡せる純粋関数 (CSV 文字列 → テーブル)。isolate 境界を越えるため top-level に置く。

**設計判断:** アセット読み込み (`rootBundle.loadString`) はメインで行い、CSV 文字列 (565KB) を `compute` に渡してパースする。文字列 1 本の転送は安価。結果 `TravelTimeTables` の転送コストは Task 完了後に実機/デバッグページの `travel_time_parse` 値で確認する (効果が無ければ compute を戻す判断材料になる)。

- [ ] **Step 1: パース関数を top-level に切り出すテストを書く**

`app/test/core/provider/travel_time/travel_time_parse_test.dart`:

```dart
import 'package:eqmonitor/core/provider/travel_time/data/travel_time_data_source.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('parseTravelTimeCsv parses depth/distance/p/s rows', () {
    // 実 CSV のヘッダ有無・列順は既存 loadTables の実装に合わせる。
    // 既存パースと同一の結果になることを、代表 1 行で検証する。
    const raw = '0,10,1.23,2.34';
    final tables = parseTravelTimeCsv(raw);
    expect(tables.table, isNotEmpty);
    final row = tables.table.first;
    expect(row.depth, 0);
    expect(row.distance, 10);
  });
}
```

**注意:** 上記 CSV の列順・パース方法は既存 `loadTables` (`travel_time_data_source.dart:12-38`) の実装に厳密に合わせること。列順が異なる場合はテストの `raw` と期待値を実装に合わせて修正する。

- [ ] **Step 2: 失敗を確認**

Run: `cd app && flutter test test/core/provider/travel_time/travel_time_parse_test.dart`
Expected: FAIL (`parseTravelTimeCsv` 未定義)

- [ ] **Step 3: パースを top-level 関数へ抽出**

`travel_time_data_source.dart` で、既存 `loadTables` のパースロジックを top-level 関数 `parseTravelTimeCsv(String raw)` に抽出し、`loadTables` は `rootBundle.loadString` の結果を `compute(parseTravelTimeCsv, raw)` に渡すよう変更する。既存のパースロジック (行分割・trim・`TravelTimeTable.fromList`) をそのまま関数内へ移すこと。

```dart
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
// ... 既存 import

Future<TravelTimeTables> ... loadTables() async {
  final raw = await rootBundle.loadString('assets/tjma2001.csv');
  final table = await compute(parseTravelTimeCsv, raw);
  return table;
}

/// CSV 文字列を走時テーブルへパースする。compute で isolate 実行するため
/// top-level に置く。
TravelTimeTables parseTravelTimeCsv(String raw) {
  // 既存 loadTables のパースロジックをそのまま移植する
  ...
}
```

戻り型は既存に合わせる (`loadTables` が `TravelTimeTables` を返すなら `parseTravelTimeCsv` も `TravelTimeTables` を返す。`List<TravelTimeTable>` を返していた場合はそれに合わせ、`travelTimeInternalProvider` の組み立てを維持する)。

- [ ] **Step 4: 走時表ロード区間を計測**

`travel_time_provider.dart` の `travelTimeInternal` で、ロード全体を `Stopwatch` で計測し profiler に記録する:

```dart
@Riverpod(keepAlive: true)
Future<TravelTimeTables> travelTimeInternal(Ref ref) async {
  final dataSource = ref.watch(travelTimeDataSourceProvider);
  final stopwatch = Stopwatch()..start();
  final tables = TravelTimeTables(table: await dataSource.loadTables()...);
  ref.read(startupProfilerProvider).measure(
        'travel_time_load',
        stopwatch.elapsedMicroseconds,
      );
  return tables;
}
```

(既存の組み立てに合わせて `loadTables` の戻りを扱うこと。import に `startupProfilerProvider` を追加。)

- [ ] **Step 5: テスト成功を確認**

Run: `cd app && flutter test test/core/provider/travel_time/`
Expected: PASS

- [ ] **Step 6: build_runner + analyze**

Run: `cd app && dart run build_runner build --delete-conflicting-outputs && dart analyze lib/core/provider/travel_time/`
Expected: 生成物更新, No issues

- [ ] **Step 7: コミット**

```bash
git add app/lib/core/provider/travel_time/ app/test/core/provider/travel_time/
git commit -m "perf: 走時表 CSV パースを compute へ移し区間を計測"
```

---

### Task 10: パラメータパース区間の計測 (compute 化は計測判断)

パラメータ JSON パースは 10MB と大きく、isolate 境界の転送コストで compute 化が逆効果になりうる。まず区間を計測し、実データで効果を判断できるようにする (compute 化自体はこの Task では行わず、計測結果に基づく follow-up とする)。

**Files:**
- Modify: `app/lib/feature/parameter/data/notifier/parameter_set_notifier.dart` もしくは `parameter_repository.dart` (パース呼び出し箇所)

**Interfaces:**
- Consumes: `startupProfilerProvider` (Task 4)
- Produces: なし (計測のみ)

**設計判断:** ユーザーの「compute が効くか」の懸念に対し、まず計測。`parameter_repository.dart` の `parseSet` / `loadAsset` 呼び出し区間を `Stopwatch` で計測し `startupProfilerProvider.measure('parameter_parse', micros)` に記録する。デバッグページ/サーバ metrics で確認後、効果が見込めれば別途 compute 化する。この方針は PR 説明に明記する。

- [ ] **Step 1: パース区間を計測**

パラメータのパース (JSON デシリアライズ) を行う箇所を `Stopwatch` で挟み、profiler に `parameter_parse` として記録する。`parameter_set_notifier` が Ref を持つため、そこで `ref.read(startupProfilerProvider).measure(...)` を呼ぶのが自然。パースが repository 内なら、notifier 側で「取得〜返却」全体を計測して `parameter_load` として記録する。

具体: `parameter_set_notifier.dart` の `build`/`cachedBuild` 完了までを `Stopwatch` で計測し記録する。既存の 1 ファイル 1 公開 Provider ルールを壊さないこと (計測は既存 notifier 内に閉じる)。

- [ ] **Step 2: analyze で確認**

Run: `cd app && dart analyze lib/feature/parameter/`
Expected: No issues

- [ ] **Step 3: コミット**

```bash
git add app/lib/feature/parameter/
git commit -m "chore: パラメータロード区間を計測 (compute 化は計測結果で判断)"
```

---

### Task 11: 全体 analyze + テスト + 仕上げ

**Files:**
- (必要に応じて) 上記各ファイル

- [ ] **Step 1: 全体 analyze**

Run: `melos run analyze`
Expected: No issues across packages

- [ ] **Step 2: 全体テスト**

Run: `melos run test`
Expected: PASS

- [ ] **Step 3: format 確認**

Run: `cd app && dart format --set-exit-if-changed lib test` (差分があれば `dart format` 実行後コミット)

- [ ] **Step 4: 修正が生じたらコミット**

```bash
git add -A
git commit -m "chore: analyze/format 修正"
```

---

## 補足: PR とデプロイ

全 Task 完了後、`develop` ベースで PR を作成し (`--repo YumNumm/EQMonitor`)、deploy-app ワークフローをトリガーする。PR 説明には、compute 化の効果判断がデバッグページ/サーバ metrics で可能なこと、パラメータ compute 化は計測結果に基づく follow-up であることを明記する。
