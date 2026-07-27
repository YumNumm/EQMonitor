# LiveMonitor Map Focus and Earthquake Card Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** HomeMap と LiveMonitor で EEW・未結合揺れ検知を同時に自動フォーカスし、LiveMonitor の地震表示を全有感観測点・小型発表時刻 Card・既存震源情報 Card・full-bleed 地図へ更新する。

**Architecture:** EEW と未結合揺れ検知から bounds を作る純粋ロジックを `feature/map` へ移し、HomeMap と LiveMonitor の camera owner はそれぞれ維持する。自動 camera 操作だけを zoom 8 に制限する共通 controller を通し、地震固有の観測点抽出・overlay padding・表示 mode は LiveMonitor 内に残す。

**Tech Stack:** Flutter、Dart、Riverpod 3、flutter_hooks、MapLibre、Freezed、Mockito、flutter_test

## Global Constraints

- Flutter / Dart コマンドはすべて `mise exec --` 経由で実行する。
- 新規 Widget test は作成せず、純粋ロジックと camera controller を単体テストする。
- EEW だけ、未結合揺れ検知だけ、両方、どちらもない状態を同じ focus builder で扱う。
- 対象がない場合はユーザーの Home 地図設定に保存された既定範囲を使う。
- 自動フォーカスの最大 zoom は 8、手動 gesture の最大 zoom は既存のユーザー設定値を維持する。
- 地震 bounds には震源と震度 1 以上の全観測点を含め、震度 0・不明・座標不明は除外する。
- 地震画面下部は既存 `EarthquakeHypocenterInformationCard` を変更せず再利用し、地域震度一覧は表示しない。
- 発表時刻は `yyyy/MM/dd HH:mm 発表 (5時間07分前)` 形式で左上に表示し、時間は累積、分は 2 桁、1 分ごとに更新する。
- MapLibre と gesture 領域は SafeArea 外まで描画し、情報 Card・接続状態・コントロールパネルだけを SafeArea 内に置く。
- 固定座標、推測した発表時刻、不完全データを補う固定値は使わない。

---

## File Structure

- Create `app/lib/feature/map/data/logic/seismic_map_focus_builder.dart`: EEW・未結合揺れ検知の有効座標抽出と共通 realtime bounds 計算。
- Create `app/lib/feature/map/data/service/map_automatic_focus_controller.dart`: actual viewport と bounds から zoom 8 以下の camera target を事前計算し、世代 guard 付きの単一 camera 操作を行う。
- Modify `app/lib/feature/live_monitor/data/logic/live_monitor_map_focus_builder.dart`: 共通 realtime builder を利用し、地震の有感観測点と上下 padding を計算。
- Modify `app/lib/feature/home/data/provider/map_camera_state_provider.dart`: EEW と揺れ検知の両 Provider を購読し、共通 bounds と camera 操作を使用。
- Modify `app/lib/feature/live_monitor/ui/components/live_monitor_map_host.dart`: LiveMonitor の camera 操作を共通 auto-focus controller 経由にする。
- Create `app/lib/feature/live_monitor/data/logic/live_monitor_publication_time_formatter.dart`: 発表時刻と累積経過時間の文字列生成。
- Create `app/lib/feature/live_monitor/ui/components/live_monitor_earthquake_publication_card.dart`: 1 分 ticker に追従する左上 Card。
- Create `app/lib/feature/live_monitor/ui/components/live_monitor_earthquake_overlay.dart`: 左上発表時刻 Card と下部既存震源情報 Card を配置・計測。
- Modify `app/lib/feature/live_monitor/data/logic/live_monitor_earthquake_card_presenter.dart`: 地図 display mode と最新発表時刻の選択だけを残す。
- Delete `app/lib/feature/live_monitor/ui/components/live_monitor_earthquake_card.dart`: 地域震度・現在地震度を含む LiveMonitor 専用大型 Card を撤去。
- Modify `app/lib/feature/live_monitor/ui/components/live_monitor_automatic_view.dart`: 新 overlay と上下実測 padding を使用。
- Modify `app/lib/feature/live_monitor/ui/components/live_monitor_earthquake_pane.dart`: 分割表示でも同じ overlay と padding を使用。
- Modify `app/lib/feature/live_monitor/ui/page/live_monitor_page.dart`: 画面全体へ掛かっている SafeArea を外し MapLibre を full-bleed 化。
- Create `app/test/feature/map/data/logic/seismic_map_focus_builder_test.dart`: focus 対象4状態と不正座標の単体テスト。
- Create `app/test/feature/map/data/service/map_automatic_focus_controller_test.dart`: web/native の zoom 8 制限を Mockito で検証。
- Create generated `app/test/feature/map/data/service/map_automatic_focus_controller_test.mocks.dart`: Mockito の MapController mock。
- Modify `app/test/feature/home/data/provider/map_camera_state_provider_test.dart`: combined target の camera action 判定を検証。
- Modify `app/test/feature/live_monitor/data/live_monitor_map_focus_builder_test.dart`: 有感観測点 filter と上下 padding を検証。
- Modify `app/test/feature/live_monitor/data/live_monitor_earthquake_card_presenter_test.dart`: 地域一覧用 test を削除し、最新発表時刻と display mode の test を維持。
- Create `app/test/feature/live_monitor/data/live_monitor_publication_time_formatter_test.dart`: 日付・累積時間・2桁分・未来時刻の表示を検証。

