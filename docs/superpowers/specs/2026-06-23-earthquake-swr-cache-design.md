# Earthquake 取得の SWR 化 + 差分取得 設計

- 日付: 2026-06-23
- 対象: Flutter アプリ (`app/`) + バックエンド (`backend/` submodule) + 共有パッケージ (`packages/eqmonitor_api`)
- ゴール: 地震情報取得を useSWR 的な `stale-while-revalidate` 化する。起動直後はローカルキャッシュから即時表示し、裏で差分のみを取得して更新する。あわせて Partial Response (差分取得) と CDN キャッシュ活用で通信量を削減する。

## 背景 (現状)

- `EarthquakeHistoryNotifier` (Riverpod) が `items` + `nextToken` を **メモリ上のみ** で保持。地震情報に関する永続化層は存在しない (shared_preferences は設定用途のみ)。
- 起動時はデフォルト param で `GET /v2/earthquake?limit=10` を発行し、取得完了までリストは空。
- 更新トリガは ① WebSocket リアルタイム ② アプリ復帰時 (最新10件全取得) ③ 5分タイマー (WS 未接続時、最新10件全取得) の 3 系統で、いずれも eventId ベースの upsert。
- バックエンド `earthquake` テーブルには **更新日時カラムが無い**。続報は同じ eventId で上書き。差分取得・`updatedSince` 系のパラメータも未実装 (`next_pooling` は常に undefined)。
- カーソルは `base64("PAGING:{eventId}")`。ETag は Hono の `etag()` ミドルウェアが自動生成。Cache-Control は環境変数制御 (デフォルト DISABLED)。圧縮は Cloudflare 透過。
- Drift は現状未使用 (新規導入)。talker の typed log パターンは `app/lib/core/provider/log/talker.dart` に既存 (`DioLog` 等)。

## キャッシュ対象 (スコープ)

1. **全国の一覧** (デフォルト `EarthquakeHistoryParameter()`)
2. **現在地 (region) の地震履歴一覧** — 現在地は変わりうるため region code をキーにした複数キャッシュになる
3. **地震履歴詳細** (eventId 個別)

フィルタ付き検索結果など上記以外は対象外 (従来通り毎回ネットワーク取得)。

---

## アーキテクチャ全体像

```
[起動] → Drift キャッシュを即読み込み・即表示 (stale)
            ↓ 同時に
        差分取得 GET /v2/earthquake?lastUpdatedSince=<floorToHourJst(maxUpdatedAt)>
            ↓
        upsert → Drift に反映 → UI 逐次更新 (newest-first)
            ↓
        Chip: 読み込み中 → (成功) 消える / (オフライン・失敗) 状態表示
```

2 層構成:

- **バックエンド**: 差分取得 API (`?lastUpdatedSince=`) + 差分用タイムスタンプ (`updatedAt`)
- **クライアント**: Drift による永続キャッシュ + SWR (stale-then-revalidate) フロー

> **削除は扱わない**: ソフトデリート/tombstone は設計に含めない。realtime 削除は既存 WebSocket (`RealtimeEarthquakeDeleteEvent`) が担当し、運用者の意図的削除・データ訂正は `cacheId` バンプ (全 wipe) で対応する。差分は upsert (新着・続報) のみを伝える。

---

## セクション1: バックエンド (DB + API)

### DB スキーマ変更 (`earthquake` テーブル, Drizzle migration)

| カラム | 型 | 用途 |
|---|---|---|
| `updatedAt` | `timestamptz` | **DB クロックで統一** (`.defaultNow()` + `$onUpdateFn(() => sql\`now()\`)` または DB トリガ)。**DB 行変更時刻 = アプリの差分カーソル**。insert/update の全行変更で自動更新 |
| `lastReportedAt` | `timestamptz` | **最後に publish された電文の発表時刻**。ドメイン値 (表示・ソート用)。upsert 時に最新電文の発表時刻で設定。差分カーソルには使わない |

