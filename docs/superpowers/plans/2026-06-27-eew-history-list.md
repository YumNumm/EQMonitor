# EEW一覧ページ (Spec A) 実装プラン

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** デバッグ画面に、発表中EEWを上部にピン留めし過去EEWをページネーションで遡れる「EEW一覧ページ」を新規作成する。

**Architecture:** 既存の地震履歴ページ (`app/lib/feature/earthquake_history/`) を踏襲し、`GroupedDataSource` + `paging_view` でページネーション、`EewListParameter` でフィルタ、既存 `eewProvider` でリアルタイムピン留めを行う。新規ディレクトリ `app/lib/feature/eew_history/` に実装する。

**Tech Stack:** Flutter / Riverpod (riverpod_annotation) / Flutter Hooks / Freezed / paging_view / retrofit (`eqmonitor_api`)

## Global Constraints

- Dart コードは `dart analyze` で警告ゼロ (`melos run analyze`)。
- フォーマットは `dart format` 準拠。
- パッケージ間 import は package import を使用(相対 import 禁止)。
- 生成ファイル (`*.g.dart`, `*.freezed.dart`) はコミットする。アノテーション変更後は app パッケージで `dart run build_runner build --delete-conflicting-outputs` を実行。
- テスト実行は app ディレクトリ内で `flutter test <path>`、全体は `melos run test:flutter`。
- 一覧の行は **イベント単位**(1 eventId につき1行、最終報を代表表示)。
- フィルタは EEW API (`GET /v2/eew`) が対応する5項目のみ: マグニチュード / 深さ / 最大予想震度 / 期間 / 警報のみ。
- 行タップ遷移は暫定で既存 `EewDetailsByEventIdRoute(eventId)` へ push(Spec B で差し替え)。
- 描画は履歴・リアルタイム共通で `EewTelegramItem`(`app/lib/feature/eew/data/model/eew_telegram_item.dart`)を用いる。`api.EewItemWithRelations` からは既存の `toEewTelegramItem` で変換する。

---

## ファイル構成

```
app/lib/feature/eew_history/
├── data/
│   ├── model/
│   │   ├── eew_list_parameter.dart          # Create — フィルタ条件 (Freezed) + toQuery + isFiltering
│   │   └── eew_list_page.dart               # Create — リポジトリ戻り値 (items + nextToken)
│   ├── repository/
│   │   └── eew_list_repository.dart          # Create — EewApiClient.getV2Eew ラッパ + provider
│   └── notifier/
│       └── eew_list_data_source.dart         # Create — GroupedDataSource + provider
└── ui/
    ├── eew_history_page.dart                 # Create — ピン留め + リスト組み立て
    └── components/
        ├── eew_history_list_tile.dart        # Create — 一覧1行
        ├── eew_warning_filter_chip.dart      # Create — 警報のみトグル
        ├── eew_list_parameter_persistent_delegate.dart  # Create — フィルタバー
        └── pinned_active_eew_section.dart    # Create — 上部ピン留め

app/lib/core/router/router.dart               # Modify — EewHistoryRoute 追加
app/lib/feature/settings/children/config/debug/debug_page.dart  # Modify — ListTile 追加

app/test/feature/eew_history/
├── eew_list_parameter_test.dart              # Create
└── eew_list_data_source_test.dart            # Create
```

---

## Task 1: EewListParameter モデル(フィルタ条件 + クエリ変換)

`EewListParameter` は5項目のフィルタを保持する Freezed クラス。API クエリへの変換 `toQuery` と、フィルタ適用中かを表す `isFiltering` を持つ。これらは純粋関数なので単体テストの中心になる。

**Files:**
- Create: `app/lib/feature/eew_history/data/model/eew_list_parameter.dart`
- Test: `app/test/feature/eew_history/eew_list_parameter_test.dart`

**Interfaces:**
- Consumes: `core` の `Date`、`app/lib/core/model/intensity/jma_intensity.dart` の `JmaIntensity` と `toApiJmaIntensity`、`eqmonitor_api` の `JmaIntensity`(`api.JmaIntensity`)。
- Produces:
  - `class EewListParameter`(Freezed, `fromJson` 付き)。フィールド: `double? magnitudeGte/Lte`, `int? depthGte/Lte`, `JmaIntensity? intensityGte/Lte`(app の JmaIntensity), `Date? originTimeGte/Lte`, `bool? isWarning`。
  - `bool get isFiltering`(default インスタンスとの不一致で true)。
  - `EewQuery get toQuery` ではなく `EewQuery toQuery({String? cursor, required int limit})` を返す。`EewQuery` は型エイリアスの record:
    `typedef EewQuery = ({String limit, String? cursor, String? magnitudeGte, String? magnitudeLte, String? depthGte, String? depthLte, api.JmaIntensity? intensityGte, api.JmaIntensity? intensityLte, String? originTimeGte, String? originTimeLte, String? isWarning});`
  - update 拡張: `updateMagnitude`, `updateDepth`, `updateIntensity`, `updateOriginTimeRange`, `updateIsWarning`(地震履歴の reset-to-null パターンに合わせる)。

- [ ] **Step 1: 失敗するテストを書く**

`app/test/feature/eew_history/eew_list_parameter_test.dart`:

```dart
import 'package:core/core.dart' show Date;
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/eew_history/data/model/eew_list_parameter.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EewListParameter.isFiltering', () {
    test('デフォルトでは false', () {
      expect(const EewListParameter().isFiltering, isFalse);
    });
    test('いずれかの条件が設定されると true', () {
      expect(
        const EewListParameter(magnitudeGte: 5).isFiltering,
        isTrue,
      );
    });
  });

  group('EewListParameter.toQuery', () {
    test('空パラメータでは limit と cursor 以外は null', () {
      final q = const EewListParameter().toQuery(cursor: null, limit: 10);
      expect(q.limit, '10');
      expect(q.cursor, isNull);
      expect(q.magnitudeGte, isNull);
      expect(q.intensityGte, isNull);
      expect(q.isWarning, isNull);
    });

    test('各フィルタが文字列・APIenumに変換される', () {
      const originGte = Date(year: 2026, month: 6, day: 1);
      final q = const EewListParameter(
        magnitudeGte: 4.5,
        depthLte: 100,
        intensityGte: JmaIntensity.fiveLower,
        originTimeGte: originGte,
        isWarning: true,
      ).toQuery(cursor: 'c1', limit: 50);

      expect(q.limit, '50');
      expect(q.cursor, 'c1');
      expect(q.magnitudeGte, '4.5');
      expect(q.depthLte, '100');
      expect(q.intensityGte, JmaIntensity.fiveLower.toApiJmaIntensity);
      expect(q.originTimeGte, originGte.toString());
      expect(q.isWarning, 'true');
    });
  });

  group('EewListParameter update', () {
    test('updateMagnitude は初期値(0,9)で null に戻す想定の値も保持する', () {
      final p = const EewListParameter().updateMagnitude(4, 7);
      expect(p.magnitudeGte, 4);
      expect(p.magnitudeLte, 7);
    });
    test('updateIsWarning(false) は null 化(全件表示)', () {
      final p = const EewListParameter(isWarning: true).updateIsWarning(false);
      expect(p.isWarning, isNull);
    });
    test('updateIsWarning(true) は true', () {
      final p = const EewListParameter().updateIsWarning(true);
      expect(p.isWarning, isTrue);
    });
  });
}
```

- [ ] **Step 2: テストが失敗することを確認**

Run: `cd app && flutter test test/feature/eew_history/eew_list_parameter_test.dart`
Expected: コンパイルエラー(`EewListParameter` 未定義)で FAIL。

- [ ] **Step 3: モデルを実装**

`app/lib/feature/eew_history/data/model/eew_list_parameter.dart`:

```dart
import 'package:core/core.dart' show Date;
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'eew_list_parameter.freezed.dart';
part 'eew_list_parameter.g.dart';

/// `GET /v2/eew` に渡すクエリ値。すべて文字列化済み(intensity は API enum)。
typedef EewQuery = ({
  String limit,
  String? cursor,
  String? magnitudeGte,
  String? magnitudeLte,
  String? depthGte,
  String? depthLte,
  api.JmaIntensity? intensityGte,
  api.JmaIntensity? intensityLte,
  String? originTimeGte,
  String? originTimeLte,
  String? isWarning,
});

@freezed
abstract class EewListParameter with _$EewListParameter {
  const factory EewListParameter({
    double? magnitudeGte,
    double? magnitudeLte,
    int? depthGte,
    int? depthLte,
    JmaIntensity? intensityGte,
    JmaIntensity? intensityLte,
    Date? originTimeGte,
    Date? originTimeLte,
    bool? isWarning,
  }) = _EewListParameter;

  const EewListParameter._();

  factory EewListParameter.fromJson(Map<String, dynamic> json) =>
      _$EewListParameterFromJson(json);

  bool get isFiltering => this != const EewListParameter();

  EewQuery toQuery({required String? cursor, required int limit}) => (
    limit: limit.toString(),
    cursor: cursor,
    magnitudeGte: magnitudeGte?.toString(),
    magnitudeLte: magnitudeLte?.toString(),
    depthGte: depthGte?.toString(),
    depthLte: depthLte?.toString(),
    intensityGte: intensityGte?.toApiJmaIntensity,
    intensityLte: intensityLte?.toApiJmaIntensity,
    originTimeGte: originTimeGte?.toString(),
    originTimeLte: originTimeLte?.toString(),
    isWarning: isWarning?.toString(),
  );
}

extension EewListParameterEx on EewListParameter {
  EewListParameter updateMagnitude(double? min, double? max) =>
      copyWith(magnitudeGte: min, magnitudeLte: max);

  EewListParameter updateDepth(int? min, int? max) =>
      copyWith(depthGte: min, depthLte: max);

  EewListParameter updateIntensity(JmaIntensity? min, JmaIntensity? max) =>
      copyWith(intensityGte: min, intensityLte: max);

  EewListParameter updateOriginTimeRange(Date? gte, Date? lte) =>
      copyWith(originTimeGte: gte, originTimeLte: lte);

  /// 警報のみトグル。false は「全件表示」を意味するため null 化する。
  EewListParameter updateIsWarning(bool value) =>
      copyWith(isWarning: value ? true : null);
}
```

- [ ] **Step 4: コード生成**

Run: `cd app && dart run build_runner build --delete-conflicting-outputs`
Expected: `eew_list_parameter.freezed.dart` と `eew_list_parameter.g.dart` が生成される。

- [ ] **Step 5: テストが通ることを確認**

Run: `cd app && flutter test test/feature/eew_history/eew_list_parameter_test.dart`
Expected: PASS(全 7 ケース)。

- [ ] **Step 6: コミット**

```bash
git add app/lib/feature/eew_history/data/model/eew_list_parameter.dart \
        app/lib/feature/eew_history/data/model/eew_list_parameter.freezed.dart \
        app/lib/feature/eew_history/data/model/eew_list_parameter.g.dart \
        app/test/feature/eew_history/eew_list_parameter_test.dart
git commit -m "feat(eew_history): add EewListParameter with query conversion"
```

---

## Task 2: EewListRepository(EEW履歴取得)

`GET /v2/eew` を呼び、`api.EewItemWithRelations` を `EewTelegramItem` に変換して返す薄いリポジトリ。テスト容易性のため `EewApiClient` を直接受け取る(ApiClient 全体ではなく)。

**Files:**
- Create: `app/lib/feature/eew_history/data/model/eew_list_page.dart`
- Create: `app/lib/feature/eew_history/data/repository/eew_list_repository.dart`