---

### Task 1: Shared realtime focus builder

**Files:**
- Create: `app/lib/feature/map/data/logic/seismic_map_focus_builder.dart`
- Create: `app/test/feature/map/data/logic/seismic_map_focus_builder_test.dart`
- Modify: `app/lib/feature/live_monitor/data/logic/live_monitor_map_focus_builder.dart:1-124`
- Modify: `app/test/feature/live_monitor/data/live_monitor_map_focus_builder_test.dart:1-240`

**Interfaces:**
- Consumes: `EewTelegramItem`, `ShakeDetectionEvent`, `LngLatBounds`。
- Produces: `SeismicMapFocusBuilder.forRealtime({required LngLatBounds fallbackBounds, required List<EewTelegramItem> eews, required List<ShakeDetectionEvent> shakes}) -> LngLatBounds` と `realtimeTargetCoordinates(...) -> List<SeismicMapGeoCoordinate>`。

- [ ] **Step 1: 共通 builder の失敗する単体テストを書く**

`seismic_map_focus_builder_test.dart` に EEW のみ、未結合揺れ検知のみ、両方、対象なし、結合済み揺れ検知、不正座標を追加する。

```dart
const fallback = LngLatBounds(
  longitudeWest: 120,
  longitudeEast: 154,
  latitudeSouth: 20,
  latitudeNorth: 46,
);

test('EEWと未結合揺れ検知の全座標を同じboundsへ含める', () {
  final bounds = const SeismicMapFocusBuilder().forRealtime(
    fallbackBounds: fallback,
    eews: [eew(latitude: 40, longitude: 142)],
    shakes: [shake(minLat: 33, maxLat: 34, minLng: 130, maxLng: 132)],
  );

  expect(bounds.latitudeSouth, lessThanOrEqualTo(33));
  expect(bounds.latitudeNorth, greaterThanOrEqualTo(40));
  expect(bounds.longitudeWest, lessThanOrEqualTo(130));
  expect(bounds.longitudeEast, greaterThanOrEqualTo(142));
});

test('対象がなければユーザーのfallback boundsを返す', () {
  final bounds = const SeismicMapFocusBuilder().forRealtime(
    fallbackBounds: fallback,
    eews: const [],
    shakes: const [],
  );
  expect(bounds, fallback);
});
```

- [ ] **Step 2: test が未定義 class で失敗することを確認する**

Run from `app/`: `mise exec -- flutter test test/feature/map/data/logic/seismic_map_focus_builder_test.dart`

Expected: `SeismicMapFocusBuilder` が未定義のため FAIL。

- [ ] **Step 3: 有効座標抽出と bounds 計算を共通 file へ実装する**

```dart
const seismicMapFocusMargin = 0.1;

typedef SeismicMapGeoCoordinate = ({double latitude, double longitude});

class SeismicMapFocusBuilder {
  const SeismicMapFocusBuilder();

  LngLatBounds forRealtime({
    required LngLatBounds fallbackBounds,
    required List<EewTelegramItem> eews,
    required List<ShakeDetectionEvent> shakes,
  }) {
    final targets = realtimeTargetCoordinates(eews: eews, shakes: shakes);
    return boundsForTargets(targets: targets, fallbackBounds: fallbackBounds);
  }

  List<SeismicMapGeoCoordinate> realtimeTargetCoordinates({
    required List<EewTelegramItem> eews,
    required List<ShakeDetectionEvent> shakes,
  }) => [
    ...eews.expand(eewTargetCoordinates),
    ...shakes.expand(shakeTargetCoordinates),
  ];
}
```

