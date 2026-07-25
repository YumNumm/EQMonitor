# EEW警報overlay Presentation・状態制御 実装計画

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Plan 1が生成する現在地向けEEW警報表示モデルを、foreground限定の全画面警報・最小化バナー・バイブレーション・設定・固定シミュレーションとして提供する。

**Architecture:** `MaterialApp.router.builder` に宣言的なroot hostを置き、Riverpod notifierが表示状態、既知eventId、10秒timer、lifecycle、振動副作用を一元管理する。WidgetはPlan 1の構造化表示モデルだけを描画し、時刻文言はpure formatter、端末振動は差し替え可能なservice境界へ分離する。

**Tech Stack:** Flutter 3.44.4 / Dart 3.12.2 / Riverpod 3 / flutter_hooks / Freezed / vibration / fake_async / shared_preferences / talker

**Spec:** `docs/superpowers/specs/2026-07-25-eew-warning-overlay-design.md`

## Global Constraints

- 実警報はforegroundかつrealtimeかつ現在地が警報対象の時だけ表示する。background・終了中のOS通知、音声、安全行動案内は追加しない。
- 状態は`hidden` / `fullscreen` / `minimized`。初回は最大10秒後に最小化し、再展開後は自動最小化・再振動しない。
- 振動は対応端末で`700ms振動 + 300ms停止`を最大10秒。最小化、閉じる、無効化、backgroundで即時停止する。
- 同じeventIdは再通知しない。新しいeventIdは表示中でも全画面と振動を開始し、閉じる操作は現在の有効イベント群をまとめて処理済みにする。
- 設定は既定有効で、無効化時は実警報UIと振動を停止する。固定シミュレーションは設定無効時も実行でき、実警報が常に優先される。
- 全画面最上部の赤黒ストライプは約10 logical pxでSafeArea外まで広げ、本文だけをスクロール可能にし、操作はSafeArea内下部へ固定する。
- Widget testは作成・変更しない。pure unit / provider / notifier testと手動確認だけを行う。
- Flutter / Dartコマンドは必ず`mise exec --`経由。依存追加は`flutter pub add`、生成は`mise exec -- dart run build_runner build --delete-conflicting-outputs`を使う。
- `SharedPreferences`キー文字列は利用箇所へ直書きせず、Plan 1の`eewWarningOverlayEnabledProvider`と`SharedPreferencesKey`を利用する。
- 既存`eewSimulationProvider`はEEW詳細リプレイ専用であり、警報overlayシミュレーションには使用しない。

## Plan 1 接続契約

この計画は次の公開interfaceを消費する。

- `eewWarningOverlayDisplayProvider`: 実警報の`EewWarningOverlayDisplayModel?`
- `eewWarningOverlaySimulationProvider`: 固定訓練モデルを`start()` / `stop()`するnotifier provider
- `eewWarningOverlayEffectiveDisplayProvider`: 実警報をシミュレーションより優先した`EewWarningOverlayDisplayModel?`
- `eewWarningOverlayEnabledProvider`: 既定`true`を永続化し、`set({required bool value})`を持つasync notifier provider
- `EewWarningOverlayDisplayModel`: `source`、`eventIds`、`representativeEventId`、`serialNo`、`alertCount`、`reportLabel`、`hypocenterHeadline`、`strongMotionHeadline`、`currentRegionName`、`localIntensity`、`localIntensityIsOver`、`arrivalState`、`secondsUntilArrival`、`hypocenterName`、`magnitude`、`depth`を公開する

---

### Task 1: vibration依存と差し替え可能な振動service

**Files:**
- Modify: `app/pubspec.yaml`
- Modify: `pubspec.lock`
- Create: `app/lib/feature/eew/data/service/eew_warning_overlay_vibration_service.dart`
- Create: `app/lib/feature/eew/data/service/eew_warning_overlay_vibration_service.g.dart`
- Test: `app/test/feature/eew/data/service/eew_warning_overlay_vibration_service_test.dart`
- Create: `docs/knowledge/20260725_eew_warning_overlay_vibration.md`