**Interfaces:**
- Consumes: Task 1 の `EewListParameter.toQuery`、`eqmonitor_api` の `EewApiClient`・`EewListResponse`・`EewItemWithRelations`、`app/lib/core/api/api_client_provider.dart` の `apiClientProvider`、`app/lib/feature/eew/data/model/eew_telegram_item.dart` の `toEewTelegramItem`。
- Produces:
  - `class EewListPage`(Freezed): `List<EewTelegramItem> items`, `String? nextToken`。
  - `class EewListRepository`: コンストラクタ `EewListRepository({required EewApiClient eew})`、メソッド `Future<EewListPage> fetchEewList({required EewListParameter parameter, String? cursor, required int limit})`。
  - `eewListRepositoryProvider`(`@Riverpod(keepAlive: true) Future<EewListRepository>`)。

- [ ] **Step 1: EewListPage を実装**

`app/lib/feature/eew_history/data/model/eew_list_page.dart`:

```dart
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'eew_list_page.freezed.dart';

@freezed
abstract class EewListPage with _$EewListPage {
  const factory EewListPage({
    required List<EewTelegramItem> items,
    required String? nextToken,
  }) = _EewListPage;
}
```

- [ ] **Step 2: リポジトリを実装**

`app/lib/feature/eew_history/data/repository/eew_list_repository.dart`:

```dart
import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/eew_history/data/model/eew_list_page.dart';
import 'package:eqmonitor/feature/eew_history/data/model/eew_list_parameter.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'eew_list_repository.g.dart';

@Riverpod(keepAlive: true)
Future<EewListRepository> eewListRepository(Ref ref) async {
  final apiClient = await ref.watch(apiClientProvider.future);
  return EewListRepository(eew: apiClient.eew);
}

class EewListRepository {
  EewListRepository({required api.EewApiClient eew}) : _eew = eew;

  final api.EewApiClient _eew;

  Future<EewListPage> fetchEewList({
    required EewListParameter parameter,
    required String? cursor,
    required int limit,
  }) async {
    final q = parameter.toQuery(cursor: cursor, limit: limit);
    final response = await _eew.getV2Eew(
      limit: q.limit,
      cursor: q.cursor,
      magnitudeGte: q.magnitudeGte,
      magnitudeLte: q.magnitudeLte,
      depthGte: q.depthGte,
      depthLte: q.depthLte,
      intensityGte: q.intensityGte,
      intensityLte: q.intensityLte,
      originTimeGte: q.originTimeGte,
      originTimeLte: q.originTimeLte,
      isWarning: q.isWarning,
    );
    return EewListPage(
      items: response.data.items.map((e) => e.toEewTelegramItem).toList(),
      nextToken: response.data.nextToken,
    );
  }
}
```

- [ ] **Step 3: コード生成**

Run: `cd app && dart run build_runner build --delete-conflicting-outputs`
Expected: `eew_list_page.freezed.dart` と `eew_list_repository.g.dart` が生成される。

- [ ] **Step 4: analyze で検証**

Run: `cd app && dart analyze lib/feature/eew_history/data`
Expected: `No issues found!`。(リポジトリの実挙動は Task 3 のデータソーステストで Fake リポジトリ経由で検証する。)

- [ ] **Step 5: コミット**

```bash
git add app/lib/feature/eew_history/data/model/eew_list_page.dart \
        app/lib/feature/eew_history/data/model/eew_list_page.freezed.dart \
        app/lib/feature/eew_history/data/repository/eew_list_repository.dart \
        app/lib/feature/eew_history/data/repository/eew_list_repository.g.dart
git commit -m "feat(eew_history): add EewListRepository"
```

---

## Task 3: EewListDataSource(ページネーション + グループ化 + リアルタイム upsert)

`GroupedDataSource` を継承し、日付グループ化・ページネーション・リアルタイム upsert を行う。`earthquake_history_data_source.dart` を踏襲する。

**Files:**
- Create: `app/lib/feature/eew_history/data/notifier/eew_list_data_source.dart`
- Test: `app/test/feature/eew_history/eew_list_data_source_test.dart`

**Interfaces:**
- Consumes: Task 2 の `EewListRepository`・`eewListRepositoryProvider`・`EewListPage`、Task 1 の `EewListParameter`、`EewTelegramItem`、`paging_view` の `GroupedDataSource`/`LoadResult`/`LoadAction`/`Refresh`/`Append`/`Prepend`/`Success`/`Failure`/`PageData`/`None`、`app/lib/feature/eew/data/eew.dart` の `eewProvider`、`app/lib/core/realtime/realtime_event_provider.dart` の `realtimeEventsProvider`、`RealtimeEewUpsertEvent`、`eqMonitorWsStatusProvider`、`appLifecycleProvider`。
- Produces:
  - `class EewListDataSource extends GroupedDataSource<String?, String, EewTelegramItem>`。`groupBy`, `load`, `upsertItems(List<EewTelegramItem>)`。コンストラクタ `EewListDataSource({required EewListRepository repository, required EewListParameter parameter})`。
  - `eewListDataSourceProvider`(`@riverpod Future<EewListDataSource> eewListDataSource(Ref, EewListParameter)`)。

- [ ] **Step 1: 失敗するテストを書く**

`app/test/feature/eew_history/eew_list_data_source_test.dart`:

```dart
import 'package:eqmonitor/core/model/telegram/telegram_info_type.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/eew_history/data/model/eew_list_page.dart';
import 'package:eqmonitor/feature/eew_history/data/model/eew_list_parameter.dart';
import 'package:eqmonitor/feature/eew_history/data/notifier/eew_list_data_source.dart';
import 'package:eqmonitor/feature/eew_history/data/repository/eew_list_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:paging_view/paging_view.dart';

EewTelegramItem _eew({
  required String eventId,
  required DateTime originTime,
}) => EewTelegramItem(
  eventId: eventId,
  status: TelegramStatus.normal,
  infoType: TelegramInfoType.publication,
  serialNo: 1,
  isCanceled: false,
  isLastInfo: true,
  reportTime: originTime,
  isPlum: false,
  originTime: originTime,
);

class _FakeEewListRepository extends EewListRepository {
  _FakeEewListRepository() : super(eew: api.ApiClient(Dio()).eew);

  final cursors = <String?>[];
  String? nextToken;
  List<EewTelegramItem> items = const [];

  @override
  Future<EewListPage> fetchEewList({
    required EewListParameter parameter,
    required String? cursor,
    required int limit,
  }) async {
    cursors.add(cursor);
    return EewListPage(items: items, nextToken: nextToken);
  }
}

void main() {
  group('EewListDataSource.groupBy', () {
    test('originTime をローカル日付 yyyy/MM/dd でグループ化', () {
      final ds = EewListDataSource(
        repository: _FakeEewListRepository(),
        parameter: const EewListParameter(),
      );
      final key = ds.groupBy(
        _eew(eventId: 'e1', originTime: DateTime.utc(2026, 6, 27, 3)),
      );
      // ローカルタイムに依存するため、形式(8文字 + 区切り)のみ検証
      expect(key, matches(r'^\d{4}/\d{2}/\d{2}$'));
    });
  });

  group('EewListDataSource.load', () {
    test('Refresh は cursor=null、Append は受け取った key を渡す', () async {
      final repo = _FakeEewListRepository()
        ..items = [_eew(eventId: 'e1', originTime: DateTime.utc(2026, 6, 27))]
        ..nextToken = 'next-1';
      final ds = EewListDataSource(
        repository: repo,
        parameter: const EewListParameter(),
      );

      final refresh = await ds.load(const Refresh());
      expect(refresh, isA<Success<String?, EewTelegramItem>>());
      await ds.load(const Append(key: 'next-1'));

      expect(repo.cursors, [null, 'next-1']);
    });

    test('Success の appendKey に nextToken が入る', () async {
      final repo = _FakeEewListRepository()
        ..items = [_eew(eventId: 'e1', originTime: DateTime.utc(2026, 6, 27))]
        ..nextToken = 'tok';
      final ds = EewListDataSource(
        repository: repo,
        parameter: const EewListParameter(),
      );
      final result = await ds.load(const Refresh());
      final success = result as Success<String?, EewTelegramItem>;
      expect(success.page.appendKey, 'tok');
      expect(success.page.data.single.eventId, 'e1');
    });
  });
}
```

- [ ] **Step 2: テストが失敗することを確認**

Run: `cd app && flutter test test/feature/eew_history/eew_list_data_source_test.dart`
Expected: コンパイルエラー(`EewListDataSource` 未定義)で FAIL。

- [ ] **Step 3: データソースを実装**

`app/lib/feature/eew_history/data/notifier/eew_list_data_source.dart`:

```dart
import 'dart:async';
import 'dart:developer';

import 'package:eqmonitor/core/provider/app_lifecycle.dart';
import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_ws_status_notifier.dart';
import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_ws_status_state.dart';
import 'package:eqmonitor/core/realtime/model/realtime_event.dart';
import 'package:eqmonitor/core/realtime/realtime_event_provider.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/eew_history/data/model/eew_list_parameter.dart';
import 'package:eqmonitor/feature/eew_history/data/repository/eew_list_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:paging_view/paging_view.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'eew_list_data_source.g.dart';

@riverpod
Future<EewListDataSource> eewListDataSource(
  Ref ref,
  EewListParameter parameter,
) async {
  final repository = await ref.watch(eewListRepositoryProvider.future);
  final dataSource = EewListDataSource(
    repository: repository,
    parameter: parameter,
  );
  ref.onDispose(dataSource.dispose);

  // フィルタ未適用時のみリアルタイム連携を張る(地震履歴に倣う)。
  if (!parameter.isFiltering) {
    Future<void> refresh() async {
      final result = await repository.fetchEewList(
        parameter: parameter,
        cursor: null,
        limit: 10,
      );
      dataSource.upsertItems(result.items);
    }

    final timer = Timer.periodic(const Duration(seconds: 30), (_) async {
      final wsPhase = ref.read(eqMonitorWsStatusProvider).phase;
      if (wsPhase == WsPhase.connected) {
        log('WS connected, skip eew history refresh');
        return;
      }
      if (ref.read(appLifecycleProvider) != AppLifecycleState.resumed) {
        return;
      }
      await refresh();
    });
    ref.onDispose(timer.cancel);

    ref.listen(realtimeEventsProvider, (_, next) async {
      if (next case AsyncData(:final value)) {
        if (value is RealtimeEewUpsertEvent) {
          dataSource.upsertItems([value.item.toEewTelegramItem]);
        }
      }
    });
  }

  return dataSource;
}

class EewListDataSource
    extends GroupedDataSource<String?, String, EewTelegramItem> {
  EewListDataSource({
    required EewListRepository repository,
    required EewListParameter parameter,
  }) : _repository = repository,
       _parameter = parameter;

  final EewListRepository _repository;
  final EewListParameter _parameter;

  static final _dateFormatter = DateFormat('yyyy/MM/dd');

  @override
  String groupBy(EewTelegramItem value) {
    final dateTime = value.originTime ?? value.reportTime;
    return _dateFormatter.format(dateTime.toLocal());
  }

  @override
  Future<LoadResult<String?, EewTelegramItem>> load(
    LoadAction<String?> action,
  ) async => switch (action) {
    Refresh() => await _fetch(null),
    Append(:final key) => await _fetch(key),
    Prepend() => const None(),
  };

  Future<LoadResult<String?, EewTelegramItem>> _fetch(String? cursor) async {
    try {
      final limit = cursor != null
          ? 100
          : _parameter.isFiltering
          ? 50
          : 10;
      final page = await _repository.fetchEewList(
        parameter: _parameter,
        cursor: cursor,
        limit: limit,
      );
      return Success(
        page: PageData(data: page.items, appendKey: page.nextToken),
      );
    } on Exception catch (e, st) {
      return Failure(error: e, stackTrace: st);
    }
  }

  void upsertItems(List<EewTelegramItem> newItems) {
    final currentItems = [...notifier.values];
    for (final item in newItems) {
      final index = currentItems.indexWhere((e) => e.eventId == item.eventId);
      if (index == -1) {
        insertItem(0, item);
        currentItems.insert(0, item);
      } else {
        updateItem(index, (_) => item);
        currentItems[index] = item;
      }
    }
  }
}
```