- 命名の責務分離: `updatedAt` = 同期カーソル (DB 行変更時刻、`?lastUpdatedSince` で絞る)、`lastReportedAt` = ドメイン (発表時刻、表示/ソート)。パラメータ名 `lastUpdatedSince` とフィルタ対象 `updatedAt` を一致させる。
- `updatedAt` を差分カーソルにする利点: insert/update の全変更を自動捕捉。`deletedAt` は持たない (削除は差分で扱わない方針)。
- **クロック統一 (Codex BLOCKER3)**: `$onUpdateFn(() => new Date())` はアプリクロック、`.defaultNow()` は DB クロックで、混在すると `updatedAt` の時刻逆転 → カーソル順序保証が壊れる。**insert/update とも DB の `now()` を使う** (`sql\`now()\`` または BEFORE UPDATE トリガ)。
- **唯一の強制点 (Codex A-2)**: ORM 経由しない直接 SQL 書き込みが `updatedAt` を更新し忘れる漏れを防ぐため、**BEFORE UPDATE トリガを唯一の強制点**とするのが堅牢 (ORM の `$onUpdateFn` は補助)。全 upsert で `updatedAt` が進むことをテストで担保。
- **子テーブル変更の伝播 (Codex)**: intensity 等の子テーブルのみ変更されるケースでも、`EarthquakePartial` が intensity を含むため**親 `earthquake.updatedAt` を必ず bump する** (子 upsert 時に親も touch)。
- インデックス: DESC ページングのため `CREATE INDEX ON earthquake (updated_at DESC, event_id DESC)`。scoped intensity diff 用に子スコープ + 親 `updatedAt` の複合インデックスも追加。
- **レプリカ遅延 (Codex)**: 差分クエリはプライマリから読む (遅延レプリカ読みだと全ページ完走→`since_cursor` 前進がレプリカ可視化前に起き取りこぼす)。

### API 変更

対象エンドポイント: `/v2/earthquake` (全国一覧) および region/prefecture/city の intensity-search 系。

- `?lastUpdatedSince=<HourBucketJst>` クエリパラメータを追加 = **差分モード**。
- 差分モード時の挙動:
  - `updatedAt >= lastUpdatedSince` のレコードを返す (下限 inclusive)。新着・続報 (upsert) のみ。削除は扱わない。
  - `(updatedAt, eventId)` の複合カーソルで **降順 (newest-first)** ページング。
- レスポンスの `EarthquakePartial` に `updatedAt` (次カーソル算出用)・`lastReportedAt` (表示用) を追加。現行 transformer/Valibot 型は未 emit のため**スキーマ変更 + codegen が前提依存**。
- `lastUpdatedSince` 無しの通常リスト (初回・キャッシュ無し・フルロード) は従来通り eventId 降順。

#### 複合カーソルトークン (Codex BLOCKER1)

現行カーソルは `base64("PAGING:{eventId}")` の単一次元で `updatedAt` ページング不可。新トークンを定義する。

- トークン: `base64({ updatedAt: string, eventId: string })` のみ。`type` は持たない (差分モードか否かは `?lastUpdatedSince=` の有無で判別できるため、`type` は冗長 = 場当たり的な複雑化を避ける)。
- keyset ページングの原則として ORDER BY の全カラム (`updatedAt` + `eventId`) をカーソルに含める。`updatedAt` は一意でないため両方が必須。
- next-page 述語 (DESC, 取りこぼし/重複なし):

  ```text
  and(
    gte(earthquake.updatedAt, lastUpdatedSince),          // 差分窓
    or(
      lt(earthquake.updatedAt, cursor.updatedAt),
      and(eq(earthquake.updatedAt, cursor.updatedAt),
          lt(earthquake.eventId, cursor.eventId)),        // 同 updatedAt のタイ分解
    ),
  )
  ```

- フラットな `updatedAt >= cursor.updatedAt AND eventId < cursor.eventId` は **NG** (新しい updatedAt 行の重複・古い updatedAt + 大 eventId の取りこぼし)。

#### 述語 (削除を扱わないため2種)

- **通常リスト**: 全件 (`deletedAt` カラムが無いので削除フィルタ不要)。
- **差分リスト** (全国 / scoped): `updatedAt >= lastUpdatedSince` + scoped はスコープ filter。新着・続報のみ。

#### 差分モードの正規パラメータ契約 (Codex RISK4)

CDN 共有キャッシュは「全クライアントが完全同一 URL」を送ることに依存する。差分モードでは:

- 受理するパラメータを `lastUpdatedSince` / `cursor` / `limit` / scope code / `cacheId` / `statuses`(既定固定) に**ロックダウン**。それ以外のフィルタ (magnitude/depth/intensity 等任意フィルタ) が付いたら **SWR 共有キャッシュ対象外** (`no-store`、差分マージもしない)。
- `limit` は差分モードで固定値、`statuses` は常に含める/常に省くを統一、パラメータ並び順を正規化。
- Cloudflare Cache Rule でキャッシュキーを `path + scope code + lastUpdatedSince + cursor + limit + cacheId` のみに正規化。`cacheId` を含めることで、バンプ時に edge キャッシュキーごと切り替わる (後述)。
- **`statuses` 固定をコード制約として残す (Codex D-3)**: 将来クライアント指定可能にするとキャッシュキーから外している分が即 cache poisoning になる。差分モードでは `statuses` を可変にしない制約をコード/型で表現。
- **クロススコープカーソル (Codex D-2)**: カーソルは `(updatedAt, eventId)` のみでスコープを持たない。クライアントは**スコープごとに独立したページング状態**を持ち、別スコープのカーソルを再利用しない (クライアント規約)。スコープは URL で決まるためサーバ側追加検証は不要。

#### キャッシュヘッダの条件分岐 (Codex RISK5 / AREA6)

- 差分エンドポイント (正規契約を満たす): `Cache-Control: public, s-maxage=60`。
- filtered/search・非正規パラメータ: `no-store`。
- 現行 `cacheConfig.earthquake.list` は既定 `no-store` のため、モード別の条件分岐を実装する。
- **境界タイミング窓 SLA**: `10:59:55` 更新は最悪 `11:00:50` まで `10:00` バケットの裏。これは履歴の追いつき用であり、**sub-60s の鮮度は WebSocket が担保**する旨を明記。
- **キャッシュ世代 / 緊急パージ = `cacheId`** (下記)。

#### キャッシュ世代トークン `cacheId` (クライアント wipe + edge 無効化)

**起動 API (`/v1/start`, `StartResponse`) に `cacheId` (キャッシュ世代トークン)** を持たせ、運用者がデータ訂正・偽イベント除去・スキーマ事故・削除時に値を変える。これ1つで2系統を同時に無効化する。

- **クライアント永続キャッシュの wipe**: クライアントは最後に見た `cacheId` を `cache_meta.last_seen_cache_id` に永続保持。`/v1/start` 取得時に比較し、**変化していたら Drift + HTTP キャッシュを全消去してフルロード**。`/v1/start` は既に `ifNoneMatch` (ETag/304) 対応済みなので無変更時はバイトゼロ。
- **CDN edge の無効化 (Codex B-1 解決)**: クライアントは取得した `cacheId` を**差分リクエストのクエリパラメータ `&cacheId=` に付与**する。`cacheId` は Cloudflare キャッシュキーに含まれるため (上記正規化)、バンプ時に**全 diff URL が新キーへ切り替わり edge も即座に新鮮な応答を返す** (旧キーは放置で expire)。Cloudflare Tag purge のような場当たり機構は不要。
- **`/v1/start` 失敗時 (Codex B-2)**: フェイルオープン。`cacheId` を確認できなければ既存キャッシュをそのまま使い続け wipe しない (次回起動でリトライ)。直前に保持していた `cacheId` を差分リクエストに使う。
- **stale 表示との順序 (Codex B-3)**: 起動時は **Drift を即時表示 (ブロックしない)**。`/v1/start` 解決後に `cacheId` 不一致なら wipe + リロード。旧世代データが一時表示される window は許容 (バンプは稀で、表示後すぐ訂正)。即時表示を犠牲にしない。

#### 削除の扱い (ソフトデリートは導入しない)

- earthquake の削除 (取消電文・手動削除) は **差分では伝えない**。`deletedAt`・tombstone・writer のソフトデリート移行は**導入しない** (複雑さを排除)。
- 接続中クライアント: 既存 WebSocket `RealtimeEarthquakeDeleteEvent` が即時削除。
- オフライン中・コールドスタート時の削除取りこぼし: 運用者の `cacheId` バンプ (全 wipe) で解消。軽微な自動取消の取りこぼしは TTL で自然に消える。削除は稀なためこのトレードオフを許容。
- 現行 writer のハードデリート (`writer.ts:18`) はそのまま (変更不要)。

