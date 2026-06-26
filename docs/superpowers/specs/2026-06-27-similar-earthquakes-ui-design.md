# 類似地震 UI 機能 設計書

作成日: 2026-06-27
対象: Flutter アプリ (`app/`) — 地震履歴詳細画面

## 1. 概要

地震履歴詳細画面の Sheet 末尾に「類似地震」Card を追加する。Card には類似地震グループの上位3件（代表地震）を表示し、「もっと見る」ボタンで全画面に遷移して全代表地震を一覧する。全画面では各代表地震を toggle で展開し、同一グループ内の他の地震（`groupedEarthquakes`）を表示する。

類似度は backend が返す `score`（km 相当の距離スコア、小さいほど類似、500 超は除外）を **A→E の5段階グレード**に分類し、**5セルのゲージ**で視覚表示する。

## 2. 前提（既存実装の調査結果）

### API（実装済み）
- エンドポイント: `GET /v2/earthquake/{eventId}/similar`
- Dart クライアント: `packages/eqmonitor_api` の `EarthquakeApiClient.getV2EarthquakeEventIdSimilar({eventId})`
- レスポンス型:
  ```dart
  SimilarEarthquakeResponse { List<SimilarEarthquakeItem> items }
  SimilarEarthquakeItem {
    EarthquakePartial earthquake;        // 代表地震（グループ内で最大マグニチュード）
    num score;                            // km 相当の距離スコア（小さいほど類似、グループ内最小スコア）
    List<EarthquakePartial> groupedEarthquakes;  // グループ内の他の地震（代表を除く）
  }
  ```
- backend はスコア順（昇順）にソート済み、最大50グループを返却。

### app 側の既存資産（再利用する）
- `api.EarthquakePartial.toEarthquakePartial({parameter})` 拡張で app の `EarthquakePartial` に変換可能
  (`app/lib/feature/earthquake_history/data/model/earthquake_partial.dart`)
- `EarthquakeHistoryListTile`（`app/lib/feature/earthquake_history/ui/components/earthquake_history_list_tile.dart`）が app `EarthquakePartial` を描画（日時・マグニチュード・最大震度・震源地）
- Repository: `earthquake_history_repository.dart`（`EarthquakeParameter` を保持し変換に渡す）
- Provider: `@riverpod` codegen + `earthquakeHistoryRepositoryProvider`
- ルーティング: `go_router` + `TypedGoRoute`。遷移は `EarthquakeHistoryDetailsRoute(eventId:).push(context)`
- Card 共通スタイル: `BorderedContainer`（`app/lib/core/component/container/bordered_container.dart`）
- 詳細画面: `earthquake_history_details_page.dart` の Sheet 内 `Column` に Card 群が並ぶ

## 3. 仕様決定事項（ユーザー確認済み）

| 項目 | 決定 |
|------|------|
| タイルのタップ挙動 | その地震の詳細画面へ遷移（`EarthquakeHistoryDetailsRoute(eventId:).push`） |
| タイル表示内容 | 既存 `EarthquakeHistoryListTile` を再利用 + 類似度（A→E グレード + ゲージ）を併記 |
| 全画面の展開 | 代表行に toggle、配下に `groupedEarthquakes` を展開。子地震0件なら toggle 非表示 |
| データ取得 | Riverpod FutureProvider (family by eventId) を Card が watch して取得 |
| Card の件数 | 上位3グループの代表地震のみ（Card 内では toggle なし） |
| 類似度の表現 | score を A→E の5段階に分類し、5セルゲージで表示 |

### グレード分類（score → グレード）
| グレード | score 範囲 | ゲージ点灯セル |
|---------|-----------|--------------|
| A | 0 〜 50 | ■■■■■ (5) |
| B | 50 〜 100 | ■■■■□ (4) |
| C | 100 〜 200 | ■■■□□ (3) |
| D | 200 〜 350 | ■■□□□ (2) |
| E | 350 〜 500 | ■□□□□ (1) |

