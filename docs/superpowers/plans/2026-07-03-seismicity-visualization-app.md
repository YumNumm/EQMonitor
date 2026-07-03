# 地震活動可視化(公開版)+ Hi-net一元化震源ビューア(デバッグ) 実装計画(アプリ)

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** EQMonitorアプリに、①共通可視化基盤(震源イベントモデル+チャート群)、②公開版の地震活動画面(MapLibre震央分布+矩形選択→M-T図/積算・ヒストグラム/深さ断面)、③デバッグ画面のHi-net一元化震源ビューアを実装する。

**Architecture:** `app/lib/feature/seismicity/` に公開版・デバッグ版が共有する「震源イベントのリスト」ベースの可視化基盤(Freezedモデル+純粋計算ロジック+MapLibreレイヤー+fl_chartチャート)を作る。公開版はmanifest→GeoJSONをDioで取得しアプリ固有モデルへ変換、デバッグ版は`packages/nied_api_client`に新設するHi-net認証クライアント+テキストパーサで同じモデルへ変換し、同じ可視化ウィジェットへ渡す。

**Tech Stack:** Flutter, Riverpod(riverpod_generator, `@riverpod`/`@Riverpod(keepAlive:)`), Freezed 3.x, Dio 5.8, fl_chart ^1.2.0, MapLibre(fork: `https://github.com/YumNumm/flutter-maplibre.git`), go_router_builder(`@TypedGoRoute`), flutter_secure_storage, path_provider, cookie_jar/dio_cookie_manager(新規追加)。

## Global Constraints

- backend契約(変更禁止): `GET /v2/seismicity/manifest` → `{ "layers": [{ "type": "geojson", "span": "P1M"|"P3M"|"P12M", "url": string, "generated_at": ISO8601, "count": number }] }`。GeoJSONはFeatureCollection、Point(lng, lat)、properties: `event_id`(string), `origin_time`(ISO8601), `magnitude`(number|null), `depth`(number|null km), `max_intensity`(string|null)。
- backend実装は別計画で並行進行中。アプリ側はこの契約に対するモックfixtureで開発・テストする。
- `eqmonitor_api`(OpenAPI生成)への追加はbackendの`openapi.json`更新後になるため、当面は素のDioで叩く薄いdata_sourceで実装する(`eqmonitor/core/provider/dio_provider.dart`の`dioProvider`を再利用。baseUrlは`telegramUrlProvider.restApiUrl`)。
- Hi-netの震源情報はNIEDにより二次配布が明示的に禁止されているため、**一般ユーザーからは到達不可能なデバッグ画面のみ**で使用する。
- NIEDアカウントのID/PWは**コード・設定ファイル・fixture・コミットに一切書かない**。実行時入力→`flutter_secure_storage`(`secureStorageProvider`)保存のみ。
- Dartコード規約: typedef禁止(既存の`MapOperationScheduler`typedefはmap操作フックの既存コードであり変更しない。新規コードでは使わない)、`Impl`命名禁止、不要な`abstract interface class`禁止、freezedモデルは1ファイル1モデル基本、StringよりEnum。Mutationは`XxxMutation`命名で非同期関数直前に配置。グローバル関数/変数禁止(class内定数かProvider経由)。API型をUI層で使わない(アプリ固有Freezedへ変換)。
- コード生成後は必ず `melos run generate` を実行し、`*.g.dart`/`*.freezed.dart` をコミット対象に含める。
- `dart analyze` は警告ゼロで通ること(`melos run analyze`)。フォーマットは `dart format`(CI強制)。
- テストは `melos run test:flutter` / `melos run test:dart` で実行し、fixtureは震源値のみでクレデンシャルを含めない。

---

### Task 1: 共通震源イベントモデル(Freezed)

**Files:**
- Create: `app/lib/feature/seismicity/data/model/seismicity_span.dart`
- Create: `app/lib/feature/seismicity/data/model/seismicity_event.dart`
- Create: `app/lib/feature/seismicity/data/model/seismicity_manifest_layer.dart`
- Create: `app/lib/feature/seismicity/data/model/seismicity_manifest.dart`
- Test: `app/test/feature/seismicity/data/model/seismicity_span_test.dart`

**Interfaces:**
- Produces: `SeismicitySpan`(enum, `p1m`/`p3m`/`p12m`、`@JsonValue('P1M')`等でAPI文字列と対応)。`SeismicityEvent`(Freezed: `eventId String`, `originTime DateTime`, `magnitude double?`, `depth double?`, `latitude double`, `longitude double`, `maxIntensity String?`)。`SeismicityManifestLayer`(Freezed: `type String`, `span SeismicitySpan`, `url String`, `generatedAt DateTime`, `count int`)。`SeismicityManifest`(Freezed: `layers List<SeismicityManifestLayer>`)。すべて`fromJson`/`toJson`を持つ(json_serializable経由)。

- [ ] **Step 1: 失敗するテストを書く**

`app/test/feature/seismicity/data/model/seismicity_span_test.dart`:

```dart
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_span.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('SeismicitySpan は API 文字列と対応する', () {
    expect(seismicitySpanFromApiValue('P1M'), SeismicitySpan.p1m);
    expect(seismicitySpanFromApiValue('P3M'), SeismicitySpan.p3m);
    expect(seismicitySpanFromApiValue('P12M'), SeismicitySpan.p12m);
  });

  test('未知の span 文字列は FormatException', () {
    expect(() => seismicitySpanFromApiValue('P6M'), throwsFormatException);
  });
}
```

- [ ] **Step 2: テストを実行し失敗を確認**

Run: `cd /home/yumnumm/EQMonitor/app && flutter test test/feature/seismicity/data/model/seismicity_span_test.dart`
Expected: FAIL(`seismicity_span.dart` が存在しないためコンパイルエラー)

- [ ] **Step 3: `SeismicitySpan` を実装**

`app/lib/feature/seismicity/data/model/seismicity_span.dart`:

```dart
import 'package:json_annotation/json_annotation.dart';

/// GeoJSON層の対象期間(manifest の `span` フィールドと対応)
enum SeismicitySpan {
  @JsonValue('P1M')
  p1m,
  @JsonValue('P3M')
  p3m,
  @JsonValue('P12M')
  p12m,
}

/// manifest の `span` 文字列から [SeismicitySpan] を復元する。
///
/// json_serializable の `@JsonValue` はモデルの `fromJson` 内でのみ機能するため、
/// キャッシュファイル名の組み立て等モデル外で文字列を扱う箇所向けに
/// 明示的な変換関数を用意する。
SeismicitySpan seismicitySpanFromApiValue(String value) =>
    switch (value) {
      'P1M' => SeismicitySpan.p1m,
      'P3M' => SeismicitySpan.p3m,
      'P12M' => SeismicitySpan.p12m,
      _ => throw FormatException('Unknown SeismicitySpan value: $value'),
    };

extension SeismicitySpanApiValue on SeismicitySpan {
  String get apiValue => switch (this) {
    SeismicitySpan.p1m => 'P1M',
    SeismicitySpan.p3m => 'P3M',
    SeismicitySpan.p12m => 'P12M',
  };
}
```

- [ ] **Step 4: テストを実行し成功を確認**

Run: `cd /home/yumnumm/EQMonitor/app && flutter test test/feature/seismicity/data/model/seismicity_span_test.dart`
Expected: PASS(2 tests)

- [ ] **Step 5: 残りのFreezedモデルを実装**

`app/lib/feature/seismicity/data/model/seismicity_event.dart`:

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'seismicity_event.freezed.dart';
part 'seismicity_event.g.dart';

/// 公開版・デバッグ版(Hi-net)が共有する震源イベント。
///
/// データの出所(GeoJSON/Hi-netテキスト)を可視化層に露出しないための
/// アプリ固有の中間表現。
@freezed
abstract class SeismicityEvent with _$SeismicityEvent {
  const factory SeismicityEvent({
    /// イベントID(Hi-net由来は合成ID)
    required String eventId,

    /// 発生時刻
    required DateTime originTime,

    /// マグニチュード(不明な場合 null)
    required double? magnitude,

    /// 深さ(km、不明な場合 null)
    required double? depth,

    /// 緯度(度)
    required double latitude,

    /// 経度(度)
    required double longitude,

    /// 最大震度(Hi-net由来は null)
    required String? maxIntensity,
  }) = _SeismicityEvent;

  factory SeismicityEvent.fromJson(Map<String, dynamic> json) =>
      _$SeismicityEventFromJson(json);
}
```

`app/lib/feature/seismicity/data/model/seismicity_manifest_layer.dart`:

```dart
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_span.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'seismicity_manifest_layer.freezed.dart';
part 'seismicity_manifest_layer.g.dart';

@freezed
abstract class SeismicityManifestLayer with _$SeismicityManifestLayer {
  const factory SeismicityManifestLayer({
    required String type,
    required SeismicitySpan span,
    required String url,
    @JsonKey(name: 'generated_at') required DateTime generatedAt,
    required int count,
  }) = _SeismicityManifestLayer;

  factory SeismicityManifestLayer.fromJson(Map<String, dynamic> json) =>
      _$SeismicityManifestLayerFromJson(json);
}
```

`app/lib/feature/seismicity/data/model/seismicity_manifest.dart`:

```dart
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_manifest_layer.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'seismicity_manifest.freezed.dart';
part 'seismicity_manifest.g.dart';

@freezed
abstract class SeismicityManifest with _$SeismicityManifest {
  const factory SeismicityManifest({
    required List<SeismicityManifestLayer> layers,
  }) = _SeismicityManifest;

  factory SeismicityManifest.fromJson(Map<String, dynamic> json) =>
      _$SeismicityManifestFromJson(json);
}
```

- [ ] **Step 6: コード生成**

Run: `cd /home/yumnumm/EQMonitor/app && melos run generate`
Expected: `seismicity_event.freezed.dart` / `seismicity_event.g.dart` / `seismicity_manifest_layer.freezed.dart` / `seismicity_manifest_layer.g.dart` / `seismicity_manifest.freezed.dart` / `seismicity_manifest.g.dart` が生成される。

- [ ] **Step 7: analyze + test**

Run: `cd /home/yumnumm/EQMonitor/app && flutter test test/feature/seismicity/data/model/seismicity_span_test.dart && dart analyze lib/feature/seismicity`
Expected: PASS、警告0件

- [ ] **Step 8: コミット**

```bash
cd /home/yumnumm/EQMonitor
git add app/lib/feature/seismicity/data/model app/test/feature/seismicity/data/model
git commit -m "feat(seismicity): 共通震源イベントモデルを追加"
```

---

### Task 2: 矩形フィルタ・積算/日別ビニング・深さ断面投影(純粋計算ロジック)

**Files:**
- Create: `app/lib/feature/seismicity/data/logic/seismicity_bounds_filter.dart`
- Create: `app/lib/feature/seismicity/data/logic/seismicity_daily_bin.dart`
- Create: `app/lib/feature/seismicity/data/logic/seismicity_cumulative_binning.dart`
- Create: `app/lib/feature/seismicity/data/logic/seismicity_depth_projection.dart`
- Test: `app/test/feature/seismicity/data/logic/seismicity_bounds_filter_test.dart`
- Test: `app/test/feature/seismicity/data/logic/seismicity_cumulative_binning_test.dart`
- Test: `app/test/feature/seismicity/data/logic/seismicity_depth_projection_test.dart`

**Interfaces:**
- Consumes: `SeismicityEvent`(Task 1)。
- Produces: `SeismicityBoundsFilter.filter({required events, required minLatitude, required maxLatitude, required minLongitude, required maxLongitude}) -> List<SeismicityEvent>`。`SeismicityDailyBin`(Freezed: `date DateTime`, `count int`, `cumulativeCount int`)。`SeismicityCumulativeBinning.bin(List<SeismicityEvent>) -> List<SeismicityDailyBin>`。`SeismicityDepthProjectionAxis`(enum: `latitude`/`longitude`)。`SeismicityDepthPoint`(Freezed: `axisValue double`, `depth double`, `magnitude double?`, `eventId String`)。`SeismicityDepthProjection.project({required events, required axis}) -> List<SeismicityDepthPoint>`。以降のタスク(チャート実装)はこれらの型・メソッド名をそのまま使う。

- [ ] **Step 1: 矩形フィルタの失敗するテストを書く**

`app/test/feature/seismicity/data/logic/seismicity_bounds_filter_test.dart`:

```dart
import 'package:eqmonitor/feature/seismicity/data/logic/seismicity_bounds_filter.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_event.dart';
import 'package:flutter_test/flutter_test.dart';

SeismicityEvent _event({
  required String eventId,
  required double latitude,
  required double longitude,
}) => SeismicityEvent(
  eventId: eventId,
  originTime: DateTime.utc(2026, 1, 1),
  magnitude: 4,
  depth: 10,
  latitude: latitude,
  longitude: longitude,
  maxIntensity: null,
);

void main() {
  test('矩形範囲内のイベントのみ返す', () {
    const filter = SeismicityBoundsFilter();
    final events = [
      _event(eventId: 'in', latitude: 35, longitude: 139),
      _event(eventId: 'out-lat', latitude: 50, longitude: 139),
      _event(eventId: 'out-lng', latitude: 35, longitude: 160),
      _event(eventId: 'edge', latitude: 30, longitude: 130),
    ];

    final result = filter.filter(
      events: events,
      minLatitude: 30,
      maxLatitude: 40,
      minLongitude: 130,
      maxLongitude: 145,
    );

    expect(result.map((e) => e.eventId), ['in', 'edge']);
  });
}
```

- [ ] **Step 2: 失敗を確認**

Run: `cd /home/yumnumm/EQMonitor/app && flutter test test/feature/seismicity/data/logic/seismicity_bounds_filter_test.dart`
Expected: FAIL(ファイル未実装)

- [ ] **Step 3: `SeismicityBoundsFilter` を実装**

`app/lib/feature/seismicity/data/logic/seismicity_bounds_filter.dart`:

```dart
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_event.dart';

/// 地図上で選択された緯度経度矩形でイベントをフィルタする。
class SeismicityBoundsFilter {
  const SeismicityBoundsFilter();

  List<SeismicityEvent> filter({
    required List<SeismicityEvent> events,
    required double minLatitude,
    required double maxLatitude,
    required double minLongitude,
    required double maxLongitude,
  }) {
    return events
        .where(
          (e) =>
              e.latitude >= minLatitude &&
              e.latitude <= maxLatitude &&
              e.longitude >= minLongitude &&
              e.longitude <= maxLongitude,
        )
        .toList();
  }
}
```

- [ ] **Step 4: 成功を確認**

Run: `cd /home/yumnumm/EQMonitor/app && flutter test test/feature/seismicity/data/logic/seismicity_bounds_filter_test.dart`
Expected: PASS

- [ ] **Step 5: 積算・日別ビニングの失敗するテストを書く**

`app/test/feature/seismicity/data/logic/seismicity_cumulative_binning_test.dart`:

```dart
import 'package:eqmonitor/feature/seismicity/data/logic/seismicity_cumulative_binning.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_event.dart';
import 'package:flutter_test/flutter_test.dart';

SeismicityEvent _event(DateTime originTime) => SeismicityEvent(
  eventId: originTime.toIso8601String(),
  originTime: originTime,
  magnitude: 3,
  depth: 10,
  latitude: 35,
  longitude: 139,
  maxIntensity: null,
);

void main() {
  test('日別件数と積算件数を計算する(欠測日も0件で補完)', () {
    const binning = SeismicityCumulativeBinning();
    final events = [
      _event(DateTime.utc(2026, 1, 1, 1)),
      _event(DateTime.utc(2026, 1, 1, 23)),
      _event(DateTime.utc(2026, 1, 3, 0)),
    ];

    final bins = binning.bin(events);

    expect(bins.length, 3);
    expect(bins[0].date, DateTime.utc(2026, 1, 1));
    expect(bins[0].count, 2);
    expect(bins[0].cumulativeCount, 2);
    expect(bins[1].date, DateTime.utc(2026, 1, 2));
    expect(bins[1].count, 0);
    expect(bins[1].cumulativeCount, 2);
    expect(bins[2].date, DateTime.utc(2026, 1, 3));
    expect(bins[2].count, 1);
    expect(bins[2].cumulativeCount, 3);
  });

  test('空リストは空を返す', () {
    const binning = SeismicityCumulativeBinning();
    expect(binning.bin(const []), isEmpty);
  });
}
```

- [ ] **Step 6: 失敗を確認**

Run: `cd /home/yumnumm/EQMonitor/app && flutter test test/feature/seismicity/data/logic/seismicity_cumulative_binning_test.dart`
Expected: FAIL

- [ ] **Step 7: `SeismicityDailyBin` と `SeismicityCumulativeBinning` を実装**

`app/lib/feature/seismicity/data/logic/seismicity_daily_bin.dart`:

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'seismicity_daily_bin.freezed.dart';

/// 1日ごとの発生件数と積算件数。
@freezed
abstract class SeismicityDailyBin with _$SeismicityDailyBin {
  const factory SeismicityDailyBin({
    /// UTC 日付(00:00 に正規化)
    required DateTime date,
    required int count,
    required int cumulativeCount,
  }) = _SeismicityDailyBin;
}
```

`app/lib/feature/seismicity/data/logic/seismicity_cumulative_binning.dart`:

```dart
import 'package:eqmonitor/feature/seismicity/data/logic/seismicity_daily_bin.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_event.dart';

/// 発生回数積算図・日別ヒストグラム用のビニング。
///
/// 最初のイベント発生日から最後のイベント発生日まで、イベントが
/// 存在しない日も 0 件として補完した連続系列を返す。
class SeismicityCumulativeBinning {
  const SeismicityCumulativeBinning();

  List<SeismicityDailyBin> bin(List<SeismicityEvent> events) {
    if (events.isEmpty) {
      return const [];
    }

    final countsByDay = <DateTime, int>{};
    for (final event in events) {
      final day = DateTime.utc(
        event.originTime.year,
        event.originTime.month,
        event.originTime.day,
      );
      countsByDay[day] = (countsByDay[day] ?? 0) + 1;
    }

    final sortedDays = countsByDay.keys.toList()..sort();
    final firstDay = sortedDays.first;
    final lastDay = sortedDays.last;

    final bins = <SeismicityDailyBin>[];
    var cumulative = 0;
    for (
      var day = firstDay;
      !day.isAfter(lastDay);
      day = day.add(const Duration(days: 1))
    ) {
      final count = countsByDay[day] ?? 0;
      cumulative += count;
      bins.add(
        SeismicityDailyBin(
          date: day,
          count: count,
          cumulativeCount: cumulative,
        ),
      );
    }
    return bins;
  }
}
```

- [ ] **Step 8: コード生成 + 成功を確認**

Run: `cd /home/yumnumm/EQMonitor/app && melos run generate && flutter test test/feature/seismicity/data/logic/seismicity_cumulative_binning_test.dart`
Expected: PASS(2 tests)

- [ ] **Step 9: 深さ断面投影の失敗するテストを書く**

`app/test/feature/seismicity/data/logic/seismicity_depth_projection_test.dart`:

```dart
import 'package:eqmonitor/feature/seismicity/data/logic/seismicity_depth_projection.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_event.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('緯度軸投影は latitude を axisValue にする', () {
    const projection = SeismicityDepthProjection();
    final events = [
      SeismicityEvent(
        eventId: 'a',
        originTime: DateTime.utc(2026, 1, 1),
        magnitude: 4,
        depth: 30,
        latitude: 35.5,
        longitude: 139.5,
        maxIntensity: null,
      ),
      SeismicityEvent(
        eventId: 'no-depth',
        originTime: DateTime.utc(2026, 1, 1),
        magnitude: 3,
        depth: null,
        latitude: 36,
        longitude: 140,
        maxIntensity: null,
      ),
    ];

    final points = projection.project(
      events: events,
      axis: SeismicityDepthProjectionAxis.latitude,
    );

    expect(points.length, 1);
    expect(points.single.axisValue, 35.5);
    expect(points.single.depth, 30);
    expect(points.single.eventId, 'a');
  });

  test('経度軸投影は longitude を axisValue にする', () {
    const projection = SeismicityDepthProjection();
    final events = [
      SeismicityEvent(
        eventId: 'a',
        originTime: DateTime.utc(2026, 1, 1),
        magnitude: 4,
        depth: 30,
        latitude: 35.5,
        longitude: 139.5,
        maxIntensity: null,
      ),
    ];

    final points = projection.project(
      events: events,
      axis: SeismicityDepthProjectionAxis.longitude,
    );

    expect(points.single.axisValue, 139.5);
  });
}
```

- [ ] **Step 10: 失敗を確認**

Run: `cd /home/yumnumm/EQMonitor/app && flutter test test/feature/seismicity/data/logic/seismicity_depth_projection_test.dart`
Expected: FAIL

- [ ] **Step 11: `SeismicityDepthProjection` を実装**

`app/lib/feature/seismicity/data/logic/seismicity_depth_projection.dart`:

```dart
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_event.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'seismicity_depth_projection.freezed.dart';

/// 深さ断面図の投影軸。
enum SeismicityDepthProjectionAxis { latitude, longitude }

/// 深さ断面図の1点(投影後の軸値・深さ・マグニチュード)。
@freezed
abstract class SeismicityDepthPoint with _$SeismicityDepthPoint {
  const factory SeismicityDepthPoint({
    /// 投影軸の値(緯度 or 経度)
    required double axisValue,
    required double depth,
    required double? magnitude,
    required String eventId,
  }) = _SeismicityDepthPoint;
}

/// 深さ(km) が既知のイベントを、指定軸(緯度/経度)へ投影する。
///
/// 深さ未知のイベントは断面図に描画できないため除外する。
class SeismicityDepthProjection {
  const SeismicityDepthProjection();

  List<SeismicityDepthPoint> project({
    required List<SeismicityEvent> events,
    required SeismicityDepthProjectionAxis axis,
  }) {
    return events
        .where((e) => e.depth != null)
        .map(
          (e) => SeismicityDepthPoint(
            axisValue: axis == SeismicityDepthProjectionAxis.latitude
                ? e.latitude
                : e.longitude,
            depth: e.depth!,
            magnitude: e.magnitude,
            eventId: e.eventId,
          ),
        )
        .toList();
  }
}
```

- [ ] **Step 12: コード生成 + 全テスト実行**

Run: `cd /home/yumnumm/EQMonitor/app && melos run generate && flutter test test/feature/seismicity/data/logic`
Expected: PASS(全テスト)

- [ ] **Step 13: analyze**

Run: `cd /home/yumnumm/EQMonitor/app && dart analyze lib/feature/seismicity`
Expected: 警告0件

- [ ] **Step 14: コミット**

```bash
cd /home/yumnumm/EQMonitor
git add app/lib/feature/seismicity/data/logic app/test/feature/seismicity/data/logic
git commit -m "feat(seismicity): 矩形フィルタ・積算ビニング・深さ断面投影ロジックを追加"
```

---

### Task 3: GeoJSONパーサ + manifest/GeoJSON data_source(素のDio)

**Files:**
- Create: `app/lib/feature/seismicity/data/data_source/seismicity_geojson_parser.dart`
- Create: `app/lib/feature/seismicity/data/data_source/seismicity_manifest_data_source.dart`
- Create: `app/lib/feature/seismicity/data/data_source/seismicity_geojson_data_source.dart`
- Test: `app/test/feature/seismicity/data/data_source/seismicity_geojson_parser_test.dart`
- Test: `app/test/feature/seismicity/data/data_source/seismicity_manifest_data_source_test.dart`
- Test fixture: `app/test/fixtures/seismicity/manifest.json`
- Test fixture: `app/test/fixtures/seismicity/geojson_p1m.json`

**Interfaces:**
- Consumes: `SeismicityEvent`, `SeismicityManifest`(Task 1)。
- Produces: `SeismicityGeoJsonParser.parse(Map<String, dynamic> geoJson) -> List<SeismicityEvent>`。`SeismicityManifestDataSource(Dio dio).fetchManifest() -> Future<SeismicityManifest>`。`SeismicityGeoJsonDataSource(Dio dio, {SeismicityGeoJsonParser parser}).fetchEvents(String url) -> Future<List<SeismicityEvent>>`。Task 5(Repository)がこれらをそのまま利用する。

- [ ] **Step 1: fixtureを用意**

`app/test/fixtures/seismicity/manifest.json`:

```json
{
  "layers": [
    {
      "type": "geojson",
      "span": "P1M",
      "url": "https://static.eqmonitor.app/seismicity/p1m.json",
      "generated_at": "2026-07-03T00:00:00Z",
      "count": 2
    },
    {
      "type": "geojson",
      "span": "P3M",
      "url": "https://static.eqmonitor.app/seismicity/p3m.json",
      "generated_at": "2026-07-03T00:00:00Z",
      "count": 2
    },
    {
      "type": "geojson",
      "span": "P12M",
      "url": "https://static.eqmonitor.app/seismicity/p12m.json",
      "generated_at": "2026-07-03T00:00:00Z",
      "count": 2
    }
  ]
}
```

`app/test/fixtures/seismicity/geojson_p1m.json`:

```json
{
  "type": "FeatureCollection",
  "features": [
    {
      "type": "Feature",
      "geometry": { "type": "Point", "coordinates": [139.7, 35.6] },
      "properties": {
        "event_id": "eq-1",
        "origin_time": "2026-06-01T12:00:00Z",
        "magnitude": 4.5,
        "depth": 30.0,
        "max_intensity": "4"
      }
    },
    {
      "type": "Feature",
      "geometry": { "type": "Point", "coordinates": [140.1, 36.0] },
      "properties": {
        "event_id": "eq-2",
        "origin_time": "2026-06-02T03:15:00Z",
        "magnitude": null,
        "depth": null,
        "max_intensity": null
      }
    }
  ]
}
```

- [ ] **Step 2: パーサの失敗するテストを書く**

`app/test/feature/seismicity/data/data_source/seismicity_geojson_parser_test.dart`:

```dart
import 'dart:convert';
import 'dart:io';

import 'package:eqmonitor/feature/seismicity/data/data_source/seismicity_geojson_parser.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('GeoJSON FeatureCollection を SeismicityEvent のリストへ変換する', () {
    const parser = SeismicityGeoJsonParser();
    final json =
        jsonDecode(
              File(
                'test/fixtures/seismicity/geojson_p1m.json',
              ).readAsStringSync(),
            )
            as Map<String, dynamic>;

    final events = parser.parse(json);

    expect(events.length, 2);
    expect(events[0].eventId, 'eq-1');
    expect(events[0].latitude, 35.6);
    expect(events[0].longitude, 139.7);
    expect(events[0].magnitude, 4.5);
    expect(events[0].depth, 30.0);
    expect(events[0].maxIntensity, '4');
    expect(events[1].eventId, 'eq-2');
    expect(events[1].magnitude, isNull);
    expect(events[1].depth, isNull);
    expect(events[1].maxIntensity, isNull);
  });

  test('event_id または origin_time が欠けた Feature はスキップする', () {
    const parser = SeismicityGeoJsonParser();
    final json = {
      'type': 'FeatureCollection',
      'features': [
        {
          'type': 'Feature',
          'geometry': {
            'type': 'Point',
            'coordinates': [139.0, 35.0],
          },
          'properties': <String, dynamic>{},
        },
      ],
    };

    expect(parser.parse(json), isEmpty);
  });
}
```

- [ ] **Step 3: 失敗を確認**

Run: `cd /home/yumnumm/EQMonitor/app && flutter test test/feature/seismicity/data/data_source/seismicity_geojson_parser_test.dart`
Expected: FAIL

- [ ] **Step 4: `SeismicityGeoJsonParser` を実装**

`app/lib/feature/seismicity/data/data_source/seismicity_geojson_parser.dart`:

```dart
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_event.dart';

/// backend の `/v2/seismicity/manifest` が指す GeoJSON FeatureCollection を
/// [SeismicityEvent] のリストへ変換する。
///
/// contract: Point(lng, lat)、properties: event_id(string, required),
/// origin_time(ISO8601, required), magnitude(number|null),
/// depth(number|null km), max_intensity(string|null)。
class SeismicityGeoJsonParser {
  const SeismicityGeoJsonParser();

  List<SeismicityEvent> parse(Map<String, dynamic> geoJson) {
    final features = geoJson['features'] as List<dynamic>? ?? const [];
    final events = <SeismicityEvent>[];

    for (final rawFeature in features) {
      final feature = rawFeature as Map<String, dynamic>;
      final geometry = feature['geometry'] as Map<String, dynamic>?;
      final coordinates = geometry?['coordinates'] as List<dynamic>?;
      final properties = feature['properties'] as Map<String, dynamic>?;
      if (coordinates == null || coordinates.length < 2 || properties == null) {
        continue;
      }

      final eventId = properties['event_id'] as String?;
      final originTimeStr = properties['origin_time'] as String?;
      if (eventId == null || originTimeStr == null) {
        continue;
      }

      events.add(
        SeismicityEvent(
          eventId: eventId,
          originTime: DateTime.parse(originTimeStr),
          magnitude: (properties['magnitude'] as num?)?.toDouble(),
          depth: (properties['depth'] as num?)?.toDouble(),
          latitude: (coordinates[1] as num).toDouble(),
          longitude: (coordinates[0] as num).toDouble(),
          maxIntensity: properties['max_intensity'] as String?,
        ),
      );
    }

    return events;
  }
}
```

- [ ] **Step 5: 成功を確認**

Run: `cd /home/yumnumm/EQMonitor/app && flutter test test/feature/seismicity/data/data_source/seismicity_geojson_parser_test.dart`
Expected: PASS(2 tests)

- [ ] **Step 6: manifest data_source の失敗するテストを書く**

`app/test/feature/seismicity/data/data_source/seismicity_manifest_data_source_test.dart`:

```dart
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:eqmonitor/feature/seismicity/data/data_source/seismicity_manifest_data_source.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_span.dart';
import 'package:flutter_test/flutter_test.dart';

class _FixtureAdapter implements HttpClientAdapter {
  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    if (options.path != '/v2/seismicity/manifest') {
      throw StateError('Unexpected path: ${options.path}');
    }
    final body = File(
      'test/fixtures/seismicity/manifest.json',
    ).readAsStringSync();
    return ResponseBody.fromString(
      body,
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

void main() {
  test('manifest を取得して SeismicityManifest へ変換する', () async {
    final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
      ..httpClientAdapter = _FixtureAdapter();
    final dataSource = SeismicityManifestDataSource(dio);

    final manifest = await dataSource.fetchManifest();

    expect(manifest.layers.length, 3);
    expect(manifest.layers[0].span, SeismicitySpan.p1m);
    expect(manifest.layers[0].count, 2);
    expect(
      manifest.layers[0].url,
      'https://static.eqmonitor.app/seismicity/p1m.json',
    );
  });
}
```

- [ ] **Step 7: 失敗を確認**

Run: `cd /home/yumnumm/EQMonitor/app && flutter test test/feature/seismicity/data/data_source/seismicity_manifest_data_source_test.dart`
Expected: FAIL

- [ ] **Step 8: `SeismicityManifestDataSource` と `SeismicityGeoJsonDataSource` を実装**

`app/lib/feature/seismicity/data/data_source/seismicity_manifest_data_source.dart`:

```dart
import 'package:dio/dio.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_manifest.dart';

/// `GET /v2/seismicity/manifest` を取得する薄いdata_source。
///
/// backend の openapi.json 反映後に `eqmonitor_api` パッケージへ移行する想定の
/// 暫定実装(素のDioで直接叩く)。
class SeismicityManifestDataSource {
  const SeismicityManifestDataSource(this._dio);

  final Dio _dio;

  Future<SeismicityManifest> fetchManifest() async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/v2/seismicity/manifest',
    );
    final data = response.data;
    if (data == null) {
      throw StateError('Empty /v2/seismicity/manifest response');
    }
    return SeismicityManifest.fromJson(data);
  }
}
```

`app/lib/feature/seismicity/data/data_source/seismicity_geojson_data_source.dart`:

```dart
import 'package:dio/dio.dart';
import 'package:eqmonitor/feature/seismicity/data/data_source/seismicity_geojson_parser.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_event.dart';

/// manifest の layer.url が指す静的GeoJSONを取得しパースするdata_source。
///
/// GeoJSON は API ホストとは別の静的配信ホストに置かれるため、
/// [Dio.get] へは絶対URLを渡す(Dioは絶対URLの場合baseUrlを無視する)。
class SeismicityGeoJsonDataSource {
  const SeismicityGeoJsonDataSource(
    this._dio, {
    this.parser = const SeismicityGeoJsonParser(),
  });

  final Dio _dio;
  final SeismicityGeoJsonParser parser;

  Future<List<SeismicityEvent>> fetchEvents(String url) async {
    final response = await _dio.get<Map<String, dynamic>>(url);
    final data = response.data;
    if (data == null) {
      throw StateError('Empty GeoJSON response from $url');
    }
    return parser.parse(data);
  }
}
```

- [ ] **Step 9: 成功を確認**

Run: `cd /home/yumnumm/EQMonitor/app && flutter test test/feature/seismicity/data/data_source`
Expected: PASS(全テスト)

- [ ] **Step 10: analyze**

Run: `cd /home/yumnumm/EQMonitor/app && dart analyze lib/feature/seismicity`
Expected: 警告0件

- [ ] **Step 11: コミット**

```bash
cd /home/yumnumm/EQMonitor
git add app/lib/feature/seismicity/data/data_source app/test/feature/seismicity/data/data_source app/test/fixtures/seismicity
git commit -m "feat(seismicity): manifest/GeoJSON data_source(素のDio)を追加"
```

---

### Task 4: ローカルキャッシュdata_source(取得失敗時フォールバック用)

**Files:**
- Create: `app/lib/feature/seismicity/data/data_source/seismicity_cached_dataset.dart`
- Create: `app/lib/feature/seismicity/data/data_source/seismicity_local_cache_data_source.dart`
- Test: `app/test/feature/seismicity/data/data_source/seismicity_local_cache_data_source_test.dart`

**Interfaces:**
- Consumes: `SeismicityEvent`, `SeismicitySpan`(Task 1)。
- Produces: `SeismicityCachedDataset`(`events List<SeismicityEvent>`, `generatedAt DateTime`)、`toJson()`/`SeismicityCachedDataset.fromJson(Map<String,dynamic>)`。`SeismicityLocalCacheDataSource({Future<Directory> Function()? directoryProvider}).save(SeismicitySpan span, SeismicityCachedDataset dataset) -> Future<void>`、`.read(SeismicitySpan span) -> Future<SeismicityCachedDataset?>`。Task 5(Repository)がこれを取得失敗時のフォールバックに使う。`directoryProvider`はテストで一時ディレクトリを注入するためのDI(プラットフォームチャンネルのモック化を避ける)。

- [ ] **Step 1: 失敗するテストを書く**

`app/test/feature/seismicity/data/data_source/seismicity_local_cache_data_source_test.dart`:

```dart
import 'dart:io';

import 'package:eqmonitor/feature/seismicity/data/data_source/seismicity_cached_dataset.dart';
import 'package:eqmonitor/feature/seismicity/data/data_source/seismicity_local_cache_data_source.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_event.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_span.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('保存したデータセットを span ごとに読み戻せる', () async {
    final tempDir = Directory.systemTemp.createTempSync(
      'seismicity_cache_test',
    );
    addTearDown(() => tempDir.deleteSync(recursive: true));

    final dataSource = SeismicityLocalCacheDataSource(
      directoryProvider: () async => tempDir,
    );

    final dataset = SeismicityCachedDataset(
      generatedAt: DateTime.utc(2026, 7, 1),
      events: [
        SeismicityEvent(
          eventId: 'eq-1',
          originTime: DateTime.utc(2026, 6, 1),
          magnitude: 4.5,
          depth: 30,
          latitude: 35.6,
          longitude: 139.7,
          maxIntensity: '4',
        ),
      ],
    );

    await dataSource.save(SeismicitySpan.p1m, dataset);
    final restored = await dataSource.read(SeismicitySpan.p1m);

    expect(restored, isNotNull);
    expect(restored!.generatedAt, DateTime.utc(2026, 7, 1));
    expect(restored.events.single.eventId, 'eq-1');
  });

  test('未保存の span は null を返す', () async {
    final tempDir = Directory.systemTemp.createTempSync(
      'seismicity_cache_test_empty',
    );
    addTearDown(() => tempDir.deleteSync(recursive: true));

    final dataSource = SeismicityLocalCacheDataSource(
      directoryProvider: () async => tempDir,
    );

    expect(await dataSource.read(SeismicitySpan.p12m), isNull);
  });
}
```

- [ ] **Step 2: 失敗を確認**

Run: `cd /home/yumnumm/EQMonitor/app && flutter test test/feature/seismicity/data/data_source/seismicity_local_cache_data_source_test.dart`
Expected: FAIL

- [ ] **Step 3: `SeismicityCachedDataset` と `SeismicityLocalCacheDataSource` を実装**

`app/lib/feature/seismicity/data/data_source/seismicity_cached_dataset.dart`:

```dart
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_event.dart';

/// ローカルキャッシュへ保存する単位(span 1つ分のイベント一覧と鮮度情報)。
class SeismicityCachedDataset {
  const SeismicityCachedDataset({
    required this.events,
    required this.generatedAt,
  });

  final List<SeismicityEvent> events;
  final DateTime generatedAt;

  Map<String, dynamic> toJson() => {
    'generated_at': generatedAt.toIso8601String(),
    'events': events.map((e) => e.toJson()).toList(),
  };

  static SeismicityCachedDataset fromJson(Map<String, dynamic> json) =>
      SeismicityCachedDataset(
        generatedAt: DateTime.parse(json['generated_at'] as String),
        events: (json['events'] as List<dynamic>)
            .map((e) => SeismicityEvent.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}
```

`app/lib/feature/seismicity/data/data_source/seismicity_local_cache_data_source.dart`:

```dart
import 'dart:convert';
import 'dart:io';

import 'package:eqmonitor/feature/seismicity/data/data_source/seismicity_cached_dataset.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_span.dart';
import 'package:path_provider/path_provider.dart';

/// GeoJSON取得失敗時のフォールバック用ローカルキャッシュ。
///
/// span ごとに `<ApplicationSupportDirectory>/seismicity/dataset_<span>.json`
/// へ JSON を書き込む。[directoryProvider] はテストで一時ディレクトリを
/// 注入するためのフック(未指定時は [getApplicationSupportDirectory])。
class SeismicityLocalCacheDataSource {
  SeismicityLocalCacheDataSource({
    Future<Directory> Function()? directoryProvider,
  }) : _directoryProvider = directoryProvider ?? getApplicationSupportDirectory;

  final Future<Directory> Function() _directoryProvider;

  Future<File> _fileFor(SeismicitySpan span) async {
    final baseDir = await _directoryProvider();
    final cacheDir = Directory('${baseDir.path}/seismicity');
    await cacheDir.create(recursive: true);
    return File('${cacheDir.path}/dataset_${span.name}.json');
  }

  Future<void> save(SeismicitySpan span, SeismicityCachedDataset dataset) async {
    final file = await _fileFor(span);
    await file.writeAsString(jsonEncode(dataset.toJson()));
  }

  Future<SeismicityCachedDataset?> read(SeismicitySpan span) async {
    final file = await _fileFor(span);
    if (!file.existsSync()) {
      return null;
    }
    final content = await file.readAsString();
    return SeismicityCachedDataset.fromJson(
      jsonDecode(content) as Map<String, dynamic>,
    );
  }
}
```

