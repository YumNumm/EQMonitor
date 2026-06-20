# 津波APIクライアント正常化 実装計画

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 津波機能のAPIクライアントを最新バックエンドOpenAPI仕様から再生成し、破壊的変更（`earthquake` → `earthquakes` 配列）をUI全体に反映する。

**Architecture:** バックエンドは最新で `TsunamiState`（サーバーサイドマージ済み）を `/v2/tsunami/{tsunamiId}` から直接返す。issueで述べられていたクライアントサイドマージは不要。主な変更点は (1) APIクライアント再生成、(2) `earthquake`（nullable単体）→ `earthquakes`（required配列）へのUI対応、(3) contract drift test の修正、(4) ポーリング改善。

**Tech Stack:** Dart/Flutter, Freezed, Retrofit, swagger_parser, Riverpod

## Global Constraints

- `dart analyze` がクリーン（警告なし）であること
- `dart format` 準拠
- 既存の Riverpod / Freezed パターンに従う
- バックエンドは変更しない

---

### Task 1: API クライアント再生成

**Files:**
- Modify: `packages/eqmonitor_api/` (全体が再生成される)
- Key output: `packages/eqmonitor_api/lib/src/models/tsunami_state.dart` (earthquake → earthquakes)
- Key output: `packages/eqmonitor_api/lib/src/clients/tsunami_api_client.dart`
- Key output: `packages/eqmonitor_api/test/fixtures/contract/` (fixturesが更新)

**Interfaces:**
- Produces: `TsunamiState` with `earthquakes: List<TsunamiStateEarthquake>` (was `earthquake: TsunamiStateEarthquake?`)
- Produces: Updated contract fixtures matching backend spec

- [ ] **Step 1: generate.dart を実行してAPIクライアントを再生成**

```bash
cd packages/eqmonitor_api && dart run bin/generate.dart
```

Expected: OpenAPIスペックコピー → swagger_parser → パッチ → build_runner → fixtures コピー が順に成功。

- [ ] **Step 2: 再生成後の TsunamiState を確認**

```bash
grep -n 'earthquakes' packages/eqmonitor_api/lib/src/models/tsunami_state.dart
```

Expected: `required List<TsunamiStateEarthquake> earthquakes` が含まれている。`earthquake` (singular) は存在しない。

- [ ] **Step 3: コンパイルチェック**

```bash
cd packages/eqmonitor_api && dart analyze
```

Expected: eqmonitor_api パッケージ単体はエラーなし。app 側はまだ壊れている（Task 2 で修正）。

- [ ] **Step 4: コミット**

```bash
git add packages/eqmonitor_api/
git commit -m "chore(eqmonitor_api): regenerate from latest backend OpenAPI spec

- earthquake (nullable) → earthquakes (required array)
- contract fixtures updated
- latest_telegrams added to fixtures"
```

---

### Task 2: UI を earthquakes 配列に対応

**Files:**
- Modify: `app/lib/feature/tsunami/ui/tsunami_details_page.dart:55-65`
- Modify: `app/lib/feature/tsunami/ui/components/tsunami_earthquake_card.dart:7-11`
- Modify: `app/lib/feature/tsunami/ui/components/tsunami_details_map_view.dart:122,141,382,456`

**Interfaces:**
- Consumes: `TsunamiState.earthquakes: List<TsunamiStateEarthquake>` (from Task 1)
- Produces: UI コンポーネントがコンパイル可能・正常表示

- [ ] **Step 1: tsunami_details_page.dart を修正**

`tsunami.earthquake` → `tsunami.earthquakes` の配列に対応。地震が複数ある場合は全て表示する。

```dart
// Before (line 61-65):
if (tsunami.earthquake != null)
  TsunamiEarthquakeCard(
    earthquake: tsunami.earthquake!,
    eventIds: tsunami.eventIds,
  ),

// After:
for (final earthquake in tsunami.earthquakes)
  TsunamiEarthquakeCard(
    earthquake: earthquake,
    eventIds: tsunami.eventIds,
  ),
```

- [ ] **Step 2: tsunami_details_map_view.dart を修正**

震源座標の取得を `earthquakes.firstOrNull` に変更。4箇所すべて修正。

```dart
// _initialCenter() (line 122):
// Before:
final coords = tsunami.earthquake?.hypocenter.coordinates;
// After:
final coords = tsunami.earthquakes.firstOrNull?.hypocenter.coordinates;

// _fitBounds() (line 141):
// Before:
final coords = tsunami.earthquake?.hypocenter.coordinates;
// After:
final coords = tsunami.earthquakes.firstOrNull?.hypocenter.coordinates;

// _TsunamiHypocenterLayer build() (line 382):
// Before:
final coords = tsunami.earthquake?.hypocenter.coordinates;
// After:
final coords = tsunami.earthquakes.firstOrNull?.hypocenter.coordinates;

// useEffect deps (line 456):
// Before:
[styleController, tsunami.earthquake],
// After:
[styleController, tsunami.earthquakes],
```

