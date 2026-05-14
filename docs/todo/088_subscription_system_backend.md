# バックエンド: サブスクリプション基盤 / デバイス認証リワーク

**作成日**: 2026-05-15
**対象ブランチ**: develop
**ステータス**: 設計完了 / 実装未着手
**関連**: [089_subscription_system_app.md](./089_subscription_system_app.md)（アプリ側仕様）

---

## 背景

EQMonitor にサブスクリプション機能を導入する。同時に、現状のデバイス認証モデルを改修して、サブスク機能の前提となる **デバイス本人性証明** を成立させる。

### 現状の問題

1. **デバイス ID がクライアント生成**: アプリが `SHA512(UDID) → UUID` 形式で生成・送信。UDID が漏れれば誰でも同じ ID を計算でき、なりすまし可能。
2. **認証ヘッダーが「知識」**: `x-eqmonitor-device-id` は秘密値ではなく ID そのもの。本人性証明として弱い。
3. **App Check に依存しすぎ**: WebSocket チケット取得時にも毎回 App Check Token が必要。App Check は「正規アプリからの呼び出し」の保証用途であり、デバイス個別の認証手段ではない。
4. **特定ユーザー向けの登録ルートがない**: 開発者と直接やりとりするテスター等を App Check なしで登録する手段がない。

### 本タスクで実現すること

- **サーバー発行のデバイス ID**: 推測・偽造不能な ID
- **JWT による Bearer 認証**: 標準的な認証方式に移行
- **チャレンジ・レスポンス登録パス**: 開発者承認制のサブルート
- **RevenueCat 連携によるサブスク管理**: webhook 駆動で `subscriptions` テーブル更新
- **将来の OAuth 連携の余地**: `users` テーブルを先に用意

---

## 要件

### 機能要件

1. **デバイス登録（通常パス）**: アプリから `X-Firebase-AppCheck` Limited-Use Token 付きで `POST /v2/device` → サーバが UUID v7 を発行 → JWT を返す
2. **デバイス登録（チャレンジパス）**: アプリから `POST /v2/device/challenge` でコード取得 → 管理者 CLI で response 確認 → アプリから code+response 付きで `POST /v2/device` → JWT 発行
3. **デバイス認証**: 以降のすべての device-scoped API は `Authorization: Bearer <JWT>` で認証
4. **WebSocket チケット**: App Check 不要、Bearer JWT のみで発行
5. **RevenueCat Webhook**: 課金イベントを受信して `subscriptions` テーブルを更新
6. **サブスク状態確認**: 認証された API で現在のサブスク状態を取得可能
7. **管理者 CLI**: チャレンジ発行・確認、デバイス管理（強制 revoke）

### 非機能要件

- **冪等性**: 同一チャレンジペアでの登録は1回限り。再送は 409
- **失効可能性**: JWT は `token_version` で revoke 可能（DB の `devices.token_version` インクリメントで全トークン無効化）
- **レート制限**: チャレンジ発行エンドポイントは IP 単位でレート制限（DoS 防止）
- **監査ログ**: 登録・revoke・チャレンジ消費は構造化ログに残す
- **後方互換性なし**: アプリは未リリースのため、既存の `PUT /v2/device/{id}` 系 API は撤去してよい
- **既存データ無視**: 既存の `devices` テーブルは TRUNCATE して再構築可能

---

## 設計判断（確定事項）

