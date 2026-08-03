# EEW地図フォーカス Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** HomeMap で最新生存 EEW 1件＋相関揺れ検知の累積 0.5° 矩形へ自動フォーカスし、ユーザー操作で解除・ホームボタンで再フォーカスできるようにする。

**Architecture:** 純ロジック（BoundsBuilder / Transition）で状態遷移と更新要否を判定し、`EewMapFocus` Notifier が状態を保持。`HomeMapCameraCoordinator` は EEW あり時にその判定結果だけを fit する。ジェスチャは `apiGesture` でフォーカス解除、ホームボタンは `isFocused` で無効化。

**Tech Stack:** Flutter / Riverpod 3 / Freezed / MapLibre / `mise exec --`

**Spec:** `docs/superpowers/specs/2026-08-02-eew-map-focus-design.md`

## Global Constraints

- maxZoom は既存 `mapAutomaticFocusMaxZoom`（8.0）を利用する（二重定義しない）
- 表示用揺れ検知グリッド（0.25°）は変更しない。カメラ用は 0.5°
- LiveMonitor はスコープ外
- EEW なし＋未紐付け揺れ検知のみは既存 `SeismicMapFocusBuilder` 経路を維持
- Flutter / Dart コマンドは `mise exec --` 経由
- 生成ファイル（`.g.dart` / `.freezed.dart`）は直接編集しない
- top-level / クラス内プライベートメソッドでロジックを書かない（専用クラスへ）
- `!` 禁止。名前付き引数。`dynamic` 禁止
- コミットはユーザー指示があるまで行わない

## File Structure

| File | Role |
|------|------|
| `app/lib/feature/home/data/model/eew_map_focus_grid_rect.dart` | 0.5° 累積矩形モデル |
| `app/lib/feature/home/data/model/eew_map_focus_state.dart` (+ freezed) | フォーカス状態 |
| `app/lib/feature/home/data/logic/eew_map_focus_bounds_builder.dart` (+ `.g.dart`) | スナップ・union・bounds |
| `app/lib/feature/home/data/logic/eew_map_focus_transition.dart` (+ `.g.dart`) | 純ロジックの状態遷移・shouldFit |
| `app/lib/feature/home/data/notifier/eew_map_focus.dart` (+ `.g.dart`) | Riverpod 状態保持 |
| `app/lib/feature/home/data/service/home_map_camera_coordinator.dart` | EEW 単体 fit / 再フォーカス |
| `app/lib/feature/home/data/provider/map_camera_state_provider.dart` | listen・配線 |
| `app/lib/feature/map/ui/maplibre_event_provider.dart` | ジェスチャ転送（任意拡張） |
| `app/lib/feature/home/ui/component/map/home_map_view.dart` | ジェスチャ解除・ボタン enabled |
| `app/lib/feature/home/ui/component/map/home_map_controller_card.dart` | ホームボタン enabled |
| `app/test/feature/home/data/logic/eew_map_focus_bounds_builder_test.dart` | Builder テスト |
| `app/test/feature/home/data/logic/eew_map_focus_transition_test.dart` | 遷移テスト |
| `app/test/feature/home/data/service/home_map_camera_coordinator_test.dart` | Coordinator 更新 |

---

### Task 1: 0.5° BoundsBuilder（純ロジック）

**Files:**
- Create: `app/lib/feature/home/data/model/eew_map_focus_grid_rect.dart`
- Create: `app/lib/feature/home/data/logic/eew_map_focus_bounds_builder.dart`
- Create: `app/test/feature/home/data/logic/eew_map_focus_bounds_builder_test.dart`

**Interfaces:**
- Produces:
  - `class EewMapFocusGridRect { minLat, maxLat, minLng, maxLng }`（`==` / `hashCode` 実装）
  - `class EewMapFocusBoundsBuilder`
    - `static const step = 0.5`
    - `EewMapFocusGridRect snapOutward({required double minLat, required double maxLat, required double minLng, required double maxLng})`
    - `EewMapFocusGridRect union({required EewMapFocusGridRect a, required EewMapFocusGridRect b})`
    - `EewMapFocusGridRect? mergeShakeEvents({required List<ShakeDetectionEvent> shakes})`
    - `LngLatBounds? boundsForFocus({required ({double latitude, double longitude})? hypocenter, required EewMapFocusGridRect? shakeRect, required LngLatBounds fallbackBounds})`  
      ※ 震源も矩形も無いときは `null`（caller がカメラ更新をスキップ）
    - 既存 `seismicMapFocusMargin`（0.1）を bounds に付与

