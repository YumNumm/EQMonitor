# 087: 通知配信ルーティング v2（地震・EEW 連動配信）

## 背景

現行の `device_earthquake_notification_setting.region_id` には EEW 予報区コード（`area_forecast_local_eew`、例: 9140=神奈川）が格納されている。
一方、地震情報 (VXSE51/53) の `regions.code` は JMA 一次細分化地域コード（例: 250=福島県中通り）であり、両者は完全に別系統。
結果、地震通知のマッチングが永久に成立せず、通知が一切発火しない欠陥を抱えている。

本ドキュメントは、地震・EEW 通知配信の **正しいコード系・粒度・連動ルール** を再設計する。

## 要件

| # | 要件 |
|---|------|
| R1 | 地震通知は **一次細分化地域** または **市区町村** で配信先を指定可能 |
| R2 | 市区町村を指定した場合、所属する一次細分化地域が自動でセットされる |
| R3 | 現在地モードは GPS から **市区町村コード + 一次細分化地域コード** の両方を解決 |
| R4 | VXSE51（震度速報）は **一次細分化地域** でマッチング |
| R5 | VXSE53（震源・震度に関する情報）は **市区町村** を優先しマッチング（city 未設定の設定は region でフォールバック） |
| R6 | 同一 EventId で先行電文を配信したデバイスは、後続電文も配信対象（VXSE51 → VXSE52/VXSE53 連動。VXSE51/52 スキップ → VXSE53 単独パターンも対応） |
| R7 | EEW 配信済デバイスは、同一 EventId の後続 Earthquake 通知の配信対象。ただし「earthquake 通知が無効」のデバイスは除外 |
| R8 | 「earthquake 通知が無効」判定は `device_earthquake_notification_setting` 行が 1 件も存在しないこと |
| R9 | 1 電文あたりの配信先解決（マッチング + 伝播 + Redis 操作）を **p95 < 100ms** で完了させる |
| R10 | 各 phase のレイテンシ・マッチ件数を Grafana で可視化、構造化ログに残す |

## 確定事項

| # | 内容 |
|---|------|
| D1 | `earthquake_enabled` 判定 = `device_earthquake_notification_setting` 行が 1 件以上存在するか |
| D2 | 既存データはマイグレーションで全削除（ユーザに再設定を依頼）。未リリースのため移行 UI 不要 |
| D3 | 通知本文は既存実装踏襲（マッチした region/city 名を含める） |
| D4 | VXSE52 + VXSE53 は「震度速報+震源に関する情報」として連動配信（既存挙動踏襲） |
| D5 | 設定行ごとに `min_jma_intensity` を持つ（region のみ・region+city のいずれでも） |
| D6 | 旧 API スキーマからの互換は不要（未リリース）。新スキーマでエラーを返す |

## データモデル

### `device_earthquake_notification_setting`（再構築）

```sql
DROP TABLE device_earthquake_notification_setting CASCADE;

CREATE TABLE device_earthquake_notification_setting (
  device_id           uuid          NOT NULL REFERENCES devices(id) ON DELETE CASCADE,
  region_id           integer       NOT NULL,           -- 一次細分化地域コード (0 = 全国)
  region_name         text,
  city_code           text,                              -- 市区町村コード (NULL = region 単位の通知)
  city_name           text,
  is_current_location boolean       NOT NULL DEFAULT false,
  min_jma_intensity   jma_intensity NOT NULL,
  created_at          timestamptz   NOT NULL DEFAULT now(),
  updated_at          timestamptz   NOT NULL DEFAULT now(),
  CONSTRAINT device_earthquake_notification_setting_pkey
    UNIQUE NULLS NOT DISTINCT (device_id, region_id, city_code)
);
```

設定行は 3 パターン:
- 全国: `region_id=0, city_code=NULL`
- 一次細分化地域指定: `region_id=190, city_code=NULL`
- 市区町村指定: `region_id=190, city_code=1410100`

### インデックス（クエリ駆動）

```sql
-- VXSE51 用: region_id + intensity 範囲、city_code IS NULL の partial
CREATE INDEX idx_eq_setting_region_no_city
  ON device_earthquake_notification_setting (region_id, min_jma_intensity)
  WHERE city_code IS NULL AND region_id <> 0;

-- VXSE53 用: city_code + intensity
CREATE INDEX idx_eq_setting_city
  ON device_earthquake_notification_setting (city_code, min_jma_intensity)
  WHERE city_code IS NOT NULL;

-- 全国対象（region_id=0）専用
CREATE INDEX idx_eq_setting_all_japan
  ON device_earthquake_notification_setting (min_jma_intensity)
  WHERE region_id = 0;

-- device_id は PK 先頭でカバー
```