| # | 決定事項 | 理由 |
|---|---|---|
| 1 | デバイス ID 生成はサーバー側（UUID v7） | クライアント側生成は推測可能で本人性証明にならない。v7 は時系列ソート可能 |
| 2 | デバイストークンは JWT（HS256） | 自己完結・検証が DB なしで可能。`ver` で revoke を実現 |
| 3 | JWT に有効期限を設けない（長期トークン） | UX を優先。失効は `token_version` で対応 |
| 4 | JWT 失効方式: `token_version` のインクリメント | `jti` ブロックリストより DB 負荷が低い（1 行更新だけで全トークン無効） |
| 5 | チャレンジ・レスポンス両方をサーバーで生成 | response を admin が考える必要なし、衝突回避もサーバー側で完結 |
| 6 | チャレンジ文字列: 6 文字、`23456789ABCDEFGHJKMNPQRSTUVWXYZ` | 紛らわしい文字（0/O, 1/I/L）を除外、Slack で送信しやすい |
| 7 | 認証エンドポイントの URL から `{deviceId}` を撤去し `/me` に統一 | JWT から device 特定できるので URL に乗せる必要がない、安全性も向上 |
| 8 | RevenueCat の `app_user_id` = `deviceId` | サブスクをデバイスに紐付け。将来 OAuth 連携時に `userId` に切替予定 |
| 9 | サブスク確認は毎リクエスト DB クエリ | JWT 埋め込みより最新性を優先。認証チェックと同一クエリで実行 |
| 10 | 認証 + サブスク確認を 1 クエリで | `devices LEFT JOIN subscriptions` で 1 ラウンドトリップに |
| 11 | RevenueCat webhook の冪等性: `event_id` を持つレコード重複検出 | RC が再送する可能性がある |
| 12 | `users` テーブルは先に作るが今期は使わない | OAuth 連携時のスキーマ変更を最小化 |
| 13 | 既存 `PUT /v2/device/{id}` `GET /v2/device/{id}` `DELETE /v2/device/{id}` `/migrate` は削除 | 後方互換不要、メソッドと URL 設計を刷新 |
| 14 | App Check は「初回登録時の bot 排除」用途のみ | 登録後のリクエストは JWT 単独で認証 |

---

## API 仕様

### 認証区分

| 区分 | ヘッダー | 用途 |
|---|---|---|
| Public | なし | チャレンジ発行・ヘルスチェック |
| AppCheck | `X-Firebase-AppCheck: <LUT>` | デバイス登録（通常パス） |
| Challenge | `X-Challenge-Code: <code>` + `X-Challenge-Response: <resp>` | デバイス登録（チャレンジパス） |
| Bearer | `Authorization: Bearer <JWT>` | 登録後のすべての API |
| Webhook | RevenueCat 署名 | `POST /webhooks/revenuecat` |
| Admin | 環境変数の管理者トークン or mTLS | Admin API（CLI から呼ぶ） |

### エンドポイント一覧

#### `POST /v2/device/challenge`

**認証**: Public（IP レート制限あり）

**Request**: ボディなし

**Response 201**:
```json
{
  "challengeCode": "A3K9P2",
  "expiresAt": "2026-05-16T12:00:00Z"
}
```

**振る舞い**:
1. `code` (6文字) と `response` (6文字) を crypto.randomInt で生成
2. `device_challenges` に INSERT（`expires_at = now() + 24h`）
3. `code` のみクライアントに返す
4. レート制限: 1 IP あたり 10 req / 10min（429 を返す）

**エラー**:
- 429: レート制限超過

---

#### `POST /v2/device`

**認証**: AppCheck **OR** Challenge

**Request**:
```http
POST /v2/device
X-Firebase-AppCheck: <LUT>                   # AppCheck パスの場合
# または
X-Challenge-Code: A3K9P2                     # Challenge パスの場合
X-Challenge-Response: X7M4QR

Content-Type: application/json

{
  "type": "IOS",                             # IOS | ANDROID
  "locale": "ja"                             # ja | en | zh（オプション、デフォルト ja）
}
```

**Response 201**:
```json
{
  "deviceId": "01976d8e-7d12-7000-8000-1234567890ab",
  "deviceToken": "<JWT 文字列>",
  "expiresAt": null
}
```

**振る舞い**:
1. 認証ヘッダーから登録パスを判定
   - AppCheck パス: `X-Firebase-AppCheck` を Firebase Admin SDK で検証（Replay Protection 有効）
   - Challenge パス: `device_challenges` テーブルで `code = ? AND response = ? AND used_at IS NULL AND expires_at > now()` を検証
2. `devices` テーブルに INSERT
   - `id`: UUID v7 生成
   - `registration_type`: `app_check` or `challenge`
   - `token_version`: 1