**Interfaces:**
- Produces: `EewWarningOverlayVibrationGateway`, `VibrationPackageGateway`, `EewWarningOverlayVibrationService.start()` / `cancel()`, `eewWarningOverlayVibrationServiceProvider`

- [ ] **Step 1: vibrationを正規手順で追加する**

Run: `cd app && mise exec -- flutter pub add vibration`

Expected: `app/pubspec.yaml`とworkspace rootの`pubspec.lock`が更新される。

- [ ] **Step 2: 失敗するservice testを書く**

fake gatewayで次を検証する。

```dart
test('custom vibration starts the finite requested pulse pattern', () async {
  final gateway = FakeVibrationGateway(hasVibrator: true, custom: true);
  final service = EewWarningOverlayVibrationService(
    gateway: gateway,
    talker: Talker(),
  );
  await service.start();
  expect(gateway.pattern, eewWarningOverlayVibrationPattern);
  expect(
    eewWarningOverlayVibrationPattern.reduce((a, b) => a + b),
    9700,
  );
});

test('unsupported device and plugin errors do not escape', () async {
  final unsupported = FakeVibrationGateway(hasVibrator: false);
  await EewWarningOverlayVibrationService(
    gateway: unsupported,
    talker: Talker(),
  ).start();
  expect(unsupported.vibrateCalls, 0);

  final failing = FakeVibrationGateway(error: StateError('disabled'));
  await expectLater(
    EewWarningOverlayVibrationService(
      gateway: failing,
      talker: Talker(),
    ).start(),
    completes,
  );
});
```

- [ ] **Step 3: testが未定義型で失敗することを確認する**

Run: `cd app && mise exec -- flutter test test/feature/eew/data/service/eew_warning_overlay_vibration_service_test.dart`

Expected: FAIL（振動service未定義）。

- [ ] **Step 4: gateway・service・providerを実装する**

```dart
abstract interface class EewWarningOverlayVibrationGateway {
  Future<bool> hasVibrator();
  Future<bool> hasCustomVibrationsSupport();
  Future<void> vibrate({required List<int> pattern});
  Future<void> vibrateOnce({required int durationMs});
  Future<void> cancel();
}

class EewWarningOverlayVibrationService {
  const EewWarningOverlayVibrationService({
    required EewWarningOverlayVibrationGateway gateway,
    required Talker talker,
  }) : _gateway = gateway, _talker = talker;

  final EewWarningOverlayVibrationGateway _gateway;
  final Talker _talker;

  Future<void> start() async {
    try {
      if (!await _gateway.hasVibrator()) return;
      if (await _gateway.hasCustomVibrationsSupport()) {
        await _gateway.vibrate(pattern: eewWarningOverlayVibrationPattern);
      } else {
        await _gateway.vibrateOnce(durationMs: 700);
      }
    } catch (error, stackTrace) {
      _talker.error('[EEW warning overlay] vibration start failed', error, stackTrace);
    }
  }

  Future<void> cancel() async {
    try {
      await _gateway.cancel();
    } catch (error, stackTrace) {
      _talker.error('[EEW warning overlay] vibration cancel failed', error, stackTrace);
    }
  }
}
```

`eewWarningOverlayVibrationPattern`は、先頭delay 0、700ms振動を10回、間の300ms停止を9回並べた有限の`List<int>`とする。合計9700msで自動終了するため、cancel失敗時も振動が無期限に継続しない。

`VibrationPackageGateway`だけが`Vibration.hasVibrator()`、`hasCustomVibrationsSupport()`、`vibrate()`、`cancel()`へ触れる。Android manifestには既存の`android.permission.VIBRATE`があるため重複追加しない。

- [ ] **Step 5: platform知見を記録し、生成・testを行う**