- [ ] **Step 4: コード生成**

Run: `cd app && dart run build_runner build --delete-conflicting-outputs`
Expected: `eew_list_data_source.g.dart` が生成される。

- [ ] **Step 5: テストが通ることを確認**

Run: `cd app && flutter test test/feature/eew_history/eew_list_data_source_test.dart`
Expected: PASS(全 3 ケース)。

- [ ] **Step 6: コミット**

```bash
git add app/lib/feature/eew_history/data/notifier/eew_list_data_source.dart \
        app/lib/feature/eew_history/data/notifier/eew_list_data_source.g.dart \
        app/test/feature/eew_history/eew_list_data_source_test.dart
git commit -m "feat(eew_history): add EewListDataSource with pagination and realtime upsert"
```

---

## Task 4: EewHistoryListTile(一覧の1行)

`EewTelegramItem` を1行で表示する。`EarthquakeHistoryListTile` の見た目に倣い、leading に最大予想震度アイコン、title に震源地名、subtitle に発生時刻・深さ・警報バッジ、trailing にマグニチュードを置く。

**Files:**
- Create: `app/lib/feature/eew_history/ui/components/eew_history_list_tile.dart`
- Test: `app/test/feature/eew_history/eew_history_list_tile_test.dart`

**Interfaces:**
- Consumes: `EewTelegramItem`、`app/lib/core/component/intenisty/jma_intensity_icon.dart` の `JmaIntensityIcon`、`app/lib/feature/earthquake_history/ui/components/magnitude_text.dart` の `MagnitudeText`、`app/lib/core/provider/config/theme/intensity_color/model/intensity_color_model.dart` の `IntensityColorModel`。
- Produces: `class EewHistoryListTile extends StatelessWidget`。コンストラクタ `EewHistoryListTile({required EewTelegramItem item, required IntensityColorModel intensityColor, VoidCallback? onTap, VisualDensity? visualDensity, Key? key})`。

- [ ] **Step 1: 失敗するテストを書く**

`app/test/feature/eew_history/eew_history_list_tile_test.dart`:

```dart
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/telegram/telegram_info_type.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/eew_history/ui/components/eew_history_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  testWidgets('震源地名と最大予想震度が表示される', (tester) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final item = EewTelegramItem(
      eventId: 'e1',
      status: TelegramStatus.normal,
      infoType: TelegramInfoType.publication,
      serialNo: 3,
      isCanceled: false,
      isLastInfo: true,
      reportTime: DateTime.utc(2026, 6, 27, 12),
      originTime: DateTime.utc(2026, 6, 27, 12),
      isPlum: false,
      hypocenter: const EewHypocenterInfo(
        code: '100',
        name: '宮城県沖',
        hasLatLng: false,
        magnitude: 6.2,
      ),
      forecastIntensity: const EewForecastIntensityInfo(
        regions: [],
        maxIntensity: JmaIntensity.fiveLower,
      ),
    );

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          home: Scaffold(
            body: EewHistoryListTile(
              item: item,
              intensityColor: container.read(intensityColorProvider),
            ),
          ),
        ),
      ),
    );

    expect(find.text('宮城県沖'), findsOneWidget);
  });
}
```

- [ ] **Step 2: テストが失敗することを確認**

Run: `cd app && flutter test test/feature/eew_history/eew_history_list_tile_test.dart`
Expected: コンパイルエラー(`EewHistoryListTile` 未定義)で FAIL。

- [ ] **Step 3: ListTile を実装**

`app/lib/feature/eew_history/ui/components/eew_history_list_tile.dart`:

```dart
import 'package:eqmonitor/core/component/intenisty/jma_intensity_icon.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/magnitude_text.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EewHistoryListTile extends StatelessWidget {
  const EewHistoryListTile({
    required this.item,
    required this.intensityColor,
    this.onTap,
    this.visualDensity,
    super.key,
  });

  final EewTelegramItem item;
  final IntensityColorModel intensityColor;
  final VoidCallback? onTap;
  final VisualDensity? visualDensity;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hypocenter = item.hypocenter;
    final maxIntensity = item.forecastIntensity?.maxIntensity;
    final isWarning = item.isWarning ?? false;

    final title = hypocenter?.name ?? '震源不明';
    final dateFormatter = DateFormat('yyyy/MM/dd HH:mm');
    final time = item.originTime ?? item.reportTime;
    final depth = hypocenter?.depth;
    final subTitle =
        '${dateFormatter.format(time.toLocal())}発生 '
        '${depth != null ? '深さ ${depth}km' : ''}';

    final maxIntensityColor = maxIntensity != null
        ? intensityColor.fromJmaIntensity(maxIntensity).background
        : null;

    return ListTile(
      visualDensity: visualDensity,
      tileColor: maxIntensityColor?.withValues(alpha: 0.4),
      onTap: onTap,
      leading: maxIntensity != null
          ? JmaIntensityIcon(
              intensity: maxIntensity,
              type: .filled,
              size: 40,
            )
          : null,
      title: Row(
        spacing: 4,
        children: [
          if (isWarning)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(179, 26, 26, 1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                '警報',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              ),
            ),
          Flexible(
            child: Text(
              title.toHalfWidth,
              style: theme.textTheme.titleSmall!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      subtitle: Text(
        subTitle,
        style: const TextStyle(
          fontFamily: FontFamily.googleSansCode,
          fontFamilyFallback: [FontFamily.notoSansJP],
          letterSpacing: -0.2,
        ),
      ),
      trailing: MagnitudeText(magnitude: hypocenter?.magnitude),
    );
  }
}
```

- [ ] **Step 4: テストが通ることを確認**

