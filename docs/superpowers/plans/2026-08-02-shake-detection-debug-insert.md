# 揺れ検知デバッグ挿入 Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** デバッグ画面からプリセット揺れ検知を挿入し、ホーム地図グリッドとカードに本番イベントとマージして表示する。

**Architecture:** `ShakeDetectionDebugOverlay`（keepAlive）にデバッグイベントを保持し、`shakeDetectionVisibleProvider` で本番フィルタ結果と結合する。AcceptedSnapshot には書き込まない。

**Tech Stack:** Flutter / Riverpod 3 / go_router_builder / eqmonitor_api Points

**Spec:** `docs/superpowers/specs/2026-08-02-shake-detection-debug-insert-design.md`

## Global Constraints

- 単体テストは追加しない
- SnackBar 案内は出さない
- 履歴・通知・カスタム入力はスコープ外
- Flutter / Dart コマンドは `mise exec --` 経由
- 生成ファイル（`.g.dart`）は直接編集しない。`build_runner` 後は `git status` で誤削除がないか確認する
- コミットはユーザー指示があるまで行わない

## File Structure

| File | Role |
|------|------|
| `app/lib/feature/shake_detection/data/logic/shake_detection_debug_preset_factory.dart` | プリセット ID・表示名・イベント生成 |
| `app/lib/feature/shake_detection/data/notifier/shake_detection_debug_overlay.dart` (+ `.g.dart`) | デバッグイベント一覧 Notifier |
| `app/lib/feature/shake_detection/data/provider/shake_detection_merge_provider.dart` | 本番 + デバッグ結合 |
| `app/lib/feature/settings/children/config/debug/shake_detection/debug_shake_detection_insert_page.dart` | 挿入 UI |
| `app/lib/core/router/router.dart` (+ `.g.dart`) | ルート追加 |
| `app/lib/feature/settings/children/config/debug/debug_page.dart` | メニュー追加 |

---

### Task 1: プリセット Factory

**Files:**
- Create: `app/lib/feature/shake_detection/data/logic/shake_detection_debug_preset_factory.dart`

**Interfaces:**
- Produces:
  - `enum ShakeDetectionDebugPresetId { tokyoMultiLevelGrid }`
  - `class ShakeDetectionDebugPresetInfo { id, title, description }`
  - `class ShakeDetectionDebugPresetFactory`
    - `List<ShakeDetectionDebugPresetInfo> get presets`
    - `ShakeDetectionEvent create({required ShakeDetectionDebugPresetId id, required DateTime now})`

- [ ] **Step 1: Factory を実装する**

```dart
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';

enum ShakeDetectionDebugPresetId {
  tokyoMultiLevelGrid,
}

class ShakeDetectionDebugPresetInfo {
  const ShakeDetectionDebugPresetInfo({
    required this.id,
    required this.title,
    required this.description,
  });

  final ShakeDetectionDebugPresetId id;
  final String title;
  final String description;
}

class ShakeDetectionDebugPresetFactory {
  List<ShakeDetectionDebugPresetInfo> get presets => const [
    ShakeDetectionDebugPresetInfo(
      id: ShakeDetectionDebugPresetId.tokyoMultiLevelGrid,
      title: '東京・多レベルグリッド',
      description: '東京付近の複数 0.25° セルに Weaker〜Stronger を配置',
    ),
  ];

  ShakeDetectionEvent create({
    required ShakeDetectionDebugPresetId id,
    required DateTime now,
  }) {
    return switch (id) {
      ShakeDetectionDebugPresetId.tokyoMultiLevelGrid =>
        _tokyoMultiLevelGrid(now: now),
    };
  }

  ShakeDetectionEvent _tokyoMultiLevelGrid({required DateTime now}) {
    // 各点は異なる 0.25° セルに置き、intensity 閾値でレベルが分かれるようにする
    // ≤-1 Weaker, >-1 Weak, >0.5 Medium, >2.5 Strong, >4.5 Stronger
    final pointSpecs = <({double lat, double lng, num intensity})>[
      (lat: 35.55, lng: 139.55, intensity: -2), // Weaker @ 35.50/139.50
      (lat: 35.55, lng: 139.80, intensity: 0), // Weak @ 35.50/139.75
      (lat: 35.80, lng: 139.55, intensity: 1), // Medium @ 35.75/139.50
      (lat: 35.80, lng: 139.80, intensity: 3), // Strong @ 35.75/139.75
      (lat: 36.05, lng: 139.70, intensity: 5), // Stronger @ 36.00/139.50
    ];

    final points = [
      for (final (i, spec) in pointSpecs.indexed)
        Points(
          code: 'DEBUG-TKY-$i',
          name: 'Debug Tokyo $i',
          region: '東京都',
          type: 'K',
          location: Location(latitude: spec.lat, longitude: spec.lng),
          intensity: spec.intensity,
        ),
    ];

    final lats = [for (final p in points) p.location.latitude.toDouble()];
    final lngs = [for (final p in points) p.location.longitude.toDouble()];
    final minLat = lats.reduce((a, b) => a < b ? a : b);
    final maxLat = lats.reduce((a, b) => a > b ? a : b);
    final minLng = lngs.reduce((a, b) => a < b ? a : b);
    final maxLng = lngs.reduce((a, b) => a > b ? a : b);

    return ShakeDetectionEvent(
      eventId:
          'debug-shake-tokyoMultiLevelGrid-${now.toUtc().millisecondsSinceEpoch}',
      serialNo: 1,
      createdAt: now.toUtc(),
      updatedAt: now.toUtc(),
      expiresAt: now.toUtc().add(const Duration(days: 365 * 100)),
      level: ShakeDetectionLevel.stronger,
      pointCount: points.length,
      minLat: minLat,
      maxLat: maxLat,
      minLng: minLng,
      maxLng: maxLng,
      changeReasons: const ['new_event'],
      points: points,
    );
  }
}
```