knowledge docへAndroid権限が既存であること、iOSにusage descriptionが不要であること、非対応・OS無効・plugin例外でもUIを継続すること、実機で開始・停止を確認するコマンドを記録する。

Run: `cd app && mise exec -- dart run build_runner build --delete-conflicting-outputs`

Run: `cd app && mise exec -- flutter test test/feature/eew/data/service/eew_warning_overlay_vibration_service_test.dart`

Expected: PASS。

- [ ] **Step 6: commitする**

```bash
git add app/pubspec.yaml pubspec.lock app/lib/feature/eew/data/service app/test/feature/eew/data/service docs/knowledge/20260725_eew_warning_overlay_vibration.md
git commit -m "feat: EEW警報overlayの振動serviceを追加"
```

---

### Task 2: 表示state・10秒timer・lifecycle reducer/notifier

**Files:**
- Create: `app/lib/feature/eew/data/model/eew_warning_overlay_state.dart`
- Create: `app/lib/feature/eew/data/model/eew_warning_overlay_state.freezed.dart`
- Create: `app/lib/feature/eew/data/service/eew_warning_overlay_scheduler.dart`
- Create: `app/lib/feature/eew/data/service/eew_warning_overlay_scheduler.g.dart`
- Create: `app/lib/feature/eew/data/notifier/eew_warning_overlay_notifier.dart`
- Create: `app/lib/feature/eew/data/notifier/eew_warning_overlay_notifier.g.dart`
- Test: `app/test/feature/eew/data/notifier/eew_warning_overlay_notifier_test.dart`

**Interfaces:**
- Consumes: Plan 1の`eewWarningOverlayEffectiveDisplayProvider` / `eewWarningOverlaySimulationProvider`、Task 1の振動service、既存`appLifecycleProvider`
- Produces: `EewWarningOverlayMode`、`EewWarningOverlayState`、`eewWarningOverlayNotifierProvider`と`minimize()` / `close()` / `expand()`

- [ ] **Step 1: notifierの失敗testを先に書く**

`ProviderContainer`でsource、enabled、lifecycle、scheduler、振動serviceをoverrideし、次を別testとして固定する。

```dart
expect(container.read(eewWarningOverlayNotifierProvider).mode,
    EewWarningOverlayMode.hidden);
source.set(display(eventIds: ['A']));
expect(state().mode, EewWarningOverlayMode.fullscreen);
expect(vibration.startCalls, 1);

scheduler.elapse(const Duration(seconds: 10));
expect(state().mode, EewWarningOverlayMode.minimized);
expect(vibration.cancelCalls, 1);
```

追加caseは、同一Aの更新は再振動せず内容更新、A+B追加で全画面再開、複数を閉じても既知A/Bを表示しない、C追加だけ再開、C消失後にdismissed済みA/Bだけならhidden、手動最小化、再展開後はtimer・振動なし、対象消失、離脱後の再進入はbanner、設定無効で実警報は消えるがsimulationは表示できること、実警報preemption後に同じ固定IDのsimulationを再実行できること、background中の新eventIdをseenへ入れずresume時に全画面通知することを含める。

- [ ] **Step 2: testが未定義providerで失敗することを確認する**

Run: `cd app && mise exec -- flutter test test/feature/eew/data/notifier/eew_warning_overlay_notifier_test.dart`

Expected: FAIL（state/notifier未定義）。

- [ ] **Step 3: stateとscheduler境界を実装する**

```dart
enum EewWarningOverlayMode { hidden, fullscreen, minimized }

@freezed
abstract class EewWarningOverlayState with _$EewWarningOverlayState {
  const factory EewWarningOverlayState({
    @Default(EewWarningOverlayMode.hidden) EewWarningOverlayMode mode,
    EewWarningOverlayDisplayModel? displayModel,
    @Default(<String>{}) Set<String> seenEventIds,
    @Default(<String>{}) Set<String> dismissedEventIds,
    @Default(false) bool simulationSessionActive,
  }) = _EewWarningOverlayState;
}

abstract interface class EewWarningOverlayScheduledTask { void cancel(); }
abstract interface class EewWarningOverlayScheduler {
  EewWarningOverlayScheduledTask schedule({
    required Duration delay,
    required Future<void> Function() callback,
  });
}
```