3. Challenge パスの場合は `device_challenges.used_at`, `used_by_device_id` を更新
4. JWT 発行（claims は後述）
5. レスポンスを返す

**エラー**:
- 400: ボディ不正
- 401: AppCheck 検証失敗
- 403: Challenge 不一致 or 期限切れ or 使用済み
- 429: レート制限

---

#### `GET /v2/device/me`

**認証**: Bearer

**Response 200**:
```json
{
  "id": "01976d8e-7d12-7000-8000-1234567890ab",
  "type": "IOS",
  "locale": "ja",
  "registrationType": "app_check",
  "userId": null,
  "createdAt": "2026-05-15T10:00:00Z",
  "updatedAt": "2026-05-15T10:00:00Z"
}
```

---

#### `PATCH /v2/device/me/fcm`

**認証**: Bearer

**Request**:
```json
{ "token": "fcm-token-string" }
```

**Response 204**: 空ボディ

---

#### `PATCH /v2/device/me/apns/{kind}`

**認証**: Bearer

**Path Parameter**: `kind` = `notification` | `liveActivityStart`

**Request**:
```json
{ "token": "apns-token-string" }
```

**Response 204**: 空ボディ

---

#### `DELETE /v2/device/me`

**認証**: Bearer

**振る舞い**:
1. `devices.token_version` をインクリメント（既存 JWT を無効化）
2. 関連レコード（通知設定、subscription 等）を削除
3. デバイス自体も削除（または `deleted_at` を立てる）

**Response 204**: 空ボディ

---

#### `GET /v2/realtime/ticket`

**認証**: Bearer

（App Check ヘッダーは不要）

**Response 200**:
```json
{
  "url": "wss://...",
  "expiresAt": "2026-05-15T10:01:00Z",
  "issuedAt": "2026-05-15T10:00:00Z"
}
```

---

#### `GET /v2/subscription/me`

**認証**: Bearer

**Response 200（アクティブ時）**:
```json
{
  "status": "active",
  "productId": "premium_monthly",
  "expiresAt": "2026-06-15T10:00:00Z",
  "willRenew": true
}
```

**Response 200（非アクティブ時）**:
```json
{
  "status": "inactive"
}
```

**振る舞い**: 認証ミドルウェアで取得済みのサブスク情報をそのまま返す（追加クエリ不要）

---

#### `POST /webhooks/revenuecat`

**認証**: RevenueCat の Webhook Authorization ヘッダー（共有秘密 or 署名）

**Request**: RevenueCat 形式の event payload

**Response 200**: 空ボディ（RC 側は 200 以外を受け取ると再送する）

**振る舞い**: 後述「RevenueCat 統合」参照

---

#### Admin API: `POST /admin/challenges`（CLI 用）

**認証**: Admin Token

**Response 200**:
```json
{
  "pending": [
    {
      "code": "A3K9P2",
      "response": "X7M4QR",
      "createdAt": "2026-05-15T10:00:00Z",
      "expiresAt": "2026-05-16T10:00:00Z"
    }
  ]
}
```

CLI から `pending` 一覧を取得して response を確認する。

---

#### Admin API: `DELETE /admin/devices/{id}`（CLI 用）

**認証**: Admin Token

**振る舞い**: `token_version` をインクリメントして強制 revoke

---

## データモデル

### マイグレーション方針

既存テーブル（`devices`, `devices_*_settings`）はすべて DROP して再作成する。アプリ未リリースのため後方互換不要。

### スキーマ

