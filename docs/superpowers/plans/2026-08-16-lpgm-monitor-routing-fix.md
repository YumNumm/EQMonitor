# LPGM Monitor Routing Fix Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** LMoni の通常データと長周期データを現行の正しい配信経路から取得し、長周期データで無効な地下レイヤーを要求しない。

**Architecture:** Retrofit クライアントで通常データと長周期データのエンドポイントを別メソッドにし、DataSource が `RealtimeDataType.isLpgm` で選択する。アプリ設定モデルが保存値と実効レイヤーを分離し、Notifier と設定 UI が同じ制約を利用する。

**Tech Stack:** Dart 3.11、Flutter 3.44、Dio、Retrofit、Freezed、Riverpod、flutter_test / test

## Global Constraints

- Flutter / Dart コマンドは必ず `mise exec --` 経由で実行する。
- 外部配信エラー時に別ソース、固定値、古い画像へフォールバックしない。
- 通常データは `/img_svr/data/map_img/RealTimeImg/`、長周期データは `/monitor/data/data/map_img/RealTimeImg/` を使う。
- 長周期データの URL と実効レイヤーは地表 (`s`) 固定とする。
- 保存済みの地下設定は破棄せず、通常データへ戻したときに再利用する。
- ユーザーの既存未コミット変更には触れない。

---

### Task 1: LMoni 配信経路をデータ種別ごとに分離する

**Files:**
- Create: `packages/kyoshin_monitor_api/test/src/api/lpgm_kyoshin_monitor_web_api_client_test.dart`
- Modify: `packages/kyoshin_monitor_api/lib/src/api/lpgm_kyoshin_monitor_web_api_client.dart`
- Modify: `packages/kyoshin_monitor_api/lib/src/api/lpgm_kyoshin_monitor_web_api_client.g.dart`
- Modify: `packages/kyoshin_monitor_api/lib/src/data_source/lpgm_kyoshin_monitor_web_api_data_source.dart`

**Interfaces:**
- Consumes: `RealtimeDataType.isLpgm`、`RealtimeLayer.urlString`、指定時刻。
- Produces: `getKyoshinRealtimeImageData(...)` と `getLpgmRealtimeImageData(...)`、および種別を判定する `LpgmKyoshinMonitorWebApiDataSource.getRealtimeImageData({required type, required layer, required dateTime})`。

- [ ] **Step 1: 現在の誤った URL を捕捉する回帰テストを書く**

```dart
import 'dart:async';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:kyoshin_monitor_api/kyoshin_monitor_api.dart';
import 'package:test/test.dart';

final class _RecordingBytesAdapter implements HttpClientAdapter {
  RequestOptions? request;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    request = options;
    return ResponseBody.fromBytes(const [1, 2, 3], 200);
  }

  @override
  void close({bool force = false}) {}
}

void main() {
  late _RecordingBytesAdapter adapter;
  late LpgmKyoshinMonitorWebApiDataSource dataSource;

  setUp(() {
    adapter = _RecordingBytesAdapter();
    final dio = Dio()..httpClientAdapter = adapter;
    dataSource = LpgmKyoshinMonitorWebApiDataSource(
      client: LpgmKyoshinMonitorWebApiClient(dio),
    );
  });

  test('通常震度の地表は img_svr の jma_s を取得する', () async {
    await dataSource.getRealtimeImageData(
      RealtimeDataType.shindo,
      RealtimeLayer.surface,
      DateTime(2026, 8, 16, 22, 58, 3),
    );
    expect(
      adapter.request?.path,
      'https://www.lmoni.bosai.go.jp/img_svr/data/map_img/'
      'RealTimeImg/jma_s/20260816/20260816225803.jma_s.gif',
    );
  });

  test('通常震度の地下は img_svr の jma_b を取得する', () async {
    await dataSource.getRealtimeImageData(
      RealtimeDataType.shindo,
      RealtimeLayer.underground,
      DateTime(2026, 8, 16, 22, 58, 3),
    );
    expect(adapter.request?.path, endsWith('20260816225803.jma_b.gif'));
  });

  test('長周期データは地下設定でも monitor 配下の abrspmx_s を取得する', () async {
    await dataSource.getRealtimeImageData(
      RealtimeDataType.abrspmx,
      RealtimeLayer.underground,
      DateTime(2026, 8, 16, 22, 58, 3),
    );
    expect(
      adapter.request?.path,
      'https://www.lmoni.bosai.go.jp/monitor/data/data/map_img/'
      'RealTimeImg/abrspmx_s/20260816/20260816225803.abrspmx_s.gif',
    );
  });
}
```