`eewTargetCoordinates` は緯度経度が両方有限かつ範囲内の EEW 震源だけを返す。`shakeTargetCoordinates` は `correlatedEewEventId == null`、矩形の最小値が最大値以下、4値が有限かつ範囲内の場合だけ南西・北東の2点を返す。`boundsForTargets` は対象が空なら `fallbackBounds`、それ以外は全点の min/max に `0.1` 度を足して緯度 `-90...90`、経度 `-180...180` へ clamp する。

- [ ] **Step 4: LiveMonitor の realtime focus を共通 builder へ切り替える**

`LiveMonitorMapFocusBuilder.forRealtime` で `LiveMonitorGeoBounds` を `LngLatBounds` へ変換し、返された値を `LiveMonitorGeoBounds` に戻す。`liveMonitorEewTargetCoordinates` と `liveMonitorShakeTargetCoordinates` は削除し、地震専用の座標抽出だけを残す。

- [ ] **Step 5: 共通 builder と既存 LiveMonitor test を通す**

Run from `app/`: `mise exec -- flutter test test/feature/map/data/logic/seismic_map_focus_builder_test.dart test/feature/live_monitor/data/live_monitor_map_focus_builder_test.dart`

Expected: PASS。

- [ ] **Step 6: Task 1 をコミットする**

```bash
git add app/lib/feature/map/data/logic/seismic_map_focus_builder.dart app/lib/feature/live_monitor/data/logic/live_monitor_map_focus_builder.dart app/test/feature/map/data/logic/seismic_map_focus_builder_test.dart app/test/feature/live_monitor/data/live_monitor_map_focus_builder_test.dart
git commit -m "feat: 地震リアルタイム表示のフォーカス計算を共通化"
```

---

### Task 2: Automatic zoom limiter and HomeMap combined focus

**Files:**
- Create: `app/lib/feature/map/data/service/map_automatic_focus_controller.dart`
- Create: `app/lib/feature/map/data/service/map_automatic_focus_operation_queue.dart`
- Create: `app/test/feature/map/data/service/map_automatic_focus_controller_test.dart`
- Create generated: `app/test/feature/map/data/service/map_automatic_focus_controller_test.mocks.dart`
- Modify: `app/lib/feature/home/data/provider/map_camera_state_provider.dart:1-180`
- Modify generated: `app/lib/feature/home/data/provider/map_camera_state_provider.g.dart`
- Modify: `app/lib/feature/home/ui/component/map/home_map_view.dart`
- Modify: `app/lib/feature/live_monitor/ui/components/live_monitor_map_host.dart:1-90`
- Modify: `app/test/feature/home/data/provider/map_camera_state_provider_test.dart:1-60`

**Interfaces:**
- Consumes: Task 1 の `SeismicMapFocusBuilder` と既存 `shakeDetectionVisibleProvider`。
- Produces: `MapAutomaticFocusController.fit({required MapController controller, required LngLatBounds bounds, required Size viewportSize, required bool Function() isCurrent, EdgeInsets padding, Duration nativeDuration, double bearing = 0, double pitch = 0}) -> Future<bool>`、`mapAutomaticFocusMaxZoom = 8.0`、combined target 対応の `HomeMapCameraUpdateAction`。

- [ ] **Step 1: 事前計算 target と operation guard の失敗する単体テストを書く**

```dart
test('狭いboundsでも事前計算したzoom 8のcameraを一度だけ送る', () async {
  final controller = MockMapController();
  when(controller.animateCamera(
    center: anyNamed('center'),
    zoom: anyNamed('zoom'),
    bearing: anyNamed('bearing'),
    pitch: anyNamed('pitch'),
    nativeDuration: anyNamed('nativeDuration'),
    webSpeed: anyNamed('webSpeed'),
    webMaxDuration: anyNamed('webMaxDuration'),
    padding: anyNamed('padding'),
  )).thenAnswer((_) async {});

  await const MapAutomaticFocusController().fit(
    controller: controller,
    bounds: bounds,
    viewportSize: const Size(375, 667),
    isCurrent: () => true,
  );

  verify(controller.animateCamera(
    center: anyNamed('center'),
    zoom: 8,
  ));
  verifyNever(controller.fitBounds(bounds: anyNamed('bounds')));
  verifyNever(controller.getCamera());
});
```