- [ ] **Step 1: 失敗するテストを書く**

```dart
import 'package:eqmonitor/feature/home/data/logic/eew_map_focus_bounds_builder.dart';
import 'package:eqmonitor/feature/home/data/model/eew_map_focus_grid_rect.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' show ShakeDetectionLevel;
import 'package:maplibre/maplibre.dart';
import 'package:test/test.dart';

void main() {
  const builder = EewMapFocusBoundsBuilder();

  test('0.5度に外向きスナップする', () {
    final rect = builder.snapOutward(
      minLat: 35.1,
      maxLat: 35.6,
      minLng: 139.1,
      maxLng: 139.6,
    );
    expect(rect, const EewMapFocusGridRect(
      minLat: 35.0,
      maxLat: 36.0,
      minLng: 139.0,
      maxLng: 140.0,
    ));
  });

  test('unionは拡大のみで縮小しない', () {
    const a = EewMapFocusGridRect(
      minLat: 35.0,
      maxLat: 36.0,
      minLng: 139.0,
      maxLng: 140.0,
    );
    const b = EewMapFocusGridRect(
      minLat: 35.5,
      maxLat: 35.5,
      minLng: 138.5,
      maxLng: 139.5,
    );
    expect(
      builder.union(a: a, b: b),
      const EewMapFocusGridRect(
        minLat: 35.0,
        maxLat: 36.0,
        minLng: 138.5,
        maxLng: 140.0,
      ),
    );
  });

  test('複数揺れ検知をスナップしてunionする', () {
    final now = DateTime.utc(2026, 8, 2);
    final rect = builder.mergeShakeEvents(
      shakes: [
        ShakeDetectionEvent(
          eventId: 's1',
          serialNo: 1,
          createdAt: now,
          updatedAt: now,
          expiresAt: now.add(const Duration(hours: 1)),
          level: ShakeDetectionLevel.medium,
          pointCount: 1,
          minLat: 35.1,
          maxLat: 35.2,
          minLng: 139.1,
          maxLng: 139.2,
          changeReasons: const [],
        ),
        ShakeDetectionEvent(
          eventId: 's2',
          serialNo: 1,
          createdAt: now,
          updatedAt: now,
          expiresAt: now.add(const Duration(hours: 1)),
          level: ShakeDetectionLevel.strong,
          pointCount: 1,
          minLat: 35.7,
          maxLat: 35.8,
          minLng: 139.7,
          maxLng: 139.8,
          changeReasons: const [],
        ),
      ],
    );
    expect(
      rect,
      const EewMapFocusGridRect(
        minLat: 35.0,
        maxLat: 36.0,
        minLng: 139.0,
        maxLng: 140.0,
      ),
    );
  });

  test('震源のみなら震源周辺boundsを返す', () {
    final bounds = builder.boundsForFocus(
      hypocenter: (latitude: 35.5, longitude: 139.5),
      shakeRect: null,
      fallbackBounds: const LngLatBounds(
        longitudeWest: 120,
        longitudeEast: 150,
        latitudeSouth: 20,
        latitudeNorth: 50,
      ),
    );
    expect(bounds, isNotNull);
    expect(bounds!.latitudeSouth, lessThan(35.5));
    expect(bounds.latitudeNorth, greaterThan(35.5));
  });

  test('震源も矩形も無いときはnull', () {
    final bounds = builder.boundsForFocus(
      hypocenter: null,
      shakeRect: null,
      fallbackBounds: const LngLatBounds(
        longitudeWest: 120,
        longitudeEast: 150,
        latitudeSouth: 20,
        latitudeNorth: 50,
      ),
    );
    expect(bounds, isNull);
  });
}
```

- [ ] **Step 2: テスト実行して失敗を確認**

Run: `mise exec -- flutter test app/test/feature/home/data/logic/eew_map_focus_bounds_builder_test.dart`  
（cwd: リポジトリルート、または `app/` から相対パスを合わせて実行）  
Expected: FAIL（クラス未定義）