production schedulerは`Timer(delay, () async => callback())`を閉じ込め、testは明示的に`elapse()`できるfakeへ差し替える。

- [ ] **Step 4: notifierを最小実装する**

`build()`でeffective displayとlifecycleをlistenする。`source == real`の時は新しいeventIdを検出した時だけ`fullscreen`へ遷移し、seenへ追加、10秒taskを張り、振動を開始する。既知更新は現在表示中なら`displayModel`だけ差し替える。ただし現在のreal eventIdsがすべてdismissed済みになった時はhiddenへ遷移して振動を止める。これにより、閉じたA/Bへ新規Cが加わって再表示した後、Cだけが無効になってもA/Bを再表示しない。

`source == simulation`は、直前のeffective sourceがnullまたはreal、もしくは`simulationSessionActive == false`から入った遷移ごとに新しいsessionとして全画面・timer・振動を開始する。同じ固定eventIdをseen判定に使わない。`close()`時はsimulation notifierの`stop()`も呼び、`simulationSessionActive`をfalseへ戻す。実警報preemptionまたはsource nullでもfalseへ戻し、後日の手動simulationを再実行可能にする。

`close()`は実警報なら現在eventIdsをdismissedへ追加してhidden、`minimize()`はtimer取消・振動停止、`expand()`は状態だけfullscreenとしtimer・振動を開始しない。effective displayがnullならtimerと振動を止める。

lifecycleが非resumedへ変わった時はfullscreenだけminimizedとして保持し、timerと振動を止める。background中にeffective displayへ現れた新eventIdはseenへ追加せずpendingのままにし、resume時点の有効modelとseenを比較して、未処理IDがあれば初めてseen化・fullscreen・timer・振動を開始する。background中に消えたIDは通知しない。既知IDだけならresume時はminimizedとする。

設定値をnotifierで直接gateしてはならない。Plan 1の実警報providerが設定を適用し、simulationは設定無効時もeffective displayへ流れる。

- [ ] **Step 5: 生成し、全notifier testを通す**

Run: `cd app && mise exec -- dart run build_runner build --delete-conflicting-outputs`

Run: `cd app && mise exec -- flutter test test/feature/eew/data/notifier/eew_warning_overlay_notifier_test.dart`

Expected: PASS。

- [ ] **Step 6: commitする**

```bash
git add app/lib/feature/eew/data/model/eew_warning_overlay_state* app/lib/feature/eew/data/service/eew_warning_overlay_scheduler* app/lib/feature/eew/data/notifier/eew_warning_overlay_notifier* app/test/feature/eew/data/notifier/eew_warning_overlay_notifier_test.dart
git commit -m "feat: EEW警報overlayの表示状態制御を追加"
```

---

### Task 3: 到達文言formatterと全画面・最小化UI

**Files:**
- Create: `app/lib/feature/eew/ui/formatter/eew_warning_overlay_arrival_formatter.dart`
- Create: `app/lib/feature/eew/ui/components/eew_warning_overlay_fullscreen.dart`
- Create: `app/lib/feature/eew/ui/components/eew_warning_overlay_banner.dart`
- Test: `app/test/feature/eew/ui/formatter/eew_warning_overlay_arrival_formatter_test.dart`

**Interfaces:**
- Consumes: `EewWarningOverlayDisplayModel`とTask 2の操作callback
- Produces: `formatEewWarningOverlayArrival(...)`、`EewWarningOverlayFullscreen`、`EewWarningOverlayBanner`

- [ ] **Step 1: pure formatterの失敗testを書く**