pure target の center/zoom、padding 控除後の非正値 viewport no-op、guard が開始時・移動直前・完了後に false となる境界、LiveMonitor instance switch 後に旧 controller を再参照しないケースも追加する。

- [ ] **Step 2: Mockito mock を生成し、旧 post-fit 補正実装で失敗することを確認する**

Run from `app/`: `mise exec -- dart run build_runner build --delete-conflicting-outputs`

Run from `app/`: `mise exec -- flutter test test/feature/map/data/service/map_automatic_focus_controller_test.dart`

Expected: `viewportSize` / `isCurrent` が未定義、または `fitBounds` / `getCamera` が呼ばれるため FAIL。

- [ ] **Step 3: viewport から zoom 8 以下の target を移動前に算出する controller を実装する**

```dart
const mapAutomaticFocusMaxZoom = 8.0;

class MapAutomaticFocusController {
  const MapAutomaticFocusController();

  Future<bool> fit({
    required MapController controller,
    required LngLatBounds bounds,
    required Size viewportSize,
    required bool Function() isCurrent,
    EdgeInsets padding = EdgeInsets.zero,
    Duration nativeDuration = const Duration(seconds: 2),
    double bearing = 0,
    double pitch = 0,
  }) async {
    if (!isCurrent()) {
      return false;
    }
    final target = mapAutomaticFocusTargetForBounds(
      bounds: bounds,
      viewportSize: viewportSize,
      padding: padding,
    );
    if (target == null || !isCurrent()) {
      return false;
    }
    await controller.animateCamera(
      center: target.center,
      zoom: target.zoom,
      bearing: bearing,
      pitch: pitch,
      nativeDuration: nativeDuration,
      padding: padding,
    );
    return isCurrent();
  }
}
```

MapLibre と同じ 512px world size の Web Mercator へ投影した bounds と padding 控除後の actual viewport から target を純粋計算し、zoom を `0...8` に clamp して単一 `animateCamera` へ渡す。bounds 収容を保証するため bearing / pitch は既定で 0 に戻す。非正値 viewport は no-op。`fitBounds` 完了契約、`getCamera()`、任意 delay には依存しない。MapOptions の `maxZoom` は変更しない。

- [ ] **Step 4: HomeMap の camera action test を combined target 仕様へ更新する**

`resolveHomeMapCameraUpdateAction` を `hasRealtimeTargets` と `isAtHome` から判定する純粋関数へ変更する test を先に書く。

```dart
expect(
  resolveHomeMapCameraUpdateAction(
    hasRealtimeTargets: true,
    isAtHome: true,
  ),
  HomeMapCameraUpdateAction.fitToRealtime,
);
expect(
  resolveHomeMapCameraUpdateAction(
    hasRealtimeTargets: false,
    isAtHome: false,
  ),
  HomeMapCameraUpdateAction.returnToHome,
);
```

- [ ] **Step 5: HomeMap で EEW と未結合揺れ検知を同時購読する**

`HomeMapCameraState.build()` で `eewAliveTelegramProvider` と `shakeDetectionVisibleProvider` の双方を `ref.listen` し、どちらの更新でも現在の両リストを読み直して `_handleRealtimeTransition` を呼ぶ。`setController` でも両リストを評価する。target があれば `SeismicMapFocusBuilder.forRealtime`、なければ `lngLatBoundsForHomeMapSettings(home.map)` を使い、既存 `home.eew.autoZoom` が有効な場合だけ realtime target へ自動移動する。Home 復帰と realtime fit は `MapAutomaticFocusController.fit` を通す。

`setController` は actual viewport `Size` も受け取る。HomeMap は viewport size を `MapLibreMap` の key に含め、回転・リサイズ時に新 controller と新 viewport で focus を再評価する。全 target 更新と明示 Home 復帰で generation を進め、controller identity と generation を `isCurrent` で各 operation 境界に検証する。同一 controller は FIFO で直列化し、最新 generation の命令を最終適用する。target 消滅、明示 Home 復帰、controller 切替の in-flight race を provider 単体テストで固定する。

- [ ] **Step 6: LiveMonitorMapHost も共通 auto-focus controller を使う**

`LiveMonitorMapHost` は `LayoutBuilder` で actual viewport を取得する外側と hook/controller lifecycle を持つ内側へ分ける。`MapAutomaticFocusController.fit` に `viewportSize` と `isCurrent: () => instanceOwner.acceptCameraCompletion(operation)` を渡し、開始時・移動直前・完了後に identity/controller/generation を検証する。instance switch/dispose 後に旧 controller を再参照しない単体テストを追加する。