- [ ] **Step 3: app のコンパイルチェック**

```bash
cd app && dart analyze
```

Expected: tsunami 関連のエラーが全て解消。

- [ ] **Step 4: コミット**

```bash
git add app/lib/feature/tsunami/
git commit -m "fix(tsunami): adapt UI to earthquakes array field

Backend now returns earthquakes as a required array instead of
a nullable single object. Update all references across map view,
details page, and earthquake card."
```

---

### Task 3: Contract drift test の修正

**Files:**
- Modify: `packages/eqmonitor_api/test/contract_drift_test.dart:45-46`

**Interfaces:**
- Consumes: 再生成されたモデル（`TsunamiState` が `/v2/tsunami/:tsunamiId` のレスポンス型）

- [ ] **Step 1: パーサーマッピングを確認・更新**

再生成後、`TsunamiDetailResponse` が存在しなくなった場合、`TsunamiState` に変更する必要がある。
再生成後にモデルの存在を確認:

```bash
grep -r 'class TsunamiDetailResponse' packages/eqmonitor_api/lib/src/
```

もし存在しなければ、contract_drift_test.dart を修正:

```dart
// Before:
'GET /v2/tsunami/by-event-id/:eventId': TsunamiDetailResponse.fromJson,
'GET /v2/tsunami/:tsunamiId': TsunamiDetailResponse.fromJson,

// After:
'GET /v2/tsunami/by-event-id/:eventId': TsunamiState.fromJson,
'GET /v2/tsunami/:tsunamiId': TsunamiState.fromJson,
```

- [ ] **Step 2: contract drift test 実行**

```bash
cd packages/eqmonitor_api && dart test test/contract_drift_test.dart
```

Expected: quarantine 以外の tsunami fixture テストがすべて PASS。

- [ ] **Step 3: コミット**

```bash
git add packages/eqmonitor_api/test/contract_drift_test.dart
git commit -m "fix(eqmonitor_api): update contract drift test for TsunamiState

Replace TsunamiDetailResponse with TsunamiState in parser mapping
to match the current OpenAPI spec."
```

---

### Task 4: ポーリング改善

**Files:**
- Modify: `app/lib/feature/tsunami/data/notifier/tsunami_details_notifier.dart`

**Interfaces:**
- Consumes: `TsunamiState.isActive: bool`

- [ ] **Step 1: テスト方針決定**

ポーリングの改善は以下の2点:
1. `isActive` が `false` の場合、ポーリングを停止
2. `invalidateSelf()` の代わりに `AsyncValue.guard` で差分更新（画面フラッシュ防止）

- [ ] **Step 2: notifier を修正**

```dart
@riverpod
class TsunamiDetailsNotifier extends _$TsunamiDetailsNotifier {
  Timer? _refreshTimer;

  @override
  Future<TsunamiState> build(String tsunamiId) async {
    ref.onDispose(() => _refreshTimer?.cancel());
    final result = await _fetch();
    if (result.isActive) {
      _startPolling();
    }
    return result;
  }

  Future<TsunamiState> _fetch() async {
    final client = await ref.read(apiClientProvider.future);
    final response = await client.tsunami.getV2TsunamiTsunamiId(
      tsunamiId: tsunamiId,
    );
    return response.data;
  }

  void _startPolling() {
    _refreshTimer?.cancel();
    _refreshTimer = Timer.periodic(
      const Duration(seconds: 30),
      (_) async {
        state = await AsyncValue.guard(() => _fetch());
        if (state case AsyncData(value: final tsunami) when !tsunami.isActive) {
          _refreshTimer?.cancel();
        }
      },
    );
  }
}
```

- [ ] **Step 3: build_runner で .g.dart を再生成**

```bash
cd app && dart run build_runner build --delete-conflicting-outputs --build-filter="lib/feature/tsunami/**"
```

- [ ] **Step 4: analyze**

```bash
cd app && dart analyze lib/feature/tsunami/
```

Expected: エラーなし。

- [ ] **Step 5: コミット**

```bash
git add app/lib/feature/tsunami/data/
git commit -m "fix(tsunami): stop polling for inactive events

Only poll every 30s when tsunami is active. Use AsyncValue.guard
instead of invalidateSelf to avoid full-screen loading flash on
each refresh."
```

---

### Task 5: 全体検証

- [ ] **Step 1: melos run analyze**

```bash
melos run analyze
```

Expected: 全パッケージでエラーなし。

- [ ] **Step 2: melos run test:dart**

```bash
melos run test:dart
```

Expected: contract drift test を含むすべてのテストが PASS。

- [ ] **Step 3: 最終コミット（必要に応じて）**

lint 修正などが必要な場合のみ。