- [ ] **Step 3: モデルと Builder を実装する**

`eew_map_focus_grid_rect.dart`:

```dart
class EewMapFocusGridRect {
  const EewMapFocusGridRect({
    required this.minLat,
    required this.maxLat,
    required this.minLng,
    required this.maxLng,
  });

  final double minLat;
  final double maxLat;
  final double minLng;
  final double maxLng;

  @override
  bool operator ==(Object other) =>
      other is EewMapFocusGridRect &&
      other.minLat == minLat &&
      other.maxLat == maxLat &&
      other.minLng == minLng &&
      other.maxLng == maxLng;

  @override
  int get hashCode => Object.hash(minLat, maxLat, minLng, maxLng);
}
```

`eew_map_focus_bounds_builder.dart` 要点:

```dart
@riverpod
EewMapFocusBoundsBuilder eewMapFocusBoundsBuilder(Ref ref) =>
    const EewMapFocusBoundsBuilder();

class EewMapFocusBoundsBuilder {
  const EewMapFocusBoundsBuilder();

  static const step = 0.5;

  EewMapFocusGridRect snapOutward({
    required double minLat,
    required double maxLat,
    required double minLng,
    required double maxLng,
  }) {
    // floor(min/step)*step, ceil(max/step)*step
  }

  EewMapFocusGridRect union({
    required EewMapFocusGridRect a,
    required EewMapFocusGridRect b,
  }) => EewMapFocusGridRect(
    minLat: a.minLat < b.minLat ? a.minLat : b.minLat,
    maxLat: a.maxLat > b.maxLat ? a.maxLat : b.maxLat,
    minLng: a.minLng < b.minLng ? a.minLng : b.minLng,
    maxLng: a.maxLng > b.maxLng ? a.maxLng : b.maxLng,
  );

  // mergeShakeEvents: 各イベントを snapOutward → fold union
  // boundsForFocus: hypocenter / shakeRect の角を SeismicMapFocusBuilder と同様に margin 付き LngLatBounds へ
}
```

スナップは負の座標でも外向きになるよう `floor`/`ceil` を使う（日本域でも実装を一般化）。

- [ ] **Step 4: build_runner（provider 用）**

Run（`app/`）:

```bash
mise exec -- dart run build_runner build --delete-conflicting-outputs
```

- [ ] **Step 5: テスト成功を確認**

Run: `mise exec -- flutter test test/feature/home/data/logic/eew_map_focus_bounds_builder_test.dart`（cwd: `app/`）  
Expected: PASS

---

### Task 2: Transition（状態遷移・shouldFit）

**Files:**
- Create: `app/lib/feature/home/data/model/eew_map_focus_state.dart`
- Create: `app/lib/feature/home/data/logic/eew_map_focus_transition.dart`
- Create: `app/test/feature/home/data/logic/eew_map_focus_transition_test.dart`

**Interfaces:**
- Consumes: `EewMapFocusBoundsBuilder`, `EewMapFocusGridRect`
- Produces:
  - `@freezed class EewMapFocusState`
    - `String? focusedEventId`
    - `bool isFocused`
    - `({double latitude, double longitude})? focusedHypocenter`
    - `Map<String, EewMapFocusGridRect> shakeBoundsByEventId`
  - `@freezed class EewMapFocusDecision`
    - `EewMapFocusState state`
    - `bool shouldFit`
  - `class EewMapFocusTransition`
    - `EewMapFocusDecision evaluate({required EewMapFocusState previous, required List<EewTelegramItem> aliveEews, required List<ShakeDetectionEvent> allShakes})`
    - `EewMapFocusState clearFocus({required EewMapFocusState previous})` → `isFocused: false`
    - `EewMapFocusDecision refocus({required EewMapFocusState previous, required List<EewTelegramItem> aliveEews, required List<ShakeDetectionEvent> allShakes})` → 最新へ `isFocused: true` + `shouldFit: true`（ターゲット無しなら fit しない）

**evaluate ルール（実装必須）:**