- [ ] **Step 7: Task 2 の対象 test を通す**

Run from `app/`: `mise exec -- flutter test test/feature/map/data/service/map_automatic_focus_controller_test.dart test/feature/home/data/provider/map_camera_state_provider_test.dart test/feature/live_monitor/ui/components/live_monitor_map_host_test.dart`

Expected: PASS。

- [ ] **Step 8: Task 2 をコミットする**

```bash
git add docs/superpowers/plans/2026-07-27-live-monitor-map-focus-and-earthquake-card.md app/pubspec.yaml app/lib/feature/map/data/service/map_automatic_focus_controller.dart app/lib/feature/map/data/service/map_automatic_focus_operation_queue.dart app/lib/feature/home/data/provider/map_camera_state_provider.dart app/lib/feature/home/data/provider/map_camera_state_provider.g.dart app/lib/feature/home/ui/component/map/home_map_view.dart app/lib/feature/live_monitor/ui/components/live_monitor_map_host.dart app/test/feature/map/data/service/map_automatic_focus_controller_test.dart app/test/feature/map/data/service/map_automatic_focus_controller_test.mocks.dart app/test/feature/home/data/provider/map_camera_state_provider_test.dart
git commit -m "feat: HomeMapでEEWと揺れ検知へ自動フォーカス"
```

---

### Task 3: Felt-station earthquake bounds and compact overlay

**Files:**
- Modify: `app/lib/feature/live_monitor/data/logic/live_monitor_map_focus_builder.dart:29-172`
- Modify: `app/test/feature/live_monitor/data/live_monitor_map_focus_builder_test.dart:260-440`
- Create: `app/lib/feature/live_monitor/data/logic/live_monitor_publication_time_formatter.dart`
- Create: `app/test/feature/live_monitor/data/live_monitor_publication_time_formatter_test.dart`
- Modify: `app/lib/feature/live_monitor/data/logic/live_monitor_earthquake_card_presenter.dart:1-130`
- Modify: `app/test/feature/live_monitor/data/live_monitor_earthquake_card_presenter_test.dart:180-320`
- Create: `app/lib/feature/live_monitor/ui/components/live_monitor_earthquake_publication_card.dart`
- Create: `app/lib/feature/live_monitor/ui/components/live_monitor_earthquake_overlay.dart`
- Delete: `app/lib/feature/live_monitor/ui/components/live_monitor_earthquake_card.dart`

**Interfaces:**
- Consumes: `Earthquake`, `LiveMonitorEarthquakePresentation`, `EarthquakeHypocenterInformationCard`, `timeTickerProvider(const Duration(minutes: 1))`。
- Produces: `LiveMonitorMapFocusBuilder.forEarthquake(..., required double obscuredTop, required double obscuredBottom)`、`formatLiveMonitorPublicationTime({required DateTime reportedAt, required DateTime now}) -> String`、`LiveMonitorEarthquakeOverlay`。

- [ ] **Step 1: 震度 filter と上下 padding の失敗する test を書く**

既存 earthquake fixture に震度 `unknown`、`zero`、`one`、`four` の station を別座標で入れ、`one` と `four` だけが bounds に含まれることを検証する。

```dart
final focus = builder.forEarthquake(
  earthquake: earthquake,
  fallbackBounds: homeBounds,
  obscuredTop: 36,
  obscuredBottom: 92,
);

expect(focus.bounds.contains(latitude: oneLat, longitude: oneLng), isTrue);
expect(focus.bounds.contains(latitude: fourLat, longitude: fourLng), isTrue);
expect(focus.bounds.contains(latitude: zeroLat, longitude: zeroLng), isFalse);
expect(focus.bounds.contains(latitude: unknownLat, longitude: unknownLng), isFalse);
expect(focus.padding.top, 44);
expect(focus.padding.bottom, 100);
```

- [ ] **Step 2: 変更前の test が signature と filter の相違で失敗することを確認する**

Run from `app/`: `mise exec -- flutter test test/feature/live_monitor/data/live_monitor_map_focus_builder_test.dart`

Expected: `obscuredTop` 未定義または震度 0・不明が bounds に含まれて FAIL。

- [ ] **Step 3: 地震 target と padding を実装する**

