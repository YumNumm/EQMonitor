# Notification Backend Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 緊急地震速報（警報）の現在地・全国一致を区別して正しいAPNs割り込みレベルとAndroid Channelへ送り、backendが生成し得るFCM通知を意味別Channelへ振り分ける。

**Architecture:** `device_eew_warning_config` に現在地レベルを追加し、警報マッチ結果とRedis通知済み状態に一致元を保持する。FCMビルダーにはChannel IDと配送priorityを明示的に渡し、Appleの割り込みレベルやsoundからAndroid表示設定を推測しない。

**Tech Stack:** TypeScript 6、Hono、Valibot、Drizzle ORM/PostgreSQL、Redis、Firebase Admin互換payload、Vitest、pnpm。

## Global Constraints

- 現在地の割り込みレベルは `passive` / `active` / `time_sensitive` / `critical`、既定値は `critical`。
- 全国の割り込みレベルは `passive` / `active` / `time_sensitive` のみで、`critical` はAPI・DBで拒否する。
- 現在地と全国が重複した場合は必ず現在地を優先する。
- 全国通知済みから現在地一致へ変わった続報は、新規の現在地警報として昇格配信する。
- FCMの配送priorityとAndroid Channelの表示importanceは独立させる。
- FCM payloadに音を指定せず、Androidの音・バイブレーションはChannelへ委ねる。
- Webhookの任意Channel ID契約は変更しない。
- App/backend横断契約テスト、段階切り替え、旧アプリversion gateは追加しない。
- backendリポジトリ内の変更はbackend専用ブランチへコミット・pushし、backend PRを作成する。

---

### Task 1: EEW警報設定のDB・API契約

**Files:**
- Modify: `backend/packages/database/src/schema/schema.ts`
- Create: `backend/packages/database/drizzle/<generated>/migration.sql`
- Modify: `backend/api/api/src/features/device/model/slot-requests.ts`
- Modify: `backend/api/api/src/features/device/model/slot-responses.ts`
- Modify: `backend/api/api/src/features/device/datasource/slot-datasource.ts`
- Modify: `backend/api/api/src/features/device/routes/settings/eew-warning.ts`
- Test: `backend/api/api/test/device/eew-warning-routes.test.ts`
- Regenerate: `backend/api/api/openapi.json`

**Interfaces:**
- Produces: `current_location_interruption_level: 'passive' | 'active' | 'time_sensitive' | 'critical'`。
- Produces: `nationwide_interruption_level: 'passive' | 'active' | 'time_sensitive' | null`。

- [ ] **Step 1: APIルートの失敗テストを追加する**

```ts
it('defaults current location to critical', async () => {
  const res = await app.request('/');
  expect(await res.json()).toMatchObject({
    target: 'current_location_only',
    current_location_interruption_level: 'critical',
    nationwide_interruption_level: null,
  });
});

it('accepts time_sensitive nationwide and rejects critical', async () => {
  const accepted = await patch({
    target: 'current_location_and_nationwide',
    current_location_interruption_level: 'active',
    nationwide_interruption_level: 'time_sensitive',
  });
  expect(accepted.status).toBe(200);
  const rejected = await patch({ nationwide_interruption_level: 'critical' });
  expect(rejected.status).toBe(400);
});
```

- [ ] **Step 2: テストが現行契約で失敗することを確認する**

Run: `cd backend && pnpm --filter @eqmonitor-backend/api test -- test/device/eew-warning-routes.test.ts`

Expected: `current_location_interruption_level` 不在または `time_sensitive` のvalidation失敗でFAIL。

- [ ] **Step 3: schema・datasource・routeを最小実装する**

`deviceEewWarningConfig` に次を追加する。

```ts
currentLocationInterruptionLevel: interruptionLevelEnum(
  'current_location_interruption_level',
).default('critical').notNull(),
```

CHECK制約は次の不変条件にする。