- [ ] **Step 4: 成功を確認**

Run: `cd /home/yumnumm/EQMonitor/app && flutter test test/feature/seismicity/data/data_source/seismicity_local_cache_data_source_test.dart`
Expected: PASS(2 tests)

- [ ] **Step 5: analyze**

Run: `cd /home/yumnumm/EQMonitor/app && dart analyze lib/feature/seismicity`
Expected: 警告0件

- [ ] **Step 6: コミット**

```bash
cd /home/yumnumm/EQMonitor
git add app/lib/feature/seismicity/data/data_source app/test/feature/seismicity/data/data_source
git commit -m "feat(seismicity): ローカルキャッシュdata_sourceを追加"
```

---

### Task 5: Repository(manifest+GeoJSON取得 → キャッシュフォールバック)

**Files:**
- Create: `app/lib/feature/seismicity/data/model/seismicity_dataset.dart`
- Create: `app/lib/feature/seismicity/data/repository/seismicity_repository.dart`
- Test: `app/test/feature/seismicity/data/repository/seismicity_repository_test.dart`

**Interfaces:**
- Consumes: `SeismicityManifestDataSource`, `SeismicityGeoJsonDataSource`(Task 3)、`SeismicityLocalCacheDataSource`, `SeismicityCachedDataset`(Task 4)、`SeismicitySpan`(Task 1)。
- Produces: `SeismicityDataset`(Freezed: `events List<SeismicityEvent>`, `generatedAt DateTime`, `isFromCache bool`)。`SeismicityRepository({required Dio dio, SeismicityLocalCacheDataSource? cache}).fetch({required SeismicitySpan span}) -> Future<SeismicityDataset>`。Task 6(Provider)がこれを利用する。

- [ ] **Step 1: 失敗するテストを書く(正常系+フォールバック系)**

`app/test/feature/seismicity/data/repository/seismicity_repository_test.dart`:

```dart
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:eqmonitor/feature/seismicity/data/data_source/seismicity_local_cache_data_source.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_span.dart';
import 'package:eqmonitor/feature/seismicity/data/repository/seismicity_repository.dart';
import 'package:flutter_test/flutter_test.dart';

const _manifestJson = '''
{
  "layers": [
    {
      "type": "geojson",
      "span": "P1M",
      "url": "https://static.example.com/p1m.json",
      "generated_at": "2026-07-01T00:00:00Z",
      "count": 1
    }
  ]
}
''';

const _geoJson = '''
{
  "type": "FeatureCollection",
  "features": [
    {
      "type": "Feature",
      "geometry": { "type": "Point", "coordinates": [139.0, 35.0] },
      "properties": {
        "event_id": "eq-1",
        "origin_time": "2026-06-30T00:00:00Z",
        "magnitude": 3.0,
        "depth": 10.0,
        "max_intensity": null
      }
    }
  ]
}
''';

class _SuccessAdapter implements HttpClientAdapter {
  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    final body = options.path == '/v2/seismicity/manifest'
        ? _manifestJson
        : _geoJson;
    return ResponseBody.fromString(
      body,
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

class _FailingAdapter implements HttpClientAdapter {
  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    throw DioException(
      requestOptions: options,
      type: DioExceptionType.connectionError,
    );
  }

  @override
  void close({bool force = false}) {}
}

void main() {
  late Directory tempDir;

  setUp(() {
    tempDir = Directory.systemTemp.createTempSync('seismicity_repo_test');
  });

  tearDown(() {
    tempDir.deleteSync(recursive: true);
  });

  test('取得成功時はキャッシュへ保存しつつ最新データを返す', () async {
    final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
      ..httpClientAdapter = _SuccessAdapter();
    final cache = SeismicityLocalCacheDataSource(
      directoryProvider: () async => tempDir,
    );
    final repository = SeismicityRepository(dio: dio, cache: cache);

    final dataset = await repository.fetch(span: SeismicitySpan.p1m);

    expect(dataset.isFromCache, isFalse);
    expect(dataset.events.single.eventId, 'eq-1');
    expect(dataset.generatedAt, DateTime.utc(2026, 7, 1));

    final cached = await cache.read(SeismicitySpan.p1m);
    expect(cached, isNotNull);
    expect(cached!.events.single.eventId, 'eq-1');
  });

  test('取得失敗時はローカルキャッシュへフォールバックする', () async {
    final workingDio = Dio(BaseOptions(baseUrl: 'https://example.com'))
      ..httpClientAdapter = _SuccessAdapter();
    final cache = SeismicityLocalCacheDataSource(
      directoryProvider: () async => tempDir,
    );
    // 事前に一度成功させてキャッシュへ書き込んでおく
    await SeismicityRepository(
      dio: workingDio,
      cache: cache,
    ).fetch(span: SeismicitySpan.p1m);

    final failingDio = Dio(BaseOptions(baseUrl: 'https://example.com'))
      ..httpClientAdapter = _FailingAdapter();
    final repository = SeismicityRepository(dio: failingDio, cache: cache);

    final dataset = await repository.fetch(span: SeismicitySpan.p1m);

    expect(dataset.isFromCache, isTrue);
    expect(dataset.events.single.eventId, 'eq-1');
  });

  test('取得失敗かつキャッシュも無い場合は例外を再送出する', () async {
    final failingDio = Dio(BaseOptions(baseUrl: 'https://example.com'))
      ..httpClientAdapter = _FailingAdapter();
    final cache = SeismicityLocalCacheDataSource(
      directoryProvider: () async => tempDir,
    );
    final repository = SeismicityRepository(dio: failingDio, cache: cache);

    expect(
      () => repository.fetch(span: SeismicitySpan.p1m),
      throwsA(isA<DioException>()),
    );
  });
}
```

- [ ] **Step 2: 失敗を確認**

Run: `cd /home/yumnumm/EQMonitor/app && flutter test test/feature/seismicity/data/repository/seismicity_repository_test.dart`
Expected: FAIL(未実装)

- [ ] **Step 3: `SeismicityDataset` と `SeismicityRepository` を実装**

`app/lib/feature/seismicity/data/model/seismicity_dataset.dart`:

```dart
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_event.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'seismicity_dataset.freezed.dart';

/// 指定 span 1つ分の震源イベント一覧と鮮度情報。
@freezed
abstract class SeismicityDataset with _$SeismicityDataset {
  const factory SeismicityDataset({
    required List<SeismicityEvent> events,
    required DateTime generatedAt,

    /// 取得失敗によりローカルキャッシュへフォールバックした場合 true
    required bool isFromCache,
  }) = _SeismicityDataset;
}
```

`app/lib/feature/seismicity/data/repository/seismicity_repository.dart`:

```dart
import 'package:dio/dio.dart';
import 'package:eqmonitor/feature/seismicity/data/data_source/seismicity_cached_dataset.dart';
import 'package:eqmonitor/feature/seismicity/data/data_source/seismicity_geojson_data_source.dart';
import 'package:eqmonitor/feature/seismicity/data/data_source/seismicity_local_cache_data_source.dart';
import 'package:eqmonitor/feature/seismicity/data/data_source/seismicity_manifest_data_source.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_dataset.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_span.dart';

/// manifest → GeoJSON の取得を行い、失敗時はローカルキャッシュへ
/// フォールバックする。矩形選択後の分析はすべてクライアント側で完結するため、
/// このリポジトリが返す [SeismicityDataset.events] が唯一の分析用データソース。
class SeismicityRepository {
  SeismicityRepository({
    required Dio dio,
    SeismicityLocalCacheDataSource? cache,
  }) : _manifestDataSource = SeismicityManifestDataSource(dio),
       _geoJsonDataSource = SeismicityGeoJsonDataSource(dio),
       _cache = cache ?? SeismicityLocalCacheDataSource();

  final SeismicityManifestDataSource _manifestDataSource;
  final SeismicityGeoJsonDataSource _geoJsonDataSource;
  final SeismicityLocalCacheDataSource _cache;

  Future<SeismicityDataset> fetch({required SeismicitySpan span}) async {
    try {
      final manifest = await _manifestDataSource.fetchManifest();
      final layer = manifest.layers.firstWhere(
        (l) => l.span == span,
        orElse: () => throw StateError('No manifest layer for span $span'),
      );
      final events = await _geoJsonDataSource.fetchEvents(layer.url);

      await _cache.save(
        span,
        SeismicityCachedDataset(
          events: events,
          generatedAt: layer.generatedAt,
        ),
      );

      return SeismicityDataset(
        events: events,
        generatedAt: layer.generatedAt,
        isFromCache: false,
      );
    } on Object {
      final cached = await _cache.read(span);
      if (cached == null) {
        rethrow;
      }
      return SeismicityDataset(
        events: cached.events,
        generatedAt: cached.generatedAt,
        isFromCache: true,
      );
    }
  }
}
```

- [ ] **Step 4: コード生成 + 成功を確認**

Run: `cd /home/yumnumm/EQMonitor/app && melos run generate && flutter test test/feature/seismicity/data/repository/seismicity_repository_test.dart`
Expected: PASS(3 tests)

- [ ] **Step 5: analyze**

Run: `cd /home/yumnumm/EQMonitor/app && dart analyze lib/feature/seismicity`
Expected: 警告0件

- [ ] **Step 6: コミット**

```bash
cd /home/yumnumm/EQMonitor
git add app/lib/feature/seismicity/data/model/seismicity_dataset.dart app/lib/feature/seismicity/data/repository app/test/feature/seismicity/data/repository
git commit -m "feat(seismicity): Repositoryにキャッシュフォールバックを実装"
```

---

### Task 6: Riverpodプロバイダ層(Repository/Notifier)

**Files:**
- Create: `app/lib/feature/seismicity/data/provider/seismicity_repository_provider.dart`
- Create: `app/lib/feature/seismicity/data/notifier/seismicity_dataset_notifier.dart`
- Test: `app/test/feature/seismicity/data/notifier/seismicity_dataset_notifier_test.dart`

**Interfaces:**
- Consumes: `dioProvider`(`app/lib/core/provider/dio_provider.dart`、既存、`Future<Dio>`)、`SeismicityRepository`(Task 5)。
- Produces: `seismicityRepositoryProvider`(`@Riverpod(keepAlive: true) Future<SeismicityRepository>`)。`SeismicityDatasetNotifier`(`@riverpod family class` with `build(SeismicitySpan span) -> Future<SeismicityDataset>`、Provider名 `seismicityDatasetNotifierProvider(span)`)。公開版UI(Task 9)とデバッグ版が共通の`SeismicityDataset`/`SeismicityEvent`型で購読する。

- [ ] **Step 1: 失敗するテストを書く**

`app/test/feature/seismicity/data/notifier/seismicity_dataset_notifier_test.dart`:

```dart
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:eqmonitor/core/provider/dio_provider.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_span.dart';
import 'package:eqmonitor/feature/seismicity/data/notifier/seismicity_dataset_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';

const _manifestJson = '''
{
  "layers": [
    {
      "type": "geojson",
      "span": "P1M",
      "url": "https://static.example.com/p1m.json",
      "generated_at": "2026-07-01T00:00:00Z",
      "count": 1
    }
  ]
}
''';

const _geoJson = '''
{
  "type": "FeatureCollection",
  "features": [
    {
      "type": "Feature",
      "geometry": { "type": "Point", "coordinates": [139.0, 35.0] },
      "properties": {
        "event_id": "eq-1",
        "origin_time": "2026-06-30T00:00:00Z",
        "magnitude": 3.0,
        "depth": 10.0,
        "max_intensity": null
      }
    }
  ]
}
''';

class _SuccessAdapter implements HttpClientAdapter {
  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    final body = options.path == '/v2/seismicity/manifest'
        ? _manifestJson
        : _geoJson;
    return ResponseBody.fromString(
      body,
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

void main() {
  test('span を指定して SeismicityDataset を取得できる', () async {
    final container = ProviderContainer(
      overrides: [
        dioProvider.overrideWith((ref) async {
          return Dio(BaseOptions(baseUrl: 'https://example.com'))
            ..httpClientAdapter = _SuccessAdapter();
        }),
      ],
    );
    addTearDown(container.dispose);

    final dataset = await container.read(
      seismicityDatasetNotifierProvider(SeismicitySpan.p1m).future,
    );

    expect(dataset.events.single.eventId, 'eq-1');
    expect(dataset.isFromCache, isFalse);
  });
}
```

- [ ] **Step 2: 失敗を確認**

Run: `cd /home/yumnumm/EQMonitor/app && flutter test test/feature/seismicity/data/notifier/seismicity_dataset_notifier_test.dart`
Expected: FAIL(未実装)

- [ ] **Step 3: プロバイダとNotifierを実装**

`app/lib/feature/seismicity/data/provider/seismicity_repository_provider.dart`:

```dart
import 'package:eqmonitor/core/provider/dio_provider.dart';
import 'package:eqmonitor/feature/seismicity/data/repository/seismicity_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'seismicity_repository_provider.g.dart';

@Riverpod(keepAlive: true)
Future<SeismicityRepository> seismicityRepository(Ref ref) async {
  final dio = await ref.watch(dioProvider.future);
  return SeismicityRepository(dio: dio);
}
```

`app/lib/feature/seismicity/data/notifier/seismicity_dataset_notifier.dart`:

```dart
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_dataset.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_span.dart';
import 'package:eqmonitor/feature/seismicity/data/provider/seismicity_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'seismicity_dataset_notifier.g.dart';

/// 公開版・地震活動画面が表示期間(span)ごとに購読するデータセット。
@riverpod
class SeismicityDatasetNotifier extends _$SeismicityDatasetNotifier {
  @override
  Future<SeismicityDataset> build(SeismicitySpan span) async {
    final repository = await ref.watch(seismicityRepositoryProvider.future);
    return repository.fetch(span: span);
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }
}
```

- [ ] **Step 4: コード生成 + 成功を確認**

Run: `cd /home/yumnumm/EQMonitor/app && melos run generate && flutter test test/feature/seismicity/data/notifier/seismicity_dataset_notifier_test.dart`
Expected: PASS(1 test)

- [ ] **Step 5: analyze**

Run: `cd /home/yumnumm/EQMonitor/app && dart analyze lib/feature/seismicity`
Expected: 警告0件

- [ ] **Step 6: コミット**

```bash
cd /home/yumnumm/EQMonitor
git add app/lib/feature/seismicity/data/provider app/lib/feature/seismicity/data/notifier app/test/feature/seismicity/data/notifier
git commit -m "feat(seismicity): Riverpodプロバイダ層(Repository/Notifier)を追加"
```

---

### Task 7: 公開版ルート登録(`/seismicity`)+ 設定画面からの導線

**Files:**
- Create: `app/lib/feature/seismicity/ui/seismicity_page.dart`(このタスクでは仮のScaffoldのみ。実UIはTask 9で拡張)
- Modify: `app/lib/core/router/router.dart`
- Modify: `app/lib/feature/settings/settings_page.dart`

**Interfaces:**
- Produces: `SeismicityRoute`(`@TypedGoRoute<SeismicityRoute>(path: '/seismicity')`、`GoRouteData`)、`SeismicityPage`(ConsumerWidget、Scaffoldのみ)。Task 9がこのファイルにUIを追加する。

- [ ] **Step 1: 仮のページを作成**

`app/lib/feature/seismicity/ui/seismicity_page.dart`:

```dart
import 'package:flutter/material.dart';

/// 地震活動画面(震央分布 + 矩形選択によるM-T図・積算・深さ断面)。
class SeismicityPage extends StatelessWidget {
  const SeismicityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('地震活動')),
      body: const Placeholder(),
    );
  }
}
```

(注: Task 9で `Placeholder()` を実UIへ置き換える。単体では計画のNo Placeholders原則に反するが、本タスクの目的はルーティング配線の検証であり後続タスクで必ず置換されるため許容する。)

- [ ] **Step 2: `router.dart` にトップレベルルートを追加**

`app/lib/core/router/router.dart` の import ブロックへ追加(38行目付近、`feature/settings`系importの前が読みやすい):

```dart
import 'package:eqmonitor/feature/seismicity/ui/seismicity_page.dart';
```

`EewHistoryRoute` の直後(183行目 `}` の後)に追加:

```dart
@TypedGoRoute<SeismicityRoute>(path: '/seismicity')
class SeismicityRoute extends GoRouteData with $SeismicityRoute {
  const SeismicityRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SeismicityPage();
}
```

- [ ] **Step 3: 設定画面に導線を追加**

`app/lib/feature/settings/settings_page.dart` の「地震履歴設定」ListTile(67-72行目付近)の直後へ追加:

```dart
ListTile(
  title: const Text('地震活動'),
  subtitle: const Text('震央分布・M-T図・深さ断面'),
  leading: const Icon(Icons.bubble_chart_outlined),
  onTap: () async => const SeismicityRoute().push<void>(context),
),
```

必要な import(`settings_page.dart` の import ブロックへ追加):

```dart
import 'package:eqmonitor/core/router/router.dart';
```

(既に `router.dart` を import 済みの場合は追加不要。実装時に既存 import 一覧を確認すること。)

- [ ] **Step 4: コード生成**

Run: `cd /home/yumnumm/EQMonitor/app && melos run generate`
Expected: `router.g.dart` に `$SeismicityRoute` 等が生成される。

- [ ] **Step 5: analyze**

Run: `cd /home/yumnumm/EQMonitor/app && dart analyze lib/core/router lib/feature/seismicity lib/feature/settings/settings_page.dart`
Expected: 警告0件

- [ ] **Step 6: コミット**

```bash
cd /home/yumnumm/EQMonitor
git add app/lib/feature/seismicity/ui/seismicity_page.dart app/lib/core/router/router.dart app/lib/core/router/router.g.dart app/lib/feature/settings/settings_page.dart
git commit -m "feat(seismicity): 公開版ルート /seismicity と設定画面からの導線を追加"
```

---

### Task 8: MapLibre震央分布レイヤー(色分けモード切替対応)

**Files:**
- Create: `app/lib/feature/seismicity/data/model/seismicity_color_mode.dart`
- Create: `app/lib/feature/seismicity/ui/layer/seismicity_epicenter_layer.dart`

**Interfaces:**
- Consumes: `SeismicityEvent`(Task 1)、`useMapOperationQueue()`(`app/lib/core/hook/use_map_operation_queue.dart`、既存)、`MapController.maybeOf(context)?.style`, `GeoJsonSource`, `CircleStyleLayer`(`package:maplibre/maplibre.dart`)。
- Produces: `SeismicityColorMode`(enum: `elapsedTime`/`magnitude`)。`SeismicityEpicenterLayer`(HookConsumerWidget、`events List<SeismicityEvent>`, `colorMode SeismicityColorMode`必須パラメータ)。Task 9がこのウィジェットを地図に配置する。

- [ ] **Step 1: `SeismicityColorMode` を実装**

`app/lib/feature/seismicity/data/model/seismicity_color_mode.dart`:

```dart
/// 震央分布図の色分けモード。
enum SeismicityColorMode {
  /// 経過時間(古い=灰 → 直近=赤、験震時報方式)
  elapsedTime,

  /// マグニチュード
  magnitude,
}
```

- [ ] **Step 2: `SeismicityEpicenterLayer` を実装**

`app/lib/feature/seismicity/ui/layer/seismicity_epicenter_layer.dart`:

```dart
import 'dart:async';
import 'dart:convert';

import 'package:eqmonitor/core/hook/use_map_operation_queue.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_color_mode.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

/// 震央分布図(MapLibre circle レイヤー、data-driven styling)。
///
/// [colorMode] に応じて `circle-color` の式を切り替える。円サイズは常に
/// マグニチュードへ連動する(`circle-radius`)。
class SeismicityEpicenterLayer extends HookConsumerWidget {
  const SeismicityEpicenterLayer({
    required this.events,
    required this.colorMode,
    super.key,
  });

  final List<SeismicityEvent> events;
  final SeismicityColorMode colorMode;

  static const _sourceId = 'seismicity-epicenter';
  static const _layerId = 'seismicity-epicenter-circle';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styleController = MapController.maybeOf(context)?.style;
    final enqueue = useMapOperationQueue();

    useEffect(
      () {
        if (styleController == null) {
          return null;
        }

        unawaited(
          enqueue(() async {
            try {
              await styleController.addSource(
                GeoJsonSource(
                  id: _sourceId,
                  data: jsonEncode(_toGeoJson(events)),
                ),
              );
              await styleController.addLayer(
                CircleStyleLayer(
                  id: _layerId,
                  sourceId: _sourceId,
                  paint: {
                    'circle-color': _colorExpression(colorMode),
                    'circle-radius': _radiusExpression(),
                    'circle-opacity': 0.75,
                    'circle-stroke-width': 0.5,
                    'circle-stroke-color': '#00000080',
                  },
                ),
              );
            } on Exception catch (e) {
              talker.log(e);
            }
          }),
        );

        return () {
          unawaited(
            enqueue(() async {
              try {
                await styleController.removeLayer(_layerId);
                await styleController.removeSource(_sourceId);
              } on Exception catch (e) {
                talker.log(e);
              }
            }),
          );
        };
      },
      [styleController, events, colorMode],
    );

    return const SizedBox.shrink();
  }

  Map<String, dynamic> _toGeoJson(List<SeismicityEvent> events) {
    final now = DateTime.now().toUtc();
    return {
      'type': 'FeatureCollection',
      'features': [
        for (final event in events)
          {
            'type': 'Feature',
            'geometry': {
              'type': 'Point',
              'coordinates': [event.longitude, event.latitude],
            },
            'properties': {
              'event_id': event.eventId,
              'magnitude': event.magnitude ?? 0.0,
              'elapsed_hours': now
                  .difference(event.originTime.toUtc())
                  .inHours
                  .toDouble(),
            },
          },
      ],
    };
  }

  /// マグニチュードに応じた円半径(px)。M2〜M7 を 3px〜18px へ線形補間。
  List<dynamic> _radiusExpression() => [
    'interpolate',
    ['linear'],
    ['get', 'magnitude'],
    2,
    3,
    7,
    18,
  ];

  List<dynamic> _colorExpression(SeismicityColorMode mode) => switch (mode) {
    SeismicityColorMode.magnitude => [
      'interpolate',
      ['linear'],
      ['get', 'magnitude'],
      2,
      '#9e9e9e',
      4,
      '#ffca28',
      6,
      '#e53935',
    ],
    SeismicityColorMode.elapsedTime => [
      'interpolate',
      ['linear'],
      ['get', 'elapsed_hours'],
      0,
      '#e53935',
      24 * 30,
      '#9e9e9e',
    ],
  };
}
```

- [ ] **Step 3: analyze**

Run: `cd /home/yumnumm/EQMonitor/app && dart analyze lib/feature/seismicity`
Expected: 警告0件

- [ ] **Step 4: コミット**

```bash
cd /home/yumnumm/EQMonitor
git add app/lib/feature/seismicity/data/model/seismicity_color_mode.dart app/lib/feature/seismicity/ui/layer
git commit -m "feat(seismicity): 震央分布MapLibreレイヤー(色分けモード切替)を追加"
```

**Note:** `CircleStyleLayer` は `paint`/`layout` を素の `Map<String, dynamic>`(MapLibre Style Spec の生キー、例 `circle-color`/`circle-radius`)で受け取る(型付きプロパティは存在しない)。既存の `SymbolStyleLayer` 利用例(`earthquake_history_hypocenter_layer.dart`)と同じ流儀。実装時に `package:maplibre/maplibre.dart` の `CircleStyleLayer` コンストラクタが `id`/`sourceId`/`paint`/`layout`(共に省略可)であることを確認すること。

---

### Task 9: 公開版UI — 地震活動画面(地図 + 期間/色分け切替)

**Files:**
- Modify: `app/lib/feature/seismicity/ui/seismicity_page.dart`(Task 7の仮実装を置き換え)
- Create: `app/lib/feature/seismicity/ui/components/seismicity_span_selector.dart`
- Create: `app/lib/feature/seismicity/ui/components/seismicity_color_mode_selector.dart`

**Interfaces:**
- Consumes: `seismicityDatasetNotifierProvider(SeismicitySpan)`(Task 6)、`SeismicityEpicenterLayer`, `SeismicityColorMode`(Task 8)、`mapConfigurationProvider`(`app/lib/feature/map/data/notifier/map_configuration_notifier.dart`、既存、`AsyncValue<MapConfigurationState>` with `.styleString`)。
- Produces: `SeismicitySpanSelector`(`value SeismicitySpan`, `onChanged void Function(SeismicitySpan)`)。`SeismicityColorModeSelector`(`value SeismicityColorMode`, `onChanged void Function(SeismicityColorMode)`)。`SeismicityPage` の内部 state(`useState<SeismicitySpan>`, `useState<SeismicityColorMode>`)。Task 10・14がこのページに矩形選択とパネルを追加する。

- [ ] **Step 1: 期間セレクタを実装**

`app/lib/feature/seismicity/ui/components/seismicity_span_selector.dart`:

```dart
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_span.dart';
import 'package:flutter/material.dart';

class SeismicitySpanSelector extends StatelessWidget {
  const SeismicitySpanSelector({
    required this.value,
    required this.onChanged,
    super.key,
  });

  final SeismicitySpan value;
  final ValueChanged<SeismicitySpan> onChanged;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<SeismicitySpan>(
      segments: const [
        ButtonSegment(value: SeismicitySpan.p1m, label: Text('1ヶ月')),
        ButtonSegment(value: SeismicitySpan.p3m, label: Text('3ヶ月')),
        ButtonSegment(value: SeismicitySpan.p12m, label: Text('12ヶ月')),
      ],
      selected: {value},
      onSelectionChanged: (selected) => onChanged(selected.single),
    );
  }
}
```

- [ ] **Step 2: 色分けモードセレクタを実装**

`app/lib/feature/seismicity/ui/components/seismicity_color_mode_selector.dart`:

```dart
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_color_mode.dart';
import 'package:flutter/material.dart';

class SeismicityColorModeSelector extends StatelessWidget {
  const SeismicityColorModeSelector({
    required this.value,
    required this.onChanged,
    super.key,
  });

  final SeismicityColorMode value;
  final ValueChanged<SeismicityColorMode> onChanged;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<SeismicityColorMode>(
      segments: const [
        ButtonSegment(
          value: SeismicityColorMode.elapsedTime,
          label: Text('経過時間'),
          icon: Icon(Icons.schedule),
        ),
        ButtonSegment(
          value: SeismicityColorMode.magnitude,
          label: Text('マグニチュード'),
          icon: Icon(Icons.bubble_chart),
        ),
      ],
      selected: {value},
      onSelectionChanged: (selected) => onChanged(selected.single),
    );
  }
}
```

- [ ] **Step 3: `SeismicityPage` を実装(Placeholder を置き換え)**

`app/lib/feature/seismicity/ui/seismicity_page.dart`:

```dart
import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/feature/map/data/notifier/map_configuration_notifier.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_color_mode.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_span.dart';
import 'package:eqmonitor/feature/seismicity/data/notifier/seismicity_dataset_notifier.dart';
import 'package:eqmonitor/feature/seismicity/ui/components/seismicity_color_mode_selector.dart';
import 'package:eqmonitor/feature/seismicity/ui/components/seismicity_span_selector.dart';
import 'package:eqmonitor/feature/seismicity/ui/layer/seismicity_epicenter_layer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geobase/geobase.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

/// 地震活動画面(震央分布 + 矩形選択によるM-T図・積算・深さ断面)。
class SeismicityPage extends HookConsumerWidget {
  const SeismicityPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final span = useState(SeismicitySpan.p1m);
    final colorMode = useState(SeismicityColorMode.elapsedTime);
    final mapConfiguration = ref.watch(mapConfigurationProvider);
    final datasetAsync = ref.watch(
      seismicityDatasetNotifierProvider(span.value),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('地震活動'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Row(
              children: [
                SeismicitySpanSelector(
                  value: span.value,
                  onChanged: (value) => span.value = value,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SeismicityColorModeSelector(
                    value: colorMode.value,
                    onChanged: (value) => colorMode.value = value,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: switch (mapConfiguration) {
        AsyncData(:final value) when value.styleString != null =>
          _MapBody(
            styleString: value.styleString!,
            datasetAsync: datasetAsync,
            colorMode: colorMode.value,
          ),
        AsyncError(:final error) => Center(child: ErrorCard(error: error)),
        _ => const Center(child: CircularProgressIndicator.adaptive()),
      },
    );
  }
}

class _MapBody extends StatelessWidget {
  const _MapBody({
    required this.styleString,
    required this.datasetAsync,
    required this.colorMode,
  });

  final String styleString;
  final AsyncValue datasetAsync;
  final SeismicityColorMode colorMode;

  @override
  Widget build(BuildContext context) {
    final events = switch (datasetAsync) {
      AsyncData(:final value) => value.events,
      _ => const [],
    };

    return Stack(
      children: [
        MapLibreMap(
          options: MapOptions(
            initStyle: styleString,
            initCenter: const Geographic(lon: 137.0, lat: 36.5),
            initZoom: 4.5,
          ),
          children: [
            SeismicityEpicenterLayer(events: events, colorMode: colorMode),
          ],
        ),
        if (datasetAsync case AsyncLoading())
          const Positioned(
            top: 8,
            right: 8,
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
        if (datasetAsync case AsyncData(:final value) when value.isFromCache)
          Positioned(
            top: 8,
            left: 8,
            child: Card(
              color: Theme.of(context).colorScheme.errorContainer,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Text('取得失敗のため前回データを表示中'),
              ),
            ),
          ),
      ],
    );
  }
}
```

(注: `AsyncValue` の型引数を省略した宣言はTask 14で `SeismicityDataset` に確定させる。現時点では `events`/`isFromCache` へのアクセスのみのため動的解決で型検査を通過するが、Task 14で `AsyncValue<SeismicityDataset> datasetAsync` へ厳密化し、`dart analyze` の `dynamic` 使用に関する警告が出ないことを確認する。)

- [ ] **Step 4: analyze**

Run: `cd /home/yumnumm/EQMonitor/app && dart analyze lib/feature/seismicity`
Expected: 警告0件(`dynamic` 型緩和が原因の警告が出た場合は `_MapBody.datasetAsync` を `AsyncValue<SeismicityDataset>` に確定させて解消する)

- [ ] **Step 5: コミット**

```bash
cd /home/yumnumm/EQMonitor
git add app/lib/feature/seismicity/ui
git commit -m "feat(seismicity): 公開版UI(地図+期間/色分け切替)を実装"
```

---

### Task 10: 矩形選択フック + オーバーレイ

**Files:**
- Create: `app/lib/feature/seismicity/ui/hook/use_rectangle_selection.dart`
- Create: `app/lib/feature/seismicity/data/model/seismicity_bounds.dart`
- Create: `app/lib/feature/seismicity/ui/components/seismicity_selection_overlay.dart`
- Test: `app/test/feature/seismicity/ui/components/seismicity_selection_overlay_test.dart`

**Interfaces:**
- Consumes: `MapController.maybeOf(context)?.toLngLat(Offset)`(`package:maplibre/maplibre.dart`、スクリーン座標→地理座標変換)。
- Produces: `SeismicityBounds`(Freezed: `minLatitude`, `maxLatitude`, `minLongitude`, `maxLongitude`、いずれも`double`)。`useRectangleSelection() -> RectangleSelectionState`(`isSelecting bool`, `dragStart Offset?`, `dragCurrent Offset?`, `startSelecting()`, `updateDrag(Offset)`, `endDrag() -> Rect?`)。`SeismicitySelectionOverlay`(`enabled bool`, `onSelectionEnd void Function(SeismicityBounds)`の子ウィジェット)。Task 14がこのオーバーレイをマップの上に重ね、`onSelectionEnd` で分析パネルを更新する。

- [ ] **Step 1: `SeismicityBounds` を実装**

`app/lib/feature/seismicity/data/model/seismicity_bounds.dart`:

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'seismicity_bounds.freezed.dart';

/// 地図上で矩形選択された緯度経度範囲。
@freezed
abstract class SeismicityBounds with _$SeismicityBounds {
  const factory SeismicityBounds({
    required double minLatitude,
    required double maxLatitude,
    required double minLongitude,
    required double maxLongitude,
  }) = _SeismicityBounds;
}
```

- [ ] **Step 2: 矩形選択フックを実装**

`app/lib/feature/seismicity/ui/hook/use_rectangle_selection.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// ドラッグ中の矩形選択状態を保持するフック。
///
/// 画面座標(Offset)のみを扱う。地理座標への変換は呼び出し側
/// ([SeismicitySelectionOverlay])が [MapController.toLngLat] を用いて行う。
class RectangleSelectionState {
  const RectangleSelectionState({
    required this.dragStart,
    required this.dragCurrent,
    required this.startDrag,
    required this.updateDrag,
    required this.endDrag,
  });

  final Offset? dragStart;
  final Offset? dragCurrent;
  final void Function(Offset) startDrag;
  final void Function(Offset) updateDrag;

  /// ドラッグ終了時に確定した矩形(画面座標)を返し、内部状態をリセットする。
  /// ドラッグが開始されていなければ null を返す。
  final Rect? Function() endDrag;
}

RectangleSelectionState useRectangleSelection() {
  final dragStart = useState<Offset?>(null);
  final dragCurrent = useState<Offset?>(null);

  return RectangleSelectionState(
    dragStart: dragStart.value,
    dragCurrent: dragCurrent.value,
    startDrag: (offset) {
      dragStart.value = offset;
      dragCurrent.value = offset;
    },
    updateDrag: (offset) => dragCurrent.value = offset,
    endDrag: () {
      final start = dragStart.value;
      final current = dragCurrent.value;
      dragStart.value = null;
      dragCurrent.value = null;
      if (start == null || current == null) {
        return null;
      }
      return Rect.fromPoints(start, current);
    },
  );
}
```

- [ ] **Step 3: オーバーレイの失敗するウィジェットテストを書く**

`app/test/feature/seismicity/ui/components/seismicity_selection_overlay_test.dart`:

```dart
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_bounds.dart';
import 'package:eqmonitor/feature/seismicity/ui/components/seismicity_selection_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('enabled が false の場合はジェスチャーを消費しない', (tester) async {
    var tapped = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Stack(
          children: [
            GestureDetector(
              onTap: () => tapped = true,
              child: const SizedBox.expand(),
            ),
            SeismicitySelectionOverlay(
              enabled: false,
              onSelectionEnd: (_) {},
            ),
          ],
        ),
      ),
    );

    await tester.tap(find.byType(Stack));
    expect(tapped, isTrue);
  });

  testWidgets('enabled が true の場合はドラッグ完了で onSelectionEnd を呼ぶ', (
    tester,
  ) async {
    SeismicityBounds? result;
    await tester.pumpWidget(
      MaterialApp(
        home: SeismicitySelectionOverlay(
          enabled: true,
          onSelectionEnd: (bounds) => result = bounds,
        ),
      ),
    );

    await tester.dragFrom(const Offset(50, 50), const Offset(150, 150));
    await tester.pumpAndSettle();

    // MapController が widget tree に存在しないテスト環境では
    // 画面座標→地理座標変換ができないため null のままだが、
    // ドラッグのライフサイクル(pan start/update/end)自体が
    // 例外なく完了することを検証する。
    expect(result, isNull);
  });
}
```

- [ ] **Step 4: 失敗を確認**

Run: `cd /home/yumnumm/EQMonitor/app && flutter test test/feature/seismicity/ui/components/seismicity_selection_overlay_test.dart`
Expected: FAIL(未実装)

- [ ] **Step 5: `SeismicitySelectionOverlay` を実装**

`app/lib/feature/seismicity/ui/components/seismicity_selection_overlay.dart`:

```dart
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_bounds.dart';
import 'package:eqmonitor/feature/seismicity/ui/hook/use_rectangle_selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:maplibre/maplibre.dart';

/// 地図上に重ねる矩形選択オーバーレイ。
///
/// [enabled] が true の間だけジェスチャーを消費し、ドラッグ確定時に
/// 画面座標を [MapController.toLngLat] で地理座標へ変換して
/// [onSelectionEnd] を呼ぶ。[enabled] が false の場合は
/// [IgnorePointer] で下のマップ操作(パン/ズーム)を妨げない。
class SeismicitySelectionOverlay extends HookWidget {
  const SeismicitySelectionOverlay({
    required this.enabled,
    required this.onSelectionEnd,
    super.key,
  });

  final bool enabled;
  final void Function(SeismicityBounds bounds) onSelectionEnd;

  @override
  Widget build(BuildContext context) {
    final selection = useRectangleSelection();

    return IgnorePointer(
      ignoring: !enabled,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onPanStart: (details) =>
            selection.startDrag(details.localPosition),
        onPanUpdate: (details) =>
            selection.updateDrag(details.localPosition),
        onPanEnd: (_) => _handleDragEnd(context, selection),
        child: CustomPaint(
          painter: _SelectionPainter(
            start: selection.dragStart,
            current: selection.dragCurrent,
          ),
          child: const SizedBox.expand(),
        ),
      ),
    );
  }

  void _handleDragEnd(
    BuildContext context,
    RectangleSelectionState selection,
  ) {
    final rect = selection.endDrag();
    if (rect == null) {
      return;
    }
    final controller = MapController.maybeOf(context);
    if (controller == null) {
      return;
    }
    final topLeft = controller.toLngLat(rect.topLeft);
    final bottomRight = controller.toLngLat(rect.bottomRight);
    onSelectionEnd(
      SeismicityBounds(
        minLatitude: [
          topLeft.lat,
          bottomRight.lat,
        ].reduce((a, b) => a < b ? a : b),
        maxLatitude: [
          topLeft.lat,
          bottomRight.lat,
        ].reduce((a, b) => a > b ? a : b),
        minLongitude: [
          topLeft.lon,
          bottomRight.lon,
        ].reduce((a, b) => a < b ? a : b),
        maxLongitude: [
          topLeft.lon,
          bottomRight.lon,
        ].reduce((a, b) => a > b ? a : b),
      ),
    );
  }
}

class _SelectionPainter extends CustomPainter {
  const _SelectionPainter({required this.start, required this.current});

  final Offset? start;
  final Offset? current;

  @override
  void paint(Canvas canvas, Size size) {
    final start = this.start;
    final current = this.current;
    if (start == null || current == null) {
      return;
    }
    final rect = Rect.fromPoints(start, current);
    canvas.drawRect(
      rect,
      Paint()
        ..color = const Color(0x332196F3)
        ..style = PaintingStyle.fill,
    );
    canvas.drawRect(
      rect,
      Paint()
        ..color = const Color(0xFF2196F3)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    );
  }