1. 生存 EEW の最新報リストから `reportTime` 最大の `eventId` を `latestEventId` とする
2. 生存 EEW の eventId 集合に無い `shakeBoundsByEventId` entry を捨てる
3. 各生存 EEW について `correlatedEewEventId == eventId` の shakes を `mergeShakeEvents` → 既存矩形と `union`（縮小なし）
4. `latestEventId == null`:
   - state: focused クリア、`isFocused: false`、空 map
   - `shouldFit: false`（ホーム復帰は Coordinator 側）
5. `latestEventId != previous.focusedEventId`（新規 / 切替）:
   - `isFocused: true`、hypocenter を最新の値に更新
   - `shouldFit: true`（bounds が取れる場合のみ。取れなければ false）
6. 同一 `focusedEventId` かつ `isFocused == true`:
   - 震源変化 or 累積矩形変化 → `shouldFit: true` かつ hypocenter/rect を更新
   - 変化なし → `shouldFit: false`
7. 同一 `focusedEventId` かつ `isFocused == false`:
   - 累積矩形は更新するが `shouldFit: false`
   - ※ 新規 EEW が最新になるケースは 5 で扱う

最新報の選び方: `aliveEews` は既に eventId ごとの最新報想定（`eewAliveTelegramProvider`）。同リスト内で `reportTime` が最大の要素を選ぶ。同時刻なら安定のため list 先頭側でもよいが、テストで明示する。

- [ ] **Step 1: Freezed state / decision を定義し generate**

```dart
@freezed
abstract class EewMapFocusState with _$EewMapFocusState {
  const factory EewMapFocusState({
    String? focusedEventId,
    @Default(false) bool isFocused,
    ({double latitude, double longitude})? focusedHypocenter,
    @Default({}) Map<String, EewMapFocusGridRect> shakeBoundsByEventId,
  }) = _EewMapFocusState;
}

@freezed
abstract class EewMapFocusDecision with _$EewMapFocusDecision {
  const factory EewMapFocusDecision({
    required EewMapFocusState state,
    required bool shouldFit,
  }) = _EewMapFocusDecision;
}
```

Record を Freezed に載せるのが難しい場合は `EewMapFocusHypocenter { lat, lng }` の Freezed / 普通クラスに置き換える。

Run: `mise exec -- dart run build_runner build --delete-conflicting-outputs`（cwd: `app/`）

- [ ] **Step 2: 失敗する遷移テストを書く**

最低限カバー:

```dart
test('reportTimeが新しいEEWを最新として選ぶ', () { ... });
test('フォーカス中に震源が変わるとshouldFit=true', () { ... });
test('フォーカス中に0.5度矩形が変わるとshouldFit=true', () { ... });
test('同一グリッド内の揺れ拡大ではshouldFit=false', () { ... });
test('isFocused=falseでは震源変化でもshouldFit=false', () { ... });
test('新しい最新EEWは手動解除後でもisFocused=trueかつshouldFit=true', () { ... });
test('フォーカスEEW消滅で残存最新へ切替', () { ... });
test('全滅でフォーカスクリア・shouldFit=false', () { ... });
test('相関揺れのみ累積し他EEW・未紐付けは含めない', () { ... });
test('clearFocusはisFocusedのみfalse', () { ... });
test('refocusは最新へshouldFit=true', () { ... });
```

ヘルパーで `EewTelegramItem` / `ShakeDetectionEvent` を既存 coordinator テストと同様に生成する。

- [ ] **Step 3: テスト失敗を確認**

Run: `mise exec -- flutter test test/feature/home/data/logic/eew_map_focus_transition_test.dart`  
Expected: FAIL

- [ ] **Step 4: `EewMapFocusTransition` を実装**

```dart
@riverpod
EewMapFocusTransition eewMapFocusTransition(Ref ref) => EewMapFocusTransition(
  boundsBuilder: ref.watch(eewMapFocusBoundsBuilderProvider),
);

class EewMapFocusTransition {
  const EewMapFocusTransition({required this.boundsBuilder});
  final EewMapFocusBoundsBuilder boundsBuilder;

  EewMapFocusDecision evaluate({...}) { ... }
  EewMapFocusState clearFocus({required EewMapFocusState previous}) =>
      previous.copyWith(isFocused: false);
  EewMapFocusDecision refocus({...}) { ... }
}
```

`shouldFit: true` にする前に、フォーカス対象の hypocenter / shakeRect から「fit 可能なターゲットが1点以上あるか」を確認する。無ければ `shouldFit: false`。