Run: `cd app && flutter test test/feature/eew_history/eew_history_list_tile_test.dart`
Expected: PASS。

- [ ] **Step 5: コミット**

```bash
git add app/lib/feature/eew_history/ui/components/eew_history_list_tile.dart \
        app/test/feature/eew_history/eew_history_list_tile_test.dart
git commit -m "feat(eew_history): add EewHistoryListTile"
```

---

## Task 5: フィルタバー(警報チップ + PersistentHeaderDelegate)

5項目のフィルタチップを横スクロールで並べる sticky ヘッダー。マグニチュード/深さ/最大予想震度/期間は既存チップを流用、警報のみは新規チップを作る。

**Files:**
- Create: `app/lib/feature/eew_history/ui/components/eew_warning_filter_chip.dart`
- Create: `app/lib/feature/eew_history/ui/components/eew_list_parameter_persistent_delegate.dart`

**Interfaces:**
- Consumes: Task 1 の `EewListParameter` と update 拡張、`core` の `Date`、既存チップ `app/lib/core/component/chip/` の `MagnitudeFilterChip`/`DepthFilterChip`/`IntensityFilterChip`/`DateRangeFilterChip`、`app/lib/core/designsystem/extensions/design_system_theme_extension.dart`。
- Produces:
  - `class EewWarningFilterChip extends StatelessWidget`: `EewWarningFilterChip({required bool selected, required ValueChanged<bool> onChanged})`。
  - `class EewListParameterPersistentDelegate extends SliverPersistentHeaderDelegate`: `EewListParameterPersistentDelegate({required EewListParameter parameter, required void Function(EewListParameter) onChanged})`、`maxExtent == minExtent == 48`。

- [ ] **Step 1: 警報チップを実装**

`app/lib/feature/eew_history/ui/components/eew_warning_filter_chip.dart`:

```dart
import 'package:flutter/material.dart';

/// 「警報のみ」を絞り込むトグルチップ。
class EewWarningFilterChip extends StatelessWidget {
  const EewWarningFilterChip({
    required this.selected,
    required this.onChanged,
    super.key,
  });

  final bool selected;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: const Text('警報のみ'),
      selected: selected,
      onSelected: onChanged,
    );
  }
}
```

- [ ] **Step 2: PersistentHeaderDelegate を実装**

`app/lib/feature/eew_history/ui/components/eew_list_parameter_persistent_delegate.dart`:

```dart
import 'package:core/core.dart' show Date;
import 'package:eqmonitor/core/component/chip/date_range_filter_chip.dart';
import 'package:eqmonitor/core/component/chip/depth_filter_chip.dart';
import 'package:eqmonitor/core/component/chip/intensity_filter_chip.dart';
import 'package:eqmonitor/core/component/chip/magnitude_filter_chip.dart';
import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/feature/eew_history/data/model/eew_list_parameter.dart';
import 'package:eqmonitor/feature/eew_history/ui/components/eew_warning_filter_chip.dart';
import 'package:flutter/material.dart';

class EewListParameterPersistentDelegate
    extends SliverPersistentHeaderDelegate {
  const EewListParameterPersistentDelegate({
    required this.parameter,
    required this.onChanged,
  });

  final EewListParameter parameter;
  final void Function(EewListParameter) onChanged;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlaps) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.surface,
      child: _FilterChipBar(parameter: parameter, onChanged: onChanged),
    );
  }

  @override
  double get maxExtent => 48;

  @override
  double get minExtent => 48;

  @override
  bool shouldRebuild(covariant EewListParameterPersistentDelegate old) =>
      parameter != old.parameter;
}

class _FilterChipBar extends StatelessWidget {
  const _FilterChipBar({required this.parameter, required this.onChanged});

  final EewListParameter parameter;
  final void Function(EewListParameter) onChanged;

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).designSystemThemeExtension.spacing;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Row(
          spacing: spacing.sm,
          children: [
            EewWarningFilterChip(
              selected: parameter.isWarning ?? false,
              onChanged: (v) => onChanged(parameter.updateIsWarning(v)),
            ),
            IntensityFilterChip(
              min: parameter.intensityGte,
              max: parameter.intensityLte,
              onChanged: (min, max) =>
                  onChanged(parameter.updateIntensity(min, max)),
            ),
            MagnitudeFilterChip(
              min: parameter.magnitudeGte,
              max: parameter.magnitudeLte,
              onChanged: (min, max) =>
                  onChanged(parameter.updateMagnitude(min, max)),
            ),
            DepthFilterChip(
              min: parameter.depthGte,
              max: parameter.depthLte,
              onChanged: (min, max) =>
                  onChanged(parameter.updateDepth(min, max)),
            ),
            DateRangeFilterChip(
              min: parameter.originTimeGte?.toDateTime(),
              max: parameter.originTimeLte?.toDateTime(),
              onChanged: (min, max) => onChanged(
                parameter.updateOriginTimeRange(
                  min != null ? Date.fromDateTime(min) : null,
                  max != null ? Date.fromDateTime(max) : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

> 注: `MagnitudeFilterChip` / `DepthFilterChip` / `IntensityFilterChip` / `DateRangeFilterChip` の `min`/`max`/`onChanged` 引数は `earthquake_history_parameter_persistent_delegate.dart:80-129` の使用例と一致させること。型が合わない場合はその使用例に合わせて修正する。

- [ ] **Step 3: analyze で検証**

Run: `cd app && dart analyze lib/feature/eew_history/ui/components/eew_warning_filter_chip.dart lib/feature/eew_history/ui/components/eew_list_parameter_persistent_delegate.dart`
Expected: `No issues found!`。

- [ ] **Step 4: コミット**

```bash
git add app/lib/feature/eew_history/ui/components/eew_warning_filter_chip.dart \
        app/lib/feature/eew_history/ui/components/eew_list_parameter_persistent_delegate.dart