- [ ] **Step 2: analyze**

Run: `cd app && mise exec -- dart analyze lib/feature/shake_detection/data/logic/shake_detection_debug_preset_factory.dart`  
Expected: No issues found

---

### Task 2: Debug Overlay Notifier

**Files:**
- Create: `app/lib/feature/shake_detection/data/notifier/shake_detection_debug_overlay.dart`
- Generate: `app/lib/feature/shake_detection/data/notifier/shake_detection_debug_overlay.g.dart`

**Interfaces:**
- Consumes: `ShakeDetectionDebugPresetFactory`, `ShakeDetectionDebugPresetId`, `appClockProvider`
- Produces:
  - `ShakeDetectionDebugOverlay` notifier
  - `void insertPreset({required ShakeDetectionDebugPresetId id})`
  - `void clear()`
  - state: `List<ShakeDetectionEvent>`

- [ ] **Step 1: Notifier を実装する**

```dart
import 'package:eqmonitor/core/provider/clock/app_clock.dart';
import 'package:eqmonitor/feature/shake_detection/data/logic/shake_detection_debug_preset_factory.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shake_detection_debug_overlay.g.dart';

@Riverpod(keepAlive: true)
class ShakeDetectionDebugOverlay extends _$ShakeDetectionDebugOverlay {
  final _factory = ShakeDetectionDebugPresetFactory();

  @override
  List<ShakeDetectionEvent> build() => const [];

  void insertPreset({required ShakeDetectionDebugPresetId id}) {
    final now = ref.read(appClockProvider.notifier).now();
    final event = _factory.create(id: id, now: now);
    state = [...state, event];
  }

  void clear() {
    state = const [];
  }
}
```

- [ ] **Step 2: build_runner（誤削除に注意）**

```bash
cd app
mise exec -- dart run build_runner build --build-filter="lib/feature/shake_detection/data/notifier/*"
git status --short | awk '/^ D/{print}' | wc -l
# もし Deleted > 0 なら:
# git status --short | awk '/^ D/{print $2}' | xargs git checkout --
```

Expected: `.g.dart` が生成され、無関係な `D` がない

---

### Task 3: visible provider でマージ

**Files:**
- Modify: `app/lib/feature/shake_detection/data/provider/shake_detection_merge_provider.dart`

**Interfaces:**
- Consumes: `shakeDetectionProvider`, `shakeDetectionDebugOverlayProvider`
- Produces: `List<ShakeDetectionEvent>`（本番フィルタ + デバッグ全件）

- [ ] **Step 1: マージを追加する**

`shakeDetectionVisible` を次の形に置き換える:

```dart
@Riverpod(keepAlive: true)
List<ShakeDetectionEvent> shakeDetectionVisible(Ref ref) {
  final tickerTime = ref.watch(timeTickerProvider());
  final now = (tickerTime.value ?? ref.read(appClockProvider.notifier).now())
      .toUtc();

  final live = ref
      .watch(shakeDetectionProvider)
      .where(
        (event) =>
            event.correlatedEewEventId == null &&
            event.expiresAt.toUtc().isAfter(now),
      );

  final debug = ref.watch(shakeDetectionDebugOverlayProvider);

  return [...live, ...debug];
}
```

import に追加:

```dart
import 'package:eqmonitor/feature/shake_detection/data/notifier/shake_detection_debug_overlay.dart';
```

- [ ] **Step 2: analyze**

Run: `cd app && mise exec -- dart analyze lib/feature/shake_detection/data/provider/shake_detection_merge_provider.dart`  
Expected: No issues found

---

### Task 4: デバッグ挿入 UI + ルート