- 境界は下側包含（`score < 50` → A、`50 <= score < 100` → B …、`350 <= score <= 500` → E）。
- score が 500 を超えるデータは backend が除外済みのため通常届かないが、届いた場合は E 扱い（防御的）。

### ゲージ表現
- 5個の小さい角丸チップを横並び。
- 点灯セル = グレード色、消灯セル = 薄いグレー。
- 「類似度が高いほど多く点灯」（A=5、E=1）。
- グレード文字（A〜E）も併記。
- グレード色: A→E で緑→赤系のグラデーション（A:緑, B:黄緑, C:黄, D:橙, E:赤/グレー）。具体色は `Theme` / 既存カラーパレットに合わせて実装時に確定。

## 4. アーキテクチャ

### 4.1 データ層

**新規モデル** `SimilarEarthquakeGroup`
（`app/lib/feature/earthquake_history/data/model/similar_earthquake_group.dart`）
```dart
@freezed
class SimilarEarthquakeGroup with _$SimilarEarthquakeGroup {
  const factory SimilarEarthquakeGroup({
    required EarthquakePartial representative,   // app の EarthquakePartial
    required num score,
    required List<EarthquakePartial> groupedEarthquakes,
  }) = _SimilarEarthquakeGroup;
}
```

**グレード分類** `SimilarityGrade`（enum A〜E）と分類ロジック
- `SimilarityGrade` enum（`a, b, c, d, e`）に `litCells`（点灯セル数 1〜5）と表示文字を持たせる。
- `SimilarityGrade.fromScore(num score)` で score → グレードに変換。
- モデル or 専用ファイル（例: `similarity_grade.dart`）に配置。`SimilarEarthquakeGroup.grade` getter で `SimilarityGrade.fromScore(score)` を返す。

**変換拡張**
```dart
extension SimilarEarthquakeItemApiExtension on api.SimilarEarthquakeItem {
  SimilarEarthquakeGroup toSimilarEarthquakeGroup({required EarthquakeParameter parameter}) =>
    SimilarEarthquakeGroup(
      representative: earthquake.toEarthquakePartial(parameter: parameter),
      score: score,
      groupedEarthquakes: groupedEarthquakes
          .map((e) => e.toEarthquakePartial(parameter: parameter))
          .toList(),
    );
}
```

**Repository 追加** （`earthquake_history_repository.dart`）
```dart
Future<List<SimilarEarthquakeGroup>> fetchSimilarEarthquakes({required String eventId}) async {
  final response = await _api.earthquake.getV2EarthquakeEventIdSimilar(eventId: eventId);
  return response.data.items
      .map((e) => e.toSimilarEarthquakeGroup(parameter: earthquakeParameter))
      .toList();
}
```

**Provider 追加** （`@riverpod` codegen）
- `similar_earthquakes_notifier.dart` に `similarEarthquakesProvider(eventId)` (FutureProvider family, autoDispose)。
- `build` 内で repository を watch して `fetchSimilarEarthquakes(eventId:)` を返す。

### 4.2 UI 層

**`SimilarEarthquakeGauge`**（`.../ui/components/similar_earthquake_gauge.dart`）
- 入力: `SimilarityGrade grade`
- 5セルの角丸チップ + グレード文字を描画する純粋な表示 widget。

**`SimilarEarthquakeTile`**（`.../ui/components/similar_earthquake_tile.dart`）
- 入力: `SimilarEarthquakeGroup group`（または `EarthquakePartial` + `SimilarityGrade`）
- 既存 `EarthquakeHistoryListTile` を再利用しつつ `SimilarEarthquakeGauge` を併記。
- タップで `EarthquakeHistoryDetailsRoute(eventId: representative.eventId).push(context)`。
- レイアウト上、既存タイルにゲージを足す（trailing / サブ行）。既存タイルが行を専有する場合は最小限のラップで対応。