git commit -m "feat(eew_history): add EEW list filter bar"
```

---

## Task 6: 発表中EEWピン留めセクション

`eewProvider` を watch し、発表中(空でない)EEW を上部にカード表示する Sliver。空・エラー時は非表示。カードはホームの `EewCard` を流用する。

**Files:**
- Create: `app/lib/feature/eew_history/ui/components/pinned_active_eew_section.dart`

**Interfaces:**
- Consumes: `app/lib/feature/eew/data/eew.dart` の `eewProvider`、`app/lib/feature/home/ui/component/eew/eew_card.dart` の `EewCard`、`app/lib/core/designsystem/extensions/design_system_theme_extension.dart`。
- Produces: `class PinnedActiveEewSection extends ConsumerWidget`(`SliverToBoxAdapter` を返す。発表中が無い場合は `SliverToBoxAdapter(child: SizedBox.shrink())`)。

- [ ] **Step 1: ピン留めセクションを実装**

`app/lib/feature/eew_history/ui/components/pinned_active_eew_section.dart`:

```dart
import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/feature/eew/data/eew.dart';
import 'package:eqmonitor/feature/home/ui/component/eew/eew_card.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PinnedActiveEewSection extends ConsumerWidget {
  const PinnedActiveEewSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eews = ref.watch(eewProvider).valueOrNull ?? const [];
    if (eews.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }
    final spacing = Theme.of(context).designSystemThemeExtension.spacing;
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.all(spacing.sm),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spacing.sm,
          children: [
            for (final eew in eews) EewCard(eew: eew),
          ],
        ),
      ),
    );
  }
}
```

> 注: `EewCard` のコンストラクタは `EewCard({required EewTelegramItem eew, String? index})`(`eew_card.dart:18-22`)。`index` は任意なので省略する。

- [ ] **Step 2: analyze で検証**

Run: `cd app && dart analyze lib/feature/eew_history/ui/components/pinned_active_eew_section.dart`
Expected: `No issues found!`。

- [ ] **Step 3: コミット**

```bash
git add app/lib/feature/eew_history/ui/components/pinned_active_eew_section.dart
git commit -m "feat(eew_history): add pinned active EEW section"
```

---

## Task 7: EewHistoryPage(画面の組み立て)

ピン留め・フィルタバー・ページネーションリストを `CustomScrollView` で組み立てるエントリページ。`earthquake_history_page.dart` の `_SliverListBody`/`_PagingBody` 構造を踏襲する。

**Files:**
- Create: `app/lib/feature/eew_history/ui/eew_history_page.dart`

**Interfaces:**
- Consumes: Task 1 `EewListParameter`、Task 3 `eewListDataSourceProvider`/`EewListDataSource`、Task 4 `EewHistoryListTile`、Task 5 `EewListParameterPersistentDelegate`、Task 6 `PinnedActiveEewSection`、`app/lib/core/router/router.dart` の `EewDetailsByEventIdRoute`、`intensityColorProvider`、`app/lib/core/component/error/error_card.dart` の `ErrorCard`、`paging_view` の `SliverGroupedPagingList`、`skeletonizer`。
- Produces: `class EewHistoryPage extends HookConsumerWidget`(`const EewHistoryPage({super.key})`)。

- [ ] **Step 1: ページを実装**

`app/lib/feature/eew_history/ui/eew_history_page.dart`:

```dart
import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/eew_history/data/model/eew_list_parameter.dart';
import 'package:eqmonitor/feature/eew_history/data/notifier/eew_list_data_source.dart';
import 'package:eqmonitor/feature/eew_history/ui/components/eew_history_list_tile.dart';
import 'package:eqmonitor/feature/eew_history/ui/components/eew_list_parameter_persistent_delegate.dart';
import 'package:eqmonitor/feature/eew_history/ui/components/pinned_active_eew_section.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paging_view/paging_view.dart';
import 'package:skeletonizer/skeletonizer.dart';

class EewHistoryPage extends HookConsumerWidget {
  const EewHistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final parameter = useState(const EewListParameter());
    final dataSourceAsync = ref.watch(
      eewListDataSourceProvider(parameter.value),
    );

    return Scaffold(
      body: dataSourceAsync.when(
        loading: () => const _Skeleton(),
        error: (error, _) => ErrorCard(
          error: error,
          onReload: () async =>
              ref.refresh(eewListDataSourceProvider(parameter.value)),
        ),
        data: (dataSource) => _PagingBody(
          dataSource: dataSource,
          parameter: parameter,
          intensityColor: ref.watch(intensityColorProvider),
          onRefresh: dataSource.refresh,
        ),
      ),
    );
  }
}

class _PagingBody extends StatelessWidget {
  const _PagingBody({
    required this.dataSource,
    required this.parameter,
    required this.intensityColor,
    required this.onRefresh,
  });