`jma_intensity` enum は宣言順で `<=` 比較可能なので intensity 比較は直接 enum で行う。

### `device_eew_notification_setting`

**変更なし**。EEW は `area_forecast_local_eew` コード（9131=東京）で正しく動作中。

## Redis キー設計

```
notified:{eventId}:eew         SET<device_id>   TTL 1h (受信ごとに延長)
notified:{eventId}:earthquake  SET<device_id>   TTL 1h
```

電文単位の冪等性は既存実装（電文ハッシュ別キー）を踏襲。

## クエリ設計

### VXSE51 マッチング

```sql
WITH event_regions AS (
  SELECT region_id, max_int
  FROM UNNEST($1::int[], $2::jma_intensity[]) AS t(region_id, max_int)
)
SELECT s.device_id, s.region_id, s.region_name, s.min_jma_intensity
FROM device_earthquake_notification_setting s
JOIN event_regions e ON s.region_id = e.region_id
WHERE s.city_code IS NULL
  AND s.min_jma_intensity <= e.max_int
UNION ALL
SELECT device_id, 0, region_name, min_jma_intensity
FROM device_earthquake_notification_setting
WHERE region_id = 0
  AND min_jma_intensity <= $3::jma_intensity;
```

### VXSE53 マッチング

```sql
-- city マッチ
WITH event_cities AS (
  SELECT city_code, max_int
  FROM UNNEST($1::text[], $2::jma_intensity[]) AS t(city_code, max_int)
)
SELECT s.device_id, s.region_id, s.region_name, s.city_code, s.city_name, s.min_jma_intensity
FROM device_earthquake_notification_setting s
JOIN event_cities e ON s.city_code = e.city_code
WHERE s.min_jma_intensity <= e.max_int

UNION ALL  -- region フォールバック（city未指定の設定行）

WITH event_regions AS (
  SELECT region_id, max_int
  FROM UNNEST($3::int[], $4::jma_intensity[]) AS t(region_id, max_int)
)
SELECT s.device_id, s.region_id, s.region_name, NULL, NULL, s.min_jma_intensity
FROM device_earthquake_notification_setting s
JOIN event_regions e ON s.region_id = e.region_id
WHERE s.city_code IS NULL
  AND s.min_jma_intensity <= e.max_int

UNION ALL  -- 全国対象

SELECT device_id, 0, region_name, NULL, NULL, min_jma_intensity
FROM device_earthquake_notification_setting
WHERE region_id = 0
  AND min_jma_intensity <= $5::jma_intensity;
```

### EEW → Earthquake 伝播

```sql
SELECT DISTINCT device_id
FROM device_earthquake_notification_setting
WHERE device_id = ANY($1::uuid[]);
-- PK 先頭の device_id で index seek
```

EEW notified が大きい場合は chunk 分割（10k 単位）を検討。

## 配信アルゴリズム

```
async function resolveEarthquake(event):
  span = startSpan('resolveEarthquake')

  # Phase 1: Redis 既存配信先取得（並列）
  [eewNotified, eqAlreadyNotified] = await pipeline([
    SMEMBERS notified:{eventId}:eew
    SMEMBERS notified:{eventId}:earthquake
  ])

  # Phase 2: 新規マッチ
  newMatches = await timed('match_query') {
    if VXSE51: matchByRegion(event)
    elif VXSE53: matchByCityAndRegion(event)
    elif VXSE52: []  # 新規マッチなし、フォローアップのみ
  }

  # Phase 3: EEW 伝播
  candidatesForPropagation = eewNotified - eqAlreadyNotified
  propagated = candidatesForPropagation.length > 0
    ? await timed('propagation_query', getEarthquakeEnabledDevices(candidatesForPropagation))
    : []

  # Phase 4: 配信先確定
  recipients = newMatches ∪ propagated ∪ eqAlreadyNotified

  # Phase 5: Redis 更新
  newlyAdded = newMatches ∪ propagated
  if newlyAdded.length > 0:
    await SADD notified:{eventId}:earthquake newlyAdded

  # Phase 6: 通知生成 & dispatch
  return buildAndDispatchMessages(recipients, event)
```

EEW 配信フローも対称的:
```
async function resolveEew(event):
  eewAlreadyNotified = await SMEMBERS notified:{eventId}:eew
  newMatches = matchEew(event)  # area_forecast_local_eew コード
  recipients = newMatches ∪ eewAlreadyNotified
  newlyAdded = newMatches - eewAlreadyNotified
  if newlyAdded.length > 0:
    await SADD notified:{eventId}:eew newlyAdded
  return buildAndDispatchMessages(recipients, event)
```