```dart
test('arrival text distinguishes future, arrived, and unknown', () {
  expect(formatEewWarningOverlayArrival(
    state: EewWarningArrivalState.unarrived,
    secondsUntilArrival: 10,
  ), 'あと約10秒');
  expect(formatEewWarningOverlayArrival(
    state: EewWarningArrivalState.arrived,
    secondsUntilArrival: null,
  ), '到達と推定');
  expect(formatEewWarningOverlayArrival(
    state: EewWarningArrivalState.unknown,
    secondsUntilArrival: null,
  ), isNull);
});
```

- [ ] **Step 2: test失敗を確認し、formatterを実装する**

Run: `cd app && mise exec -- flutter test test/feature/eew/ui/formatter/eew_warning_overlay_arrival_formatter_test.dart`

Expected: FAIL（formatter未定義）。`unarrived`かつ秒数ありなら「あと約N秒」、`arrived`なら「到達と推定」、`unknown`ならnullを返す実装を追加する。到達判定と秒数計算はPlan 1が所有し、UIで再計算しない。

- [ ] **Step 3: Widgetを実装する（Widget testは書かない）**

全画面は`Positioned.fill`相当の不透明Material、status bar領域まで続く警告背景、`WarningStripeDecoration(colors: [Colors.red, Colors.black], height: 10)`、SafeArea内の`Column`で構成する。本文は`Expanded(child: ListView(...))`、下部は固定の「最小化」「閉じる」。2行見出し、現在地予想震度、到達文言、現在地域、震源、M、深さ、複数件表示以外の安全行動文は追加しない。

バナーは上端固定、警報ラベル・短い見出し・震度・到達情報・閉じるiconを表示する。外側`InkWell`は展開、閉じるbuttonは`close()`だけを呼び、tapを展開へ伝播させない。テキスト領域には固定高を指定せず、通常の折返しを許す。

- [ ] **Step 4: formatter testと静的解析を通す**

Run: `cd app && mise exec -- flutter test test/feature/eew/ui/formatter/eew_warning_overlay_arrival_formatter_test.dart`

Run: `cd app && mise exec -- dart analyze lib/feature/eew/ui test/feature/eew/ui/formatter/eew_warning_overlay_arrival_formatter_test.dart`

Expected: PASS、diagnosticなし。

- [ ] **Step 5: commitする**

```bash
git add app/lib/feature/eew/ui app/test/feature/eew/ui/formatter/eew_warning_overlay_arrival_formatter_test.dart
git commit -m "feat: EEW警報overlayの全画面とバナーを追加"
```

---

### Task 4: root hostと通常設定画面を接続する

**Files:**
- Create: `app/lib/feature/eew/ui/components/eew_warning_overlay_host.dart`
- Modify: `app/lib/app.dart:26-32`
- Modify: `app/lib/feature/settings/settings_page.dart:55-90`

**Interfaces:**
- Consumes: Plan 1のeffective display/simulation/enabled provider、Task 2のnotifier、Task 3のWidget
- Produces: route非依存のroot overlayと通常設定画面のtoggle・固定simulation action

- [ ] **Step 1: root hostを実装する**

hostはnotifier stateと`appLifecycleProvider`をwatchし、非resumed時またはhiddenならchildだけを返す。resumed時は`Stack(fit: StackFit.expand, children: [child, overlay])`でfullscreenなら全画面、minimizedなら`Align(alignment: Alignment.topCenter)`のbannerを描画する。表示内容はdisplay modelの`arrivalState`と`secondsUntilArrival`をformatterへ渡す。

`PopScope(canPop: state.mode != EewWarningOverlayMode.fullscreen)`を使い、`onPopInvokedWithResult`で未popかつfullscreenなら`minimize()`する。hidden/minimized時は既存routeのbackを妨げない。

- [ ] **Step 2: `MaterialApp.router.builder`へhostを接続する**