- [ ] **Step 2: 回帰テストが期待した理由で失敗することを確認する**

Run: `mise exec -- dart test packages/kyoshin_monitor_api/test/src/api/lpgm_kyoshin_monitor_web_api_client_test.dart`

Expected: 通常震度は `/monitor/data/data/` のため失敗し、長周期地下は `abrspmx_b` のため失敗する。

- [ ] **Step 3: 失敗する回帰テストだけをコミットする**

```bash
git add packages/kyoshin_monitor_api/test/src/api/lpgm_kyoshin_monitor_web_api_client_test.dart
git commit -m "Test: LMoni配信経路の回帰テストを追加"
```

- [ ] **Step 4: API クライアントと DataSource を最小修正する**

```dart
@GET(
  '/img_svr/data/map_img/RealTimeImg/'
  '{type}_{layer}/{date}/{dateTime}.{type}_{layer}.gif',
)
@DioResponseType(ResponseType.bytes)
Future<List<int>> getKyoshinRealtimeImageData({
  @Path('type') required String type,
  @Path('layer') required String layer,
  @Path('date') required String date,
  @Path('dateTime') required String dateTime,
});

@GET(
  '/monitor/data/data/map_img/RealTimeImg/'
  '{type}_s/{date}/{dateTime}.{type}_s.gif',
)
@DioResponseType(ResponseType.bytes)
Future<List<int>> getLpgmRealtimeImageData({
  @Path('type') required String type,
  @Path('date') required String date,
  @Path('dateTime') required String dateTime,
});
```

```dart
Future<List<int>> getRealtimeImageData({
  required RealtimeDataType type,
  required RealtimeLayer layer,
  required DateTime dateTime,
}) {
  final date = dateFormat.format(dateTime);
  final formattedDateTime = dateTimeFormat.format(dateTime);
  if (type.isLpgm) {
    return _client.getLpgmRealtimeImageData(
      type: type.urlString,
      date: date,
      dateTime: formattedDateTime,
    );
  }
  return _client.getKyoshinRealtimeImageData(
    type: type.urlString,
    layer: layer.urlString,
    date: date,
    dateTime: formattedDateTime,
  );
}
```

この名前付き引数への変更時に、Step 1 の3つのテスト呼び出しも
`type:`、`layer:`、`dateTime:` を使う形へ機械的に更新し、期待 URL は変更しない。

- [ ] **Step 5: Retrofit コードを再生成する**

Workdir: `packages/kyoshin_monitor_api`

Run: `mise exec -- dart run build_runner build --delete-conflicting-outputs`

- [ ] **Step 6: 回帰テストとパッケージ全テストを通す**

Run: `mise exec -- dart test packages/kyoshin_monitor_api/test/src/api/lpgm_kyoshin_monitor_web_api_client_test.dart`

Run: `mise exec -- dart test packages/kyoshin_monitor_api/test`

Expected: すべて PASS。

- [ ] **Step 7: 配信経路修正をコミットする**