  final EewListDataSource dataSource;
  final ValueNotifier<EewListParameter> parameter;
  final IntensityColorModel intensityColor;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            centerTitle: false,
            title: const Text('緊急地震速報 一覧'),
          ),
          const PinnedActiveEewSection(),
          SliverPersistentHeader(
            pinned: true,
            delegate: EewListParameterPersistentDelegate(
              parameter: parameter.value,
              onChanged: (next) => parameter.value = next,
            ),
          ),
          SliverGroupedPagingList<String?, String, EewTelegramItem>(
            dataSource: dataSource,
            stickyHeader: true,
            headerBuilder: (_, date, _) => _DateHeader(date: date),
            itemBuilder: (context, item, _, _) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                EewHistoryListTile(
                  item: item,
                  intensityColor: intensityColor,
                  visualDensity: VisualDensity.compact,
                  onTap: () async => EewDetailsByEventIdRoute(
                    eventId: item.eventId,
                  ).push<void>(context),
                ),
                Divider(
                  height: 0,
                  thickness: 0,
                  color: theme.colorScheme.onInverseSurface,
                ),
              ],
            ),
            initialLoadingWidget: const _Skeleton(scrollable: false),
            appendLoadingWidget: const _Skeleton(
              itemCount: 2,
              scrollable: false,
            ),
            errorBuilder: (context, error, _) => ErrorCard(
              error: error,
              onReload: dataSource.refresh,
            ),
            emptyWidget: const Center(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Text('緊急地震速報の履歴がありません'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Skeleton extends StatelessWidget {
  const _Skeleton({this.itemCount = 5, this.scrollable = true});

  final int itemCount;
  final bool scrollable;

  @override
  Widget build(BuildContext context) {
    final tiles = [
      for (var i = 0; i < itemCount; i++)
        const ListTile(
          leading: CircleAvatar(radius: 20),
          title: Text('宮城県沖'),
          subtitle: Text('2026/06/27 12:34発生 深さ 10km'),
          trailing: Text('M6.0'),
        ),
    ];
    return Skeletonizer(
      child: scrollable
          ? ListView(children: tiles)
          : Column(mainAxisSize: MainAxisSize.min, children: tiles),
    );
  }
}

class _DateHeader extends StatelessWidget {
  const _DateHeader({required this.date});

  final String date;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final spacing = theme.designSystemThemeExtension.spacing;
    return Container(
      color: theme.colorScheme.surfaceContainer,
      padding: EdgeInsets.symmetric(
        horizontal: spacing.lg,
        vertical: spacing.xs,
      ),
      child: Text(
        date,
        style: theme.textTheme.titleSmall?.copyWith(
          color: theme.colorScheme.onSurface,
        ),
      ),
    );
  }
}
```

> 注: `SliverGroupedPagingList` の `headerBuilder`/`itemBuilder` のシグネチャは `earthquake_history_page.dart:108-146` に合わせること(引数名・個数が異なる場合はそちらに合わせる)。`dataSource.refresh` の戻り型が `Future<void>` でない場合は `() async => dataSource.refresh()` でラップする。

- [ ] **Step 2: analyze で検証**

Run: `cd app && dart analyze lib/feature/eew_history/ui/eew_history_page.dart`
Expected: `No issues found!`。

- [ ] **Step 3: コミット**

```bash
git add app/lib/feature/eew_history/ui/eew_history_page.dart
git commit -m "feat(eew_history): add EewHistoryPage"
```

---

## Task 8: ルーティング + デバッグ画面導線

`EewHistoryRoute` をルーターに追加し、デバッグ画面から遷移できる ListTile を加える。

**Files:**
- Modify: `app/lib/core/router/router.dart`
- Modify: `app/lib/feature/settings/children/config/debug/debug_page.dart`

**Interfaces:**
- Consumes: Task 7 `EewHistoryPage`。
- Produces: `class EewHistoryRoute extends GoRouteData with $EewHistoryRoute`(`@TypedGoRoute<EewHistoryRoute>(path: '/eew-history')`、`const EewHistoryRoute()`)。

- [ ] **Step 1: ルーターに import を追加**

`app/lib/core/router/router.dart` の import 群(`eew_details_by_event_id_page.dart` の import 行 `:15` の近く)に追加:

```dart
import 'package:eqmonitor/feature/eew_history/ui/eew_history_page.dart';
```

- [ ] **Step 2: ルート定義を追加**

`app/lib/core/router/router.dart` の `EarthquakeHistoryRoute`(`:154-163`)の定義ブロックの直後に追加:

```dart
@TypedGoRoute<EewHistoryRoute>(path: '/eew-history')
class EewHistoryRoute extends GoRouteData with $EewHistoryRoute {
  const EewHistoryRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const EewHistoryPage();
}
```

- [ ] **Step 3: コード生成**

Run: `cd app && dart run build_runner build --delete-conflicting-outputs`
Expected: `router.g.dart` に `$EewHistoryRoute` と `EewHistoryRoute().push` 等が生成される。

- [ ] **Step 4: デバッグ画面に ListTile を追加**

`app/lib/feature/settings/children/config/debug/debug_page.dart` の「EEW Card」ListTile(`:149-157`)の直後に追加:

```dart
ListTile(
  title: const Text('EEW 一覧'),
  subtitle: Text(
    '発表中EEWのピン留めと過去EEWの履歴(将来一般公開予定)',
    style: Theme.of(context).textTheme.bodySmall,
  ),
  leading: const Icon(Icons.list_alt),
  onTap: () async => const EewHistoryRoute().push<void>(context),
),
```

`debug_page.dart` の import に `router.dart` が含まれていなければ追加(既に `XxxRoute` を使っているため import 済みのはず。未 import の場合のみ `import 'package:eqmonitor/core/router/router.dart';` を追加)。

- [ ] **Step 5: analyze で検証**

Run: `cd app && dart analyze lib/core/router/router.dart lib/feature/settings/children/config/debug/debug_page.dart`
Expected: `No issues found!`。

- [ ] **Step 6: 全体テスト & analyze**

Run: `cd app && flutter test test/feature/eew_history && melos run analyze`
Expected: eew_history のテスト全 PASS、analyze で警告なし。

- [ ] **Step 7: コミット**

```bash
git add app/lib/core/router/router.dart app/lib/core/router/router.g.dart \
        app/lib/feature/settings/children/config/debug/debug_page.dart
git commit -m "feat(eew_history): wire EewHistoryPage into router and debug page"
```

---

## 動作確認(手動)

1. `flutter run`(dev flavor)。
2. 設定 → デバッグ → 「EEW 一覧」をタップ。
3. 履歴が新しい順に日付グループで表示され、下スクロールで追加読み込みされること。
4. 各フィルタチップで絞り込みが反映されること(特に「警報のみ」)。
5. リアルタイム再生中(`isRealtimeMode`)に発表中EEWがあれば上部にピン留め表示されること。
6. 行タップで既存のEEW詳細ページに遷移すること。

## スコープ外(Spec B / 将来)

- 公開向けEEW詳細ページ(Spec B)。Spec B 着手時に既存デバッグEEW詳細を削除。
- API 未対応フィルタ(地域検索・並び替え・長周期階級・電文ステータス)。