- [ ] **Step 5: テスト成功を確認**

Expected: PASS

---

### Task 3: `EewMapFocus` Notifier

**Files:**
- Create: `app/lib/feature/home/data/notifier/eew_map_focus.dart`
- Modify: 必要なら test で ProviderContainer 検証を追加  
  `app/test/feature/home/data/notifier/eew_map_focus_test.dart`

**Interfaces:**
- Consumes: `eewAliveTelegramProvider`, `shakeDetectionProvider`（**visible ではない**。相関込み全件）, `EewMapFocusTransition`
- Produces:
  - `@Riverpod(keepAlive: true) class EewMapFocus`
    - state: `EewMapFocusState`
    - `EewMapFocusDecision sync()` … listen 内から呼ぶ内部更新
    - `void clearFocus()`
    - `EewMapFocusDecision refocus()`
    - 直近の `shouldFit` は state に持たせず、`sync`/`refocus` の戻り値で Coordinator に渡す

- [ ] **Step 1: Notifier を実装**

```dart
@Riverpod(keepAlive: true)
class EewMapFocus extends _$EewMapFocus {
  @override
  EewMapFocusState build() {
    ref.listen(eewAliveTelegramProvider, (_, _) {
      // HomeMapCameraState 側で sync→fit を駆動するため、ここは state 更新のみでもよい。
      // 二重 fit を避けるなら、listen では sync せず、CameraState から sync を呼ぶ。
    });
    return const EewMapFocusState();
  }

  EewMapFocusDecision sync() {
    final decision = ref.read(eewMapFocusTransitionProvider).evaluate(
      previous: state,
      aliveEews: ref.read(eewAliveTelegramProvider) ?? const [],
      allShakes: ref.read(shakeDetectionProvider),
    );
    state = decision.state;
    return decision;
  }

  void clearFocus() {
    state = ref.read(eewMapFocusTransitionProvider).clearFocus(previous: state);
  }

  EewMapFocusDecision refocus() {
    final decision = ref.read(eewMapFocusTransitionProvider).refocus(
      previous: state,
      aliveEews: ref.read(eewAliveTelegramProvider) ?? const [],
      allShakes: ref.read(shakeDetectionProvider),
    );
    state = decision.state;
    return decision;
  }
}
```

**駆動方針（二重 fit 防止）:** `EewMapFocus` は listen で自動 sync しない。`HomeMapCameraState` が EEW / shake の listen で `sync()` → 必要なら fit、と単一経路にする。

- [ ] **Step 2: build_runner**

- [ ] **Step 3: 簡易 Provider テスト（任意だが推奨）**

`clearFocus` 後 `state.isFocused == false`、`refocus` で true に戻ることを `ProviderContainer` で確認。

---

### Task 4: Coordinator / CameraState 配線

**Files:**
- Modify: `app/lib/feature/home/data/service/home_map_camera_coordinator.dart`
- Modify: `app/lib/feature/home/data/provider/map_camera_state_provider.dart`
- Modify: `app/test/feature/home/data/service/home_map_camera_coordinator_test.dart`
- Modify: `app/test/feature/home/data/provider/map_camera_state_provider_test.dart`（あれば）

**Interfaces:**
- Consumes: `EewMapFocusDecision`, `EewMapFocusBoundsBuilder.boundsForFocus`
- Produces:
  - Coordinator に EEW フォーカス専用 API:
    - `Future<bool?> applyEewFocus({required Future<HomeConfigurationModel> home, required LngLatBounds bounds, required int generation})`
  - `handleRealtimeTransition` の分岐:
    1. 生存 EEW あり → `EewMapFocus.sync()` 相当の decision を受け取り、`shouldFit` なら EEW bounds で fit。`isAtHome` 相当は `false`
    2. 生存 EEW なし → 既存どおり未紐付け shakes + `resolveHomeMapCameraUpdateAction`
  - `returnToHome`:
    1. 生存 EEW あり → `refocus` → EEW bounds fit（通常ホームへ行かない）
    2. なし → 既存 `applyHomeFocus`

- [ ] **Step 1: 既存テスト「全EEW＋未結合揺れをまとめて focus」を仕様に合わせて更新**

