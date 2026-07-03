# キャッシュ先行表示の全面展開 + CachedDataBanner 設計 (Issue #1432)

- 日付: 2026-07-04
- 対象: Flutter アプリ (`app/`)
- Issue: [#1432 キャッシュした情報の先行表示](https://github.com/YumNumm/EQMonitor/issues/1432)
- ゴール: 既存の cache-first SWR 基盤 (`CachedNotifier`, [2026-06-27 設計](2026-06-27-http-cache-first-swr-foundation-design.md)) を詳細・静的系の GET エンドポイントへ広げ、キャッシュデータ表示中であることを共通バナーで明示する。

## 背景 / 現状

- SWR 基盤は実装済み (PR #1355)。`app/lib/core/provider/cached_notifier.dart` の `CachedNotifier<T>` mixin が「cache-only 即返し → microtask で裏更新 → 差し替え」を担い、状態は `AsyncValue<T>` + `copyWithPrevious` で表現する (独自状態型なし。Issue 本文の「AsyncValue でいいかも」という結論どおり)。
- 適用済みは `StartNotifier` / `ChangelogNotifier` / `ParameterSetNotifier` の 3 件のみ。
- Issue の残要件は次の 2 点:
  1. 詳細・静的系 GET への **SWR 適用拡大**
  2. **キャッシュデータ表示中であることの明記** (共通 UI)

## 確定方針 (ユーザー承認済)

- **対象は詳細・静的系のみ**: GET・冪等・非ページングに限定。ページネーション一覧 (地震一覧・フィード一覧・EEW 一覧等) は明示的に対象外 (地震一覧は 2026-06-23 設計のドメイン Drift キャッシュに委ねる)。リアルタイム系 (EEW / 津波ポーリング)・ユーザー設定系 (Tier 2) も対象外。
- **移行方式は案 A (Notifier 単位の個別移行)**: Repository 層の全面リファクタは行わず、SWR 対象の Repository メソッドにのみ client 引数を追加する (`ParameterRepository.fetch(client)` の前例に従う)。
- **明示 UI は共通 Widget**: AppBar 直下の**上部バナー**形式。

## セクション1: 共通バナー `CachedDataBanner`

場所: `app/lib/core/component/cached_data_banner.dart`

```dart
class CachedDataBanner extends StatelessWidget {
  const CachedDataBanner({required this.values, super.key});

  /// 画面が表示している SWR 対象 provider の状態。複数可。
  final List<AsyncValue<Object?>> values;
}
```

表示ロジック (優先度順):

| 条件 | 表示 |
|---|---|
| いずれかが `hasValue && hasError` (再検証失敗・stale 維持) | 「最新情報の取得に失敗しました（キャッシュ表示中）」+ 警告アイコン |
| いずれかが `isFromCache` (キャッシュ由来の値を表示中・裏で再検証中) | 「キャッシュ表示中・更新を確認しています…」+ 進行インジケータ |
| それ以外 (fresh / 初回ロード中 / キャッシュ無し) | `SizedBox.shrink()` (高さゼロ) |

- 出し入れは `AnimatedSize` (または `AnimatedSwitcher`) でスライドイン/アウトし、レイアウトジャンプを緩和する。
- テーマは `Theme.of(context).colorScheme` から取得 (surfaceContainerHighest 系 + onSurfaceVariant。失敗時は errorContainer 系)。
- 判定は `AsyncValue` の公開 API のみ使用。`isFromCache` は riverpod 3 の公開 API (`valueFilled?.kind == DataKind.cache` のラッパ) で、`CachedNotifier` が stale 値に付与する cache マークを正確に検出できる (`isRefreshing` だと通常の invalidate 再取得も「キャッシュ表示中」と誤表示するため採用しない)。riverpod 内部 API (`DataKind`) には本体コードで依存しない。
- 初回ロード (キャッシュ無し) はバナーを出さない: 画面本体が既存のローディング表現を持つため二重表示になる。

## セクション2: Notifier 移行 (6 件・案 A)

各 provider を `CachedNotifier<T>` mixin のクラス型へ変換し、`build() => cachedBuild()`、`fetch(ApiClient client)` を実装する。**公開 provider 名・戻り値型・keepAlive/autoDispose・family 引数は現状維持**のため、呼び出し側コードは無変更 (codegen 再実行のみ)。

| # | Provider (ファイル) | 現形態 → 変換 | fetch 内の処理 |
|---|---|---|---|
| 1 | `EarthquakeHistoryDetailsNotifier` (`feature/earthquake_history/data/notifier/earthquake_history_details_notifier.dart`) | クラス型 family — mixin 追加のみ | `repository.fetchEarthquakeDetail(client, eventId: eventId)` |
| 2 | `telegramDetails` (`feature/telegram_list/data/notifier/telegram_details_notifier.dart`) | 関数型 family → クラス化 | `client.telegram.getV2TelegramEventIdEventIdDetails(eventId:)` 直接 + Map 変換 |
| 3 | `prefectureHighest` (`feature/intensity_history/data/notifier/prefecture_highest_provider.dart`) | 関数型 keepAlive → クラス化 | `repository.fetchPrefectureHighest(client)` |
| 4 | `cityHighest` (`feature/intensity_history/data/notifier/city_highest_provider.dart`) | 関数型 family → クラス化 | `repository.fetchCityHighest(client, prefectureCode)` |
| 5 | `nearbyEarthquake` (`feature/earthquake_history/data/provider/similar_earthquake_provider.dart`) | 関数型 family (8引数) → クラス化 | `repository.fetchEarthquakeList(client, ...)` — 一覧 API だがフィルタ付き単発 GET (limit 5・カーソル不使用) のためページング非該当 |
| 6 | `feedBySource` (`feature/feed/data/provider/feed_by_source_provider.dart`) | 関数型 family → クラス化 | `repository.fetchByTelegramHash(client, telegramHash)` |

Repository 変更の原則:

- SWR 対象メソッドにのみ `ApiClient` (またはサブクライアント) 引数を追加する。コンストラクタに保持している client は他メソッドのためそのまま残す。
- `fetchEarthquakeList` はページネーション経路 (`EarthquakeHistoryNotifier` 等) と共用のため、既存呼び出し側を壊さない形 (省略可能な client 引数、または SWR 用の別メソッド) を実装計画で選ぶ。他の対象メソッドは単一呼び出し元のため単純にシグネチャ変更でよい。
- family Notifier の `fetch(ApiClient)` は provider 引数 (`this.eventId` 等) を読んで呼び出す (2026-06-27 設計の family パターン)。
- `ifNoneMatch` 等の条件付きヘッダは渡さない (インターセプタ任せ)。

対象外 (今回は移行しない):

- ページネーション一覧すべて (`/v2/earthquake` 一覧, `/v2/feeds`, `/v2/eew`, `/v2/telegram/eventId/*` 一覧, 通知履歴, 津波一覧)
- リアルタイム系 (`/v2/eew/*`, 津波詳細の 30 秒ポーリング, realtime ticket)
- ユーザー設定系 (`/v2/device/me/settings/*` — Tier 2 として別 spec)
- 非冪等・書き込み系すべて

## セクション3: UI 組み込み

| 画面 | 渡す values |
|---|---|
| 地震詳細ページ (`feature/earthquake_history/ui/earthquake_history_details_page.dart`) | 地震詳細のみ。類似地震はカード内ローカル状態 (ソート/探索パラメータの hooks) が family 引数のためページからは同一 provider インスタンスを参照できず、カード内の既存インライン表示 (stale 維持) で完結させる |
| 電文一覧ページ (`feature/telegram_list/ui/telegram_list_by_event_id_page.dart`) | `telegramDetails` (同ページの電文一覧 API はページングのため SWR 対象外のまま) |
| 震度履歴マップページ (`feature/intensity_history/ui/intensity_history_page.dart`) | `prefectureHighest` / `cityHighest` — マップ全面 UI のため、バナーは画面上部のオーバーレイとして重ねる (既存 `intensity_history_error_overlay.dart` の配置慣習に合わせる) |
| フィード詳細ページ (`feature/feed/ui/page/feed_details_page.dart`) | `feedBySource` |

- 設置位置は AppBar 直下 (body 先頭)。Sliver ベースの画面では `SliverToBoxAdapter` でラップ、マップ全面の画面では上部オーバーレイとして配置する。
- **消費側の値付き Loading 対応**: SWR 化後は「値を保持した `AsyncLoading`」が流れるため、`switch (state) { AsyncLoading() => 全画面スピナー, ... }` のような Loading 優先パターンは stale 即表示を打ち消してしまう。対象画面の switch は値優先 (`AsyncValue(:final value?)` を先頭) に並べ替える (地震詳細ページ・類似地震カードが該当)。`when` を使う画面は `skipLoadingOnRefresh` (既定 true) で問題ないが、再検証失敗で stale を維持するため `skipError: true` を付ける (フィード詳細が該当)。
- バナーは購読済み `AsyncValue` を受け取るだけで、自身では provider を watch しない (再利用性・テスト容易性のため)。

## セクション4: エラー処理

基盤 (`CachedNotifier`) が処理済みのため追加実装なし。

- キャッシュミス → 通常ロード (既存のローディング/エラー UI)
- 壊れたキャッシュ → force-fresh 取得で上書き (基盤実装済)
- 再検証失敗 → `AsyncError.copyWithPrevious` で stale 維持 → バナーが失敗表示

## セクション5: テスト

- `CachedDataBanner` Widget テスト: 3 状態の出し分け (fresh で非表示 / isFromCache で更新中 / stale+error で失敗表示)、複数 values の合成 (1 つでも該当すれば表示)、優先度 (失敗 > 更新中)、初回ロード (値なし Loading) で非表示。
- Notifier 移行の代表テスト: family 型 1 件 (`cityHighest`) で「キャッシュヒット → stale 即 emit → fresh 差し替え」「キャッシュミス → 通常ロード」「再検証失敗 → stale 維持」を検証。既存 `intensity_highest_repository_test` の fixture ヘルパを流用でき、Repository 差し替え (client の identical 判定) で cache-only / 通常経路を区別する (telegram 系はモデル fixture が重いため代表から外した)。
- 回帰: `melos run analyze` / `melos run test` が緑。既存の呼び出し側テストが provider 名維持により無変更で通ること。

## セクション6: PR 分割

1. **PR-1**: `CachedDataBanner` + 地震詳細系 3 provider (詳細/類似/電文詳細) の移行 + 地震詳細ページ・電文一覧ページへの設置
2. **PR-2**: 震度履歴 2 provider + フィード詳細の移行と各画面への設置

いずれも base は `develop`、repo は `YumNumm/EQMonitor`。

## 決定事項まとめ

1. 対象は詳細・静的系 6 provider のみ。ページング・リアルタイム・設定系・非冪等は対象外。
2. 移行は案 A (Notifier 単位)。Repository は SWR 対象メソッドへの client 引数追加に留める。
3. キャッシュ表示の明示は共通の上部バナー `CachedDataBanner`。`AsyncValue` 公開 API のみで判定。
4. 公開 provider 名・型・ライフサイクルは維持し、呼び出し側は無変更。
5. 初回ロード (キャッシュ無し) はバナー非表示 (既存ローディング UI に委ねる)。