```bash
git add packages/kyoshin_monitor_api/lib/src/api/lpgm_kyoshin_monitor_web_api_client.dart packages/kyoshin_monitor_api/lib/src/api/lpgm_kyoshin_monitor_web_api_client.g.dart packages/kyoshin_monitor_api/lib/src/data_source/lpgm_kyoshin_monitor_web_api_data_source.dart
git commit -m "Fix: LMoni画像の配信経路をデータ種別で分離"
```

### Task 2: 長周期データの実効レイヤーと設定 UI を地表に制限する

**Files:**
- Modify: `app/lib/feature/kyoshin_monitor/data/model/kyoshin_monitor_settings_model.dart`
- Modify: `app/lib/feature/kyoshin_monitor/data/notifier/kyoshin_monitor_notifier.dart`
- Modify: `app/lib/feature/home/ui/page/home_map_layer_page.dart`
- Create: `app/test/feature/kyoshin_monitor/kyoshin_monitor_settings_model_test.dart`

**Interfaces:**
- Consumes: 保存済み `KyoshinMonitorSettingsModel.realtimeLayer` と `realtimeDataType`。
- Produces: `effectiveRealtimeLayer` と `canSelectRealtimeLayer`。前者は取得と状態記録、後者は設定 UI の表示判定に使う。

- [ ] **Step 1: 実効レイヤーと UI 可視性の失敗テストを書く**

```dart
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_settings_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyoshin_monitor_api/kyoshin_monitor_api.dart';

void main() {
  test('長周期データでは保存値が地下でも実効レイヤーは地表になる', () {
    const settings = KyoshinMonitorSettingsModel(
      realtimeDataType: RealtimeDataType.abrspmx,
      realtimeLayer: RealtimeLayer.underground,
    );
    expect(settings.effectiveRealtimeLayer, RealtimeLayer.surface);
    expect(settings.canSelectRealtimeLayer, isFalse);
  );

  test('通常データでは保存済みレイヤーを維持する', () {
    const settings = KyoshinMonitorSettingsModel(
      realtimeDataType: RealtimeDataType.shindo,
      realtimeLayer: RealtimeLayer.underground,
    );
    expect(settings.effectiveRealtimeLayer, RealtimeLayer.underground);
    expect(settings.canSelectRealtimeLayer, isTrue);
  );

  test('モニター無効時はレイヤーを選択できない', () {
    const settings = KyoshinMonitorSettingsModel(useKmoni: false);
    expect(settings.canSelectRealtimeLayer, isFalse);
  });
}
```

- [ ] **Step 2: 新しい契約が未実装のため失敗することを確認する**

Run: `mise exec -- flutter test app/test/feature/kyoshin_monitor/kyoshin_monitor_settings_model_test.dart`

Expected: `effectiveRealtimeLayer` / `canSelectRealtimeLayer` が未定義で FAIL。

- [ ] **Step 3: 設定モデルの派生値を最小実装する**

```dart
extension KyoshinMonitorSettingsModelX on KyoshinMonitorSettingsModel {
  RealtimeLayer get effectiveRealtimeLayer =>
      realtimeDataType.isLpgm ? RealtimeLayer.surface : realtimeLayer;

  bool get canSelectRealtimeLayer => useKmoni && !realtimeDataType.isLpgm;
}
```

- [ ] **Step 4: Notifier と UI を同じ派生値へ接続する**

`KyoshinMonitorNotifier` は `settings.effectiveRealtimeLayer` を DataSource と
`KyoshinMonitorState.currentRealtimeLayer` の両方へ渡す。LMoni DataSource 呼び出しは
Task 1 の名前付き引数へ更新する。

`_KyoshinRealtimeLayerTile` は次のガードを使う。

```dart
if (!setting.canSelectRealtimeLayer) {
  return const SizedBox.shrink();
}
```

- [ ] **Step 5: モデルテストと既存の強震モニタテストを通す**

Run: `mise exec -- flutter test app/test/feature/kyoshin_monitor/kyoshin_monitor_settings_model_test.dart app/test/feature/kyoshin_monitor/kyoshin_monitor_delay_test.dart`