#### 移行順序 (Codex AREA6)

`updatedAt` を移行時刻で一括付与すると初回 diff が全テーブルを返す。順序:

1. nullable `updatedAt` / `lastReportedAt` を追加
2. domain time (発表時刻) ベースで `updatedAt` をバックフィル (順序衝突に注意)
3. writer を DB now() ベースの `updatedAt`/`lastReportedAt` 更新に変更しデプロイ
4. API に新フィールド/差分モード/`/v1/start` の `cacheId` を露出
5. 必要なら `updatedAt` を non-null 化

### HTTP / CDN

- 差分レスポンス: `Cache-Control: public, s-maxage=60` 程度。`lastUpdatedSince` が Hour バケットに量子化されているため (セクション4参照)、同一バケットのクライアント間で edge キャッシュを共有。
- 通常フルリスト (lastUpdatedSince 無し): 既存 `cache-config.ts` の edge キャッシュをそのまま/必要に応じ有効化。全員共通なので共有キャッシュ可能。
- ETag (Hono 自動) + Cloudflare → 無変更時 304。圧縮 (gzip/brotli) は Cloudflare 透過。

---

## セクション2: クライアント (Drift + SWR)

### Drift DB (新規, app 内 `core/cache/` 想定)

| テーブル | 主キー / カラム | 用途 |
|---|---|---|
| `earthquake_cache` | PK (`scope`, `event_id`) / `payload`(json), `updated_at`, `last_reported_at`, `fetched_at` | 一覧キャッシュ。`scope` = `national` / `region:<code>`。`updated_at` = 差分カーソル、`last_reported_at` = 表示/ソート |
| `earthquake_detail_cache` | PK `event_id` / `payload`(json), `updated_at`, `last_reported_at`, `fetched_at` | 詳細キャッシュ |
| `cache_sync_state` | PK `scope` / `since_cursor`, `last_synced_at` | scope ごとの差分カーソル (= 同期済み最大 `updatedAt`) |
| `cache_meta` | `schema_version`, `last_seen_cache_id` | 一括無効化トリガ (app 由来 `schema_version` / サーバ由来 `cacheId`) |

- `payload` は API レスポンスの `EarthquakePartial` / 詳細 JSON をそのまま保持。
- `fetched_at` = キャッシュ取得時刻 (TTL 判定・「いつ取得したキャッシュか」の記録に使用)。

### SWR フロー (一覧)

既存の `EarthquakeHistoryNotifier` (および region 系 notifier) を差分ベースに置換する。

1. **build 時**: Drift を読み、まず即時表示 (stale)。
2. `lastUpdatedSince = floorToHourJst(scope 内の max updatedAt)` を算出。`since_cursor` (同期済みカーソル) があればそれを優先。
3. 裏で差分 API `?lastUpdatedSince=` を発行。
4. **段階的マージ (newest-first)**: ページが届くごとに逐次 upsert / `fetched_at` 更新し、UI へ反映。chip は完了まで「読み込み中」。
5. **全ページ完走後にのみ** `cache_sync_state.since_cursor` を前進。途中中断時は次回また同じ `since` から取り直す (冪等マージで重複吸収、取りこぼしゼロ)。

### 差分取得の挙動詳細

- **表示順 / ページング方向**: 差分は降順 (newest-first) でページングし、最新の地震からリスト先頭へ埋まる。
- **段階的マージ**: 1 ページごとに反映。全ページ待ちにしない。
- **ロングギャップ (保持期間超)**: `lastUpdatedSince = floorToHourJst(max(maxUpdatedAt, now - 保持期間))` でクランプ。ギャップが保持期間を超えたら差分を諦め、**通常フルロード (lastUpdatedSince 無し・最新 N 件)** でキャッシュを作り直す。
- **カーソル前進**: ページング途中の中断では `since_cursor` を進めない。
- **削除**: 差分では扱わない (realtime は WS、運用削除は `cacheId` バンプ。セクション1「削除の扱い」参照)。

### 既存トリガとの統合