```sql
current_location_interruption_level IN
  ('passive', 'active', 'time_sensitive', 'critical')
AND (
  (target = 'current_location_only' AND nationwide_interruption_level IS NULL)
  OR
  (target = 'current_location_and_nationwide' AND
   nationwide_interruption_level IN ('passive', 'active', 'time_sensitive'))
)
```

routeのGETは未作成設定を `critical` / `null` で返し、PATCHは既存値と部分更新をマージしてから同じ不変条件を検証する。datasourceの入力型とupsert対象にも両フィールドを含める。

- [ ] **Step 4: Drizzle migrationとOpenAPIを生成する**

Run: `cd backend && pnpm --filter @eqmonitor-backend/database drizzle-kit:generate`

Expected: 新migrationが列追加、既存CHECK削除、新CHECK追加を含む。

Run: `cd backend/api/api && pnpm -s generate:openapi > openapi.json`

Expected: request/response schemaに現在地レベルがあり、全国enumに `time_sensitive` があり `critical` がない。

- [ ] **Step 5: API・DBテストと型検査を通す**

Run: `cd backend && pnpm --filter @eqmonitor-backend/api test -- test/device/eew-warning-routes.test.ts`

Run: `cd backend && pnpm --filter @eqmonitor-backend/api type-check`

Run: `cd backend && pnpm --filter @eqmonitor-backend/database check-types`

Expected: すべて成功。

- [ ] **Step 6: コミットする**

```bash
git -C backend add packages/database/src/schema/schema.ts packages/database/drizzle api/api/src/features/device api/api/test/device/eew-warning-routes.test.ts api/api/openapi.json
git -C backend commit -m "Feat: EEW警報の現在地配信レベルを追加"
```

---

### Task 2: EEW予報しきい値のslot別制約

**Files:**
- Modify: `backend/packages/database/src/schema/schema.ts`
- Modify: `backend/packages/database/drizzle/<Task 1 generated>/migration.sql`
- Modify: `backend/api/api/src/features/device/model/slot-requests.ts`
- Modify: `backend/api/api/src/features/device/routes/settings/slots.ts`
- Test: `backend/api/api/test/device/notification-slots.test.ts`

**Interfaces:**
- Produces: `isAllowedEewMinIntensity(slotType, intensity): boolean`。

- [ ] **Step 1: slot別validationの失敗テストを書く**

```ts
it.each(['1', '2', '3'])('rejects %s for current location and region', async intensity => {
  expect((await putCurrentLocation({ eew_min_intensity: intensity })).status).toBe(400);
  expect((await createRegion({ eew_min_intensity: intensity })).status).toBe(400);
});

it.each(['1', '2', '3'])('accepts %s for nationwide', async intensity => {
  expect((await putNationwide({ eew_min_intensity: intensity })).status).toBe(200);
});
```

- [ ] **Step 2: 現行の共通JmaIntensity validatorで失敗することを確認する**

Run: `cd backend && pnpm --filter @eqmonitor-backend/api test -- test/device/notification-slots.test.ts`

Expected: 現在地・地域でも震度1〜3を受理してFAIL。

- [ ] **Step 3: slot別許可値と既存データ正規化を実装する**

```ts
const currentOrRegionEewValues = new Set([
  '0', '4', '5-', '5+', '6-', '6+', '7',
]);
const nationwideEewValues = new Set([
  '0', '1', '2', '3', '4', '5-', '5+', '6-', '6+', '7',
]);
```

singleton/region routeは部分更新後のslot typeと値で検証する。migrationには、制約追加前に次の決定的な移行を含める。

```sql
UPDATE device_notification_slots
SET eew_min_intensity = '0'
WHERE slot_type IN ('current_location', 'region')
  AND eew_min_intensity IN ('1', '2', '3');
```

DB CHECKにも同じ許可集合を記述し、APIを迂回した不正値を拒否する。

- [ ] **Step 4: API・DBテストを通す**