EEW ありケースは「最新 EEW 震源（＋相関揺れ）」のみが bounds に入ることを assert する。未紐付け揺れは EEW あり時に含めない。

- [ ] **Step 2: `HomeMapCameraState` を更新**

```dart
ref.listen(eewAliveTelegramProvider, (_, _) async {
  await handleRealtimeTransition();
});
ref.listen(shakeDetectionProvider, (_, _) async {
  await handleRealtimeTransition();
});
// 未紐付けのみ経路用に visible も残すなら、EEW空のときだけ visible を読む
```

```dart
Future<void> handleRealtimeTransition() async {
  final eews = ref.read(eewAliveTelegramProvider) ?? [];
  if (eews.isNotEmpty) {
    final decision = ref.read(eewMapFocusProvider.notifier).sync();
    if (!decision.shouldFit) {
      return;
    }
    final focused = eews.cast<EewTelegramItem?>().firstWhere(
      (e) => e?.eventId == decision.state.focusedEventId,
      orElse: () => null,
    );
    // bounds を Builder で組み立てて coordinator.applyEewFocus
    return;
  }
  // 既存: visible shakes + returnToHome / fitToRealtime
  await ... handleRealtimeTransition(eews: [], shakes: ref.read(shakeDetectionVisibleProvider));
}
```

`firstWhere` + null より、`eews.where(...).firstOrNull`（collection）を使う。

`returnToHome`:

```dart
Future<void> returnToHome() async {
  final eews = ref.read(eewAliveTelegramProvider) ?? [];
  if (eews.isNotEmpty) {
    final decision = ref.read(eewMapFocusProvider.notifier).refocus();
    if (decision.shouldFit) {
      // applyEewFocus → isAtHome=false
    }
    return;
  }
  // 既存ホーム復帰
}
```

- [ ] **Step 3: autoZoom=false の扱い**

`applyEewFocus` 内で既存同様 `configuration.eew.autoZoom` を見る。  
ただし **ホームボタンによる `refocus` は autoZoom に関わらず fit する**（仕様: 明示再フォーカスは有効）。API を分け、`applyEewFocus({required bool ignoreAutoZoom})` のようにする。

- [ ] **Step 4: テスト更新・追加して PASS**

---

### Task 5: ジェスチャでフォーカス解除

**Files:**
- Modify: `app/lib/feature/home/ui/component/map/home_map_view.dart`（`_MapLibreMapHost.onEvent`）
- 必要なら Modify: `app/lib/feature/map/ui/maplibre_event_provider.dart`

**Interfaces:**
- Consumes: `MapEventStartMoveCamera`, `CameraChangeReason.apiGesture`, `eewMapFocusProvider.notifier.clearFocus`

- [ ] **Step 1: onEvent で apiGesture のみ clearFocus**

```dart
onEvent: (event) {
  MapLibreEventProvider.maybeOf(context)?.emit(event);
  if (event is MapEventStartMoveCamera &&
      event.reason == CameraChangeReason.apiGesture) {
    ref.read(eewMapFocusProvider.notifier).clearFocus();
  }
},
```

プログラムによる `animateCamera` は `apiAnimation` 等になる想定のため解除しない。

- [ ] **Step 2: 手動確認ポイントをコメントまたは knowledge に残さない場合はテストで Transition の clearFocus 済みを以て完了とする**

Widget テストは必須としない（MapLibre 依存）。Transition / Notifier の `clearFocus` で担保。

---

### Task 6: ホームボタン enabled 制御

**Files:**
- Modify: `app/lib/feature/home/ui/component/map/home_map_controller_card.dart`
- Modify: `app/lib/feature/home/ui/component/map/home_map_view.dart`（`_MapHeader`）

**Interfaces:**
- Produces: `HomeMapControllerCard({ bool isLocationButtonEnabled = true, ... })`
  - `false` のときホーム `InkWell.onTap: null`（または `IgnorePointer` + 見た目の無効色）

- [ ] **Step 1: Card に enabled を追加**