- 既存の「最新10件全取得」(`_onResumed` / `_refreshIfWsNotConnected` / `_refreshFromEarthquakeUpsert`) を **差分取得に統合** (置換)。
- WebSocket はリアルタイム upsert/delete に **そのまま維持**。差分取得はコールドスタート/オフライン復帰の追いつき用。
- 「1ファイル1公開 Provider」ルールを遵守する。
- notifier は現行「単一ネットワーク呼び出しを await」(`_fetchInitialData`) から「Drift 先返し → 裏再検証」へ**構造的に書き換え**る (リポジトリ層差し替えでは済まない)。

### 並行制御・自己修復ガード・保持基準 (Codex AREA4)

- **書き込み直列化**: timer / lifecycle / WS / 差分ページ / 自己修復が並行ライターになる。全 Drift 書き込みを**単一の直列トランザクションキュー**経由にし、`(eventId, updatedAt)` でマージ。incoming の `updatedAt` が既存より古ければ破棄 (差分ページが新しい WS データを上書きしない)。
- **自己修復ガード**: 同一 `(eventId, appSchemaVersion)` につき再取得は1回まで。2回目失敗で `failed` マークし停止 (app↔API スキーマ不一致時の delete-fetch 無限ループ防止)。
- **schema 検証を先に**: row パース前に `cache_meta.schema_version` を検証。不一致なら per-record 自己修復はせず **bulk clear に委譲** (bulk clear と per-record 修復の交錯防止)。
- **保持基準**: TTL の刈り取りは **domain age (`last_reported_at` / `updated_at`)** で行う。`fetched_at` は診断・「いつ取得したキャッシュか」表示用 (時間オーバーラップで再取得された行が永久に残る/未オープンの有用履歴が刈られる問題を回避)。

### 既存ロジックとの境界

- **スクロールバック**: SWR/差分はリスト先頭 (直近・キャッシュ内) を担当。キャッシュより古い履歴へのスクロールは従来の append paging (`nextToken`) でネットワーク取得を継続。両者は直交。
- **現在地変更**: 現在地が新 region に変わると `scope=region:<newcode>` は未キャッシュ → コールドロード (since 無しフルロード)。旧 region キャッシュは TTL まで残置。
- **詳細キャッシュ**: 詳細を開く → キャッシュ詳細を即表示 → `/v2/earthquake/{eventId}` を単純 refetch (差分なし)。再検証は API 層の ETag/304 (セクション6) を経由し、無変更時はバイトゼロ。

---

## セクション3: Chip 状態表示

```dart
sealed class CacheRevalidationState {
  idle          // 再検証なし
  revalidating  // 差分取得中 → 「読み込み中」
  offline       // ネット無し → 「オフライン」
  failed(error) // 失敗 → 「更新失敗 (再試行可)」
}
```

- provider で公開し、履歴画面 (全国/region) の AppBar または Overlay に Chip として描画。
- キャッシュ表示中かつ裏で再検証している間「読み込み中」を出す要件を満たす。

---

## セクション4: HTTP 最適化 (差分カーソルの量子化 + CDN)

### Hour バケット量子化

- クライアントは正確な `updatedAt` ではなく、それを **JST 時境界へ切り下げた値** を `?lastUpdatedSince=` に渡す (例 `?lastUpdatedSince=2026-06-23T19:00:00+09:00`)。
- 効果: 同一時間帯に同期する多数クライアントが **完全同一 URL** を叩く → Cloudflare が 1 回のオリジン取得結果を全員へ配れる (共有キャッシュヒット)。URL カーディナリティは低い (90日×24時間でも 2160 URL)。
- クライアントはバケット先頭〜実 `updatedAt` の分を余分に取得するが、**eventId で冪等 upsert マージ** するため無害。
- キャッシュキー数 (低) と鮮度 (短 TTL `s-maxage=60`) を分離。新着地震は最大 ~60 秒で反映 (リアルタイムは WS が別途担保)。
- 下限は inclusive (`>= lastUpdatedSince`) + 冪等マージで境界取りこぼし防止。

### バケット境界の検証 (Hour バケット表現スキーマ)

CDN キャッシュ共有は「全クライアントが厳密に同一境界値を送る」ことに依存するため、サーバは非境界値を **拒否** する (受理すると共有が断片化する)。不正状態を表現不可能にする方針で、専用スキーマを定義する。