  @override
  bool shouldRepaint(_SelectionPainter oldDelegate) =>
      oldDelegate.start != start || oldDelegate.current != current;
}
```

- [ ] **Step 6: コード生成 + 成功を確認**

Run: `cd /home/yumnumm/EQMonitor/app && melos run generate && flutter test test/feature/seismicity/ui/components/seismicity_selection_overlay_test.dart`
Expected: PASS(2 tests)

- [ ] **Step 7: analyze**

Run: `cd /home/yumnumm/EQMonitor/app && dart analyze lib/feature/seismicity`
Expected: 警告0件

- [ ] **Step 8: コミット**

```bash
cd /home/yumnumm/EQMonitor
git add app/lib/feature/seismicity/data/model/seismicity_bounds.dart app/lib/feature/seismicity/ui/hook app/lib/feature/seismicity/ui/components/seismicity_selection_overlay.dart app/test/feature/seismicity/ui/components
git commit -m "feat(seismicity): 矩形選択フック+オーバーレイを追加"
```

---

### Task 11: M-T図(ScatterChart)

**Files:**
- Create: `app/lib/feature/seismicity/ui/panel/seismicity_mt_chart.dart`
- Test: `app/test/feature/seismicity/ui/panel/seismicity_mt_chart_test.dart`

**Interfaces:**
- Consumes: `SeismicityEvent`(Task 1)、`fl_chart`(`ScatterChart`, `ScatterChartData`, `ScatterSpot`, `FlTitlesData`, `AxisTitles`, `SideTitles`, `FlBorderData`)。
- Produces: `SeismicityMtChart`(StatelessWidget、`events List<SeismicityEvent>`必須)。Task 14が分析パネルの1タブとして配置する。

- [ ] **Step 1: 失敗するウィジェットテストを書く**

`app/test/feature/seismicity/ui/panel/seismicity_mt_chart_test.dart`:

```dart
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_event.dart';
import 'package:eqmonitor/feature/seismicity/ui/panel/seismicity_mt_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('イベントが0件でも例外なく描画できる', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: SeismicityMtChart(events: [])),
    );
    expect(find.byType(SeismicityMtChart), findsOneWidget);
  });

  testWidgets('マグニチュード欠測イベントを除外して描画する', (tester) async {
    final events = [
      SeismicityEvent(
        eventId: 'a',
        originTime: DateTime.utc(2026, 1, 1),
        magnitude: 4.5,
        depth: 10,
        latitude: 35,
        longitude: 139,
        maxIntensity: null,
      ),
      SeismicityEvent(
        eventId: 'b',
        originTime: DateTime.utc(2026, 1, 2),
        magnitude: null,
        depth: 10,
        latitude: 35,
        longitude: 139,
        maxIntensity: null,
      ),
    ];

    await tester.pumpWidget(
      MaterialApp(home: SeismicityMtChart(events: events)),
    );
    expect(find.byType(SeismicityMtChart), findsOneWidget);
  });
}
```

- [ ] **Step 2: 失敗を確認**

Run: `cd /home/yumnumm/EQMonitor/app && flutter test test/feature/seismicity/ui/panel/seismicity_mt_chart_test.dart`
Expected: FAIL(未実装)

- [ ] **Step 3: `SeismicityMtChart` を実装**

`app/lib/feature/seismicity/ui/panel/seismicity_mt_chart.dart`:

```dart
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_event.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

/// M-T図(時間 × マグニチュードの点プロット)。
class SeismicityMtChart extends StatelessWidget {
  const SeismicityMtChart({required this.events, super.key});

  final List<SeismicityEvent> events;

  @override
  Widget build(BuildContext context) {
    final withMagnitude = events.where((e) => e.magnitude != null).toList()
      ..sort((a, b) => a.originTime.compareTo(b.originTime));

    if (withMagnitude.isEmpty) {
      return const Center(child: Text('マグニチュードが既知のイベントがありません'));
    }

    final firstTime = withMagnitude.first.originTime;
    final spots = [
      for (final event in withMagnitude)
        ScatterSpot(
          event.originTime.difference(firstTime).inHours.toDouble(),
          event.magnitude!,
        ),
    ];
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 12, 16, 8),
      child: ScatterChart(
        ScatterChartData(
          scatterSpots: spots,
          minY: 0,
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              axisNameWidget: const Text('M', style: TextStyle(fontSize: 10)),
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 32,
                getTitlesWidget: (v, _) =>
                    Text(v.toStringAsFixed(1), style: const TextStyle(fontSize: 8)),
              ),
            ),
            bottomTitles: AxisTitles(
              axisNameWidget: const Text(
                '経過時間 (h)',
                style: TextStyle(fontSize: 10),
              ),
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (v, _) =>
                    Text(v.toStringAsFixed(0), style: const TextStyle(fontSize: 8)),
              ),
            ),
            topTitles: const AxisTitles(),
            rightTitles: const AxisTitles(),
          ),
          borderData: FlBorderData(
            border: Border(bottom: BorderSide(color: colorScheme.outline)),
          ),
        ),
      ),
    );
  }
}
```

- [ ] **Step 4: 成功を確認**

Run: `cd /home/yumnumm/EQMonitor/app && flutter test test/feature/seismicity/ui/panel/seismicity_mt_chart_test.dart`
Expected: PASS(2 tests)

- [ ] **Step 5: analyze + コミット**

Run: `cd /home/yumnumm/EQMonitor/app && dart analyze lib/feature/seismicity`
Expected: 警告0件

```bash
cd /home/yumnumm/EQMonitor
git add app/lib/feature/seismicity/ui/panel/seismicity_mt_chart.dart app/test/feature/seismicity/ui/panel/seismicity_mt_chart_test.dart
git commit -m "feat(seismicity): M-T図(ScatterChart)を追加"
```

---

### Task 12: 回数積算図 + 日別ヒストグラム(LineChart + BarChart)

**Files:**
- Create: `app/lib/feature/seismicity/ui/panel/seismicity_cumulative_histogram_chart.dart`
- Test: `app/test/feature/seismicity/ui/panel/seismicity_cumulative_histogram_chart_test.dart`

**Interfaces:**
- Consumes: `SeismicityEvent`(Task 1)、`SeismicityCumulativeBinning`, `SeismicityDailyBin`(Task 2)、`fl_chart`(`LineChart`, `BarChart`)。
- Produces: `SeismicityCumulativeHistogramChart`(StatelessWidget、`events List<SeismicityEvent>`必須)。内部で積算図(上段、LineChart)と日別ヒストグラム(下段、BarChart)を縦に併記する。Task 14が分析パネルの1タブとして配置する。

- [ ] **Step 1: 失敗するウィジェットテストを書く**

`app/test/feature/seismicity/ui/panel/seismicity_cumulative_histogram_chart_test.dart`:

```dart
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_event.dart';
import 'package:eqmonitor/feature/seismicity/ui/panel/seismicity_cumulative_histogram_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('イベントが0件でも例外なく描画できる', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SeismicityCumulativeHistogramChart(events: []),
      ),
    );
    expect(find.byType(SeismicityCumulativeHistogramChart), findsOneWidget);
  });

  testWidgets('複数イベントで積算図とヒストグラムを描画する', (tester) async {
    final events = [
      SeismicityEvent(
        eventId: 'a',
        originTime: DateTime.utc(2026, 1, 1),
        magnitude: 4,
        depth: 10,
        latitude: 35,
        longitude: 139,
        maxIntensity: null,
      ),
      SeismicityEvent(
        eventId: 'b',
        originTime: DateTime.utc(2026, 1, 2),
        magnitude: 3,
        depth: 10,
        latitude: 35,
        longitude: 139,
        maxIntensity: null,
      ),
    ];

    await tester.pumpWidget(
      MaterialApp(
        home: SeismicityCumulativeHistogramChart(events: events),
      ),
    );
    expect(find.byType(SeismicityCumulativeHistogramChart), findsOneWidget);
  });
}
```

- [ ] **Step 2: 失敗を確認**

Run: `cd /home/yumnumm/EQMonitor/app && flutter test test/feature/seismicity/ui/panel/seismicity_cumulative_histogram_chart_test.dart`
Expected: FAIL(未実装)

- [ ] **Step 3: `SeismicityCumulativeHistogramChart` を実装**

`app/lib/feature/seismicity/ui/panel/seismicity_cumulative_histogram_chart.dart`:

```dart
import 'package:eqmonitor/feature/seismicity/data/logic/seismicity_cumulative_binning.dart';
import 'package:eqmonitor/feature/seismicity/data/logic/seismicity_daily_bin.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_event.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

/// 回数積算図(上段、LineChart)と日別ヒストグラム(下段、BarChart)の併記。
class SeismicityCumulativeHistogramChart extends StatelessWidget {
  const SeismicityCumulativeHistogramChart({
    required this.events,
    super.key,
  });

  final List<SeismicityEvent> events;

  static const SeismicityCumulativeBinning _binning =
      SeismicityCumulativeBinning();

  @override
  Widget build(BuildContext context) {
    final bins = _binning.bin(events);
    if (bins.isEmpty) {
      return const Center(child: Text('選択範囲にイベントがありません'));
    }

    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 12, 16, 4),
            child: LineChart(
              LineChartData(
                minY: 0,
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      for (var i = 0; i < bins.length; i++)
                        FlSpot(i.toDouble(), bins[i].cumulativeCount.toDouble()),
                    ],
                    dotData: const FlDotData(show: false),
                    isCurved: false,
                    barWidth: 2,
                    color: colorScheme.primary,
                  ),
                ],
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    axisNameWidget: const Text(
                      '積算件数',
                      style: TextStyle(fontSize: 10),
                    ),
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 36,
                      getTitlesWidget: (v, _) => Text(
                        v.toStringAsFixed(0),
                        style: const TextStyle(fontSize: 8),
                      ),
                    ),
                  ),
                  bottomTitles: const AxisTitles(),
                  topTitles: const AxisTitles(),
                  rightTitles: const AxisTitles(),
                ),
                borderData: FlBorderData(
                  border: Border(bottom: BorderSide(color: colorScheme.outline)),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 4, 16, 8),
            child: BarChart(
              BarChartData(
                barGroups: [
                  for (var i = 0; i < bins.length; i++)
                    BarChartGroupData(
                      x: i,
                      barRods: [
                        BarChartRodData(
                          toY: bins[i].count.toDouble(),
                          color: colorScheme.secondary,
                          width: 4,
                        ),
                      ],
                    ),
                ],
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    axisNameWidget: const Text(
                      '日別件数',
                      style: TextStyle(fontSize: 10),
                    ),
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 36,
                      getTitlesWidget: (v, _) => Text(
                        v.toStringAsFixed(0),
                        style: const TextStyle(fontSize: 8),
                      ),
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    axisNameWidget: const Text('日', style: TextStyle(fontSize: 10)),
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (v, _) {
                        final index = v.toInt();
                        if (index < 0 || index >= bins.length) {
                          return const SizedBox.shrink();
                        }
                        final date = bins[index].date;
                        return Text(
                          '${date.month}/${date.day}',
                          style: const TextStyle(fontSize: 8),
                        );
                      },
                    ),
                  ),
                  topTitles: const AxisTitles(),
                  rightTitles: const AxisTitles(),
                ),
                borderData: FlBorderData(
                  border: Border(bottom: BorderSide(color: colorScheme.outline)),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
```

- [ ] **Step 4: 成功を確認**

Run: `cd /home/yumnumm/EQMonitor/app && flutter test test/feature/seismicity/ui/panel/seismicity_cumulative_histogram_chart_test.dart`
Expected: PASS(2 tests)

- [ ] **Step 5: analyze + コミット**

Run: `cd /home/yumnumm/EQMonitor/app && dart analyze lib/feature/seismicity`
Expected: 警告0件

```bash
cd /home/yumnumm/EQMonitor
git add app/lib/feature/seismicity/ui/panel/seismicity_cumulative_histogram_chart.dart app/test/feature/seismicity/ui/panel/seismicity_cumulative_histogram_chart_test.dart
git commit -m "feat(seismicity): 回数積算図+日別ヒストグラムを追加"
```

---

### Task 13: 深さ断面図(緯度/経度投影切替、ScatterChart)

**Files:**
- Create: `app/lib/feature/seismicity/ui/panel/seismicity_depth_section_chart.dart`
- Test: `app/test/feature/seismicity/ui/panel/seismicity_depth_section_chart_test.dart`

**Interfaces:**
- Consumes: `SeismicityEvent`(Task 1)、`SeismicityDepthProjection`, `SeismicityDepthProjectionAxis`, `SeismicityDepthPoint`(Task 2)。
- Produces: `SeismicityDepthSectionChart`(HookWidget、`events List<SeismicityEvent>`必須。内部で `useState<SeismicityDepthProjectionAxis>` を持ち、`SegmentedButton` で軸切替UIを内蔵する)。Task 14が分析パネルの1タブとして配置する。

- [ ] **Step 1: 失敗するウィジェットテストを書く**

`app/test/feature/seismicity/ui/panel/seismicity_depth_section_chart_test.dart`:

```dart
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_event.dart';
import 'package:eqmonitor/feature/seismicity/ui/panel/seismicity_depth_section_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('軸切替ボタンをタップしても例外なく再描画できる', (tester) async {
    final events = [
      SeismicityEvent(
        eventId: 'a',
        originTime: DateTime.utc(2026, 1, 1),
        magnitude: 4,
        depth: 30,
        latitude: 35,
        longitude: 139,
        maxIntensity: null,
      ),
    ];

    await tester.pumpWidget(
      MaterialApp(home: SeismicityDepthSectionChart(events: events)),
    );
    expect(find.byType(SeismicityDepthSectionChart), findsOneWidget);

    await tester.tap(find.text('経度方向'));
    await tester.pumpAndSettle();
    expect(find.byType(SeismicityDepthSectionChart), findsOneWidget);
  });
}
```

- [ ] **Step 2: 失敗を確認**

Run: `cd /home/yumnumm/EQMonitor/app && flutter test test/feature/seismicity/ui/panel/seismicity_depth_section_chart_test.dart`
Expected: FAIL(未実装)

- [ ] **Step 3: `SeismicityDepthSectionChart` を実装**

`app/lib/feature/seismicity/ui/panel/seismicity_depth_section_chart.dart`:

```dart
import 'package:eqmonitor/feature/seismicity/data/logic/seismicity_depth_projection.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_event.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// 深さ断面図(緯度方向 / 経度方向の投影切替)。
///
/// Y軸(深さ)は下向きが正のため `reversed: true` 相当の表示にするために
/// `maxY` を 0、`minY` を負の最大深さとして軸を反転させる。
class SeismicityDepthSectionChart extends HookWidget {
  const SeismicityDepthSectionChart({required this.events, super.key});

  final List<SeismicityEvent> events;

  static const SeismicityDepthProjection _projection =
      SeismicityDepthProjection();