Run: `cd backend && pnpm --filter @eqmonitor-backend/api test -- test/device/notification-slots.test.ts`

Run: `cd backend && pnpm --filter @eqmonitor-backend/database test`

Expected: すべて成功。

- [ ] **Step 5: コミットする**

```bash
git -C backend add packages/database api/api/src/features/device/model/slot-requests.ts api/api/src/features/device/routes/settings/slots.ts api/api/test/device/notification-slots.test.ts
git -C backend commit -m "Fix: EEW予報しきい値を地域種別ごとに制約"
```

---

### Task 3: 警報一致元と優先順位

**Files:**
- Modify: `backend/service/notification-resolver/src/repository/device.ts`
- Modify: `backend/service/notification-resolver/src/handlers/eew/warning/device-matcher.ts`
- Test: `backend/service/notification-resolver/test/repository/device-pglite.integration.test.ts`
- Test: `backend/service/notification-resolver/src/handlers/eew/warning/__tests__/device-matcher.test.ts`

**Interfaces:**
- Produces: `EewWarningMatchSource = 'current_location' | 'nationwide'`。
- Produces: `EewWarningMatchedDevice.matchSource` と `interruptionLevel`。

- [ ] **Step 1: 順序非依存の現在地優先テストを書く**

```ts
it('prefers current location regardless of row order', () => {
  const preferred = selectPreferredWarningMatches([
    makeDevice({ matchSource: 'nationwide', interruptionLevel: 'active' }),
    makeDevice({ matchSource: 'current_location', interruptionLevel: 'critical' }),
  ]);
  expect(preferred).toEqual([
    expect.objectContaining({
      matchSource: 'current_location',
      interruptionLevel: 'critical',
    }),
  ]);
});
```

PGliteテストでは同一deviceを現在地と全国の両方に一致させ、返却が1件かつ `current_location` であることも検証する。

- [ ] **Step 2: 現行実装で失敗を確認する**

Run: `cd backend && pnpm --filter @eqmonitor-backend/notification-resolver test -- src/handlers/eew/warning/__tests__/device-matcher.test.ts test/repository/device-pglite.integration.test.ts`

Expected: `matchSource` 不在またはUNION順依存でFAIL。

- [ ] **Step 3: 一致行を明示し、現在地を決定的に優先する**

```ts
export type EewWarningMatchSource = 'current_location' | 'nationwide';

export interface EewWarningMatchedDevice {
  deviceId: string;
  locale: string;
  fcmToken: string | null;
  apnsToken: string | null;
  apnsEnvironment: string | null;
  matchSource: EewWarningMatchSource;
  interruptionLevel: 'passive' | 'active' | 'time_sensitive' | 'critical';
}
```

SQLの現在地SELECTにはリテラル `current_location` と `current_location_interruption_level`、全国SELECTには `nationwide` と `nationwide_interruption_level` を含める。重複解決はdevice ID単位で、現在地を全国より必ず優先する比較関数を使う。

- [ ] **Step 4: 対象テストと型検査を通す**

Run: `cd backend && pnpm --filter @eqmonitor-backend/notification-resolver test -- src/handlers/eew/warning/__tests__/device-matcher.test.ts test/repository/device-pglite.integration.test.ts`

Run: `cd backend && pnpm --filter @eqmonitor-backend/notification-resolver check-types`

Expected: すべて成功。

- [ ] **Step 5: コミットする**

```bash
git -C backend add service/notification-resolver/src/repository/device.ts service/notification-resolver/src/handlers/eew/warning service/notification-resolver/test/repository/device-pglite.integration.test.ts
git -C backend commit -m "Fix: EEW警報の現在地一致を優先"
```

---

### Task 4: 全国通知から現在地通知への昇格

**Files:**
- Modify: `backend/service/notification-resolver/src/repository/redis.ts`
- Modify: `backend/service/notification-resolver/src/handlers/eew/warning/device-matcher.ts`
- Test: `backend/service/notification-resolver/src/handlers/eew/warning/__tests__/device-matcher.test.ts`
- Create: `backend/service/notification-resolver/test/repository/redis-eew-warning-scope.test.ts`