**Files:**
- Create: `app/lib/feature/settings/children/config/debug/shake_detection/debug_shake_detection_insert_page.dart`
- Modify: `app/lib/core/router/router.dart`（TypedGoRoute + Route クラス）
- Modify: `app/lib/feature/settings/children/config/debug/debug_page.dart`（ListTile）
- Generate: `app/lib/core/router/router.g.dart`

**Interfaces:**
- Consumes: `shakeDetectionDebugOverlayProvider`, `ShakeDetectionDebugPresetFactory`

- [ ] **Step 1: ページを作成する**

```dart
import 'package:eqmonitor/feature/shake_detection/data/logic/shake_detection_debug_preset_factory.dart';
import 'package:eqmonitor/feature/shake_detection/data/notifier/shake_detection_debug_overlay.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DebugShakeDetectionInsertPage extends ConsumerWidget {
  const DebugShakeDetectionInsertPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final overlay = ref.watch(shakeDetectionDebugOverlayProvider);
    final presets = const ShakeDetectionDebugPresetFactory().presets;

    return Scaffold(
      appBar: AppBar(title: const Text('揺れ検知を挿入')),
      body: ListView(
        children: [
          ListTile(
            title: Text('デバッグイベント: ${overlay.length} 件'),
            subtitle: const Text('ホーム地図・カードに本番データとマージして表示'),
          ),
          for (final preset in presets)
            ListTile(
              title: Text(preset.title),
              subtitle: Text(preset.description),
              trailing: const Icon(Icons.add),
              onTap: () {
                ref
                    .read(shakeDetectionDebugOverlayProvider.notifier)
                    .insertPreset(id: preset.id);
              },
            ),
          const Divider(),
          ListTile(
            title: const Text('すべてクリア'),
            leading: const Icon(Icons.clear_all),
            enabled: overlay.isNotEmpty,
            onTap: overlay.isEmpty
                ? null
                : () {
                    ref
                        .read(shakeDetectionDebugOverlayProvider.notifier)
                        .clear();
                  },
          ),
        ],
      ),
    );
  }
}
```

SnackBar は出さない。

- [ ] **Step 2: ルートを追加する**

`router.dart` の debug 配下に、`DebugShakeDetectionCardRoute` の隣へ:

```dart
TypedGoRoute<DebugShakeDetectionInsertRoute>(
  path: 'shake-detection-insert',
),
```

import:

```dart
import 'package:eqmonitor/feature/settings/children/config/debug/shake_detection/debug_shake_detection_insert_page.dart';
```

Route クラス（Card の直後）:

```dart
class DebugShakeDetectionInsertRoute extends GoRouteData
    with $DebugShakeDetectionInsertRoute {
  const DebugShakeDetectionInsertRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DebugShakeDetectionInsertPage();
  }
}
```

- [ ] **Step 3: debug_page にメニューを追加する**

「揺れ検知 Card」の ListTile の直後に:

```dart
ListTile(
  title: const Text('揺れ検知を挿入'),
  subtitle: Text(
    'プリセットをホーム地図・カードへマージ表示',
    style: Theme.of(context).textTheme.bodySmall,
  ),
  leading: const Icon(Icons.add_location_alt_outlined),
  onTap: () async =>
      const DebugShakeDetectionInsertRoute().push(context),
),
```

- [ ] **Step 4: router を再生成する**

```bash
cd app
mise exec -- dart run build_runner build --build-filter="lib/core/router/*"
# Deleted が出たら checkout で復元
```

- [ ] **Step 5: analyze**

Run:

```bash
cd app && mise exec -- dart analyze \
  lib/feature/settings/children/config/debug/shake_detection/debug_shake_detection_insert_page.dart \
  lib/feature/settings/children/config/debug/debug_page.dart \
  lib/core/router/router.dart \
  lib/feature/shake_detection/
```

Expected: No issues found

---

### Task 5: 手動確認

- [ ] **Step 1: アプリで確認**

1. 設定 → デバッグ → 揺れ検知を挿入
2. 「東京・多レベルグリッド」をタップ
3. ホームへ戻り、地図に複数色の 0.25° グリッドが出ること
4. シートに揺れ検知カードが出ること
5. 「すべてクリア」で地図・カードからデバッグ分が消えること

---

## Spec coverage (self-review)

| Spec 要件 | Task |
|-----------|------|
| Overlay Notifier insert/clear | Task 2 |
| プリセット tokyoMultiLevelGrid + points | Task 1 |
| visible でマージ・デバッグは期限無視 | Task 3 |
| デバッグ UI・クリア・SnackBar なし | Task 4 |
| ルート / メニュー | Task 4 |
| 地図＋カード（既存 visible 経由） | Task 3（配線不要） |
| テストなし | Global Constraints |
| 履歴・通知なし | 非スコープ |