`StationIntensityNode.intensity?.maxIntensity?.orderIndex` が `JmaIntensity.one.orderIndex` 以上の場合だけ station 座標を yield する。`liveMonitorMapFocusForTargets` に `obscuredTop` を追加し、負値を 0 として `top = 8 + obscuredTop`、`bottom = 8 + obscuredBottom` を設定する。realtime 呼び出しは `obscuredTop: 0` を渡す。

- [ ] **Step 4: 発表時刻 formatter の失敗する test を書く**

```dart
test('24時間を超えても累積時間と2桁分で表示する', () {
  final reportedAt = DateTime(2026, 7, 26, 12, 3);
  final now = DateTime(2026, 7, 27, 17, 10);
  expect(
    formatLiveMonitorPublicationTime(reportedAt: reportedAt, now: now),
    '2026/07/26 12:03 発表 (29時間07分前)',
  );
});

test('端末時刻より未来なら経過時間を0へ丸める', () {
  final reportedAt = DateTime(2026, 7, 27, 17, 11);
  final now = DateTime(2026, 7, 27, 17, 10);
  expect(
    formatLiveMonitorPublicationTime(reportedAt: reportedAt, now: now),
    '2026/07/27 17:11 発表 (0時間00分前)',
  );
});
```

- [ ] **Step 5: formatter test の失敗を確認して最小実装を追加する**

Run from `app/`: `mise exec -- flutter test test/feature/live_monitor/data/live_monitor_publication_time_formatter_test.dart`

Expected: formatter が未定義のため FAIL。

```dart
String formatLiveMonitorPublicationTime({
  required DateTime reportedAt,
  required DateTime now,
}) {
  final rawElapsed = now.toUtc().difference(reportedAt.toUtc());
  final elapsed = rawElapsed.isNegative ? Duration.zero : rawElapsed;
  final minutes = elapsed.inMinutes.remainder(60).toString().padLeft(2, '0');
  return '${DateFormat('yyyy/MM/dd HH:mm').format(reportedAt.toLocal())} '
      '発表 (${elapsed.inHours}時間$minutes分前)';
}
```

- [ ] **Step 6: presentation を地図 mode と発表時刻選択へ縮小する**

`LiveMonitorEarthquakePresentation` に `DateTime? get publicationAt` を追加し、full earthquake の最新対応電文を優先し、存在しない場合だけ現在の `LiveMonitorTelegramTrigger.reportedAt` を使う。`maximumIntensityRegions`、`LiveMonitorIntensityRegionGroup`、`orderedIntensityRegions` と対応 test を削除する。`preferredIntensityMode`、`latestSupportedTelegramTrigger`、EEW/揺れ Card の並び替えは維持する。

- [ ] **Step 7: 左上 Card と既存震源情報 Card の overlay を実装する**

```dart
class LiveMonitorEarthquakePublicationCard extends ConsumerWidget {
  const LiveMonitorEarthquakePublicationCard({
    required this.reportedAt,
    required this.initialNow,
    super.key,
  });

  final DateTime reportedAt;
  final DateTime initialNow;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = ref.watch(
      timeTickerProvider(const Duration(minutes: 1)),
    ).value ?? initialNow;
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Text(formatLiveMonitorPublicationTime(
          reportedAt: reportedAt,
          now: now,
        )),
      ),
    );
  }
}
```

`LiveMonitorEarthquakeOverlay` は `Stack` で publication Card を `Alignment.topLeft`、`EarthquakeHypocenterInformationCard(item: earthquake)` を `Alignment.bottomCenter` に置く。両方を `LiveMonitorMeasuredCardOverlay` で個別に測定して `onTopHeightChanged` と `onBottomHeightChanged` へ通知する。`publicationAt == null` の場合は左上 Card を生成せず、top height として 0 を通知する。overlay 自体には SafeArea を掛けず、caller が一度だけ SafeArea を適用する。

- [ ] **Step 8: 大型 Card を削除し、Task 3 test を通す**

Run from `app/`: `mise exec -- flutter test test/feature/live_monitor/data/live_monitor_map_focus_builder_test.dart test/feature/live_monitor/data/live_monitor_publication_time_formatter_test.dart test/feature/live_monitor/data/live_monitor_earthquake_card_presenter_test.dart`

Expected: PASS。

- [ ] **Step 9: Task 3 をコミットする**