**Interfaces:**
- Produces: `getEewWarningNotifiedScopes(eventId): Promise<Map<string, EewWarningMatchSource>>`。
- Produces: `setEewWarningNotifiedScopes(eventId, devices): Promise<void>`。

- [ ] **Step 1: partitionとRedisの失敗テストを書く**

```ts
it('promotes nationwide to a new current-location warning', () => {
  const result = partitionWarningDevices(
    [makeDevice({ matchSource: 'current_location' })],
    new Map([['dev1', 'nationwide']]),
  );
  expect(result.newDevices).toHaveLength(1);
  expect(result.updateDevices).toHaveLength(0);
});
```

Redisテストは `dev1 -> nationwide` と `dev2 -> current_location` を保存・復元し、15分TTLが設定されることを確認する。

- [ ] **Step 2: 現行Set実装で失敗を確認する**

Run: `cd backend && pnpm --filter @eqmonitor-backend/notification-resolver test -- src/handlers/eew/warning/__tests__/device-matcher.test.ts test/repository/redis-eew-warning-scope.test.ts`

Expected: scopeを保持できずFAIL。

- [ ] **Step 3: 専用Hashへscopeを保存する**

Redis keyは既存Setとの型衝突を避けるため `eew_warning_notified_scope_v2:{eventId}` とし、Hash fieldをdevice ID、valueをscopeにする。未知valueは無視せず警告可能なparse失敗として扱う。partitionは「未通知」または「nationwide→current_location」をnew、それ以外をupdateへ分ける。

- [ ] **Step 4: テストを通す**

Run: `cd backend && pnpm --filter @eqmonitor-backend/notification-resolver test -- src/handlers/eew/warning/__tests__/device-matcher.test.ts test/repository/redis-eew-warning-scope.test.ts`

Expected: すべて成功。

- [ ] **Step 5: コミットする**

```bash
git -C backend add service/notification-resolver/src/repository/redis.ts service/notification-resolver/src/handlers/eew/warning service/notification-resolver/test/repository/redis-eew-warning-scope.test.ts
git -C backend commit -m "Fix: EEW警報の配信範囲を追跡"
```

---

### Task 5: FCM Channelと配送priorityの明示契約

**Files:**
- Modify: `backend/packages/notification-message/src/constants.ts`
- Modify: `backend/packages/notification-message/src/types.ts`
- Modify: `backend/packages/notification-message/src/platform/fcm.ts`
- Modify: `backend/packages/notification-message/src/platform/message-builder.ts`
- Create: `backend/packages/notification-message/src/__tests__/fcm-channel.test.ts`

**Interfaces:**
- Produces: `NotificationChannel` の新semantic ID一覧。
- Produces: FCM用 `androidChannelId: NotificationChannel` と `androidDeliveryPriority: 'high' | 'normal'`。

- [ ] **Step 1: FCMビルダーの失敗テストを書く**

```ts
it('uses explicit channel and keeps delivery priority independent', () => {
  const message = buildFcmMessage({
    ...baseOptions,
    androidChannelId: 'eew_warning_nationwide',
    androidDeliveryPriority: 'high',
    interruptionLevel: 'passive',
    sound: 'eew_warning',
  });
  expect(message.android?.priority).toBe('high');
  expect(message.android?.notification?.channelId).toBe(
    'eew_warning_nationwide',
  );
  expect(message.notification).not.toHaveProperty('sound');
  expect(message.android?.notification).not.toHaveProperty('sound');
  expect(message.android?.notification).not.toHaveProperty('priority');
});
```

- [ ] **Step 2: 現行のinterruption推測とsound指定で失敗を確認する**

Run: `cd backend && pnpm --filter @eqmonitor-backend/notification-message test -- src/__tests__/fcm-channel.test.ts`