- Valibot 専用スキーマ `HourBucketJst`: 正規表現 `^\d{4}-\d{2}-\d{2}T\d{2}:00:00\+09:00$` で **分・秒・以下が `00` かつ JST (`+09:00`)** を強制。外れたら 400。
- **正規表現だけでは不十分 (Codex C-1)**: `T25:00:00` や `2026-13-40` 等の不正値にマッチするため、regex 通過後に**実日時としてパース可能か検証** (Valibot transform で Date 化し妥当性チェック)。
- **JST は DST 無し (Codex C-3)**: 日本にサマータイムが無いため `+09:00` 固定で年中ブレない (実装者向け根拠)。
- 例: `2026-06-23T19:00:00+09:00` は OK、`2026-06-23T19:30:00+09:00` / `2026-06-23T10:00:00Z` / `2026-06-23T19:00:00` は NG。
- OpenAPI/Dart codegen 上は string 扱い。アプリ側にも対応するフォーマッタ/型 (`HourBucketJst` 値オブジェクト) を用意し、ローカルでも不正値を作らない。

### Timezone

- バケットは **一律 JST 固定** (デバイスのロケールに依存しない)。理由: 全クライアントが同じ絶対時刻境界に切り下げることで初めて共有が成立する。固定 TZ であればよく、本アプリは日本向けのため JST を採用。JST は +09:00 の whole-hour オフセットなので時境界は UTC 時境界と同一絶対時刻に揃う。
- フロー: クライアントは max `updatedAt` (絶対時刻) を JST で時フロア → `...T HH:00:00+09:00` で送信。サーバは絶対時刻として `updatedAt >= 値` を比較 (`timestamptz` 比較は TZ 非依存)。

### 圧縮・304

- ETag (Hono 自動) + Cloudflare → 無変更時 304。圧縮は Cloudflare 透過 (Dio はデフォルトで `Accept-Encoding` 送信)。
- **クライアント側 ETag/304 はアプリ API 層全体で実装する** (セクション6参照)。特に詳細キャッシュの再検証は差分 API を持たないため、304 によるバイト削減が効く。

---

## セクション5: 自己修復・保持戦略・運用 UI

### 自己修復キャッシュ

- Drift 読み出し時に `CheckedFromJsonException` / パース不整合を捕捉 → 該当キャッシュを削除 → ネットワークから再取得でリトライ。
- 起動時、一括クリアのトリガは2つ: ① app 由来の `cache_meta.schema_version` 不一致 (モデル変更の安全網) ② サーバ由来の `/v1/start` `cacheId` 変化 (`last_seen_cache_id` と比較、運用者の緊急パージ)。いずれも Drift + HTTP キャッシュを全消去。
- ログは talker の **typed log** (`app/lib/core/provider/log/talker.dart` に `EarthquakeCacheLog extends TalkerLog` を追加) で残す。

### 保持戦略 (アプリ側で切替可能)

| 戦略 | 挙動 |
|---|---|
| すべて保持 | 退避なし。全件永続 |
| TTL 90日 (デフォルト) | **`last_reported_at` (domain age) で判定**。起動時に TTL 超過分をクリア。`fetched_at` は表示・診断用 |
| キャッシュなし | 永続化を無効化 (常にネットワーク) |

- 切替はデバッグ画面のトグルで提供。
- region キャッシュは TTL クリアで自然に退避。

### キャッシュ状態オーバーレイ (build_config flag)

- `build_config` に **cache overlay flag** を追加し、ON のとき各要素 (全国一覧 / region 一覧 / 詳細 など) の**キャッシュ状態をオーバーレイ表示**する。
- 表示内容: cached / stale / revalidating / fresh、`fetched_at` (いつ取得したキャッシュか)、scope、件数など。開発・デバッグ時に SWR の挙動を可視化する。

### 運用 UI

- 設定画面に「キャッシュ削除」ListTile を用意。DB キャッシュサイズも表示。

---

## セクション6: アプリ API 層の ETag / 304 処理 (横断)