```bash
git add app/lib/feature/live_monitor/data/logic/live_monitor_map_focus_builder.dart app/lib/feature/live_monitor/data/logic/live_monitor_publication_time_formatter.dart app/lib/feature/live_monitor/data/logic/live_monitor_earthquake_card_presenter.dart app/lib/feature/live_monitor/ui/components/live_monitor_earthquake_publication_card.dart app/lib/feature/live_monitor/ui/components/live_monitor_earthquake_overlay.dart app/lib/feature/live_monitor/ui/components/live_monitor_earthquake_card.dart app/test/feature/live_monitor/data/live_monitor_map_focus_builder_test.dart app/test/feature/live_monitor/data/live_monitor_publication_time_formatter_test.dart app/test/feature/live_monitor/data/live_monitor_earthquake_card_presenter_test.dart
git commit -m "feat: LiveMonitorの地震情報Cardを小型化"
```

---

### Task 4: Earthquake overlay wiring and full-bleed map

**Files:**
- Modify: `app/lib/feature/live_monitor/ui/components/live_monitor_automatic_view.dart:1-120`
- Modify: `app/lib/feature/live_monitor/ui/components/live_monitor_earthquake_pane.dart:1-135`
- Modify: `app/lib/feature/live_monitor/ui/page/live_monitor_page.dart:229-314`

**Interfaces:**
- Consumes: Task 3 の `LiveMonitorEarthquakeOverlay` と `LiveMonitorMapFocusBuilder.forEarthquake`。
- Produces: automatic・split 両方で同じ上下 Card、実測 camera padding、SafeArea 外まで広がる MapLibre gesture 領域。

- [ ] **Step 1: automatic 表示を新 overlay へ切り替える**

`earthquakeCardHeight` を `earthquakeTopCardHeight` と `earthquakeBottomCardHeight` に分ける。earthquake focus へ両値を渡し、`LiveMonitorEarthquakeCard` を次へ置き換える。

```dart
LiveMonitorEarthquakeOverlay(
  earthquake: earthquake,
  presentation: LiveMonitorEarthquakePresentation.forTrigger(
    earthquake: earthquake,
    trigger: trigger,
  ),
  initialNow: now,
  onTopHeightChanged: (height) {
    earthquakeTopCardHeight.value = height;
  },
  onBottomHeightChanged: (height) {
    earthquakeBottomCardHeight.value = height;
  },
)
```

realtime 状態は既存 `LiveMonitorRealtimeCards` と bottom padding を維持する。earthquake overlay は `SafeArea(minimum: EdgeInsets.all(8))` 内に置く。

- [ ] **Step 2: split の地震 Pane も同じ overlay へ切り替える**

`cardHeight` を上下2値へ分け、`LiveMonitorEarthquakeOverlay` と `presentation.publicationAt` を使用する。最新情報取得失敗 banner は既存どおり SafeArea 内に残し、左上 Card と重なる場合は banner を top center に維持する。

- [ ] **Step 3: LiveMonitorPage の MapLibre と tap listener を full-bleed 化する**

`Positioned.fill > SafeArea > Listener > body` から外側の `SafeArea` だけを削除し、`Positioned.fill > Listener > body` にする。`LiveMonitorConnectionBanner` は自身の SafeArea、`LiveMonitorControlPanel` は自身の SafeArea を維持する。これにより map と tap/gesture 対象だけが status bar・home indicator の背後まで広がる。

- [ ] **Step 4: formatter・focus・既存非 Widget test と analyze を実行する**

Run from `app/`: `mise exec -- flutter test test/feature/live_monitor/data/live_monitor_map_focus_builder_test.dart test/feature/live_monitor/data/live_monitor_publication_time_formatter_test.dart test/feature/live_monitor/data/live_monitor_earthquake_card_presenter_test.dart test/feature/live_monitor/data/live_monitor_tap_tracker_test.dart`

Run from `app/`: `mise exec -- dart analyze lib/feature/live_monitor lib/feature/home/data/provider/map_camera_state_provider.dart lib/feature/map/data`

Expected: 全 test PASS、analyze は `No issues found!`。

- [ ] **Step 5: iOS または macOS の debug 実行で目視確認する**

確認項目:

- EEW も揺れ検知もない realtime 表示はユーザー既定範囲になる。
- EEW と未結合揺れ検知が同時にあると両方が画面内へ入る。
- 地震表示で震源と震度 1 以上の全観測点が上下 Card に隠れない。
- 近接点だけでも自動 zoom が 8 を超えず、pinch 操作は設定上限まで拡大できる。
- 地図は status bar・home indicator 背後まで描画され、Card と panel は SafeArea 内に収まる。
- 発表時刻がなければ左上 Card は出ず、下部には既存震源情報 Card だけが出る。