Expected: すべて PASS。

- [ ] **Step 6: アプリ側修正をコミットする**

```bash
git add app/lib/feature/kyoshin_monitor/data/model/kyoshin_monitor_settings_model.dart app/lib/feature/kyoshin_monitor/data/notifier/kyoshin_monitor_notifier.dart app/lib/feature/home/ui/page/home_map_layer_page.dart app/test/feature/kyoshin_monitor/kyoshin_monitor_settings_model_test.dart
git commit -m "Fix: 長周期データの取得レイヤーを地表に制限"
```

### Task 3: 運用知見を記録して全体を検証する

**Files:**
- Create: `docs/knowledge/20260816_lpgm_monitor_endpoints.md`

**Interfaces:**
- Consumes: 公式サイト JavaScript、HTTP 200/404 の実測、`ingen084/KyoshinMonitorLib` の責務分離。
- Produces: 配信経路変更時に再確認すべき URL、レイヤー制約、確認コマンドをまとめた運用知識。

- [ ] **Step 1: 配信仕様と確認手順を記録する**

```markdown
# 長周期地震動モニターの配信経路

- 通常データ: `/img_svr/data/map_img/RealTimeImg/{type}_{layer}/...`
- 長周期データ: `/monitor/data/data/map_img/RealTimeImg/{type}_s/...`
- 長周期データは地表 (`s`) のみで、地下 (`b`) を要求すると 404 になる。
- 配信形態は変更され得るため、公式サイト JavaScript と同時刻の HTTP 応答を確認する。
```

確認コマンドには `latest.json` の取得と、同一時刻の `jma_s`、`jma_b`、
`abrspmx_s`、`abrspmx_b` の HTTP ステータス比較を記載する。

- [ ] **Step 2: フォーマットと対象範囲の解析を実行する**

Run: `mise exec -- dart format packages/kyoshin_monitor_api/lib packages/kyoshin_monitor_api/test/src/api/lpgm_kyoshin_monitor_web_api_client_test.dart app/lib/feature/kyoshin_monitor/data/model/kyoshin_monitor_settings_model.dart app/lib/feature/kyoshin_monitor/data/notifier/kyoshin_monitor_notifier.dart app/lib/feature/home/ui/page/home_map_layer_page.dart app/test/feature/kyoshin_monitor/kyoshin_monitor_settings_model_test.dart`

Run: `mise exec -- dart analyze packages/kyoshin_monitor_api --fatal-infos`

Run: `mise exec -- flutter analyze app`

Expected: 変更に起因する error / warning / info がない。

- [ ] **Step 3: 回帰テストを新鮮な状態で再実行する**

Run: `mise exec -- dart test packages/kyoshin_monitor_api/test`

Run: `mise exec -- flutter test app/test/feature/kyoshin_monitor`

Expected: すべて PASS。

- [ ] **Step 4: 差分と禁止事項を確認する**

Run: `git --no-pager diff --check`

Run: `git --no-pager diff HEAD~3 -- packages/kyoshin_monitor_api app/lib/feature/kyoshin_monitor app/lib/feature/home/ui/page/home_map_layer_page.dart app/test/feature/kyoshin_monitor docs/knowledge`

Expected: 固定値フォールバック、ランダム値、`print()`、`dynamic`、`Object`、`!` の新規使用がない。

- [ ] **Step 5: 知識ドキュメントをコミットする**

```bash
git add docs/knowledge/20260816_lpgm_monitor_endpoints.md
git commit -m "Docs: LMoni配信経路の運用知識を記録"
```

- [ ] **Step 6: ブランチを push して修正 PR を作成する**

ブランチ名: `codex/fix-lpgm-monitor-routing`

PR タイトル: `Fix: 長周期地震動モニターの配信経路を修正`

PR 本文には根本原因、通常/LPGMの経路分離、地表制約、実行したテスト、
既存の未コミット変更を含めていないことを記載する。