```sql
-- 既存テーブル (簡略表示、再作成)
CREATE TABLE devices (
  id                  UUID PRIMARY KEY DEFAULT uuid_generate_v7(),
  token_version       INT NOT NULL DEFAULT 1,
  registration_type   TEXT NOT NULL CHECK (registration_type IN ('app_check', 'challenge')),
  user_id             UUID REFERENCES users(id),                      -- 将来の OAuth 連携用、nullable
  type                TEXT NOT NULL CHECK (type IN ('IOS', 'ANDROID')),
  locale              TEXT NOT NULL DEFAULT 'ja',
  fcm_token           TEXT,
  apns_notification_token TEXT,
  apns_live_activity_start_token TEXT,
  created_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at          TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE INDEX idx_devices_user_id ON devices(user_id) WHERE user_id IS NOT NULL;

-- 新規: チャレンジ・レスポンステーブル
CREATE TABLE device_challenges (
  id                  UUID PRIMARY KEY DEFAULT uuid_generate_v7(),
  code                TEXT NOT NULL UNIQUE,
  response            TEXT NOT NULL,
  expires_at          TIMESTAMPTZ NOT NULL,
  used_at             TIMESTAMPTZ,
  used_by_device_id   UUID REFERENCES devices(id),
  created_at          TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE INDEX idx_device_challenges_code_active
  ON device_challenges(code)
  WHERE used_at IS NULL;

-- 新規: ユーザーテーブル（OAuth 連携用、今期は空のまま）
CREATE TABLE users (
  id                  UUID PRIMARY KEY DEFAULT uuid_generate_v7(),
  google_sub          TEXT UNIQUE,
  apple_sub           TEXT UNIQUE,
  email               TEXT,
  created_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at          TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- 新規: サブスクリプションテーブル
CREATE TABLE subscriptions (
  id                       UUID PRIMARY KEY DEFAULT uuid_generate_v7(),
  device_id                UUID REFERENCES devices(id) ON DELETE CASCADE,
  user_id                  UUID REFERENCES users(id) ON DELETE CASCADE,
  revenuecat_customer_id   TEXT NOT NULL,
  product_id               TEXT NOT NULL,
  status                   TEXT NOT NULL CHECK (status IN ('active', 'expired', 'cancelled', 'grace_period', 'pending')),
  expires_at               TIMESTAMPTZ,
  raw_event                JSONB,
  created_at               TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at               TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  CONSTRAINT subscription_owner_xor CHECK (
    (device_id IS NOT NULL AND user_id IS NULL) OR
    (device_id IS NULL AND user_id IS NOT NULL)
  )
);
CREATE INDEX idx_subscriptions_device_id ON subscriptions(device_id);
CREATE INDEX idx_subscriptions_user_id ON subscriptions(user_id);
CREATE INDEX idx_subscriptions_rc_customer ON subscriptions(revenuecat_customer_id);

-- 新規: RevenueCat イベント冪等性管理
CREATE TABLE revenuecat_events (
  event_id            TEXT PRIMARY KEY,            -- RC から送られる event.id
  event_type          TEXT NOT NULL,
  raw_payload         JSONB NOT NULL,
  processed_at        TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
```

### 既存テーブルとの統合

既存の `devices_earthquake_settings`, `devices_eew_settings`, `devices_notification_settings` は新 `devices.id` を FK にしたまま再作成（中身は空から始まる）。

---

## JWT 設計

### Claims

```json
{
  "sub": "device:01976d8e-7d12-7000-8000-1234567890ab",
  "iat": 1747300000,
  "ver": 1,
  "jti": "01976d8e-7d12-7000-8000-fedcba987654"
}
```

| Claim | 内容 |
|---|---|
| `sub` | `device:<UUID>` 形式。将来 `user:<UUID>` も対応 |
| `iat` | 発行時刻（unix） |
| `ver` | `devices.token_version` の値。失効判定に使う |
| `jti` | JWT 個別 ID（監査ログ用、必須ではないが付ける） |

**有効期限 (`exp`) なし**: 長期トークン。失効は `ver` 不一致で検出。

### 署名

- アルゴリズム: **HS256**（共有秘密での署名）
- 秘密鍵: 環境変数 `JWT_SIGNING_SECRET`（32 バイト以上のランダム文字列）
- 鍵ローテーション: 当初は考慮せず。必要になったら `kid` claim 導入

### 検証フロー