Expected: 明示Channelを受け取れず、soundまたはnotification priorityが残ってFAIL。

- [ ] **Step 3: semantic Channel定数と明示パラメータを実装する**

定数は設計書のIDをそのまま定義する。`buildFcmMessage` は `androidChannelId` をpayloadへコピーし、top-level `android.priority` だけに `androidDeliveryPriority` を設定する。FCMのnotification soundとper-message notification priorityは生成しない。APNsビルダーは従来どおりsoundとinterruption levelを使用する。

- [ ] **Step 4: パッケージテストと型検査を通す**

Run: `cd backend && pnpm --filter @eqmonitor-backend/notification-message test`

Run: `cd backend && pnpm --filter @eqmonitor-backend/notification-message build`

Expected: すべて成功。

- [ ] **Step 5: コミットする**

```bash
git -C backend add packages/notification-message/src
git -C backend commit -m "Refactor: FCMチャネルと配送優先度を分離"
```

---

### Task 6: 全通知生成経路のChannel振り分け

**Files:**
- Create: `backend/service/notification-resolver/src/shared/android-notification-routing.ts`
- Create: `backend/service/notification-resolver/src/shared/__tests__/android-notification-routing.test.ts`
- Modify: `backend/service/notification-resolver/src/handlers/eew/message-generator.ts`
- Modify: `backend/service/notification-resolver/src/handlers/eew/warning/handler.ts`
- Modify: `backend/service/notification-resolver/src/resolver/target-resolver.ts`
- Modify: `backend/service/notification-resolver/src/handlers/estimated-intensity/handler.ts`
- Modify: `backend/service/notification-resolver/src/handlers/shake-detection/handler.ts`
- Modify: `backend/service/notification-resolver/src/tsunami/handler.ts`
- Modify: `backend/api/api/src/features/notification/datasource/test-notification-datasource.ts`
- Test: `backend/service/notification-resolver/src/tsunami/__tests__/handler.test.ts`
- Test: `backend/service/notification-resolver/src/handlers/eew/warning/__tests__/handler.test.ts`

**Interfaces:**
- Produces: `androidRouteForEarthquake(telegramType)`。
- Produces: `androidRouteForTsunami({ trigger, kind })`。
- Produces: `{ channelId: NotificationChannel; deliveryPriority: 'high' | 'normal' }`。

- [ ] **Step 1: routing tableの失敗テストを書く**

```ts
expect(androidRouteForEarthquake('VXSE51').channelId).toBe('earthquake_vxse51');
expect(androidRouteForEarthquake('VZSE40').channelId).toBe('earthquake_notice');
expect(androidRouteForEarthquake('NANKAI').channelId).toBe('nankai_information');
expect(androidRouteForEarthquake('VYSE60').channelId).toBe('aftershock_advisory');

expect(androidRouteForTsunami({ trigger: 'new_issuance', kind: '大津波警報' }).channelId)
  .toBe('tsunami_major_warning');
expect(androidRouteForTsunami({ trigger: 'first_wave_arrival', kind: '津波警報' }).channelId)
  .toBe('tsunami_warning');
expect(androidRouteForTsunami({ trigger: 'cleared', kind: '津波警報' }).channelId)
  .toBe('tsunami_update');
expect(androidRouteForTsunami({ trigger: 'offshore_observation', kind: '津波予報（若干の海面変動）' }).channelId)
  .toBe('tsunami_passive');
```

- [ ] **Step 2: routing未実装で失敗を確認する**

Run: `cd backend && pnpm --filter @eqmonitor-backend/notification-resolver test -- src/shared/__tests__/android-notification-routing.test.ts`

Expected: module不在でFAIL。

- [ ] **Step 3: 全経路へ明示routeを渡す**

割り当ては次に固定する。