地震取得に限らず **アプリの API 層全体** で利用できる条件付き GET (ETag / `If-None-Match` → 304) を実装する。サーバ (Hono `etag()`) と Cloudflare は既に ETag を返すが、クライアント側で ETag を保存し再送しないと 304 の恩恵 (バイト削減) を受けられないため、Dio インターセプタとして組み込む。

### 仕組み

- **保存**: GET レスポンスの `ETag` ヘッダとレスポンスボディを、リクエストキー (method + URL + クエリ) で永続ストアに保存。
- **再送**: 同一リクエスト時、保存済み ETag を `If-None-Match` ヘッダに付与。
- **304 応答**: サーバが 304 を返したら、ストアのボディを 200 相当として復元しレスポンスを構築。
- **更新**: 200 応答時はストアの ETag / ボディを更新。

### 実装方針

- `dio_cache_interceptor` を採用 (ETag/304 ・ Cache-Control 準拠を備える)。ストアは Drift ベース (`dio_cache_interceptor_db_store` 等) で SWR キャッシュ DB と同居、または専用ストア。
- `apiClientProvider` の Dio に横断インターセプタとして登録 (既存の `talker_dio_logger` と並列)。
- ポリシー: GET のみ。条件付き再検証 (`CachePolicy.refreshForceCache` 相当: ETag があれば必ず再検証し 304 ならキャッシュ) を既定とする。
- 差分一覧 (`?...Since=`) は既にペイロード極小だが、横断インターセプタが乗るため無変更バケットは 304 で短絡され追加の利得。
- このストアと SWR の Drift キャッシュは **責務が別** (HTTP レイヤの透過キャッシュ vs ドメインモデルの永続キャッシュ)。自己修復・保持戦略・Chip 表示は SWR キャッシュ側の責務。

### 二層の整合性 (Codex AREA5)

- **差分リクエストは常にネット到達 + `If-None-Match`**。ローカル fresh body を再検証なしで返さない (ローカル body で `since_cursor` が stale データのまま誤前進するのを防ぐ)。`CachePolicy` は条件付き再検証固定。
- **自己修復時は HTTP キャッシュも evict**: Drift 行を消して再取得しても、`dio_cache_interceptor` が 304 で同じ壊れた body を再生したら無意味。自己修復は該当 URL の HTTP キャッシュエントリも削除してから再取得する。
- **HTTP キャッシュキーを API schema version / app build で名前空間化**: モデル変更で `updatedAt`/`lastReportedAt` 追加後、旧 body が 304 再生されてパース失敗するのを防ぐ。`cache_meta.schema_version` 不一致時は HTTP キャッシュもクリア。
- 「キャッシュなし」選択時は HTTP キャッシュストアもクリア対象に含める (UX 上「全消し」期待)。

### 注意点

- 304 復元のボディは HTTP レイヤのバイト列であり、ドメイン変換 (`toEarthquake` 等) は通常経路と同一。

---

## テスト計画

- **バックエンド**: 差分クエリの正しさ — 変更/新着 (続報) が含まれること、`(updatedAt, eventId)` 降順ページング、`>= lastUpdatedSince` 境界 inclusive。`HourBucketJst` 検証 (非境界・非 JST・不正日時は 400)。`updatedAt` が全 upsert (子テーブル変更含む) で進むこと。`cacheId` がキャッシュキーに反映されること。
- **Flutter**:
  - Drift マージ (upsert / 冪等性)。
  - 自己修復 (パース失敗 → 削除 → 再取得)。
  - TTL クリア。
  - SWR stale-then-revalidate フロー (即時表示 → 差分反映)。
  - ロングギャップのクランプ / フルロードフォールバック。
  - カーソル前進が全ページ完走後のみであること (中断時の再取得)。
  - Chip 状態遷移 (idle / revalidating / offline / failed)。
  - API 層 ETag/304: ETag 保存・`If-None-Match` 再送・304 でのボディ復元・200 での更新。
  - 一括 wipe: `/v1/start` `cacheId` 変化時・`schema_version` 不一致時に Drift + HTTP キャッシュが全消去されること。

---

## 確定した決定事項

