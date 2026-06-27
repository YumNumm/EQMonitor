# EEW一覧ページ (Spec A) 設計

- 作成日: 2026-06-27
- 対象: Flutter アプリ (`app/`)
- ステータス: 設計確定

## 背景・目的

デバッグ画面に EEW(緊急地震速報)一覧ページを新規作成する。将来的には一般公開ページへ配置する想定。
本ページは以下の2つの役割を担う。

- **リアルタイム**: 現在発表中の EEW を上部にピン留め表示する。
- **履歴**: 過去に発表された EEW を新しい順にページネーションで遡る。

既存の地震履歴ページ (`app/lib/feature/earthquake_history/`) が、ページネーション・フィルタ・リアルタイム upsert・グループ化を備えた完成されたテンプレートとなっており、本ページはこれを忠実に踏襲する。

## プロジェクト分解

本機能は規模が大きいため2つの Spec に分解する。本ドキュメントは **Spec A** を対象とする。

- **Spec A(本書): EEW一覧ページ** — デバッグ画面に配置。リアルタイムピン留め + 履歴ページネーション + フィルタ。
- **Spec B(次回): 公開向け EEW 詳細ページ** — 一覧から遷移する一般公開向け詳細ページ。Spec B 着手時に既存のデバッグ用 EEW 詳細ページ (`eew_details_by_event_id_page.dart`) を削除する。

## 確定要件

| 項目 | 決定 |
|---|---|
| 主目的 | 履歴 + リアルタイムの両方 |
| 一覧の単位 | イベント単位(1 eventId につき1行、最終報を代表表示) |
| 行タップ遷移 | 暫定で既存 `EewDetailsByEventIdRoute`(eventId)へ push。Spec B で公開詳細に差し替え |
| フィルタ | EEW API が対応する5項目(M・深さ・最大予想震度・期間・警報のみ) |
| リアルタイム統合 | 上部に発表中 EEW をピン留め。下に履歴をページネーション |
| 配置 | デバッグ画面に ListTile 追加 → 新規ルートへ遷移 |

## アーキテクチャ

### ディレクトリ構成(新規)

```
app/lib/feature/eew_history/
├── data/
│   ├── model/
│   │   └── eew_list_parameter.dart          # フィルタ条件 (Freezed)
│   ├── repository/
│   │   └── eew_list_repository.dart         # eewApiClient.getV2Eew のラッパ
│   └── notifier/
│       └── eew_list_data_source.dart        # GroupedDataSource + Riverpod provider
└── ui/
    ├── eew_history_page.dart                # エントリ (ピン留め + リスト)
    └── components/
        ├── eew_history_list_tile.dart       # 一覧の1行
        ├── eew_history_filter_*.dart        # フィルタUI(地震履歴コンポーネント流用)
        └── pinned_active_eew_section.dart   # 上部ピン留めセクション
```

### 画面レイアウト

```
┌─────────────────────────────┐
│ AppBar: 緊急地震速報 一覧      │
├─────────────────────────────┤
│ [発表中ピン留め] ← eewProvider │  発表中のみ表示。ホームの EewCard を流用
│   ⚠ 警報中カード               │
├─────────────────────────────┤
│ [フィルタバー] (sticky)        │  SliverPersistentHeader
├─────────────────────────────┤
│ 2026/06/27 ─── (日付ヘッダ)    │  groupBy(originTime ?? reportTime)
│  ├ EewHistoryListTile          │
│  ├ EewHistoryListTile          │
│ 2026/06/26 ───                │
│  ├ ...                          │  無限スクロール + Pull-to-Refresh
└─────────────────────────────┘
```

`earthquake_history_page.dart` の `CustomScrollView` + `SliverAppBar` + `SliverPersistentHeader` + `SliverGroupedPagingList` 構成を踏襲する。ピン留めセクションは `SliverGroupedPagingList` の前に置く Sliver として追加する。

## データフロー

### 履歴(リスト本体)

- `EewListDataSource extends GroupedDataSource<String?, String, EewTelegramItem>` を `earthquake_history_data_source.dart` と同型で実装する。
- `load(action)`:
  - `Refresh()` → `_fetch(null)`
  - `Append(key)` → `_fetch(key)`
  - `Prepend()` → `None()`
- `_fetch(cursor)` → `EewListRepository.fetchEewList(cursor, limit, filters...)` → `eewApiClient.getV2Eew`。
  - `limit`: 初期(cursor==null かつ filter なし)は 10、ページ追加時は 100、フィルタ適用時は 50(地震履歴の方針に合わせる)。
- レスポンス `EewListResponse.items`(`EewItemWithRelations`)を、既存の変換拡張(`app/lib/feature/eew/data/model/eew_telegram_item.dart` の `EewItemWithRelations → EewTelegramItem`)で `EewTelegramItem` に変換して保持する。リアルタイムと描画ロジックを統一するため。
- `appendKey = result.nextToken` でページネーション。
- `groupBy`: 日付(`originTime ?? reportTime`)を `yyyy/MM/dd`(`toLocal()`)でグルーピング。null は「不明」。