```dart
class HomeMapControllerCard extends StatelessWidget {
  const HomeMapControllerCard({
    super.key,
    this.onLayerButtonTap,
    this.onLocationButtonTap,
    this.isLocationButtonEnabled = true,
    ...
  });

  final bool isLocationButtonEnabled;
  ...
  // ホームボタン:
  // onTap: isLocationButtonEnabled ? () async { ... onLocationButtonTap?.call(); } : null
  // Icon 色: enabled なら默认、disabled なら outline / onSurface.withValues(alpha: ...)
}
```

- [ ] **Step 2: `_MapHeader` で状態を接続**

```dart
final focus = ref.watch(eewMapFocusProvider);
final hasAliveEew = (ref.watch(eewAliveTelegramProvider) ?? []).isNotEmpty;
final isLocationButtonEnabled = !hasAliveEew || !focus.isFocused;

final controllerCard = HomeMapControllerCard(
  isLocationButtonEnabled: isLocationButtonEnabled,
  onLocationButtonTap: () =>
      ref.read(homeMapCameraStateProvider.notifier).returnToHome(),
  ...
);
```

| 状態 | enabled |
|------|---------|
| EEW なし | true（通常ホーム） |
| EEW あり & focused | false |
| EEW あり & 解除後 | true（再フォーカス） |

- [ ] **Step 3: analyze**

Run: `mise exec -- dart analyze lib/feature/home lib/feature/map/ui/maplibre_event_provider.dart`（cwd: `app/`）  
Expected: No issues

---

### Task 7: 回帰テストと最終確認

**Files:**
- 既存: `app/test/feature/map/data/logic/seismic_map_focus_builder_test.dart`（変更不要想定）
- 既存: `app/test/feature/map/data/service/map_automatic_focus_controller_test.dart`（maxZoom 8 維持）
- 本計画で追加・更新した全テスト

- [ ] **Step 1: 関連テスト一括実行**

```bash
cd app
mise exec -- flutter test \
  test/feature/home/data/logic/eew_map_focus_bounds_builder_test.dart \
  test/feature/home/data/logic/eew_map_focus_transition_test.dart \
  test/feature/home/data/service/home_map_camera_coordinator_test.dart \
  test/feature/map/data/service/map_automatic_focus_controller_test.dart \
  test/feature/map/data/logic/seismic_map_focus_builder_test.dart
```

Expected: All PASS

- [ ] **Step 2: 仕様チェックリストを手で照合**

- [ ] maxZoom 8（既存 controller）
- [ ] 最新 EEW（reportTime）のみ
- [ ] `(震源変化 || 0.5°矩形変化) && フォーカス中` のみカメラ更新
- [ ] 相関揺れのみ累積・非縮小・EEWごと
- [ ] ジェスチャ解除
- [ ] ホームボタン無効/再フォーカス
- [ ] 新規最新 EEW で自動再開
- [ ] 消滅時切替 / 全滅ホーム
- [ ] EEW なし未紐付け揺れは既存経路

- [ ] **Step 3: 知見が必要なら `docs/knowledge/20260802_eew_map_focus.md` にジェスチャ理由（apiGesture）と 0.5° vs 0.25° の役割分担を短く残す**

（ユーザーが「今後も考慮」と判断した場合のみ。実装完了報告時に提案してよい）

---

## Spec Coverage（自己レビュー）

| Spec 要件 | Task |
|-----------|------|
| maxZoom 8 | 既存利用 / Task 4・7 |
| 最新 EEW（reportTime） | Task 2 |
| 更新条件（震源\|\|0.5°）&& focused | Task 2・4 |
| 相関揺れのみ・0.5°・非縮小・EEWごと | Task 1・2 |
| ジェスチャ解除 | Task 5 |
| ホームボタン無効/再フォーカス | Task 4・6 |
| 新規最新で自動再開 | Task 2 |
| 消滅切替 / 全滅ホーム | Task 2・4 |
| EEWなし未紐付け既存経路 | Task 4 |
| LiveMonitor 非対象 | 非変更 |

## Type Consistency

- `EewMapFocusGridRect` / `EewMapFocusState` / `EewMapFocusDecision` を Task 1–2 で定義し、以降同一名を使用
- 揺れ検知入力は常に `shakeDetectionProvider`（全件）。表示用 `shakeDetectionVisibleProvider` は EEW 空時の既存経路のみ
- `clearFocus` / `refocus` / `sync` / `shouldFit` の命名を Notifier・UI・Coordinator で統一