```typescript
async function authenticateBearer(token: string): Promise<AuthContext> {
  // 1. JWT 署名検証
  const payload = jwt.verify(token, JWT_SIGNING_SECRET) as JwtPayload;

  // 2. sub から deviceId 抽出
  const deviceId = payload.sub.replace(/^device:/, '');

  // 3. devices + subscriptions を 1 クエリで取得
  const row = await db.query(`
    SELECT
      d.id, d.token_version, d.user_id, d.type, d.locale,
      s.status AS sub_status, s.expires_at AS sub_expires_at,
      s.product_id AS sub_product_id
    FROM devices d
    LEFT JOIN subscriptions s
      ON s.device_id = d.id
      AND s.status IN ('active', 'grace_period')
      AND (s.expires_at IS NULL OR s.expires_at > NOW())
    WHERE d.id = $1
    LIMIT 1
  `, [deviceId]);

  // 4. デバイス存在チェック
  if (!row) throw new UnauthorizedError('device_not_found');

  // 5. token_version 一致チェック
  if (row.token_version !== payload.ver) {
    throw new UnauthorizedError('token_revoked');
  }

  return {
    device: { id: row.id, type: row.type, locale: row.locale, userId: row.user_id },
    subscription: row.sub_status ? {
      status: row.sub_status,
      expiresAt: row.sub_expires_at,
      productId: row.sub_product_id,
    } : null,
  };
}
```

---

## チャレンジ・レスポンスフロー

### 全体シーケンス

```
[ユーザー]                    [アプリ]                    [サーバー]                [管理者(あなた)]
   |                              |                              |                              |
   |  チャレンジ登録 UI 開く        |                              |                              |
   |--------------------------->  |                              |                              |
   |                              |  POST /v2/device/challenge   |                              |
   |                              |--------------------------->  |                              |
   |                              |                              | code,resp 生成・DB INSERT    |
   |                              |  { challengeCode: "A3K9P2" } |                              |
   |                              |  <---------------------------|                              |
   |  "A3K9P2 を送ってください"      |                              |                              |
   |  <---------------------------|                              |                              |
   |  "A3K9P2" を Slack で送る                                                                  |
   |  ----------------------------------------------------------->-----------------------------> |
   |                                                              |                              |
   |                                                              |   CLI: challenge get A3K9P2  |
   |                                                              |  <---------------------------|
   |                                                              |   "response: X7M4QR"         |
   |                                                              |  --------------------------->|
   |                                                              |                              |
   |  "X7M4QR を入力してください" を Slack で受信                                                  |
   |  <-----------------------------------------------------------------------------------------|
   |                              |                              |                              |
   |  "X7M4QR" を入力              |                              |                              |
   |--------------------------->  |                              |                              |
   |                              |  POST /v2/device              |                              |
   |                              |   X-Challenge-Code: A3K9P2   |                              |
   |                              |   X-Challenge-Response: X7M4QR                              |
   |                              |--------------------------->  |                              |
   |                              |                              | code+resp 検証・used_at 更新 |
   |                              |                              | device INSERT・JWT 発行       |
   |                              |  { deviceId, deviceToken }   |                              |
   |                              |  <---------------------------|                              |
   |  登録完了                     |                              |                              |
   |  <---------------------------|                              |                              |
```

### コード生成

```typescript
const ALPHABET = '23456789ABCDEFGHJKMNPQRSTUVWXYZ'; // 紛らわしい文字を除外（31 chars）

function generateChallengeString(length = 6): string {
  return Array.from({ length }, () =>
    ALPHABET[crypto.randomInt(ALPHABET.length)]
  ).join('');
}
```

エントロピー: `31^6 ≈ 8.87 億通り`。チャレンジ + レスポンスのペアで `31^12 ≈ 7.9 × 10^17`。24h 有効、レート制限あり、3 回試行で失敗時にチャレンジ無効化するなら十分。

### 衝突回避

`code` に UNIQUE 制約を付与。INSERT 失敗時は再生成して最大 3 回リトライ。

### 期限切れと使用済みの掃除

24h を超えた `device_challenges` レコードは cron で削除（任意）。

---

## RevenueCat 統合

### 設計方針

