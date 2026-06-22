# 津波電文 state 差分追跡 ＋ UI層レイヤリング規約 設計

- 日付: 2026-06-23
- ブランチ起点: `develop`
- 関連: `packages/eqmonitor_api`, `app/lib/feature/tsunami`, `packages/eqmonitor_lints`

## 背景 / 目的

`/v2/tsunami/{id}/telegrams` は `{ telegrams: TsunamiTelegramWithState[] }` を返し、
各 `TsunamiTelegramWithState` は `{ type, telegram, state }` で **電文ごとにフルの
`TsunamiState` スナップショット**（regions / offshore_stations / earthquakes）を持つ。

この一連のスナップショットを時系列に並べ、予報区・観測点ごとの各フィールド
（kind / first_height / max_height / observation など）が **いつ・どの電文で変化したか**
を追跡できるドメインモデルへ変換し、debug 画面に横スクロールのタイムラインとして表示する。

あわせて、`eqmonitor_api` の生成型を **UI 層で直接利用することを禁止**する規約を導入する
（data 層でアプリ用ドメインモデルへ変換してから UI に渡す）。本対応では規約を lint で
強制し、新規違反を防ぐところまでを行う（既存違反の移行は別タスク）。

## スコープ

本対応に含むもの:

1. **レイヤリング規約の lint 強制** — `eqmonitor_lints` に
   「`ui/` 配下のファイルで `package:eqmonitor_api` を import 禁止」する custom lint
   `avoid_eqmonitor_api_in_ui` を追加。既存違反は `// ignore_for_file` で猶予する。
2. **lint エラー修正** — `melos run analyze`（app ＋ packages）をパスさせる。
3. **津波電文 state 差分追跡** — data 層のドメインモデル（中間表現＋公開表示型）と
   Riverpod Notifier、debug 画面の横スクロールタイムライン UI。

含まないもの（Non-goals）:

- **バックエンド / API スキーマの変更**（電文一意 ID の付与など）は別 Agent が担当。
  本対応は「telegrams レスポンスの各電文が一意 ID を持つ」ことを前提とする
  （スキーマ再生成後に `eqmonitor_api` 側へ反映される想定）。
- **本番の津波詳細画面への組み込み**は別タスク（まず debug 画面のみ）。
- **tsunami/ui を含む既存 UI 層の API 型利用の移行**は別タスク（lint は `ignore` で猶予）。
- backend submodule のテスト・修正。

## 依存・前提

- telegrams レスポンスの各要素が一意な電文 ID を持つこと。本設計では公開型・中間表現の
  `telegramId` をこの API 由来 ID で埋める。スキーマ再生成までは、対象フィールドが
  `eqmonitor_api` に現れ次第その値を使う（合成 ID は用いない）。
- 既存のドメインモデル変換パターン（`feature/earthquake_history/data/model/earthquake.dart`）
  に倣う: freezed のドメイン型＋ `extension XApiExtension on api.X { toDomain() }`。
- Riverpod の公開 Provider は 1 ファイル 1 つまで。

---

## アーキテクチャ

### レイヤリング規約

- **UI 層（`**/ui/**`）は `package:eqmonitor_api` を import しない。**
- data 層がドメインモデルへ変換し、UI は公開ドメイン型のみ参照する。
- `eqmonitor_lints` の custom lint で強制。既存違反は猶予する。

### 差分追跡: 2 段のモデル

#### (A) 中間表現 — ジェネリックな追跡型

```dart
/// {value: T, telegramId}[] を表す追跡履歴。
typedef Tracked<T> = List<TrackedPoint<T>>;

@freezed
abstract class TrackedPoint<T> with _$TrackedPoint<T> {
  const factory TrackedPoint({
    required T value,
    required String telegramId,
  }) = _TrackedPoint<T>;
}
```

- **変化点のみ**を保持する（電文を時系列順に走査し、`value` が直前と等しい場合は追加しない）。
  等価判定は freezed のドメイン型の値等価による。
- 追跡粒度 `T` は **concern 単位**（オブジェクト単位）。
  例: `Tracked<TsunamiForecastFirstHeight?>` は `arrival_time / condition / revise` を
  まとめて 1 つの値として扱い、いずれかが変われば変化点になる。
  scalar 単位の独立追跡は採らない（公開表示型と一致しシンプルなため）。

#### 追跡対象 entity（中間表現、API 型を持たない）

`feature/tsunami/data/model/tracking/`（ディレクトリ名は実装時に確定）:

- `TrackedTsunamiTimeline` — ルート集約
  - `List<TsunamiTelegramMeta> telegrams`（時系列順の電文メタ一覧）
  - `List<TrackedRegion> regions`
  - `List<TrackedOffshoreStation> offshoreStations`