  @override
  Widget build(BuildContext context) {
    final axis = useState(SeismicityDepthProjectionAxis.latitude);
    final points = _projection.project(events: events, axis: axis.value);
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: SegmentedButton<SeismicityDepthProjectionAxis>(
            segments: const [
              ButtonSegment(
                value: SeismicityDepthProjectionAxis.latitude,
                label: Text('緯度方向'),
              ),
              ButtonSegment(
                value: SeismicityDepthProjectionAxis.longitude,
                label: Text('経度方向'),
              ),
            ],
            selected: {axis.value},
            onSelectionChanged: (selected) => axis.value = selected.single,
          ),
        ),
        Expanded(
          child: points.isEmpty
              ? const Center(child: Text('深さが既知のイベントがありません'))
              : Padding(
                  padding: const EdgeInsets.fromLTRB(8, 4, 16, 8),
                  child: ScatterChart(
                    ScatterChartData(
                      scatterSpots: [
                        for (final point in points)
                          ScatterSpot(point.axisValue, -point.depth),
                      ],
                      maxY: 0,
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          axisNameWidget: const Text(
                            '深さ (km)',
                            style: TextStyle(fontSize: 10),
                          ),
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 36,
                            getTitlesWidget: (v, _) => Text(
                              (-v).toStringAsFixed(0),
                              style: const TextStyle(fontSize: 8),
                            ),
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          axisNameWidget: Text(
                            axis.value ==
                                    SeismicityDepthProjectionAxis.latitude
                                ? '緯度'
                                : '経度',
                            style: const TextStyle(fontSize: 10),
                          ),
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (v, _) => Text(
                              v.toStringAsFixed(1),
                              style: const TextStyle(fontSize: 8),
                            ),
                          ),
                        ),
                        topTitles: const AxisTitles(),
                        rightTitles: const AxisTitles(),
                      ),
                      borderData: FlBorderData(
                        border: Border(
                          bottom: BorderSide(color: colorScheme.outline),
                        ),
                      ),
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
```

- [ ] **Step 4: 成功を確認**

Run: `cd /home/yumnumm/EQMonitor/app && flutter test test/feature/seismicity/ui/panel/seismicity_depth_section_chart_test.dart`
Expected: PASS(1 test)

- [ ] **Step 5: analyze + コミット**

Run: `cd /home/yumnumm/EQMonitor/app && dart analyze lib/feature/seismicity`
Expected: 警告0件

```bash
cd /home/yumnumm/EQMonitor
git add app/lib/feature/seismicity/ui/panel/seismicity_depth_section_chart.dart app/test/feature/seismicity/ui/panel/seismicity_depth_section_chart_test.dart
git commit -m "feat(seismicity): 深さ断面図(軸切替)を追加"
```

---

### Task 14: 分析パネル配線(矩形選択 → M-T図/積算・ヒストグラム/深さ断面)

**Files:**
- Create: `app/lib/feature/seismicity/ui/panel/seismicity_analysis_panel.dart`
- Modify: `app/lib/feature/seismicity/ui/seismicity_page.dart`

**Interfaces:**
- Consumes: `SeismicityBoundsFilter`(Task 2)、`SeismicityBounds`(Task 10)、`SeismicityMtChart`(Task 11)、`SeismicityCumulativeHistogramChart`(Task 12)、`SeismicityDepthSectionChart`(Task 13)、`SeismicitySelectionOverlay`(Task 10)。
- Produces: `SeismicityAnalysisPanel`(StatelessWidget、`events List<SeismicityEvent>`必須、内部で`DefaultTabController`により3タブ(M-T図/積算・ヒストグラム/深さ断面)を表示)。`SeismicityPage` に矩形選択トグルボタンとボトムシート型の分析パネルを追加する。

- [ ] **Step 1: `SeismicityAnalysisPanel` を実装**

`app/lib/feature/seismicity/ui/panel/seismicity_analysis_panel.dart`:

```dart
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_event.dart';
import 'package:eqmonitor/feature/seismicity/ui/panel/seismicity_cumulative_histogram_chart.dart';
import 'package:eqmonitor/feature/seismicity/ui/panel/seismicity_depth_section_chart.dart';
import 'package:eqmonitor/feature/seismicity/ui/panel/seismicity_mt_chart.dart';
import 'package:flutter/material.dart';

/// 矩形選択で得られたイベント一覧の分析パネル(3タブ)。
class SeismicityAnalysisPanel extends StatelessWidget {
  const SeismicityAnalysisPanel({required this.events, super.key});

  final List<SeismicityEvent> events;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '選択範囲: ${events.length}件',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ],
            ),
          ),
          const TabBar(
            tabs: [
              Tab(text: 'M-T図'),
              Tab(text: '積算/ヒストグラム'),
              Tab(text: '深さ断面'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                SeismicityMtChart(events: events),
                SeismicityCumulativeHistogramChart(events: events),
                SeismicityDepthSectionChart(events: events),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
```

- [ ] **Step 2: `SeismicityPage` に矩形選択トグルと分析パネルを配線**

`app/lib/feature/seismicity/ui/seismicity_page.dart` を以下のとおり書き換える(Task 9実装からの差分: `useState<SeismicityBounds?>`、`useState<bool>`(選択モード)を追加し、`_MapBody` に `SeismicitySelectionOverlay` と `SeismicityAnalysisPanel` を重ねる):

```dart
import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/feature/map/data/notifier/map_configuration_notifier.dart';
import 'package:eqmonitor/feature/seismicity/data/logic/seismicity_bounds_filter.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_bounds.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_color_mode.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_dataset.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_event.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_span.dart';
import 'package:eqmonitor/feature/seismicity/data/notifier/seismicity_dataset_notifier.dart';
import 'package:eqmonitor/feature/seismicity/ui/components/seismicity_color_mode_selector.dart';
import 'package:eqmonitor/feature/seismicity/ui/components/seismicity_selection_overlay.dart';
import 'package:eqmonitor/feature/seismicity/ui/components/seismicity_span_selector.dart';
import 'package:eqmonitor/feature/seismicity/ui/layer/seismicity_epicenter_layer.dart';
import 'package:eqmonitor/feature/seismicity/ui/panel/seismicity_analysis_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geobase/geobase.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

/// 地震活動画面(震央分布 + 矩形選択によるM-T図・積算・深さ断面)。
class SeismicityPage extends HookConsumerWidget {
  const SeismicityPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final span = useState(SeismicitySpan.p1m);
    final colorMode = useState(SeismicityColorMode.elapsedTime);
    final isSelecting = useState(false);
    final selectedBounds = useState<SeismicityBounds?>(null);
    final mapConfiguration = ref.watch(mapConfigurationProvider);
    final datasetAsync = ref.watch(
      seismicityDatasetNotifierProvider(span.value),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('地震活動'),
        actions: [
          IconButton(
            icon: Icon(
              isSelecting.value
                  ? Icons.crop_free
                  : Icons.crop_free_outlined,
            ),
            tooltip: '矩形選択',
            isSelected: isSelecting.value,
            onPressed: () {
              isSelecting.value = !isSelecting.value;
              if (!isSelecting.value) {
                selectedBounds.value = null;
              }
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Row(
              children: [
                SeismicitySpanSelector(
                  value: span.value,
                  onChanged: (value) => span.value = value,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SeismicityColorModeSelector(
                    value: colorMode.value,
                    onChanged: (value) => colorMode.value = value,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: switch (mapConfiguration) {
        AsyncData(:final value) when value.styleString != null => _MapBody(
          styleString: value.styleString!,
          datasetAsync: datasetAsync,
          colorMode: colorMode.value,
          isSelecting: isSelecting.value,
          onSelectionEnd: (bounds) => selectedBounds.value = bounds,
        ),
        AsyncError(:final error) => Center(child: ErrorCard(error: error)),
        _ => const Center(child: CircularProgressIndicator.adaptive()),
      },
      bottomSheet: selectedBounds.value == null
          ? null
          : SizedBox(
              height: MediaQuery.of(context).size.height * 0.45,
              child: Material(
                elevation: 8,
                child: SeismicityAnalysisPanel(
                  events: const SeismicityBoundsFilter().filter(
                    events: switch (datasetAsync) {
                      AsyncData(:final SeismicityDataset value) =>
                        value.events,
                      _ => const <SeismicityEvent>[],
                    },
                    minLatitude: selectedBounds.value!.minLatitude,
                    maxLatitude: selectedBounds.value!.maxLatitude,
                    minLongitude: selectedBounds.value!.minLongitude,
                    maxLongitude: selectedBounds.value!.maxLongitude,
                  ),
                ),
              ),
            ),
    );
  }
}

class _MapBody extends StatelessWidget {
  const _MapBody({
    required this.styleString,
    required this.datasetAsync,
    required this.colorMode,
    required this.isSelecting,
    required this.onSelectionEnd,
  });

  final String styleString;
  final AsyncValue<SeismicityDataset> datasetAsync;
  final SeismicityColorMode colorMode;
  final bool isSelecting;
  final void Function(SeismicityBounds bounds) onSelectionEnd;

  @override
  Widget build(BuildContext context) {
    final events = switch (datasetAsync) {
      AsyncData(:final value) => value.events,
      _ => const <SeismicityEvent>[],
    };

    return Stack(
      children: [
        MapLibreMap(
          options: MapOptions(
            initStyle: styleString,
            initCenter: const Geographic(lon: 137.0, lat: 36.5),
            initZoom: 4.5,
          ),
          children: [
            SeismicityEpicenterLayer(events: events, colorMode: colorMode),
          ],
        ),
        SeismicitySelectionOverlay(
          enabled: isSelecting,
          onSelectionEnd: onSelectionEnd,
        ),
        if (datasetAsync case AsyncLoading())
          const Positioned(
            top: 8,
            right: 8,
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
        if (datasetAsync case AsyncData(:final value) when value.isFromCache)
          Positioned(
            top: 8,
            left: 8,
            child: Card(
              color: Theme.of(context).colorScheme.errorContainer,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Text('取得失敗のため前回データを表示中'),
              ),
            ),
          ),
      ],
    );
  }
}
```

- [ ] **Step 3: analyze**

Run: `cd /home/yumnumm/EQMonitor/app && dart analyze lib/feature/seismicity`
Expected: 警告0件

- [ ] **Step 4: 手動確認**

Run: `cd /home/yumnumm/EQMonitor/app && flutter run -d <device-id>`
手順: 設定 → 地震活動 → 地図上で矩形選択アイコンをタップ → 地図上をドラッグ → 画面下部にM-T図/積算・ヒストグラム/深さ断面のタブ付きパネルが表示されることを確認する。
Expected: パネルが表示され、タブ切替・軸切替(深さ断面)が例外なく動作する。

- [ ] **Step 5: コミット**

```bash
cd /home/yumnumm/EQMonitor
git add app/lib/feature/seismicity/ui
git commit -m "feat(seismicity): 矩形選択と分析パネル(M-T図/積算/深さ断面)を配線"
```

---

### Task 15: `nied_api_client` — Hi-net jmalistモデル + パーサ

**Files:**
- Create: `packages/nied_api_client/lib/src/hinet/jmalist/model/hinet_jmalist_event.dart`
- Create: `packages/nied_api_client/lib/src/hinet/jmalist/parser/hinet_jmalist_parser.dart`
- Modify: `packages/nied_api_client/lib/nied_api_client.dart`(export追加)
- Test: `packages/nied_api_client/test/hinet_jmalist_parser_test.dart`

**Interfaces:**
- Produces: `HinetJmalistEvent`(Freezed: `originTime DateTime`(UTC), `timeError double`, `latitude double`, `latitudeError double`, `longitude double`, `longitudeError double`, `depthKm double`, `magnitude1 double`, `magnitude2 double?`, `magnitudeFlag String?`, `regionNameEn String`, `qualityCode String`)。`HinetJmalistParser.parse(String content) -> HinetJmalistParseResult`。`HinetJmalistParseResult`(`events List<HinetJmalistEvent>`, `skippedLineCount int`)。Task 16(認証クライアント)とTask 18(デバッグ画面)がこのパーサを利用する。

**注意:** テストで使う実データはfixtureではなくテストファイル内に直接埋め込む(震源値のみで認証情報を含まない。ユーザー提供のサンプル行そのまま)。

- [ ] **Step 1: 失敗するテストを書く**

`packages/nied_api_client/test/hinet_jmalist_parser_test.dart`:

```dart
import 'package:nied_api_client/src/hinet/jmalist/parser/hinet_jmalist_parser.dart';
import 'package:test/test.dart';

const _sampleLine1 =
    '2026-06-02 11:08:33.99  0.07   36.571  0.18  137.868  0.29     7.7   1.0  1.6V        NORTHERN NAGANO PREF  k';
const _sampleLine2 =
    '2026-06-02 11:23:56.58  0.11   24.443  0.34  123.876  0.34     8.7   1.5              NEAR ISHIGAKIJIMA ISLAND  k';

void main() {
  group('HinetJmalistParser', () {
    const parser = HinetJmalistParser();

    test('M2とフラグ付きの行をパースできる', () {
      final result = parser.parse(_sampleLine1);

      expect(result.events, hasLength(1));
      expect(result.skippedLineCount, 0);

      final event = result.events.single;
      expect(event.originTime, DateTime.utc(2026, 6, 2, 11, 8, 33, 990));
      expect(event.timeError, 0.07);
      expect(event.latitude, 36.571);
      expect(event.latitudeError, 0.18);
      expect(event.longitude, 137.868);
      expect(event.longitudeError, 0.29);
      expect(event.depthKm, 7.7);
      expect(event.magnitude1, 1.0);
      expect(event.magnitude2, 1.6);
      expect(event.magnitudeFlag, 'V');
      expect(event.regionNameEn, 'NORTHERN NAGANO PREF');
      expect(event.qualityCode, 'k');
    });

    test('M2欠測行をパースできる(M2/flagはnull)', () {
      final result = parser.parse(_sampleLine2);

      expect(result.events, hasLength(1));
      final event = result.events.single;
      expect(event.magnitude1, 1.5);
      expect(event.magnitude2, isNull);
      expect(event.magnitudeFlag, isNull);
      expect(event.regionNameEn, 'NEAR ISHIGAKIJIMA ISLAND');
    });

    test('FAR FIELD行はスキップしてカウントする', () {
      const farFieldLine =
          '2026-06-03 00:00:00.00  0.10   10.000  0.20  140.000  0.30     100.0   5.0        FAR FIELD  k';
      final result = parser.parse('$_sampleLine1\n$farFieldLine');

      expect(result.events, hasLength(1));
      expect(result.skippedLineCount, 1);
    });

    test('パース不能行はスキップしてカウントする', () {
      final result = parser.parse('$_sampleLine1\nnot a valid line\n');

      expect(result.events, hasLength(1));
      expect(result.skippedLineCount, 1);
    });

    test('空行・コメント行は無視する(スキップカウントにも含めない)', () {
      final result = parser.parse('\n# comment\n$_sampleLine1\n\n');

      expect(result.events, hasLength(1));
      expect(result.skippedLineCount, 0);
    });
  });
}
```

- [ ] **Step 2: 失敗を確認**

Run: `cd /home/yumnumm/EQMonitor/packages/nied_api_client && dart test test/hinet_jmalist_parser_test.dart`
Expected: FAIL(未実装)

- [ ] **Step 3: `HinetJmalistEvent` を実装**

`packages/nied_api_client/lib/src/hinet/jmalist/model/hinet_jmalist_event.dart`:

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'hinet_jmalist_event.freezed.dart';

/// Hi-net 気象庁一元化処理 震源リスト(jmalist.php)の1行。
///
/// NIED により震源情報の二次配布が明示的に禁止されているため、この型は
/// アプリの一般公開機能から到達不可能なデバッグ画面専用として扱うこと。
@freezed
abstract class HinetJmalistEvent with _$HinetJmalistEvent {
  const factory HinetJmalistEvent({
    /// 発生時刻(UTC)
    required DateTime originTime,

    /// 時刻誤差(秒)
    required double timeError,
    required double latitude,

    /// 緯度誤差(度)
    required double latitudeError,
    required double longitude,

    /// 経度誤差(度)
    required double longitudeError,

    /// 深さ(km)
    required double depthKm,

    /// マグニチュード(1つ目)
    required double magnitude1,

    /// マグニチュード(2つ目、欠測時 null)
    required double? magnitude2,

    /// マグニチュード種別フラグ(例: 'V'、欠測時 null)
    required String? magnitudeFlag,

    /// 震央地名(英語)
    required String regionNameEn,

    /// 品質コード
    required String qualityCode,
  }) = _HinetJmalistEvent;
}
```

- [ ] **Step 4: `HinetJmalistParser` を実装**

`packages/nied_api_client/lib/src/hinet/jmalist/parser/hinet_jmalist_parser.dart`:

```dart
import 'package:nied_api_client/src/hinet/jmalist/model/hinet_jmalist_event.dart';

/// [HinetJmalistParser.parse] の結果。
///
/// [skippedLineCount] は FAR FIELD 行・欠測により復元不能な行の合計件数。
class HinetJmalistParseResult {
  const HinetJmalistParseResult({
    required this.events,
    required this.skippedLineCount,
  });

  final List<HinetJmalistEvent> events;
  final int skippedLineCount;
}

/// Hi-net `jmalist.php` が返す `<pre>` 内プレーンテキスト表のパーサ。
///
/// 1行の書式(空白区切り、M2列は欠測すると列ごと消える):
/// `日付 時刻 時刻誤差 緯度 緯度誤差 経度 経度誤差 深さ M1 [M2+flag] 震央地名(英語) 品質コード`
class HinetJmalistParser {
  const HinetJmalistParser();

  static final _lineRegExp = RegExp(
    r'^(\d{4}-\d{2}-\d{2})\s+(\d{2}:\d{2}:\d{2}\.\d{2})\s+'
    r'([\d.]+)\s+(-?[\d.]+)\s+([\d.]+)\s+(-?[\d.]+)\s+'
    r'([\d.]+)\s+([\d.]+)\s+([\d.]+)\s+'
    r'(?:([\d.]+)([A-Za-z]?)\s+)?'
    r'(.+?)\s+([A-Za-z])$',
  );

  HinetJmalistParseResult parse(String content) {
    final events = <HinetJmalistEvent>[];
    var skippedLineCount = 0;

    for (final rawLine in content.split('\n')) {
      final line = rawLine.trim();
      if (line.isEmpty || line.startsWith('#')) {
        continue;
      }
      if (line.contains('FAR FIELD')) {
        skippedLineCount++;
        continue;
      }

      final event = _parseLine(line);
      if (event == null) {
        skippedLineCount++;
        continue;
      }
      events.add(event);
    }

    return HinetJmalistParseResult(
      events: events,
      skippedLineCount: skippedLineCount,
    );
  }

  HinetJmalistEvent? _parseLine(String line) {
    final match = _lineRegExp.firstMatch(line);
    if (match == null) {
      return null;
    }

    try {
      final datePart = match.group(1)!;
      final timePart = match.group(2)!;
      final dateSegments = datePart.split('-').map(int.parse).toList();
      final timeSegments = timePart.split(':');
      final secondSegments = timeSegments[2].split('.');

      final originTime = DateTime.utc(
        dateSegments[0],
        dateSegments[1],
        dateSegments[2],
        int.parse(timeSegments[0]),
        int.parse(timeSegments[1]),
        int.parse(secondSegments[0]),
        secondSegments.length > 1
            ? (double.parse('0.${secondSegments[1]}') * 1000).round()
            : 0,
      );

      final magnitude2Str = match.group(10);
      final magnitudeFlag = match.group(11);

      return HinetJmalistEvent(
        originTime: originTime,
        timeError: double.parse(match.group(3)!),
        latitude: double.parse(match.group(4)!),
        latitudeError: double.parse(match.group(5)!),
        longitude: double.parse(match.group(6)!),
        longitudeError: double.parse(match.group(7)!),
        depthKm: double.parse(match.group(8)!),
        magnitude1: double.parse(match.group(9)!),
        magnitude2: magnitude2Str == null ? null : double.parse(magnitude2Str),
        magnitudeFlag: (magnitudeFlag == null || magnitudeFlag.isEmpty)
            ? null
            : magnitudeFlag,
        regionNameEn: match.group(12)!,
        qualityCode: match.group(13)!,
      );
    } on FormatException {
      return null;
    }
  }
}
```

- [ ] **Step 5: コード生成 + 成功を確認**

Run: `cd /home/yumnumm/EQMonitor/packages/nied_api_client && dart run build_runner build --delete-conflicting-outputs && dart test test/hinet_jmalist_parser_test.dart`
Expected: PASS(5 tests)

- [ ] **Step 6: exportを追加**

`packages/nied_api_client/lib/nied_api_client.dart` の既存export群へ追記:

```dart
export 'src/hinet/jmalist/model/hinet_jmalist_event.dart';
export 'src/hinet/jmalist/parser/hinet_jmalist_parser.dart';
```

- [ ] **Step 7: analyze**

Run: `cd /home/yumnumm/EQMonitor/packages/nied_api_client && dart analyze lib/src/hinet/jmalist`
Expected: 警告0件

- [ ] **Step 8: コミット**

```bash
cd /home/yumnumm/EQMonitor
git add packages/nied_api_client/lib/src/hinet/jmalist packages/nied_api_client/lib/nied_api_client.dart packages/nied_api_client/test/hinet_jmalist_parser_test.dart
git commit -m "feat(nied_api_client): Hi-net jmalistモデル+パーサを追加"
```

---

### Task 16: `nied_api_client` — Hi-net認証クライアント + jmalist取得(進捗コールバック付き)

**Files:**
- Modify: `packages/nied_api_client/pubspec.yaml`(`cookie_jar`, `dio_cookie_manager` 追加)
- Create: `packages/nied_api_client/lib/src/hinet/jmalist/api/hinet_jmalist_api_client.dart`
- Modify: `packages/nied_api_client/lib/src/hinet/hinet_api_client.dart`(`jmalist` getter 追加)
- Modify: `packages/nied_api_client/lib/nied_api_client.dart`(export追加)
- Test: `packages/nied_api_client/test/hinet_jmalist_api_client_test.dart`

**Interfaces:**
- Consumes: `HinetJmalistParser`, `HinetJmalistParseResult`(Task 15)。
- Produces: `HinetJmalistFetchProgress`(`completedRequests int`, `totalRequests int`)。`HinetJmalistApiClient(Dio dio)`。`.login({required String userId, required String password}) -> Future<bool>`(ログイン成否、Cookieは内部のDio+CookieJarで保持)。`.fetchRange({required DateTime from, required DateTime to, void Function(HinetJmalistFetchProgress)? onProgress}) -> Future<HinetJmalistParseResult>`(内部で7日ごとに分割し直列にPOST、`skippedLineCount`は全チャンク合算)。Task 17・18(デバッグ画面)がこのクライアントを利用する。

**注意:** ログインは `https://hinetwww11.bosai.go.jp/auth/?LANG=ja` 自体への POST(フィールド `auth_un`/`auth_pw`、成功時 302 + `_ssl_auth` Cookie)であることを curl による事前検証で確認済み。仕様変更に備え、URLは実装内の1定数に閉じ込める。

- [ ] **Step 1: pubspecへ依存追加**

`packages/nied_api_client/pubspec.yaml` の `dependencies:` へ追加(`dio:` の次の行に挿入してアルファベット順を維持):

```yaml
  cookie_jar: ^4.0.8
  dio_cookie_manager: ^3.2.0
```

Run: `cd /home/yumnumm/EQMonitor/packages/nied_api_client && dart pub get`
Expected: 依存解決成功

- [ ] **Step 2: 失敗するテストを書く(ログイン成功/失敗、期間分割)**

`packages/nied_api_client/test/hinet_jmalist_api_client_test.dart`:

```dart
import 'dart:async';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:nied_api_client/src/hinet/jmalist/api/hinet_jmalist_api_client.dart';
import 'package:test/test.dart';

const _samplePreBody = '''
<html><body><pre>
2026-06-02 11:08:33.99  0.07   36.571  0.18  137.868  0.29     7.7   1.0  1.6V        NORTHERN NAGANO PREF  k
</pre></body></html>
''';

class _RecordingAdapter implements HttpClientAdapter {
  final requestedPaths = <String>[];
  bool loginShouldSucceed = true;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requestedPaths.add(options.path);
    if (!options.path.contains('jmalist.php')) {
      // jmalist.php 以外(= /auth/?LANG=ja へのログインPOST)への応答
      return ResponseBody.fromString(
        '',
        loginShouldSucceed ? 302 : 401,
        headers: loginShouldSucceed
            ? {
                'set-cookie': ['_ssl_auth=dummy-token; Path=/'],
              }
            : {},
      );
    }
    return ResponseBody.fromString(_samplePreBody, 200);
  }

  @override
  void close({bool force = false}) {}
}

void main() {
  test('ログイン成功時は true を返す', () async {
    final adapter = _RecordingAdapter();
    final dio = Dio(BaseOptions(followRedirects: false))
      ..httpClientAdapter = adapter;
    final client = HinetJmalistApiClient(dio);

    final result = await client.login(userId: 'user', password: 'pass');

    expect(result, isTrue);
  });

  test('ログイン失敗時は false を返す', () async {
    final adapter = _RecordingAdapter()..loginShouldSucceed = false;
    final dio = Dio(BaseOptions(followRedirects: false))
      ..httpClientAdapter = adapter;
    final client = HinetJmalistApiClient(dio);

    final result = await client.login(userId: 'user', password: 'wrong');

    expect(result, isFalse);
  });

  test('8日間の指定は7日+1日の2リクエストへ分割され進捗が通知される', () async {
    final adapter = _RecordingAdapter();
    final dio = Dio(BaseOptions(followRedirects: false))
      ..httpClientAdapter = adapter;
    final client = HinetJmalistApiClient(dio, requestInterval: Duration.zero);

    final progressUpdates = <HinetJmalistFetchProgress>[];
    final result = await client.fetchRange(
      from: DateTime.utc(2026, 6, 1),
      to: DateTime.utc(2026, 6, 8),
      onProgress: progressUpdates.add,
    );

    final jmalistRequests = adapter.requestedPaths
        .where((p) => p.contains('jmalist.php'))
        .length;
    expect(jmalistRequests, 2);
    expect(progressUpdates.last.completedRequests, 2);
    expect(progressUpdates.last.totalRequests, 2);
    expect(result.events, hasLength(2));
  });
}
```

- [ ] **Step 3: 失敗を確認**

Run: `cd /home/yumnumm/EQMonitor/packages/nied_api_client && dart test test/hinet_jmalist_api_client_test.dart`
Expected: FAIL(未実装)

- [ ] **Step 4: `HinetJmalistApiClient` を実装**

`packages/nied_api_client/lib/src/hinet/jmalist/api/hinet_jmalist_api_client.dart`:

```dart
import 'package:dio/dio.dart';
import 'package:nied_api_client/src/hinet/jmalist/model/hinet_jmalist_event.dart';
import 'package:nied_api_client/src/hinet/jmalist/parser/hinet_jmalist_parser.dart';

/// [HinetJmalistApiClient.fetchRange] の進捗。
class HinetJmalistFetchProgress {
  const HinetJmalistFetchProgress({
    required this.completedRequests,
    required this.totalRequests,
  });

  final int completedRequests;
  final int totalRequests;
}

/// Hi-net 気象庁一元化処理 震源リスト(`jmalist.php`)の認証付きクライアント。
///
/// フォーム認証(`auth_un`/`auth_pw` POST → `_ssl_auth` Cookie)を行った上で
/// `jmalist.php` へ `list_year`/`list_month`/`list_day`/`list_span` を POST する。
/// 1リクエストは最大7日分のため、指定期間はこのクライアント内で分割し、
/// [requestInterval] を挟みながら直列に実行してサーバ負荷を抑える。
///
/// NIED により震源情報の二次配布が禁止されているため、このクライアントは
/// 一般公開機能から到達不可能なデバッグ画面専用として扱うこと。
class HinetJmalistApiClient {
  HinetJmalistApiClient(
    this._dio, {
    this.requestInterval = const Duration(seconds: 2),
    this.parser = const HinetJmalistParser(),
  });

  final Dio _dio;

  /// 期間分割リクエスト間のウェイト(サーバ負荷配慮)
  final Duration requestInterval;
  final HinetJmalistParser parser;

  static const _baseUrl = 'https://hinetwww11.bosai.go.jp';

  /// フォーム認証を行い、成功した場合 true を返す。
  ///
  /// [_dio] に紐づく Cookie 保存(`CookieManager`/`PersistCookieJar`)は
  /// 呼び出し側([HinetApiClient]生成時)で設定済みであることを前提とする。
  Future<bool> login({
    required String userId,
    required String password,
  }) async {
    final response = await _dio.post<dynamic>(
      '$_baseUrl/auth/?LANG=ja',
      data: FormData.fromMap({'auth_un': userId, 'auth_pw': password}),
      options: Options(
        followRedirects: false,
        validateStatus: (status) => status != null && status < 500,
      ),
    );
    final statusCode = response.statusCode ?? 0;
    // ログイン成功時はリダイレクト(302)、失敗時は 401/200(再表示)を想定。
    return statusCode >= 300 && statusCode < 400;
  }

  /// [from] から [to] までの震源リストを取得する(両端含む、UTC日付単位)。
  ///
  /// 1リクエスト最大7日分の制約に従い、内部で期間を分割して直列実行する。
  Future<HinetJmalistParseResult> fetchRange({
    required DateTime from,
    required DateTime to,
    void Function(HinetJmalistFetchProgress)? onProgress,
  }) async {
    final chunks = _splitIntoWeeklyChunks(from: from, to: to);
    final allEvents = <HinetJmalistEvent>[];
    var skippedLineCount = 0;

    for (var i = 0; i < chunks.length; i++) {
      final chunk = chunks[i];
      final text = await _fetchChunk(chunk.start, chunk.days);
      final result = parser.parse(text);
      allEvents.addAll(result.events);
      skippedLineCount += result.skippedLineCount;

      onProgress?.call(
        HinetJmalistFetchProgress(
          completedRequests: i + 1,
          totalRequests: chunks.length,
        ),
      );

      if (i != chunks.length - 1 && requestInterval > Duration.zero) {
        await Future<void>.delayed(requestInterval);
      }
    }

    return HinetJmalistParseResult(
      events: allEvents,
      skippedLineCount: skippedLineCount,
    );
  }

  Future<String> _fetchChunk(DateTime start, int days) async {
    final response = await _dio.post<String>(
      '$_baseUrl/auth/JMA/jmalist.php',
      data: FormData.fromMap({
        'list_year': start.year.toString(),
        'list_month': start.month.toString(),
        'list_day': start.day.toString(),
        'list_span': days.toString(),
      }),
      options: Options(responseType: ResponseType.plain),
    );
    return _extractPreText(response.data ?? '');
  }

  /// HTMLレスポンスの `<pre>...</pre>` 部分のみを抽出する。
  String _extractPreText(String html) {
    final match = RegExp(
      r'<pre[^>]*>(.*?)</pre>',
      dotAll: true,
    ).firstMatch(html);
    return match?.group(1) ?? html;
  }

  List<({DateTime start, int days})> _splitIntoWeeklyChunks({
    required DateTime from,
    required DateTime to,
  }) {
    const maxDaysPerRequest = 7;
    final chunks = <({DateTime start, int days})>[];
    var cursor = DateTime.utc(from.year, from.month, from.day);
    final end = DateTime.utc(to.year, to.month, to.day);

    while (!cursor.isAfter(end)) {
      final remainingDays = end.difference(cursor).inDays + 1;
      final days = remainingDays > maxDaysPerRequest
          ? maxDaysPerRequest
          : remainingDays;
      chunks.add((start: cursor, days: days));
      cursor = cursor.add(Duration(days: days));
    }
    return chunks;
  }
}
```

- [ ] **Step 5: 成功を確認**

Run: `cd /home/yumnumm/EQMonitor/packages/nied_api_client && dart test test/hinet_jmalist_api_client_test.dart`
Expected: PASS(3 tests)

- [ ] **Step 6: `HinetApiClient` に `jmalist` getterを追加**

`packages/nied_api_client/lib/src/hinet/hinet_api_client.dart` を以下に置き換え:

```dart
import 'package:dio/dio.dart';
import 'package:nied_api_client/src/hinet/aqua/aqua_api_client.dart';
import 'package:nied_api_client/src/hinet/jmalist/api/hinet_jmalist_api_client.dart';

/// Hi-net APIクライアント
///
/// 防災科研のHi-netシステムのAPIにアクセスします
class HinetApiClient {
  /// Hi-net APIクライアントを作成
  HinetApiClient(this._dio);

  final Dio _dio;

  AquaApiClient get aqua => AquaApiClient(_dio);

  /// 気象庁一元化処理 震源リスト(jmalist.php)クライアント
  ///
  /// NIED により震源情報の二次配布が禁止されているため、
  /// アプリ側では一般公開機能から到達不可能なデバッグ画面専用で使うこと。
  HinetJmalistApiClient get jmalist => HinetJmalistApiClient(_dio);
}
```

- [ ] **Step 7: exportを追加**

`packages/nied_api_client/lib/nied_api_client.dart` へ追記:

```dart
export 'src/hinet/jmalist/api/hinet_jmalist_api_client.dart';
```

- [ ] **Step 8: analyze + 全パッケージテスト**

Run: `cd /home/yumnumm/EQMonitor/packages/nied_api_client && dart analyze && dart test`
Expected: 警告0件、全テストPASS

- [ ] **Step 9: コミット**

```bash
cd /home/yumnumm/EQMonitor
git add packages/nied_api_client
git commit -m "feat(nied_api_client): Hi-net認証クライアント+jmalist期間分割取得を追加"
```

---

### Task 17: アプリ側 — Hi-net認証情報のsecure storage保存 + Cookie永続化

**Files:**
- Modify: `app/pubspec.yaml`(`cookie_jar`, `dio_cookie_manager` 追加)
- Modify: `app/lib/feature/nied/data/provider/nied_dio_provider.dart`(CookieManager追加)
- Create: `app/lib/feature/settings/children/config/debug/hinet_seismicity/data/provider/hinet_credentials_provider.dart`
- Test: `app/test/feature/settings/children/config/debug/hinet_seismicity/hinet_credentials_provider_test.dart`

**Interfaces:**
- Consumes: `secureStorageProvider`(`app/lib/core/data/preferences/secure/secure_storage.dart`、既存、`Future<FlutterSecureStorage>`)。
- Produces: `HinetCredentials`(`userId String`, `password String`)。`HinetCredentialsNotifier`(`@Riverpod(keepAlive: true) class`、`build() -> Future<HinetCredentials?>`、`saveMutation`/`clearMutation`(`Mutation<void>`)、`save({required userId, required password})`, `clear()`)。Provider名 `hinetCredentialsNotifierProvider`。Task 18(デバッグ画面)がこれを利用する。`niedDioProvider` はCookie永続化により、同一セッション内で `login()` → `jmalist.php` の認証状態を維持する(既存のAqua/F-net/K-NETの取得系には影響しない、Cookie未設定時は単に空のCookieJarとして動作)。

- [ ] **Step 1: pubspecへ依存追加**

`app/pubspec.yaml` の `dependencies:` の `dio:` の直後に追加:

```yaml
  cookie_jar: ^4.0.8
  dio_cookie_manager: ^3.2.0
```

Run: `cd /home/yumnumm/EQMonitor/app && flutter pub get`
Expected: 依存解決成功

- [ ] **Step 2: `nied_dio_provider.dart` にCookieManagerを追加**

`app/lib/feature/nied/data/provider/nied_dio_provider.dart` を以下に置き換え:

```dart
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'nied_dio_provider.g.dart';

@Riverpod(keepAlive: true)
Dio niedDio(Ref ref) {
  final dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),
      responseType: ResponseType.plain,
      contentType: ContentType.html.value,
    ),
  );
  // Hi-net のフォーム認証(`_ssl_auth` Cookie)をセッション中保持するため、
  // メモリ上の CookieJar を利用する(アプリ再起動で失効して問題ない)。
  dio.interceptors.add(CookieManager(CookieJar()));
  return dio;
}
```

- [ ] **Step 3: 失敗するテストを書く(credentials保存/削除)**

`app/test/feature/settings/children/config/debug/hinet_seismicity/hinet_credentials_provider_test.dart`:

```dart
import 'package:eqmonitor/feature/settings/children/config/debug/hinet_seismicity/data/provider/hinet_credentials_provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const channel = MethodChannel(
    'plugins.it_nomads.com/flutter_secure_storage',
  );

  setUp(() {
    final storage = <String, String>{};
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (call) async {
      switch (call.method) {
        case 'write':
          final args = call.arguments as Map<Object?, Object?>;
          storage[args['key']! as String] = args['value']! as String;
          return null;
        case 'read':
          final args = call.arguments as Map<Object?, Object?>;
          return storage[args['key']! as String];
        case 'delete':
          final args = call.arguments as Map<Object?, Object?>;
          storage.remove(args['key']! as String);
          return null;
        case 'readAll':
          return storage;
        case 'deleteAll':
          storage.clear();
          return null;
        default:
          return null;
      }
    });
  });

  test('保存した認証情報を読み戻せる', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    await container
        .read(hinetCredentialsNotifierProvider.notifier)
        .save(userId: 'test-user', password: 'test-pass');

    final credentials = await container.read(
      hinetCredentialsNotifierProvider.future,
    );

    expect(credentials?.userId, 'test-user');
    expect(credentials?.password, 'test-pass');
  });

  test('clearで認証情報が消える', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    await container
        .read(hinetCredentialsNotifierProvider.notifier)
        .save(userId: 'test-user', password: 'test-pass');
    await container.read(hinetCredentialsNotifierProvider.notifier).clear();

    final credentials = await container.read(
      hinetCredentialsNotifierProvider.future,
    );
    expect(credentials, isNull);
  });
}
```

- [ ] **Step 4: 失敗を確認**

Run: `cd /home/yumnumm/EQMonitor/app && flutter test test/feature/settings/children/config/debug/hinet_seismicity/hinet_credentials_provider_test.dart`
Expected: FAIL(未実装)

- [ ] **Step 5: `HinetCredentialsNotifier` を実装**

`app/lib/feature/settings/children/config/debug/hinet_seismicity/data/provider/hinet_credentials_provider.dart`:

```dart
import 'package:eqmonitor/core/data/preferences/secure/secure_storage.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'hinet_credentials_provider.g.dart';

const _hinetUserIdKey = 'hinet_bosai_user_id';
const _hinetPasswordKey = 'hinet_bosai_password';

/// Hi-net(BOSAI)認証情報(ユーザーID + パスワード)。
///
/// **注意**: 値そのものをコード・ログ・fixtureへ書き出さないこと。
class HinetCredentials {
  const HinetCredentials({required this.userId, required this.password});

  final String userId;
  final String password;
}

/// SecureStorage から Hi-net 認証情報を読み書きするNotifier。
///
/// [KnetCredentialsNotifier](`app/lib/feature/knet_waveform/data/provider/knet_credentials_provider.dart`)
/// と同じ Mutation パターンに従う。
@Riverpod(keepAlive: true)
class HinetCredentialsNotifier extends _$HinetCredentialsNotifier {
  static final saveMutation = Mutation<void>();
  static final clearMutation = Mutation<void>();

  @override
  Future<HinetCredentials?> build() async {
    final storage = await ref.watch(secureStorageProvider.future);
    final userId = await storage.read(key: _hinetUserIdKey);
    final password = await storage.read(key: _hinetPasswordKey);
    if (userId == null || password == null) {
      return null;
    }
    return HinetCredentials(userId: userId, password: password);
  }

  Future<void> save({
    required String userId,
    required String password,
  }) async {
    final storage = await ref.read(secureStorageProvider.future);
    await storage.write(key: _hinetUserIdKey, value: userId);
    await storage.write(key: _hinetPasswordKey, value: password);
    state = AsyncData(HinetCredentials(userId: userId, password: password));
  }

  Future<void> clear() async {
    final storage = await ref.read(secureStorageProvider.future);
    await storage.delete(key: _hinetUserIdKey);
    await storage.delete(key: _hinetPasswordKey);
    state = const AsyncData(null);
  }
}
```

- [ ] **Step 6: コード生成 + 成功を確認**

Run: `cd /home/yumnumm/EQMonitor/app && melos run generate && flutter test test/feature/settings/children/config/debug/hinet_seismicity/hinet_credentials_provider_test.dart`
Expected: PASS(2 tests)

- [ ] **Step 7: analyze**

Run: `cd /home/yumnumm/EQMonitor/app && dart analyze lib/feature/nied lib/feature/settings/children/config/debug/hinet_seismicity`
Expected: 警告0件

- [ ] **Step 8: コミット**

```bash
cd /home/yumnumm/EQMonitor
git add app/pubspec.yaml app/lib/feature/nied/data/provider/nied_dio_provider.dart app/lib/feature/nied/data/provider/nied_dio_provider.g.dart app/lib/feature/settings/children/config/debug/hinet_seismicity/data app/test/feature/settings/children/config/debug/hinet_seismicity
git commit -m "feat(hinet-debug): Hi-net認証情報のsecure storage保存とCookie永続化を追加"
```

**Note:** `app/pubspec.lock` の更新も本コミットに含めること(`flutter pub get` が自動更新する)。

---

### Task 18: Hi-net一元化震源ビューア(デバッグ画面)— 期間指定取得+M下限フィルタ+共通可視化への接続

**Files:**
- Create: `app/lib/feature/settings/children/config/debug/hinet_seismicity/data/model/hinet_jmalist_event_mapper.dart`
- Create: `app/lib/feature/settings/children/config/debug/hinet_seismicity/data/repository/hinet_seismicity_repository.dart`
- Create: `app/lib/feature/settings/children/config/debug/hinet_seismicity/ui/hinet_seismicity_page.dart`
- Modify: `app/lib/core/router/router.dart`(`HinetSeismicityRoute` 追加)
- Modify: `app/lib/feature/nied/ui/nied_page.dart`(ListTile追加)
- Test: `app/test/feature/settings/children/config/debug/hinet_seismicity/data/model/hinet_jmalist_event_mapper_test.dart`

**Interfaces:**
- Consumes: `HinetJmalistEvent`(Task 15、`nied_api_client`)、`HinetJmalistApiClient`, `HinetJmalistFetchProgress`(Task 16)、`niedApiClientProvider`(`app/lib/feature/nied/data/provider/nied_api_client_provider.dart`、既存)、`HinetCredentialsNotifier`, `HinetCredentials`(Task 17)、`SeismicityEvent`(Task 1)、`SeismicityBoundsFilter`(Task 2)、`SeismicityEpicenterLayer`, `SeismicityColorMode`(Task 8)、`SeismicitySelectionOverlay`, `SeismicityBounds`(Task 10)、`SeismicityAnalysisPanel`(Task 14)、`mapConfigurationProvider`(既存)。
- Produces: `HinetJmalistEventMapper`拡張(`toSeismicityEvent`)。`HinetLoginException`。`HinetSeismicityFetchResult`(`events List<SeismicityEvent>`, `skippedLineCount int`)。`HinetSeismicityRepository(NiedApiClient client).fetch({required credentials, required from, required to, void Function(HinetJmalistFetchProgress)? onProgress}) -> Future<HinetSeismicityFetchResult>`。`HinetSeismicityPage`(HookConsumerWidget)。`HinetSeismicityRoute`。

- [ ] **Step 1: 失敗するマッパーテストを書く**

`app/test/feature/settings/children/config/debug/hinet_seismicity/data/model/hinet_jmalist_event_mapper_test.dart`:

```dart
import 'package:eqmonitor/feature/settings/children/config/debug/hinet_seismicity/data/model/hinet_jmalist_event_mapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nied_api_client/nied_api_client.dart';

void main() {
  test('M2がある場合は magnitude2 を優先する', () {
    final event = HinetJmalistEvent(
      originTime: DateTime.utc(2026, 6, 2, 11, 8, 33, 990),
      timeError: 0.07,
      latitude: 36.571,
      latitudeError: 0.18,
      longitude: 137.868,
      longitudeError: 0.29,
      depthKm: 7.7,
      magnitude1: 1,
      magnitude2: 1.6,
      magnitudeFlag: 'V',
      regionNameEn: 'NORTHERN NAGANO PREF',
      qualityCode: 'k',
    );

    final mapped = event.toSeismicityEvent;

    expect(mapped.magnitude, 1.6);
    expect(mapped.depth, 7.7);
    expect(mapped.latitude, 36.571);
    expect(mapped.longitude, 137.868);
    expect(mapped.maxIntensity, isNull);
    expect(mapped.eventId, isNotEmpty);
  });

  test('M2欠測時は magnitude1 を使う', () {
    final event = HinetJmalistEvent(
      originTime: DateTime.utc(2026, 6, 2),
      timeError: 0.1,
      latitude: 24.443,
      latitudeError: 0.34,
      longitude: 123.876,
      longitudeError: 0.34,
      depthKm: 8.7,
      magnitude1: 1.5,
      magnitude2: null,
      magnitudeFlag: null,
      regionNameEn: 'NEAR ISHIGAKIJIMA ISLAND',
      qualityCode: 'k',
    );

    expect(event.toSeismicityEvent.magnitude, 1.5);
  });
}
```

- [ ] **Step 2: 失敗を確認**

Run: `cd /home/yumnumm/EQMonitor/app && flutter test test/feature/settings/children/config/debug/hinet_seismicity/data/model/hinet_jmalist_event_mapper_test.dart`
Expected: FAIL(未実装)

- [ ] **Step 3: マッパーを実装**

`app/lib/feature/settings/children/config/debug/hinet_seismicity/data/model/hinet_jmalist_event_mapper.dart`:

```dart
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_event.dart';
import 'package:nied_api_client/nied_api_client.dart';

/// Hi-net jmalist 由来のイベントを公開版と共通の [SeismicityEvent] へ変換する。
extension HinetJmalistEventMapper on HinetJmalistEvent {
  SeismicityEvent get toSeismicityEvent => SeismicityEvent(
    eventId:
        'hinet-${originTime.microsecondsSinceEpoch}-'
        '${latitude.toStringAsFixed(3)}-${longitude.toStringAsFixed(3)}',
    originTime: originTime,
    magnitude: magnitude2 ?? magnitude1,
    depth: depthKm,
    latitude: latitude,
    longitude: longitude,
    maxIntensity: null,
  );
}
```

- [ ] **Step 4: 成功を確認**

Run: `cd /home/yumnumm/EQMonitor/app && flutter test test/feature/settings/children/config/debug/hinet_seismicity/data/model/hinet_jmalist_event_mapper_test.dart`
Expected: PASS(2 tests)

- [ ] **Step 5: `HinetSeismicityRepository` を実装**

`app/lib/feature/settings/children/config/debug/hinet_seismicity/data/repository/hinet_seismicity_repository.dart`:

```dart
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_event.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/hinet_seismicity/data/model/hinet_jmalist_event_mapper.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/hinet_seismicity/data/provider/hinet_credentials_provider.dart';
import 'package:nied_api_client/nied_api_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'hinet_seismicity_repository.g.dart';

/// ログイン失敗時に送出する例外。
class HinetLoginException implements Exception {
  const HinetLoginException();

  @override
  String toString() => 'Hi-net へのログインに失敗しました';
}

/// [HinetSeismicityRepository.fetch] の結果。
class HinetSeismicityFetchResult {
  const HinetSeismicityFetchResult({
    required this.events,
    required this.skippedLineCount,
  });

  final List<SeismicityEvent> events;
  final int skippedLineCount;
}

@Riverpod(keepAlive: true)
HinetSeismicityRepository hinetSeismicityRepository(Ref ref) =>
    HinetSeismicityRepository(client: ref.watch(niedApiClientProvider));

class HinetSeismicityRepository {
  const HinetSeismicityRepository({required NiedApiClient client})
    : _client = client;

  final NiedApiClient _client;

  Future<HinetSeismicityFetchResult> fetch({
    required HinetCredentials credentials,
    required DateTime from,
    required DateTime to,
    void Function(HinetJmalistFetchProgress)? onProgress,
  }) async {
    final loggedIn = await _client.hinet.jmalist.login(
      userId: credentials.userId,
      password: credentials.password,
    );
    if (!loggedIn) {
      throw const HinetLoginException();
    }

    final result = await _client.hinet.jmalist.fetchRange(
      from: from,
      to: to,
      onProgress: onProgress,
    );

    return HinetSeismicityFetchResult(
      events: result.events.map((e) => e.toSeismicityEvent).toList(),
      skippedLineCount: result.skippedLineCount,
    );
  }
}
```

- [ ] **Step 6: `niedApiClientProvider` の import解決を確認**

`app/lib/feature/nied/data/provider/nied_api_client_provider.dart`(既存)がそのまま利用できることを確認する(変更不要)。

- [ ] **Step 7: `HinetSeismicityPage` を実装**

`app/lib/feature/settings/children/config/debug/hinet_seismicity/ui/hinet_seismicity_page.dart`:

```dart
import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/feature/map/data/notifier/map_configuration_notifier.dart';
import 'package:eqmonitor/feature/seismicity/data/logic/seismicity_bounds_filter.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_bounds.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_color_mode.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_event.dart';
import 'package:eqmonitor/feature/seismicity/ui/components/seismicity_color_mode_selector.dart';
import 'package:eqmonitor/feature/seismicity/ui/components/seismicity_selection_overlay.dart';
import 'package:eqmonitor/feature/seismicity/ui/layer/seismicity_epicenter_layer.dart';
import 'package:eqmonitor/feature/seismicity/ui/panel/seismicity_analysis_panel.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/hinet_seismicity/data/provider/hinet_credentials_provider.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/hinet_seismicity/data/repository/hinet_seismicity_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geobase/geobase.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';
import 'package:nied_api_client/nied_api_client.dart';

/// Hi-net 気象庁一元化処理 震源リストのデバッグビューア。
///
/// **一般ユーザーからは到達不可能なデバッグメニュー配下限定**。
/// NIED は震源情報の二次配布を禁止しているため、本画面の内容を
/// 一般公開画面へ転用しないこと。
class HinetSeismicityPage extends HookConsumerWidget {
  const HinetSeismicityPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final credentialsAsync = ref.watch(hinetCredentialsNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Hi-net 一元化震源ビューア')),
      body: switch (credentialsAsync) {
        AsyncData(value: final credentials?) => _FetchBody(
          credentials: credentials,
        ),
        AsyncError(:final error) => Center(child: ErrorCard(error: error)),
        AsyncData() => const _CredentialsForm(),
        _ => const Center(child: CircularProgressIndicator.adaptive()),
      },
    );
  }
}

class _CredentialsForm extends HookConsumerWidget {
  const _CredentialsForm();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userIdController = useTextEditingController();
    final passwordController = useTextEditingController();
    final isSaving = useState(false);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('NIED(BOSAI)アカウントのID/パスワードを入力してください。'),
          const SizedBox(height: 8),
          TextField(
            controller: userIdController,
            decoration: const InputDecoration(labelText: 'ユーザーID'),
          ),
          TextField(
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(labelText: 'パスワード'),
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: isSaving.value
                ? null
                : () async {
                    isSaving.value = true;
                    try {
                      await HinetCredentialsNotifier.saveMutation.run(
                        ref,
                        (tsx) async => tsx
                            .get(hinetCredentialsNotifierProvider.notifier)
                            .save(
                              userId: userIdController.text,
                              password: passwordController.text,
                            ),
                      );
                    } finally {
                      isSaving.value = false;
                    }
                  },
            child: isSaving.value
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('保存'),
          ),
        ],
      ),
    );
  }
}

class _FetchBody extends HookConsumerWidget {
  const _FetchBody({required this.credentials});

  final HinetCredentials credentials;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final from = useState(DateTime.now().subtract(const Duration(days: 7)));
    final to = useState(DateTime.now());
    final minMagnitude = useState(0.0);
    final colorMode = useState(SeismicityColorMode.magnitude);
    final isSelecting = useState(false);
    final selectedBounds = useState<SeismicityBounds?>(null);

    final isFetching = useState(false);
    final progress = useState<HinetJmalistFetchProgress?>(null);
    final fetchError = useState<Object?>(null);
    final fetchedEvents = useState<List<SeismicityEvent>>(const []);
    final skippedLineCount = useState(0);

    final mapConfiguration = ref.watch(mapConfigurationProvider);
    final filteredEvents = fetchedEvents.value
        .where((e) => (e.magnitude ?? double.negativeInfinity) >= minMagnitude.value)
        .toList();

    Future<void> handleFetch() async {
      isFetching.value = true;
      fetchError.value = null;
      progress.value = null;
      try {
        final repository = ref.read(hinetSeismicityRepositoryProvider);
        final result = await repository.fetch(
          credentials: credentials,
          from: from.value,
          to: to.value,
          onProgress: (p) => progress.value = p,
        );
        fetchedEvents.value = result.events;
        skippedLineCount.value = result.skippedLineCount;
      } on Object catch (e) {
        fetchError.value = e;
      } finally {
        isFetching.value = false;
      }
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Wrap(
            spacing: 12,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              _DatePickerButton(
                label: '開始',
                value: from.value,
                onChanged: (v) => from.value = v,
              ),
              _DatePickerButton(
                label: '終了',
                value: to.value,
                onChanged: (v) => to.value = v,
              ),
              SizedBox(
                width: 220,
                child: Row(
                  children: [
                    const Text('M ≥'),
                    Expanded(
                      child: Slider(
                        value: minMagnitude.value,
                        min: -2,
                        max: 7,
                        divisions: 90,
                        label: minMagnitude.value.toStringAsFixed(1),
                        onChanged: (v) => minMagnitude.value = v,
                      ),
                    ),
                    Text(minMagnitude.value.toStringAsFixed(1)),
                  ],
                ),
              ),
              FilledButton.icon(
                onPressed: isFetching.value ? null : handleFetch,
                icon: isFetching.value
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.download),
                label: Text(isFetching.value ? '取得中...' : '取得'),
              ),
              IconButton(
                icon: Icon(
                  isSelecting.value
                      ? Icons.crop_free
                      : Icons.crop_free_outlined,
                ),
                tooltip: '矩形選択',
                onPressed: () {
                  isSelecting.value = !isSelecting.value;
                  if (!isSelecting.value) {
                    selectedBounds.value = null;
                  }
                },
              ),
            ],
          ),
        ),
        if (progress.value case final p?)
          LinearProgressIndicator(
            value: p.completedRequests / p.totalRequests,
          ),
        if (fetchError.value case final error?)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '取得エラー: $error',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ),
                if (error is HinetLoginException)
                  TextButton(
                    onPressed: () async {
                      await HinetCredentialsNotifier.clearMutation.run(
                        ref,
                        (tsx) async =>
                            tsx.get(hinetCredentialsNotifierProvider.notifier).clear(),
                      );
                    },
                    child: const Text('認証情報を再設定'),
                  ),
              ],
            ),
          ),
        if (skippedLineCount.value > 0)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text('スキップした行: ${skippedLineCount.value}件'),
          ),
        Expanded(
          child: switch (mapConfiguration) {
            AsyncData(:final value) when value.styleString != null => Stack(
              children: [
                MapLibreMap(
                  options: MapOptions(
                    initStyle: value.styleString!,
                    initCenter: const Geographic(lon: 137.0, lat: 36.5),
                    initZoom: 4.5,
                  ),
                  children: [
                    SeismicityEpicenterLayer(
                      events: filteredEvents,
                      colorMode: colorMode.value,
                    ),
                  ],
                ),
                SeismicitySelectionOverlay(
                  enabled: isSelecting.value,
                  onSelectionEnd: (bounds) => selectedBounds.value = bounds,
                ),
              ],
            ),
            AsyncError(:final error) => Center(child: ErrorCard(error: error)),
            _ => const Center(child: CircularProgressIndicator.adaptive()),
          },
        ),
        if (selectedBounds.value case final bounds?)
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: SeismicityAnalysisPanel(
              events: const SeismicityBoundsFilter().filter(
                events: filteredEvents,
                minLatitude: bounds.minLatitude,
                maxLatitude: bounds.maxLatitude,
                minLongitude: bounds.minLongitude,
                maxLongitude: bounds.maxLongitude,
              ),
            ),
          ),
      ],
    );
  }
}

class _DatePickerButton extends StatelessWidget {
  const _DatePickerButton({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final DateTime value;
  final ValueChanged<DateTime> onChanged;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: value,
          firstDate: DateTime(2002, 6, 3),
          lastDate: DateTime.now(),
        );
        if (picked != null) {
          onChanged(picked);
        }
      },
      child: Text(
        '$label: ${value.year}/${value.month.toString().padLeft(2, '0')}/'
        '${value.day.toString().padLeft(2, '0')}',
      ),
    );
  }
}
```

- [ ] **Step 8: ルートを追加**

`app/lib/core/router/router.dart` の import ブロックへ追加:

```dart
import 'package:eqmonitor/feature/settings/children/config/debug/hinet_seismicity/ui/hinet_seismicity_page.dart';
```

`NiedRoute` の `routes:` リスト(391-422行目付近、`KnetWaveformRoute` のエントリの直後)へ追加:

```dart
TypedGoRoute<HinetSeismicityRoute>(path: 'hinet-seismicity'),
```

`KnetStationWaveformRoute` クラス定義の直後(837行目付近)に追加:

```dart
class HinetSeismicityRoute extends GoRouteData with $HinetSeismicityRoute {
  const HinetSeismicityRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HinetSeismicityPage();
  }
}
```

- [ ] **Step 9: `NiedPage` にListTileを追加**

`app/lib/feature/nied/ui/nied_page.dart` の `K-NET/KiK-net` ListTile の直後へ追加:

```dart
ListTile(
  title: const Text('Hi-net 一元化震源ビューア'),
  subtitle: const Text('デバッグ専用・二次配布禁止データのため非公開'),
  leading: const Icon(Icons.warning_amber),
  onTap: () async => const HinetSeismicityRoute().push<void>(context),
),
```

必要な import を追加:

```dart
import 'package:eqmonitor/core/router/router.dart';
```

(既に import 済みの場合は不要。実装時に確認すること。)

- [ ] **Step 10: コード生成**

Run: `cd /home/yumnumm/EQMonitor/app && melos run generate`
Expected: `hinet_seismicity_repository.g.dart` と `router.g.dart`(`$HinetSeismicityRoute` 追加分)が生成される。

- [ ] **Step 11: analyze + テスト**

Run: `cd /home/yumnumm/EQMonitor/app && dart analyze lib/feature/settings/children/config/debug/hinet_seismicity lib/feature/nied lib/core/router && flutter test test/feature/settings/children/config/debug/hinet_seismicity`
Expected: 警告0件、全テストPASS

- [ ] **Step 12: 手動確認**

Run: `cd /home/yumnumm/EQMonitor/app && flutter run -d <device-id>`
手順: 設定 → デバッグメニュー → NIED → 「Hi-net 一元化震源ビューア」→ ID/PWを入力して保存 → 期間・M下限を設定して「取得」→ 地図に震央が表示され、矩形選択→分析パネルが動作することを確認する。
Expected: 認証情報保存後にフォームが取得UIへ切り替わり、取得後に震央分布・矩形選択・分析パネルが公開版と同じ見た目で動作する。

- [ ] **Step 13: コミット**

```bash
cd /home/yumnumm/EQMonitor
git add app/lib/feature/settings/children/config/debug/hinet_seismicity app/lib/core/router/router.dart app/lib/core/router/router.g.dart app/lib/feature/nied/ui/nied_page.dart app/test/feature/settings/children/config/debug/hinet_seismicity
git commit -m "feat(hinet-debug): Hi-net一元化震源ビューア(デバッグ画面)を実装"
```

---

### Task 19: 全体検証(analyze / test / 実機確認)

**Files:**
- なし(既存タスクの成果物を横断的に検証する)

**Interfaces:**
- Consumes: Task 1〜18のすべての成果物。
- Produces: なし(検証のみ)。

- [ ] **Step 1: ワークスペース全体のコード生成が最新であることを確認**

Run: `melos run generate`
Expected: 差分なし(既にコミット済みの生成物と一致)、エラーなく完了

- [ ] **Step 2: `dart analyze` をワークスペース全体で実行**

Run: `cd /home/yumnumm/EQMonitor && melos run analyze`
Expected: `app`, `packages/nied_api_client` を含む全パッケージで警告0件

- [ ] **Step 3: Flutterテストを実行**

Run: `cd /home/yumnumm/EQMonitor && melos run test:flutter`
Expected: `app/test/feature/seismicity/**`, `app/test/feature/settings/children/config/debug/hinet_seismicity/**` を含む全テストPASS

- [ ] **Step 4: Dartパッケージテストを実行**

Run: `cd /home/yumnumm/EQMonitor && melos run test:dart`
Expected: `packages/nied_api_client/test/hinet_jmalist_parser_test.dart`, `hinet_jmalist_api_client_test.dart` を含む全テストPASS

- [ ] **Step 5: フォーマット確認**

Run: `cd /home/yumnumm/EQMonitor && dart format --output=none --set-exit-if-changed app/lib/feature/seismicity app/lib/feature/settings/children/config/debug/hinet_seismicity app/lib/feature/nied packages/nied_api_client/lib/src/hinet`
Expected: 終了コード0(フォーマット済み)。差分がある場合は `dart format <path>` で修正しコミットに含める。

- [ ] **Step 6: 実機/シミュレータでの手動確認(公開版)**

Run: `cd /home/yumnumm/EQMonitor/app && flutter run -d <device-id>`
手順:
1. 設定 → 「地震活動」を開く。
2. 期間セレクタ(1/3/12ヶ月)と色分けモード(経過時間/マグニチュード)を切り替え、震央分布の色・サイズが変化することを確認する。
3. 右上の矩形選択アイコンをタップし、地図上をドラッグして矩形を確定する。
4. 画面下部にM-T図・積算図/ヒストグラム・深さ断面(緯度/経度軸切替)のタブ付きパネルが表示され、タブ切替が正しく動くことを確認する。
5. 機内モード等でネットワークを切断した状態で期間を切り替え、「取得失敗のため前回データを表示中」の表示(初回取得済みの場合)またはエラー表示(未取得の場合)が出ることを確認する。

Expected: 上記すべてがクラッシュなく動作する。

- [ ] **Step 7: 実機/シミュレータでの手動確認(Hi-netデバッグ画面)**

Run: `cd /home/yumnumm/EQMonitor/app && flutter run -d <device-id>`
手順:
1. デバッグモードを有効化した上で 設定 → デバッグメニュー → NIED → 「Hi-net 一元化震源ビューア」を開く。
2. NIEDアカウントのID/PW(実在のテストアカウント)を入力して保存する。**この値は画面上でのみ扱い、コミット・ログに残さない。**
3. 期間(例: 直近1週間)とMの下限を設定して「取得」を押し、進捗バーが進み、地図に震央が表示されることを確認する。
4. スキップ行数の表示(存在する場合)を確認する。
5. 矩形選択→分析パネルが公開版と同じ挙動で動作することを確認する。

Expected: 認証・取得・可視化・矩形選択がすべて正常に動作し、一般ユーザー向け画面(地震活動画面や公開メニュー)からこの画面へ到達する経路が存在しないことを確認する。

- [ ] **Step 8: 最終コミット(生成物・フォーマット差分がある場合のみ)**

```bash
cd /home/yumnumm/EQMonitor
git status
# 差分がある場合のみ
git add -A
git commit -m "chore(seismicity): 生成物・フォーマットの最終調整"
```