- **アプリ ↔ RC 間**: アプリは RC SDK で直接購入処理。サーバーは関与しない
- **RC ↔ サーバー間**: webhook で `subscriptions` テーブルを更新
- **`app_user_id` の規約**: `deviceId`（UUID 文字列そのまま）
- **将来の OAuth 連携時**: アプリ側で `Purchases.logIn(userId)` を呼び出す → RC の alias 機能で `deviceId` と紐付け → サーバー側は `user_id` ベースで管理

### Webhook ハンドラ

```typescript
// POST /webhooks/revenuecat
app.post('/webhooks/revenuecat', async (req, res) => {
  // 1. 署名検証
  const auth = req.headers.authorization;
  if (auth !== `Bearer ${env.REVENUECAT_WEBHOOK_SECRET}`) {
    return res.status(401).send();
  }

  const event = req.body.event;

  // 2. 冪等性チェック
  const exists = await db.query(
    'SELECT 1 FROM revenuecat_events WHERE event_id = $1',
    [event.id]
  );
  if (exists) return res.status(200).send();

  // 3. デバイス特定
  const deviceId = event.app_user_id;
  const device = await db.findDevice(deviceId);
  if (!device) {
    // 未登録 device_id（先にアプリで logIn した直後の RC イベントなど）
    // → 一旦無視してログだけ残す
    logger.warn('revenuecat_event_for_unknown_device', { event });
    await recordEvent(event);
    return res.status(200).send();
  }

  // 4. イベントに応じて subscriptions 更新
  switch (event.type) {
    case 'INITIAL_PURCHASE':
    case 'RENEWAL':
    case 'PRODUCT_CHANGE':
    case 'UNCANCELLATION':
      await upsertSubscription(device.id, {
        revenuecatCustomerId: event.app_user_id,
        productId: event.product_id,
        status: 'active',
        expiresAt: new Date(event.expiration_at_ms),
        rawEvent: event,
      });
      break;

    case 'CANCELLATION':
      // ユーザーが解約したが期限内はまだ active
      await updateSubscription(device.id, {
        status: 'active',  // 期限到達まで active のまま
        rawEvent: event,
      });
      break;

    case 'EXPIRATION':
      await updateSubscription(device.id, {
        status: 'expired',
        rawEvent: event,
      });
      break;

    case 'BILLING_ISSUE':
      await updateSubscription(device.id, {
        status: 'grace_period',
        rawEvent: event,
      });
      break;

    case 'SUBSCRIPTION_PAUSED':
      await updateSubscription(device.id, {
        status: 'pending',
        rawEvent: event,
      });
      break;
  }

  await recordEvent(event);
  res.status(200).send();
});
```

### 扱うイベントタイプ

| RC Event | 結果ステータス | 備考 |
|---|---|---|
| `INITIAL_PURCHASE` | `active` | 初回購入 |
| `RENEWAL` | `active` | 更新 |
| `PRODUCT_CHANGE` | `active` | プラン変更 |
| `UNCANCELLATION` | `active` | 解約取り消し |
| `CANCELLATION` | `active`（期限まで） | 解約予定 |
| `EXPIRATION` | `expired` | 期限切れ |
| `BILLING_ISSUE` | `grace_period` | 支払い問題、猶予期間中 |
| `SUBSCRIPTION_PAUSED` | `pending` | 一時停止 |
| `TRANSFER` | （個別判断） | RevenueCat ID 移行（OAuth 連携時に重要） |

### Webhook 設定

- RevenueCat ダッシュボードで webhook URL を `https://api.eqmonitor.app/webhooks/revenuecat` に設定
- Authorization ヘッダー: `Bearer <REVENUECAT_WEBHOOK_SECRET>`
- リトライ: RC 側で 200 以外なら指数バックオフで再送される

---

## 管理者 CLI

### コマンド一覧