- `TrackedRegion`（key: `code`）
  - `String code`, `String name`
  - `Tracked<TsunamiWarningKind> kind`
  - `Tracked<TsunamiWarningKind> lastKind`
  - `Tracked<TsunamiForecastFirstHeight?> forecastFirstHeight`
  - `Tracked<TsunamiForecastMaxHeight?> forecastMaxHeight`
  - `Tracked<TsunamiEstimationFirstHeight?> estimationFirstHeight`
  - `Tracked<TsunamiEstimationMaxHeight?> estimationMaxHeight`
  - `List<TrackedRegionStation> stations`
- `TrackedRegionStation`（key: `code`）
  - `String code`, `String name`
  - `Tracked<TsunamiStationForecast?> forecast`
  - `Tracked<TsunamiStationObservation?> observation`
- `TrackedOffshoreStation`（key: `code`）
  - `String code`, `String name`
  - `Tracked<TsunamiObservationFirstHeight> firstHeight`
  - `Tracked<TsunamiObservationMaxHeight?> maxHeight`

`name` 等の表示名はスナップショット間で不変とみなし、最新値を保持する
（変化を追わない）。entity が途中で出現/消失する場合は、出現する電文以降のみ
変化点を持つ（消失は「直前と異なる null/欠落」として扱うかは実装時に確定）。

#### concern ドメイン型（API からの変換、`feature/tsunami/data/model/`）

API のサブオブジェクトをミラーした freezed 型。各々 `toDomain()` 変換 extension を持つ。

- 値のみ enum をドメイン側にミラー: `TsunamiWarningKind`, `FirstHeightCondition`,
  `Revise`, `QualitativeHeight`, `WaveInitial`, `ObservationMaxHeightCondition`。
- `TsunamiForecastFirstHeight` ← `TsunamiRegionForecastFirstHeight`
  `{ DateTime? arrivalTime, FirstHeightCondition? condition, Revise? revise }`
- `TsunamiForecastMaxHeight` ← `TsunamiRegionForecastMaxHeight`
  `{ double? value, bool? isOver, QualitativeHeight? qualitative, bool? isImportant, Revise? revise }`
- `TsunamiEstimationFirstHeight`
  `{ DateTime? arrivalTime, bool? isAlreadyArrived, Revise? revise }`
- `TsunamiEstimationMaxHeight`
  `{ DateTime? dateTime, double? value, bool? isOver, QualitativeHeight? qualitative, bool? isObserving, Revise? revise }`
- `TsunamiStationForecast`
  `{ DateTime highTideDateTime, TsunamiForecastFirstHeight? firstHeight }`
- `TsunamiStationObservation`
  `{ String? sensor, TsunamiObservationFirstHeight firstHeight, TsunamiObservationMaxHeight? maxHeight }`
- `TsunamiObservationFirstHeight` ← `TsunamiStationObservationFirstHeight`
  `{ DateTime? arrivalTime, WaveInitial? initial, bool? isUnidentifiable, bool? isMissing, Revise? revise }`
- `TsunamiObservationMaxHeight` ← `TsunamiStationObservationMaxHeight`
  `{ DateTime? dateTime, double? value, bool? isOver, bool? isRising, ObservationMaxHeightCondition? condition, bool? isMissing, Revise? revise }`

> 注: API 側で `const: true` の bool は domain では `bool?`（出現時 true）として扱う。

#### 電文メタ

```dart
@freezed
abstract class TsunamiTelegramMeta with _$TsunamiTelegramMeta {
  const factory TsunamiTelegramMeta({
    required String telegramId,      // API 由来の一意 ID
    required TelegramType type,      // domain enum へミラー
    int? serialNo,
    required String title,
    String? headline,
    required DateTime publishedAt,   // press_at
    required DateTime reportAt,      // report_at
    DateTime? targetAt,              // target_at
    DateTime? revokedAt,             // revoke_at
    required String infoKind,
  }) = _TsunamiTelegramMeta;
}
```

#### (B) 公開表示型 — Notifier が UI へ渡す型

中間表現を、concern のフィールド＋電文メタをフラット化した「タイムライン行」へ変換する。
UI（横スクロール）はこの行リストを電文（＝列）順に並べる。

```dart
@freezed
abstract class FirstHeightTimelineEntry with _$FirstHeightTimelineEntry {
  const factory FirstHeightTimelineEntry({
    // concern fields
    DateTime? arrivalTime,
    FirstHeightCondition? condition,
    Revise? revise,
    // telegram metadata
    required String telegramId,
    String? headline,
    required String title,
    required DateTime publishedAt,
    DateTime? revokedAt,
  }) = _FirstHeightTimelineEntry;
}
```

- concern ごとに対応する `*TimelineEntry` 型と `typedef *Timeline = List<*TimelineEntry>` を定義。
- 各 entry は「その変化点の電文」のメタを含み、UI で列ヘッダ（発表時刻・タイトル等）に使う。