### リアルタイム(ピン留め)

- 既存 `eewProvider`(`AsyncValue<List<EewTelegramItem>>`、`@Riverpod(keepAlive: true)`、WebSocket + REST polling)を **そのまま watch** する。
- 発表中(リストが空でない)のとき、上部にピン留めセクションを描画。空なら非表示。
- カード描画はホームの `app/lib/feature/home/ui/component/eew/eew_card.dart`(`EewCard`)を流用する。
- 地震履歴と同様、`realtimeEventsProvider` の `RealtimeEewUpsertEvent` を listen し、リスト本体にも `upsertItems` で反映する(最終報が確定したら履歴側に溶け込む)。リアルタイム連携は初期パラメータ(フィルタ無し)時のみ有効にする(地震履歴が `parameter == const EarthquakeHistoryParameter()` のときだけ timer/listen を張るのと同じ方針)。

### upsert ロジック

`earthquake_history_data_source.dart` の `upsertItems` を踏襲。`eventId` で突合し、存在しなければ先頭 insert、存在すれば update。

## フィルタ (`EewListParameter`)

EEW API (`GET /v2/eew`) が対応する範囲に限定する。地震履歴より項目は狭い。

| フィルタ | API パラメータ | 型 |
|---|---|---|
| マグニチュード | `magnitudeGte` / `magnitudeLte` | num? |
| 深さ | `depthGte` / `depthLte` | num? |
| 最大予想震度 | `intensityGte` / `intensityLte` | JmaIntensity? |
| 期間 | `originTimeGte` / `originTimeLte` | DateTime? (yyyy-MM-dd) |
| 警報のみ | `isWarning` | bool? |

- `EewListParameter` は Freezed の `abstract class` で定義(地震履歴の `EarthquakeHistoryParameter` に倣う)。
- フィルタ UI は地震履歴の `sort_filter_chip` 等のコンポーネントを流用しつつ、上記5項目に絞る。
- **対象外(API 未対応のため)**: 地域/都道府県/市区町村検索、並び替え(sortBy/sortOrder)、長周期地震動階級、電文ステータス。これらは将来 API 拡張が必要なため Spec A の対象外。

## エラー処理

- `load` 内の例外は地震履歴と同様 `Failure(error, stackTrace)` で返し、`paging_view` の `appendErrorBuilder` / `initialLoadingWidget` で表示する。
- リアルタイム `eewProvider` が `AsyncError` のときはピン留めセクションを非表示にし、履歴リストは独立して機能を継続する。
- 空状態: 履歴 0 件は `emptyWidget`(地震履歴の `earthquake_history_not_found.dart` 相当を流用)。
- 初期ローディング / 追加ローディングは `Skeletonizer` を用いる(地震履歴に倣う)。

## デバッグ画面への導線・ルーティング

- `app/lib/feature/settings/children/config/debug/debug_page.dart` に ListTile を1つ追加(既存「EEW Card」項目の近く)。
- `app/lib/core/router/router.dart` に `@TypedGoRoute<EewHistoryRoute>(path: '/eew-history')` を追加。
- 一覧の行タップ → 暫定で `EewDetailsByEventIdRoute(eventId: ...)` へ push。Spec B で公開詳細ページに差し替える。

## テスト

- `EewListDataSource` の単体テスト: `load`(Refresh / Append / エラー)、`groupBy`、`upsertItems`。
- `EewItemWithRelations → EewTelegramItem` 変換が一覧表示に必要なフィールド(発表時刻・震源・M・最大予想震度・警報フラグ)を満たすことの確認。
- ウィジェットテストは地震履歴に倣い最小限(描画スモークテスト程度)。

## スコープ外

- 公開向け EEW 詳細ページ(Spec B)。
- デバッグ用 EEW 詳細ページの削除(Spec B 着手時に実施)。
- API 未対応フィルタ(地域検索・並び替え・長周期階級・電文ステータス)。

## 主要参照ファイル

- テンプレート: `app/lib/feature/earthquake_history/ui/earthquake_history_page.dart`
- データソース雛形: `app/lib/feature/earthquake_history/data/notifier/earthquake_history_data_source.dart`
- フィルタ雛形: `app/lib/feature/earthquake_history/data/model/earthquake_history_parameter.dart`
- API クライアント: `packages/eqmonitor_api/lib/src/clients/eew_api_client.dart` (`getV2Eew`)
- リアルタイム provider: `app/lib/feature/eew/data/eew.dart` (`eewProvider`)
- 変換拡張・モデル: `app/lib/feature/eew/data/model/eew_telegram_item.dart`
- カード描画流用元: `app/lib/feature/home/ui/component/eew/eew_card.dart`
- ルーター: `app/lib/core/router/router.dart`
- デバッグ画面: `app/lib/feature/settings/children/config/debug/debug_page.dart`