```bash
# チャレンジ管理
eqmonitor-admin challenge list                   # 未使用のチャレンジ一覧表示
eqmonitor-admin challenge get <code>              # 特定コードの response を取得
eqmonitor-admin challenge expire <code>           # チャレンジを手動失効
eqmonitor-admin challenge cleanup                 # 期限切れチャレンジを削除

# デバイス管理
eqmonitor-admin device list [--type IOS|ANDROID]  # デバイス一覧
eqmonitor-admin device get <device-id>            # デバイス詳細
eqmonitor-admin device revoke <device-id>         # JWT を失効（token_version インクリメント）
eqmonitor-admin device delete <device-id>         # デバイス削除

# サブスクリプション管理
eqmonitor-admin subscription list <device-id>     # 指定デバイスのサブスク履歴
eqmonitor-admin subscription grant <device-id> --product-id <id> --expires <ISO8601>
                                                   # 手動付与（テスト用、後述）
```

### 実装方針

- TypeScript で実装
- Admin API（`/admin/*`）を `localhost` または mTLS でのみ受け付ける
- CLI 実体は API ラッパー

### Slack 通知（オプション）

新規チャレンジが INSERT されたら、Slack の admin チャンネルに通知を投稿:

```
新規チャレンジ:
  code: A3K9P2
  response: X7M4QR
  expiresAt: 2026-05-16 12:00 JST
```

これでユーザーから `A3K9P2 です` と言われたら、Slack で検索して response を送るだけになる。

---

## エラーハンドリング

### HTTP ステータスコードの規約

| Status | 用途 |
|---|---|
| 200 | 通常成功 |
| 201 | リソース作成成功（デバイス登録、チャレンジ発行） |
| 204 | 成功・レスポンスボディなし |
| 400 | リクエスト形式不正（バリデーション失敗） |
| 401 | JWT 不正 / 期限切れ / `token_version` 不一致 / App Check 失敗 |
| 403 | チャレンジ不一致 / 期限切れ / 使用済み |
| 404 | リソースが存在しない |
| 409 | 冪等性違反（チャレンジ二重消費など） |
| 422 | バリデーション失敗（型は正しいが意味的に不正） |
| 429 | レート制限 |
| 5xx | サーバーエラー |

### エラーレスポンス形式

```json
{
  "error": {
    "code": "challenge_invalid",
    "message": "Challenge code and response do not match or have expired."
  }
}
```

### エラーコード（`error.code`）一覧

| Code | HTTP | 意味 |
|---|---|---|
| `app_check_invalid` | 401 | App Check token 検証失敗 |
| `challenge_invalid` | 403 | チャレンジペア不一致・期限切れ・使用済み |
| `device_not_found` | 401 | JWT の sub が存在しない |
| `token_revoked` | 401 | `token_version` 不一致 |
| `token_invalid` | 401 | JWT 署名検証失敗 |
| `validation_error` | 400/422 | ボディ・パラメータ検証失敗 |
| `rate_limited` | 429 | レート制限 |
| `internal_error` | 500 | サーバー内部エラー |

---

## 実装フェーズ

| Phase | 内容 | 依存 |
|---|---|---|
| **B1. DB スキーマ** | `devices` 改修、`device_challenges` / `users` / `subscriptions` / `revenuecat_events` テーブル作成。既存 `devices_*_settings` 系の FK 張り直し | なし |
| **B2. JWT 基盤** | `JWT_SIGNING_SECRET` 環境変数、jwt 発行・検証ユーティリティ、Bearer ミドルウェア（`AuthContext` を req に注入） | B1 |
| **B3. POST /v2/device（AppCheck パス）** | エンドポイント実装、AppCheck Token 検証（既存ロジック流用）、UUID v7 発行、JWT 発行 | B2 |
| **B4. チャレンジ機構** | `POST /v2/device/challenge` 実装、`POST /v2/device` の Challenge パス追加、Admin API（`POST /admin/challenges`, `GET /admin/challenges`, `DELETE /admin/challenges/{code}`） | B2, B3 |
| **B5. /me 系エンドポイント** | `GET /v2/device/me`、`PATCH /v2/device/me/fcm`、`PATCH /v2/device/me/apns/{kind}`、`DELETE /v2/device/me` | B2 |
| **B6. 既存エンドポイント撤去** | `PUT /v2/device/{id}` 系、`/migrate`、レガシー認証ヘッダー（`x-eqmonitor-device-id`）を削除 | B5 |
| **B7. WebSocket チケット Bearer 化** | `GET /v2/realtime/ticket` の AppCheck 検証を外し、Bearer 認証に切替 | B2 |
| **B8. Admin CLI** | TypeScript で `eqmonitor-admin` 実装、Admin API 経由でチャレンジ・デバイス操作 | B4 |
| **B9. Slack 通知** | チャレンジ INSERT 時の Slack 通知（任意、運用補助） | B4 |
| **B10. RevenueCat Webhook** | `POST /webhooks/revenuecat` 実装、イベント別の `subscriptions` 更新ロジック、冪等性 (`revenuecat_events`)、署名検証 | B1 |
| **B11. サブスク確認 API** | `GET /v2/subscription/me`、Bearer ミドルウェアで取得済みのサブスク情報を返す | B2, B10 |
| **B12. プレミアム機能ガード** | プレミアム対象 API に `requireActiveSubscription` ミドルウェア追加 | B11 |
| **B13. テスト・ドキュメント整備** | OpenAPI スキーマ更新、E2E テスト追加、README 更新 | B1-B12 |