### データフロー

1. Notifier が `client.tsunami.getV2TsunamiTsunamiIdTelegrams(tsunamiId)` を呼ぶ。
2. `telegrams` を `publishedAt`（press_at）昇順にソート（同時刻は `serialNo` で安定化）。
3. 各電文の `state` を走査し、entity（code をキー）ごとに concern 値を `toDomain()` 変換、
   直前の変化点と値が異なる場合のみ `TrackedPoint` を追加 → 中間表現を構築。
4. 中間表現を公開表示型（`*Timeline`）へ変換して返す。
5. UI は公開型のみを参照して横スクロールタイムラインを描画。

### Notifier

- `feature/tsunami/data/notifier/tsunami_telegram_timeline_notifier.dart`
- 公開 Provider は 1 つ（`tsunamiTelegramTimelineProvider(tsunamiId)`）。
- 返り値は公開表示型の集約（root: `TsunamiTimeline`）。
- 既存 `tsunami_details_notifier.dart` は変更しない（別 Provider として追加）。

### debug タイムライン UI

- 配置: `feature/settings/children/config/debug/tsunami/`。
- entity（予報区・予報区内観測点・沖合観測点）を縦に並べ、各 concern を
  **`Row` ＋横方向 `SingleChildScrollView`** で電文（列）順に表示。
- 列ヘッダに電文メタ（発表時刻 / タイトル / serialNo 等）、各セルに concern 値を表示。
- API 型は import せず、公開ドメイン型のみ参照する。

---

## lint ルール: `avoid_eqmonitor_api_in_ui`

- `packages/eqmonitor_lints/lib/src/rules/avoid_eqmonitor_api_in_ui.dart` を追加。
- `AnalysisRule` を継承、`registry.addImportDirective` で import を走査。
- 判定: 解析中ファイルのパスに `/ui/` セグメントを含み、import URI が
  `package:eqmonitor_api` 始まりなら該当 import を報告。
- `severity: WARNING`、`main.dart` の `register` に登録。
- **既存違反の猶予**: 現状 UI 層で API 型を使うファイル（tsunami/ui 等、約 7 feature）に
  `// ignore_for_file: avoid_eqmonitor_api_in_ui` を付与し、`melos run analyze` の
  「no warnings」を維持する。各ファイルの移行時に ignore を外す（別タスク）。

---

## lint エラー修正

- 対象: `melos run analyze`（app ＋ packages）。backend submodule は対象外。
- 既存の警告/エラーをすべて解消し、analyze をパスさせる。
- 生成物（`*.g.dart` / `*.freezed.dart`）由来の指摘は生成設定側で対応し、手修正の
  生成ファイルは作らない。

---

## エラーハンドリング

- API 失敗は `AsyncValue` のエラーとして UI（debug 画面）の ErrorCard 相当で表示。
- entity が一部電文に存在しない場合でも null 安全に処理（変化点が空の concern は
  タイムラインで「データなし」を表示）。
- 一意 ID が（再生成前で）取得できない段階では、Notifier は明示的に未対応エラーを返すか、
  該当フィールドが API に現れるまで実装をブロックする（合成 ID は使わない）。

## テスト戦略

- **変換ロジック（最重要）**: `TsunamiTelegramsResponse`（複数電文・値変化あり）の
  fixture を入力に、中間表現の変化点が期待通り（変化時のみ追加）か、公開型が
  正しく電文メタと結合されるかを検証する unit テスト。
- 既存の contract fixtures（`test/fixtures/contract/`）または専用 fixture を利用。
- **lint ルール**: `ui/` 配下で `package:eqmonitor_api` を import した場合に報告し、
  data 層では報告しないことのテスト（既存ルールのテスト方式に倣う）。
- `melos run analyze` ＆ `melos run test` がパスすること。

## 段階的な実装順序（概略）

1. lint ルール `avoid_eqmonitor_api_in_ui` 追加 ＋ 既存違反へ `ignore_for_file` 付与。
2. concern ドメイン型 ＋ `toDomain()` 変換 extension（値のみ enum ミラー含む）。
3. 中間表現（`Tracked<T>` / `TrackedPoint` / `Tracked*` entity）＋変換ロジック。
4. 公開表示型 ＋ Notifier。
5. 変換ロジック・lint ルールの unit テスト。
6. debug 横スクロールタイムライン UI。
7. `melos run analyze` の残存 lint エラー修正。

## 未解決 / 確認事項

- 電文一意 ID の正確なフィールド名・場所（`TsunamiTelegramWithState.id` か
  `telegram.id` か）は、別 Agent のバックエンド対応＋スキーマ再生成の結果に従う。
- entity の「消失」をタイムライン上どう表現するか（空セル / 明示的 cancel 値）は
  実装時に fixture を見て確定。