1. スコープ: クライアント (Drift SWR) + バックエンド (差分 API) の両方。
2. 永続化: Drift (SQLite)。
3. キャッシュ対象: 全国一覧 / 現在地 region 履歴一覧 (region code キー) / 詳細 (eventId)。
4. バックエンド: `updatedAt` (DB now() 統一、**差分カーソル**) + `lastReportedAt` (発表時刻、表示/ソート用)。`deletedAt` は導入しない (削除は差分で扱わない)。
5. 差分カーソル伝達: クエリパラメータ `?lastUpdatedSince=` で `updatedAt` を絞る、**Hour 単位 JST バケットに量子化**、`>=` inclusive、冪等マージ。境界値は Valibot `HourBucketJst` (`^\d{4}-\d{2}-\d{2}T\d{2}:00:00\+09:00$`) で検証 (非境界は 400)。Timezone は一律 JST 固定。
6. 差分ページング: `(updatedAt, eventId)` 降順 (newest-first)、段階的マージ。
7. ロングギャップ: 保持期間でクランプ + 超過時フルロードフォールバック。
8. カーソル前進: 全ページ完走後のみ。
9. 削除: 差分では扱わない。realtime は既存 WS、運用者の削除/訂正は `cacheId` バンプ (全 wipe + edge 無効化)。ソフトデリート/tombstone は導入しない。
10. 再検証統合: 既存 WS / 5分タイマー / アプリ復帰の全取得を差分取得に統合。WS はリアルタイム維持。
11. Chip: 読み込み中 / オフライン / 失敗 を区別。
12. 保持戦略: すべて保持 / TTL 90日 (デフォルト、起動時クリア) / なし。デバッグ画面で切替。設定画面に削除 ListTile + DB サイズ表示。`build_config` の cache overlay flag で各要素のキャッシュ状態をオーバーレイ表示。
13. 自己修復: パース失敗で透過的に削除+リトライ。typed talker ログ。
14. HTTP 最適化: 量子化 `lastUpdatedSince` による CDN 共有キャッシュ + ETag/304 + Cloudflare 透過圧縮。
15. ETag/304 はアプリ API 層横断で実装 (dio_cache_interceptor、Drift ストア)。詳細キャッシュ再検証で特に有効 (セクション6)。
16. `updatedAt` クロックは **DB now() に統一** (`.defaultNow()` + `$onUpdateFn(() => sql\`now()\`)` / トリガ)。app クロック混在による順序逆転を防止。
17. 差分カーソルは `base64({updatedAt, eventId})` のみ (`type` は持たない — 場当たり的な複雑化回避) + DESC タイ分解述語。子テーブル変更時も親 `updatedAt` を bump。
18. writer のハードデリートはそのまま (ソフトデリート移行しない)。`updatedAt`/`lastReportedAt` を DB now()/発表時刻で更新するようにのみ変更。
19. 差分モードは正規パラメータ契約 (`lastUpdatedSince`/`cursor`/`limit`/scope/固定`statuses`) にロックダウン。非正規は `no-store`・非マージ。Cloudflare キャッシュキー正規化。
20. Drift 書き込みは直列キュー + `(eventId, updatedAt)` マージ。自己修復は `(eventId, appSchemaVersion)` で1回ガード。HTTP キャッシュも自己修復/スキーマ変更時に evict・schema version で名前空間化。
21. TTL 刈り取りは **`last_reported_at` (domain age)** 基準。`fetched_at` は表示/診断用。
22. 差分読みは**プライマリ**から (レプリカ遅延でのカーソル誤前進防止)。移行は nullable 追加→domain time バックフィル→writer デプロイ→API 露出→non-null 化の順。
23. `cacheId` (`/v1/start`) はキャッシュ世代トークン。①クライアント Drift+HTTP の wipe ②差分リクエストの `&cacheId=` クエリ付与で **CDN edge も即無効化** (キャッシュキーに含む)。Cloudflare cache tag は使わない。`/v1/start` 失敗時はフェイルオープン、stale 即時表示は犠牲にしない。

## 実装計画フェーズで詰める未解決論点

- 差分モードの `limit` 固定値、`s-maxage` の初回 diff と cursor ページの値。
- `cacheId` の置き場 (`StartResponse` 直下 or `flags` 配下) と発番運用 (手動 / デプロイ連動)。
- scoped 差分 (region) の実装は全国一覧の後続フェーズ。スコープ filter + `updatedAt >= since` で成立 (削除を扱わないため tombstone 問題は消滅)。