## パフォーマンス目標

| Phase | 上限 | 想定 |
|-------|------|------|
| Redis fetch (parallel SMEMBERS) | 10ms | 3-5ms |
| Match query (DB) | 50ms | 5-30ms |
| Propagation query (DB) | 20ms | 5-15ms |
| Set ops + Redis update | 10ms | 2-5ms |
| ペイロード生成 | 10ms | 2-5ms |
| **合計** | **100ms** | **17-60ms** |

**SLO: 解決フェーズ p95 < 100ms / 5 万デバイス**

## 観測性

### OpenTelemetry Spans

```
resolveEarthquakeNotification (root)
├── redis.fetch_notified_sets
├── db.match_query [attr: telegram_type, region_count, city_count]
├── db.propagation_query [attr: eew_notified_count]
├── redis.update_notified_set
└── notification.dispatch [attr: recipient_count]
```

### Prometheus メトリクス

```
notification_resolver_phase_duration_seconds{phase, telegram_type}  histogram
notification_resolver_db_query_duration_seconds{query_name}         histogram
notification_resolver_matched_devices_total{telegram_type, match_kind} counter
  # match_kind: new_match | propagated | follow_up
```

### 構造化ログ

```typescript
logger.info('Notification resolution completed', {
  eventId, telegramType, durationMs,
  matchQueryMs, propagationQueryMs, redisFetchMs,
  newMatchCount, propagatedCount, followUpCount,
  totalRecipients, regionCount, cityCount,
});
```

### Grafana

新規パネル:
- 配信解決レイテンシ p50/p95/p99（phase 別）
- マッチ件数（telegram_type × match_kind）
- DB クエリ時間内訳
- 100ms 超過アラート: `histogram_quantile(0.95, ...) > 0.1`

## アプリ側（Flutter）変更

### `JmaRegionResolver`

GPS 座標から `(regionCode, cityCode)` ペアを返すよう拡張。
- `cityCode` は `areaInformationCity` マップから解決
- `regionCode` は city の親 region を逆引き（`earthquake_param.regions[].cities` から構築）
- 既存 EEW 用 `resolveRegionCode`（`areaForecastLocalEew`）は EEW 設定用に残す

### `notification_region_picker.dart`

モード拡張: `[ 全国 | 一次細分化地域 | 市区町村 | 現在地 ]`

- 一次細分化地域: `earthquake_param.regions` から選択
- 市区町村: `earthquake_param.regions[].cities` から選択 → 親 region 自動セット
- 現在地: `JmaRegionResolver` から (region, city) ペア取得

### API スキーマ

`RegionSettingRequest` に `cityCode`・`cityName` を追加。旧フィールドのみのリクエストは 400 を返す（未リリース・互換不要）。

## 実装フェーズ

| Phase | 内容 | 完了条件 |
|-------|------|---------|
| P1 | DB migration: 旧テーブル削除 + 新スキーマ + index 投入 | `pnpm db:migrate` 成功、`EXPLAIN` で index 利用確認 |
| P2 | `DeviceRepository.getEarthquakeMatchedDevices` を電文種別ごとに分岐 | unit test |
| P3 | 最適化クエリ実装（UNNEST + JOIN、raw SQL） | EXPLAIN ANALYZE で index 利用確認 |
| P4 | Redis キー分離・EEW 伝播・フォローアップロジック | unit test（モック Redis） |
| P5 | OpenTelemetry / Prometheus / 構造化ログ実装 | metrics endpoint 確認 |
| P6 | アプリ: `JmaRegionResolver` 拡張（region + city 両解決） | unit test |
| P7 | アプリ: region/city/現在地 picker UI | 手動 E2E |
| P8 | API スキーマ更新（cityCode 追加・旧スキーマでエラー） | OpenAPI 生成 |
| P9 | 負荷試験: 5 万デバイス投入し VXSE51/53 シナリオで **p95 < 100ms 確認** | k6 / vegeta + Grafana 検証 |
| P10 | デプロイ | リリース |

## リスクと対策

| リスク | 対策 |
|--------|------|
| EEW notified 5 万件 → propagation クエリ slow | `EXPLAIN ANALYZE` で hash join 確認。閾値超えたら chunk 分割 (10k ずつ) |
| 配信レイテンシ SLO 超過 | Grafana アラート + 負荷試験 (P9) で事前検証 |
| 市区町村マッピングデータの差分（JMA パラメータ更新） | 既存パラメータ更新フロー（`parameter/earthquake.bin`）に同期 |