---

## レート制限設計

| エンドポイント | 制限 | 単位 |
|---|---|---|
| `POST /v2/device/challenge` | 10 / 10min | IP |
| `POST /v2/device` (AppCheck) | 5 / 1min | IP |
| `POST /v2/device` (Challenge) | 3 / 1min | IP |
| `GET /v2/realtime/ticket` | 60 / 1min | device |
| その他 | 300 / 1min | device |

実装: Redis or in-memory token bucket。

---

## セキュリティ考慮事項

1. **JWT secret 漏洩リスク**: 漏洩した場合、全 JWT が無効化される必要がある → `JWT_SIGNING_SECRET` をローテーションしてサーバー再起動。全デバイスは 401 を受け取り再登録（→ アプリ側でクレデンシャル消去フロー発動）
2. **チャレンジコードのブルートフォース**: `31^12 ≈ 7.9 × 10^17`通り。レート制限と期限で十分対応可能
3. **App Check Limited-Use Token のリプレイ攻撃**: Firebase Admin SDK が Replay Protection 機能で対応（同一 LUT を 2 度使えない）
4. **デバイストークン盗難**: jailbreak/root 端末では Keychain/Keystore から抽出可能。アプリ側で OS の attestation を強化、必要なら追加 App Check 検証を特定エンドポイントで実施
5. **RevenueCat Webhook 偽装**: `Authorization: Bearer <REVENUECAT_WEBHOOK_SECRET>` 検証で防止。secret は環境変数で管理
6. **管理者 API への不正アクセス**: Admin Token を別環境変数で管理、できれば mTLS で保護、ネットワーク的にも localhost or VPN 内に限定

---

## オープン項目

- **JWT 秘密鍵のローテーション戦略**: `kid` claim を入れて複数鍵対応にするか、運用上必要になるまで保留か
- **macOS / Web プラットフォーム**: `devices.type` に `MACOS` / `WEB` を追加するか、当面 iOS/Android のみとするか
- **サブスク手動付与（運用補助）**: テスター・関係者にサブスクを手動で付与する仕組みの粒度（永続 vs 期限付き）
- **Subscription Tier**: 無料/プレミアムの2段階で十分か、将来複数 tier を想定するか（DB 上は `product_id` で表現可能）
- **RevenueCat の `TRANSFER` イベント**: OAuth 連携時のデバイス→ユーザー移行をどう RC 側で扱うか

---

## 参考リンク

- 既存 `device_repository.dart`: `app/lib/feature/devices/data/repository/device_repository.dart`
- AppCheck Interceptor: `app/lib/core/provider/interceptor/app_check_interceptor.dart`
- 既存 DB スキーマ: `supabase/migrations/20250129155929_remote_schema.sql`
- RevenueCat Webhooks docs: https://www.revenuecat.com/docs/webhooks
- App Check Limited-Use Tokens: https://firebase.google.com/docs/app-check/custom-resource-backend