```text
EEW forecast -> eew_forecast/high
EEW one-point or level -> eew_low_accuracy_v2/high
EEW warning current location -> eew_warning_current_location/high
EEW warning nationwide -> eew_warning_nationwide/high delivery
VXSE51/52/53/61/62 -> earthquake_vxse51/52/53/61/62
VZSE40 -> earthquake_notice/normal
NANKAI -> nankai_information/high
VYSE60 -> aftershock_advisory/high
estimated intensity -> earthquake_estimated_intensity/normal
shake detection -> shake_detection/high
tsunami new/upgrade -> severity-specific/high
tsunami first wave -> tsunami_warning/high
tsunami update/clear/cancel -> tsunami_update/high
tsunami offshore/forecast -> tsunami_passive/normal
test -> service_test/high
critical test -> service_test_critical/high
```

通常EEW予報経路では `event.isWarning` をwarning Channel選択に使わず、専用warning handlerだけがwarning Channelを使用する。

- [ ] **Step 4: 警報処理を通常予報の対象件数から独立させる**

`handleEewWarningNotification` を `devices.length === 0` による早期returnより前に実行できる構造へ移し、通常予報マッチ0件でも全国・現在地警報対象へ配信されるhandlerテストを追加する。専用handlerはscopeに応じてAPNs interruption levelを選び、FCMにはscope別Channelを渡す。

- [ ] **Step 5: routing・handler・既存回帰テストを通す**

Run: `cd backend && pnpm --filter @eqmonitor-backend/notification-resolver test -- src/shared/__tests__/android-notification-routing.test.ts src/handlers/eew/warning/__tests__ src/tsunami/__tests__/handler.test.ts test/handlers/shake-detection/handler.test.ts`

Run: `cd backend && pnpm --filter @eqmonitor-backend/api test -- test/notification`

Run: `cd backend && pnpm --filter @eqmonitor-backend/notification-resolver check-types`

Expected: すべて成功。

- [ ] **Step 6: コミットする**

```bash
git -C backend add service/notification-resolver/src service/notification-resolver/test api/api/src/features/notification
git -C backend commit -m "Feat: Android通知を意味別チャネルへ振り分け"
```

---

### Task 7: backend全体検証とPR

**Files:**
- Delete: `backend/docs/todo/650_eew_warning_nationwide_interruption_level.md`
- Verify: backend working tree全体

**Interfaces:**
- Produces: App側が参照するbackend commit SHAとbackend PR URL。

- [ ] **Step 1: 解消済みtodoを削除し差分を検査する**

Run: `git -C backend --no-pager diff --check`

Run: `git -C backend --no-pager status --short`

Expected: 対象ファイルのみ、空白エラーなし。

- [ ] **Step 2: 関連packageの全テストと型検査を実行する**

Run: `cd backend && pnpm --filter @eqmonitor-backend/database test`

Run: `cd backend && pnpm --filter @eqmonitor-backend/api test`

Run: `cd backend && pnpm --filter @eqmonitor-backend/notification-message test`

Run: `cd backend && pnpm --filter @eqmonitor-backend/notification-resolver test`

Run: `cd backend && pnpm --filter @eqmonitor-backend/api type-check`

Run: `cd backend && pnpm --filter @eqmonitor-backend/notification-resolver check-types`

Expected: すべてexit 0。

- [ ] **Step 3: todo削除をコミットしpushする**

```bash
git -C backend add docs/todo/650_eew_warning_nationwide_interruption_level.md
git -C backend commit -m "Docs: 全国警報配信レベルの課題を解消"
git -C backend push -u origin codex/eew-warning-android-channels
```

- [ ] **Step 4: backend draft PRを作成する**

```bash
gh pr create --repo YumNumm/eqmonitor-backend --draft \
  --title "Feat: EEW警報設定とAndroid通知チャネルを再設計" \
  --body-file /tmp/eqmonitor-backend-notification-pr.md
```

PR本文には、現在地/全国scope、全国critical禁止、全国→現在地昇格、FCM Channel表、実行したテスト、Webhook非変更を記載する。