```dart
builder: (context, child) => EewWarningOverlayHost(
  child: DebugLauncher(child: child ?? const SizedBox.shrink()),
),
```

- [ ] **Step 3: 通常設定画面へtoggleとsimulationを追加する**

「各種設定」内へ次を追加する。async設定の読み込み中は既定`true`を表示し、toggle保存は`set(value:)`をawaitする。simulationはtoggle値に関係なく実行可能とする。

```dart
AppSwitchListTile(
  title: 'アプリ使用中の緊急地震速報警報',
  subtitle: '現在地が警報対象になった時に全画面で知らせます',
  value: ref.watch(eewWarningOverlayEnabledProvider).value ?? true,
  onChanged: (value) async => ref
      .read(eewWarningOverlayEnabledProvider.notifier)
      .set(value: value),
),
ListTile(
  leading: const Icon(Icons.play_arrow),
  title: const Text('警報画面をシミュレーション'),
  subtitle: const Text('固定の訓練データで表示と振動を確認します'),
  onTap: () => ref
      .read(eewWarningOverlaySimulationProvider.notifier)
      .start(),
),
```

- [ ] **Step 4: codegen・format・解析を行う**

Run: `cd app && mise exec -- dart run build_runner build --delete-conflicting-outputs`

Run: `cd app && mise exec -- dart format lib/app.dart lib/feature/eew lib/feature/settings/settings_page.dart test/feature/eew`

Run: `cd app && mise exec -- dart analyze lib/app.dart lib/feature/eew lib/feature/settings/settings_page.dart test/feature/eew`

Expected: diagnosticなし。Widget testは実行・追加しない。

- [ ] **Step 5: commitする**

```bash
git add app/lib/app.dart app/lib/feature/eew app/lib/feature/settings/settings_page.dart app/test/feature/eew
git commit -m "feat: EEW警報overlayをアプリと設定へ統合"
```

---

### Task 5: 集中回帰検証と実機・simulation確認

**Files:**
- Verify: `app/lib/feature/eew/**`
- Verify: `app/test/feature/eew/**`
- Verify: `app/lib/app.dart`
- Verify: `app/lib/feature/settings/settings_page.dart`

**Interfaces:**
- Consumes: Plan 1・Plan 2の全成果物
- Produces: 自動検証結果と手動受け入れチェック結果

- [ ] **Step 1: focused testをまとめて実行する**

Run: `cd app && mise exec -- flutter test test/feature/eew`

Run: `cd app && mise exec -- flutter test test/feature/settings/features/notification_settings/notification_preset_notifier_test.dart`

Expected: 全件PASS。

- [ ] **Step 2: focused analyzeとdiff検査を行う**

Run: `cd app && mise exec -- dart analyze lib/app.dart lib/feature/eew lib/feature/settings/settings_page.dart test/feature/eew`

Run: `git diff --check`

Expected: diagnostic・whitespace errorなし。

- [ ] **Step 3: 通常設定画面の固定simulationで手動確認する**

Light/Dark、portrait/landscape、text scale 100%/200%、長い警報地域の折返し、SafeArea外の赤黒ストライプ、本文scrollと固定button、Android back最小化、banner再展開後に10秒で再最小化しないこと、closeを確認する。

- [ ] **Step 4: 振動と状態遷移を実機確認する**

700ms/300ms pulse、10秒停止、手動最小化・close・backgroundでの即時停止、再展開で再振動しないこと、設定無効でもsimulation可能なこと、OS振動無効でもUIが継続することを確認する。実警報fixtureをprovider overrideで投入できる開発環境では、simulation中の実警報優先と、同一eventId非再通知も確認する。

- [ ] **Step 5: 最終差分を確認する**

Run: `git --no-pager status --short`

Run: `git --no-pager diff --stat HEAD~4..HEAD`

Expected: 4つの実装commitが存在し、既存の無関係なdirty差分を含めていない。検証だけの空commitは作成しない。