- [ ] **Step 6: Task 4 をコミットする**

```bash
git add app/lib/feature/live_monitor/ui/components/live_monitor_automatic_view.dart app/lib/feature/live_monitor/ui/components/live_monitor_earthquake_pane.dart app/lib/feature/live_monitor/ui/page/live_monitor_page.dart
git commit -m "fix: LiveMonitorの地図と地震overlayを調整"
```

---

### Task 5: Generation, regression verification, and PR update

**Files:**
- Modify generated files only when `build_runner` changes them.
- Modify: `docs/superpowers/specs/2026-07-27-live-monitor-mode-design.md` only if implementation reveals a factual mismatch; do not change an approved requirement.

**Interfaces:**
- Consumes: Tasks 1-4 の全実装。
- Produces: clean generated output、focused test、full LiveMonitor test、analyze、format、diff check の証跡。

- [ ] **Step 1: code generation を最新化する**

Run from `app/`: `mise exec -- dart run build_runner build --delete-conflicting-outputs`

Expected: generator が成功し、Mockito/Riverpod/Freezed の生成差分だけが残る。

- [ ] **Step 2: Dart format を実行する**

Run from repository root: `mise exec -- dart format app/lib/feature/map/data/logic/seismic_map_focus_builder.dart app/lib/feature/map/data/service/map_automatic_focus_controller.dart app/lib/feature/home/data/provider/map_camera_state_provider.dart app/lib/feature/live_monitor app/test/feature/map app/test/feature/home/data/provider/map_camera_state_provider_test.dart app/test/feature/live_monitor`

Expected: formatter が成功する。

- [ ] **Step 3: focused test を実行する**

Run from `app/`: `mise exec -- flutter test test/feature/map/data/logic/seismic_map_focus_builder_test.dart test/feature/map/data/service/map_automatic_focus_controller_test.dart test/feature/home/data/provider/map_camera_state_provider_test.dart test/feature/live_monitor/data/live_monitor_map_focus_builder_test.dart test/feature/live_monitor/data/live_monitor_publication_time_formatter_test.dart test/feature/live_monitor/data/live_monitor_earthquake_card_presenter_test.dart test/feature/live_monitor/ui/components/live_monitor_map_host_test.dart`

Expected: PASS。

- [ ] **Step 4: LiveMonitor 全単体 test と関連 Home/Map test を実行する**

Run from `app/`: `mise exec -- flutter test test/feature/live_monitor test/feature/home/data/provider/map_camera_state_provider_test.dart test/feature/map/data`

Expected: PASS。

- [ ] **Step 5: analyze と repository check を実行する**

Run from `app/`: `mise exec -- dart analyze lib/feature/live_monitor lib/feature/home/data/provider/map_camera_state_provider.dart lib/feature/map/data test/feature/live_monitor test/feature/home/data/provider/map_camera_state_provider_test.dart test/feature/map/data`

Run from repository root: `git diff --check`

Expected: analyze は `No issues found!`、`git diff --check` は出力なし。

- [ ] **Step 6: 最終差分を安全仕様に照らして確認する**

Run from repository root:

```bash
git --no-pager diff --stat origin/develop...HEAD
git --no-pager diff origin/develop...HEAD -- app/lib/feature/home/data/provider/map_camera_state_provider.dart app/lib/feature/map app/lib/feature/live_monitor app/test/feature/home app/test/feature/map app/test/feature/live_monitor
git status --short --branch
```

確認項目は、結合済み揺れ検知が focus に重複しないこと、震度 0・不明を有感範囲へ含めないこと、auto zoom 8 が MapOptions の manual maxZoom を変更していないこと、SafeArea が overlay に残っていること、固定値による地震情報補完がないこと。

- [ ] **Step 7: generator・format 差分をコミットして push する**

```bash
git add app/lib app/test docs/superpowers
git commit -m "chore: LiveMonitor追従差分を整備"
git push origin codex/live-monitor-mode
```

generator・formatter が差分を作らなかった場合は空コミットを作らず、Tasks 1-4 のコミットをそのまま push する。既存 draft PR #1552 の説明へ今回の受け入れ条件と検証結果を追記する。