**`SimilarEarthquakeCard`**（`.../ui/components/similar_earthquake_card.dart`）
- `similarEarthquakesProvider(eventId)` を watch。
- 状態別:
  - loading → `BorderedContainer` 内にローディング表示（ヘッダ「類似地震」+ プレースホルダ）
  - error → 非表示（`SizedBox.shrink()`）
  - data 空 → 非表示（`SizedBox.shrink()`）
  - data あり → ヘッダ「類似地震」+ 上位3グループの `SimilarEarthquakeTile`（toggle なし）+ グループが3件超なら「もっと見る」ボタン
- 詳細画面の `Column` に追加（電文一覧ボタンの後・AdBanner との順序は実装時に既存並びに合わせて調整。基本は最下部付近）。

**`SimilarEarthquakePage`（全画面）**（`.../ui/similar_earthquake_page.dart`）
- 入力: `eventId`
- `similarEarthquakesProvider(eventId)` を watch（Card と同じ provider を共有）。
- 全代表地震を `ListView` で一覧。各行は `SimilarEarthquakeTile` + 展開 toggle。
  - toggle 状態は `useState`（hooks）で各グループごとに管理。`AnimatedSize` で開閉アニメーション。
  - 展開時、配下に `groupedEarthquakes` を子タイル（インデント付き）で表示。各子タイルもタップで詳細へ遷移。
  - `groupedEarthquakes` が空のグループは toggle アイコンを表示しない。
- AppBar タイトル「類似地震」。

**ルーティング追加** （`app/lib/core/router/router.dart`）
```dart
@TypedGoRoute<SimilarEarthquakeRoute>(
  path: '/earthquake-history-details/:eventId/similar',
)
class SimilarEarthquakeRoute extends GoRouteData with $SimilarEarthquakeRoute {
  const SimilarEarthquakeRoute({required this.eventId});
  final String eventId;
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      SimilarEarthquakePage(eventId: eventId);
}
```
「もっと見る」から `SimilarEarthquakeRoute(eventId: eventId).push(context)`。

### 4.3 データフロー
```
詳細画面 build
  → SimilarEarthquakeCard が similarEarthquakesProvider(eventId) を watch
    → Repository.fetchSimilarEarthquakes(eventId)
      → EarthquakeApiClient.getV2EarthquakeEventIdSimilar
        → api.SimilarEarthquakeResponse
          → toSimilarEarthquakeGroup 変換（app モデル）
  → Card: 上位3件を SimilarEarthquakeTile で描画
  → 「もっと見る」→ SimilarEarthquakeRoute.push
    → SimilarEarthquakePage（同 provider をキャッシュ共有）で全件 + toggle 展開
```

## 5. エッジケース
- 類似地震 0 件 → Card 自体を非表示（`SizedBox.shrink()`）。
- API エラー → Card 非表示（詳細画面の主機能を阻害しない）。全画面では遷移経路が「もっと見る」のみのため、データありの状態からのみ到達する。
- 代表地震の `groupedEarthquakes` が空 → 全画面で toggle アイコン非表示、行はタップで詳細遷移のみ。
- score が 500 超（防御的）→ E 扱い。
- 元地震に座標/深さ/マグニチュードが無い → backend が空配列を返す → Card 非表示。

## 6. テスト方針
- `SimilarityGrade.fromScore` の境界値テスト（0, 49.9, 50, 100, 200, 350, 500, 500超）。Dart ユニットテスト。
- `toSimilarEarthquakeGroup` 変換のテスト（代表・グループ内地震の件数・score 保持）。
- ゲージ widget の点灯セル数がグレードに対応することの widget テスト（任意）。

## 7. 影響範囲・非対象
- 影響: `earthquake_history` feature 配下（data/model, data/repository, data/notifier, ui/components, ui）、`core/router/router.dart`。
- 非対象: backend（実装済み）、API クライアント生成物（生成済み）、地震履歴一覧画面。
- code generation: 新規 freezed / riverpod / go_router 注釈を追加するため `melos run generate` が必要。
