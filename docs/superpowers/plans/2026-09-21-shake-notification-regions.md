# 揺れ検知通知の細分化地域設定 Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox syntax for tracking. Execution method awaits user selection.

**Goal:** デバッグ画面から現在地・全国・細分化地域の揺れ検知通知を設定し、地域に応じた文面を受信できるようにする。

**Architecture:** 揺れ検知専用の条件に明示的な対象種別を導入する。現在地は既存の Device Location API、地域マスターは Asset Pack に集約する。バックエンドで地域別の最大レベルと通知済みレベルを判定し、タイトル用の地域レベルと本文用のイベントレベルを分離する。

**Tech Stack:** Flutter / Dart、Riverpod 3、TypeScript、Valibot、Hono、Drizzle、PostgreSQL、Valkey、Vitest / PGlite。

**Spec:** [承認済み設計](../specs/2026-09-21-shake-notification-regions-design.md)

## Global Constraints

- 地域コードは地震情報用細分化地域の3桁文字列とし、EEW用の別コード体系と混同しない。
- 都道府県は地域選択の分類に使用し、都道府県全体・市区町村・観測点を通知条件にはしない。
- 新たな課金制約や既存通知の地域枠との共有は追加しない。
- 現在地未登録を全国扱いにしない。欠測震度・未解決地域名を捏造しない。
- 通常通知の改善を理由に、別契約の Live Activity の判定や表示を暗黙に変更しない。
- Dart は `mise exec --` で実行し、生成物は生成元から再生成する。
- TDDの一律適用は不要。以下の回帰テストは実装と同じ変更単位で追加し、対象テストを実行する。
- PRは `--repo YumNumm/EQMonitor` または `--repo YumNumm/eqmonitor-backend` を明示する。
- C#変更が必要になった場合も `--repo YumNumm/KyoshinEewViewer` のみに提出する。
- 本番DBの移行・サービスのデプロイ・PRのマージは、コード作成と検証に含めない。

## Review Focus

1. 旧クライアントの全件PUTが新設定を消す入力: strict validationで400、既存状態を保持する。Task 2で検証。
2. 現在地と手動登録が同じ地域の入力: 1地域・1通知として扱い、移動先は新規対象にする。Task 3 / 4で検証。
3. 両設定の読み込み順序が逆転する条件: 揺れ検知だけ有効でも位置送信を停止しない。Task 7で検証。
4. 一部観測点に地域コードがないイベント: 地域へ偽の震度を作らず、全国条件は独立判定する。Task 3 / 5で検証。
5. 通知キュー投入が失敗した後の再配信: 未送信を通知済みにしない。統合イベントの最大履歴も保持する。Task 4で検証。

## 実行場所・依存順序

アプリ作業場所: `/home/yumnumm/EQMonitor/.worktrees/shake-notification-regions`。
ブランチ: `feat/shake-notification-regions`、作成時ベース: `origin/develop` の `bcbb0ba8b`。
バックエンドは `/home/yumnumm/eqmonitor-backend` の未コミット変更を触らず、同様に独立worktreeを作成する。
以下の `B/` はバックエンドworktree、`A/` はアプリworktreeを表す。シェル実行時は実パスへ置き換える。

依存順序は Task 1 → 2 → 3 → 4 → 5 → 6 → 7 → 8 → 9。
Task 5と6はTask 2 / 3の契約が確定すれば並行可能だが、契約変更は双方に伝える。
セットアップと基準テストは、それぞれを必要とするTask 1 / 6で行う。

## Task 1: DBの新条件と旧設定の保存

**Files:**
- Modify: `B/packages/database/src/schema/schema.ts`
- Modify: `B/packages/database/src/schema/relations.ts`（関連定義への影響がある場合）
- Generate: `B/packages/database/drizzle/<generator-created-directory>/migration.sql` と `snapshot.json`
- Create: `B/packages/database/src/repositories/shake-notification-migration.test.ts`

**Interfaces:** 既存テーブルに `target_type`、`region_code`、`enabled`、`legacy_needs_reconfiguration` を追加する。`target_type = null` は通知対象外の旧データ保存行に限定する。

- [ ] バックエンドの指示を読み、`origin/develop`から独立worktreeを作る。`pnpm install --frozen-lockfile`後、既存の揺れ検知テストを実行して基準結果を記録する。
- [ ] 新列と制約をスキーマへ追加する。条件の形を次の式で固定する。

```sql
CHECK (
  (target_type IS NULL AND enabled = false AND region_code IS NULL)
  OR (target_type IN ('current_location', 'nationwide') AND region_code IS NULL)
  OR (target_type = 'region' AND region_code ~ '^[0-9]{3}$')
)
```

- [ ] 現在地・全国はdeviceと種別で、地域はdeviceと地域コードで部分UNIQUE indexを作る。旧行の粒度列は保存し、新APIは書き込まない。
- [ ] `pnpm --dir packages/database drizzle-kit:generate`でDDLを生成する。データ移行SQLでは旧現在地を最優先で変換し、全地域列nullかつ非現在地だけを全国にする。同種の旧行が複数あれば最小閾値の1行を有効にし、残りは保存行とする。
- [ ] 旧観測点・市区町村・都道府県行は `target_type = null`、`enabled = false`、`legacy_needs_reconfiguration = true` にする。旧データは削除しない。
- [ ] PGliteテストで、現在地、全国、各旧地域粒度、重複行を投入して生成migrationを実行する。新しい地域条件の重複拒否と、保存行が通知対象にならないことを確認する。

```ts
expect(rows.find(row => row.id === 'old-current')).toMatchObject({
  target_type: 'current_location', region_code: null, enabled: true,
});
expect(rows.find(row => row.id === 'old-point')).toMatchObject({
  target_type: null, enabled: false, legacy_needs_reconfiguration: true,
});
expect(rows.find(row => row.id === 'old-point')?.sub_region_id).toBe(oldPointId);
```

- [ ] `pnpm --dir packages/database test src/repositories/shake-notification-migration.test.ts`と型検査を実行。適用済みmigrationの再実行はmigration runnerが抑止すること、未適用失敗時にトランザクションが戻ることも確認する。
- [ ] DB変更を `feat: 揺れ検知通知条件の地域種別を追加` でコミットする。生成migrationは一体で扱う。

## Task 2: APIとマスター配布の契約

**Files:**
- Modify: `B/api/api/src/features/device/model/requests.ts` / `responses.ts`
- Modify: `B/api/api/src/features/device/routes/settings/shake-detection.ts`
- Modify: `B/api/api/src/features/device/datasource/datasource.ts`
- Create: `B/api/api/src/features/device/model/shake-detection-settings.test.ts`
- Create: `B/api/api/src/features/device/routes/settings/shake-detection.test.ts`
- Modify: `B/api/api/openapi.json`、`B/app/specs/backend/api/notification-settings.md`
- Create: `B/packages/notification-common/src/shake-region-catalog.ts` と同名の `.test.ts`
- Modify: `B/packages/notification-common/src/index.ts`、API・resolverの設定と既存のAsset Pack配置定義

**Interfaces:** PUTは新条件の配列。GET / PUTのレスポンスは `ShakeDetectionSettingsResponse = { settings: ShakeDetectionSettingResponse[]; requires_reconfiguration: boolean }`。各設定はid・時刻と次のフィールドを持つ。

```ts
type ShakeCondition = {
  target_type: 'current_location' | 'nationwide' | 'region';
  region_code: string | null;
  enabled: boolean;
  min_level: 'Weaker' | 'Weak' | 'Medium' | 'Strong' | 'Stronger';
};
```

- [ ] `ShakeRegionCatalog`を共通ライブラリに作り、Asset Packの観測点コード→地域コード、地域コード→日本語名・都道府県名を解決する。公開メソッドを `loadFromFiles(pointsPath, regionsPath)`、`hasRegion(code)`、`regionForPoint(code)`、`region(code)` とする。APIは同じ地域カタログで地域コードの実在を検証する。
- [ ] Valibotの `strictObject`、種別ごとの地域コード制約、配列の重複検査を追加する。名称はリクエストから信用せずカタログで解決する。カタログ未ロードの地域保存は503とし、旧設定を保持する。
- [ ] PUTは有効契約行だけを置換し、旧保存行を削除しない。成功時に旧行の `legacy_needs_reconfiguration` をfalseにする。トランザクション失敗時は置換・フラグ解除の両方を戻す。
- [ ] `sub-regions`は410のみ返し、OpenAPIから観測点マスターの成功レスポンスを削除する。Datasourceの不要な観測点一覧メソッドも削除する。
- [ ] 次の入力を実際のrouteへ送るテストを追加し、拒否後のGETが変わらないことを確認する。

```ts
const invalidBodies = [
  [{ sub_region_id: null, min_level: 'Medium', is_current_location: true }],
  [{ target_type: 'region', region_code: null, enabled: true, min_level: 'Medium' }],
  [{ target_type: 'nationwide', region_code: '350', enabled: true, min_level: 'Medium' }],
];
for (const body of invalidBodies) {
  const response = await app.request('/settings/shake-detection', {
    method: 'PUT', headers: { 'content-type': 'application/json' }, body: JSON.stringify(body),
  }, authenticatedTestBindings);
  expect(response.status).toBe(400);
}
```

`app`と`authenticatedTestBindings`は対象routeを既存のdevice認証テストと同じ方法で組み立てるテストfixture。実ネットワーク・実認証情報を使用しない。

- [ ] APIの新規テストと型検査を実行し、`pnpm --dir api/api generate:openapi`で再生成する。API・resolver双方へPack由来ファイルのパスと配置を追加し、ローカル設定とHelmレンダリングで同じ名前を使うことを確認する。
- [ ] `feat: 揺れ検知設定APIを細分化地域契約へ移行` でコミットする。

## Task 3: 地域ごとの通知条件判定

**Files:**
- Modify: `B/service/notification-resolver/src/repository/shake-detection.ts`
- Modify: `B/service/notification-resolver/src/types/shake-detection.ts`
- Modify: `B/packages/notification-message/src/types.ts`
- Create: `B/service/notification-resolver/src/resolver/shake-region-matcher.ts`
- Create: `B/service/notification-resolver/test/resolver/shake-region-matcher.test.ts`
- Modify: `B/service/notification-resolver/test/repository/shake-detection-settings.test.ts`

**Interfaces:** `ShakeRegionMatch = { regionCode: string; regionName: string; level: ShakeDetectionLevel }`。`ShakeMatchedTargets = { regions: ShakeRegionMatch[]; nationwideLevel: ShakeDetectionLevel | null }`。`resolveShakeMatches({ conditions, currentRegionCode, regionLevels, eventLevel }): ShakeMatchedTargets` をTask 4 / 5で使う。

- [ ] 観測点ごとの有効な震度をAsset Packの地域へ集計し、地域内の最大値を既存のレベル変換関数へ渡す。null・非有限値は集計から除外する。
- [ ] enabledなregionは該当地域、current_locationは `device_location.region_id`、nationwideはイベントレベルと比較する。条件不成立を全国へフォールバックしない。
- [ ] 同じ地域の現在地・手動条件はORで閾値を評価して地域コードで重複排除する。地域名が解決できない地域は、他地域の名前を代用しない。
- [ ] 以下に加え、Weaker〜Strongerの変換境界、未登録現在地、無効条件、欠測、移動後をテストする。

```ts
const matched = resolveShakeMatches({
  conditions: [
    { target_type: 'current_location', region_code: null, enabled: true, min_level: 'Medium' },
    { target_type: 'region', region_code: '350', enabled: true, min_level: 'Weak' },
  ],
  currentRegionCode: '350',
  regionLevels: [{ regionCode: '350', regionName: '東京都23区', level: 'Medium' }],
  eventLevel: 'Strong',
});
expect(matched.regions).toEqual([
  { regionCode: '350', regionName: '東京都23区', level: 'Medium' },
]);
expect(matched.nationwideLevel).toBeNull();
```

- [ ] 対象resolver / repositoryテストと型検査を実行。`feat: 揺れ検知の現在地と登録地域を判定` でコミットする。

## Task 4: 地域単位の通知履歴と配信

**Files:**
- Modify: `B/service/notification-resolver/src/repository/redis.ts`
- Modify: `B/service/notification-resolver/src/resolver/shake-detection-resolver.ts`
- Modify: `B/service/notification-resolver/src/handlers/shake-detection/handler.ts`
- Modify: `B/service/notification-resolver/test/repository/redis-shake-level.test.ts`
- Modify: `B/service/notification-resolver/test/repository/redis-shake-level.integration.test.ts`
- Modify: `B/service/notification-resolver/test/handlers/shake-detection/handler.test.ts`
- Modify: `B/service/notification-resolver/test/consumers-shake-retry.test.ts`

**Interfaces:** 通知対象キーは `region:<3桁コード>` または `nationwide`。Valkeyのフィールドはdevice IDと対象キーのJSON配列文字列とし、曖昧な区切り連結を避ける。

```ts
type ShakeTargetKey = `region:${string}` | 'nationwide';
const historyField = (deviceId: string, targetKey: ShakeTargetKey) =>
  JSON.stringify([deviceId, targetKey]);
```

- [ ] 新しい地域単位のValkey namespaceを設ける。旧device単位履歴を地域履歴として読み替えない。既存Luaの最大レベル保持、TTL、統合時redirect・循環検査は新namespaceにも適用する。
- [ ] 新APIを `getShakeTargetLevels(eventId, fields)`、`setShakeTargetLevels(eventId, levels)`、`transferMergedShakeTargetLevels(canonicalId, absorbedIds)` として既存のdevice単位APIと区別する。
- [ ] いずれかの対象が初回または上昇なら通常通知を1件生成する。文面生成には今回一致した全対象を渡す。キュー投入成功後だけその通知に含む対象レベルを記録し、失敗は再試行可能にする。
- [ ] 正規イベント統合後も対象ごとの最大値を引き継ぐ。旧通常通知履歴を利用しているLive Activity経路がある場合、そのAPIを削除しない。
- [ ] 2地域の一方だけ上昇、別地域の初回一致、全国との同時一致、同一地域の重複、TTL、統合チェーン、キュー失敗を実際のhandlerとValkeyテストで確認する。

```ts
expect(shouldNotifyShakeDetection('Weak', 'Medium').shouldNotify).toBe(true);
expect(shouldNotifyShakeDetection('Strong', 'Medium').shouldNotify).toBe(false);
expect(shouldNotifyShakeDetection(null, 'Weak').shouldNotify).toBe(true);
// handler fixture: eventLevel='Strong'のままregion:350だけWeak→Medium。
// 1件の通知を生成し、region:350の履歴をMediumにする。全国履歴はStrongのまま。
```

- [ ] 上記テストと既存shake Live Activityテストを実行。`fix: 登録地域の揺れ増大と通知履歴を分離` でコミットする。

## Task 5: タイトルと本文の生成

**Files:**
- Modify: `B/packages/notification-message/src/shake/message.ts`
- Modify: `B/packages/notification-message/src/__tests__/shake-message.test.ts`
- Modify: `B/packages/i18n/locales/ja/shake.json`、`en/shake.json`、`zh/shake.json`
- Modify: `B/service/notification-resolver/test/message/shake-detection-message.test.ts`

**Interfaces:** `buildShakeDetectionNotification`はイベント、Task 3の一致対象、カタログで解決した全イベント地域・都道府県、translatorを受け取る。payloadの既存 `data.level` はイベントレベルを維持し、表示タイトルにイベントレベルを流用しない。

- [ ] 登録地域・現在地の一致候補があれば、その最大レベルに並ぶ地域をコード順に列挙する。候補がなければ全国条件に一致したイベントの全地域から同様に選ぶ。
- [ ] 本文は都道府県をコード順・重複なし・最大5件とし、イベントレベルで生成する。地域情報なし用テンプレートを3言語に追加する。
- [ ] タイトルの同レベル地域は、実数震度の差で1つに絞らない。地域が多い場合も推測の略称は作らず、既存のプラットフォームpayloadサイズ制限との整合性を検証する。
- [ ] 次の日本語期待値と同じ意味の英語・中国語テストを追加する。その他、全国単独、同時一致、空の地域情報、6都道府県以上を確認する。

```ts
expect(payload.title).toBe('千葉県北西部 東京都23区でやや強い揺れを検知');
expect(payload.body).toBe('12:34頃、千葉県 東京都 神奈川県で強い揺れを検知しました');
expect(payload.data.level).toBe('Strong');
```

- [ ] `pnpm --dir packages/notification-message test src/__tests__/shake-message.test.ts`とresolverの文面・handlerテストを実行。`fix: 揺れ検知通知の登録地域と全体レベルを区別` でコミットする。

## Task 6: Dart APIクライアントと設定Repository

**Files:**
- Generate: `A/packages/eqmonitor_api/openapi/openapi.json` と `lib/src/`
- Modify: `A/app/lib/feature/settings/features/notification_settings/data/model/shake_detection_settings.dart`
- Create: 同ディレクトリの `data/repository/shake_detection_settings_repository.dart`
- Modify: 同ディレクトリの `data/notifier/shake_detection_settings_notifier.dart`
- Create: 同ディレクトリの `data/logic/shake_notification_region_catalog_builder.dart`
- Create: 同ディレクトリの `data/provider/shake_notification_region_catalog_provider.dart`
- Create: `A/app/test/feature/settings/features/notification_settings/shake_detection_settings_repository_test.dart`
- Create: 同テストディレクトリの `shake_notification_region_catalog_test.dart`

**Interfaces:** アプリモデルは対象種別・地域コード・enabled・minLevelと再設定案内フラグを保持する。Repositoryの `fetch()` と `replace(entries)` は新GET / PUTだけを呼ぶ。カタログbuilderは `EarthquakeParameter` の都道府県→地域を返す。

- [ ] アプリworktreeで指示どおりmise・Flutter Scene・依存をセットアップする。実装前に既存の通知設定と位置同期テストの基準結果を記録する。
- [ ] backend submoduleを必要な範囲だけ初期化し、Task 2を含むバックエンドコミットをcheckoutする。`packages/eqmonitor_api`で `mise exec -- dart run bin/generate.dart` を実行する。生成差分の無関係部分は勝手に戻さず原因を確認する。
- [ ] APIアクセスをRepositoryへ移し、NotifierはRepositoryとアプリモデルのみを扱う。旧観測点一覧の取得と `updateCurrentLocationSubRegion` を削除する。
- [ ] `parameterRepositoryProvider` の `loadAsset()` が返す `earthquake` を使って都道府県別の選択肢を構成する。既存のEEW地域pickerをそのまま転用しない。
- [ ] HTTP adapterによるテストで要求pathとJSONを検査する。API失敗で保存済み状態を保持し、`sub-regions`への要求が0件であることを確認する。

```dart
expect(requests.map((request) => request.path),
    everyElement(isNot(contains('/sub-regions'))));
expect(savedBody.first, {
  'target_type': 'region', 'region_code': '350',
  'enabled': true, 'min_level': 'Medium',
});
```

- [ ] Freezed / Riverpodを生成し、APIパッケージの純Dartテストと追加Flutterテストを実行。生成契約とアプリモデル・Repositoryを分けてコミットする。

## Task 7: 現在地監視・headless送信の統一

**Files:**
- Modify: `A/app/lib/feature/location/data/background_location_monitoring_lifecycle.dart`
- Modify: `A/app/lib/feature/location/data/background_location_service.dart`
- Modify: `A/app/lib/feature/location/data/logic/device_location_monitoring_reconciler.dart`
- Modify: `A/app/lib/feature/settings/features/notification_settings/data/notifier/notification_slots_notifier.dart`
- Modify: 同ディレクトリの `shake_detection_settings_notifier.dart`
- Create: `A/app/lib/feature/location/data/logic/device_location_requirement.dart`
- Modify: `A/app/test/feature/location/background_location_service_error_test.dart`
- Modify: `A/app/test/feature/location/background_location_update_notifier_test.dart`
- Create: `A/app/test/feature/location/device_location_requirement_test.dart`

**Interfaces:** `DeviceLocationRequirement.resolve({bool? existingCurrentLocation, bool? shakeCurrentLocation})` は既存の `DeviceLocationSyncAvailability` を返す。nullは未取得。監視と永続化はこの同じ判断結果を使う。

```dart
final class const DeviceLocationRequirement() {
  DeviceLocationSyncAvailability resolve({
    required bool? existingCurrentLocation,
    required bool? shakeCurrentLocation,
  }) {
    if (existingCurrentLocation == true || shakeCurrentLocation == true) {
      return DeviceLocationSyncAvailability.enabled;
    }
    if (existingCurrentLocation == false && shakeCurrentLocation == false) {
      return DeviceLocationSyncAvailability.disabled;
    }
    return DeviceLocationSyncAvailability.uninitialized;
  }
}
```

- [ ] 上記ロジックを注入可能なクラスとして実装し、9通りの入力表でテストする。通常通知側の存在判定は既存仕様を維持し、揺れ検知側はcurrent_locationかつenabledを見る。
- [ ] 各Notifierが自分の設定だけでavailabilityを上書きするコードを削除する。双方の状態を購読する共通の調停処理に寄せ、世代の古い非同期結果で新状態を上書きしないようテストする。相互のprovider future待機で循環依存を作らない。
- [ ] 位置更新から揺れ検知設定PUTを削除する。通常EngineはApp Group等のappEffects、headless側はDevice Location APIという既存の所有を維持する。
- [ ] 有効化Actionは既存の位置権限フロー、位置監視、初回位置同期を呼ぶ。画面の現在地未取得表示は既存の位置・権限providerから取得する。
- [ ] 揺れ検知のみ、既存通知のみ、両方、一方削除、一方取得失敗、読み込み順序逆転、headless再試行の回帰テストを実行する。
- [ ] `fix: 揺れ検知の現在地同期を共通経路へ統合` でコミットする。

## Task 8: 設定画面とデバッグ入口

**Files:**
- Modify: `A/app/lib/feature/settings/features/notification_settings/ui/page/shake_detection_settings_page.dart`
- Create: 同ディレクトリの `shake_notification_prefecture_picker_page.dart` と `shake_notification_region_picker_page.dart`
- Create: 同featureの `data/action/shake_detection_settings_action.dart`
- Modify: `A/app/lib/feature/settings/children/config/debug/debug_page.dart`
- Modify: `A/app/lib/core/router/router.dart`、生成された `router.g.dart`
- Create: `A/app/test/feature/settings/features/notification_settings/shake_detection_settings_page_test.dart`
- Modify: 既存のデバッグroute guardテスト

**Interfaces:** pickerは細分化地域コードを返し、Actionが `region` 条件を追加する。現在地・全国はsingletonで、スイッチと最低レベルを持つ。保存はRiverpod 3 Mutationを使う。

- [ ] 既存ページに現在地・全国の固定項目、地域一覧、地域追加を実装する。新規条件の最低レベルは既存のMediumを使う。地域重複は選択画面で防ぎ、APIでも検証する。
- [ ] pickerをAsset Packの都道府県→地域階層へ接続し、市区町村や観測点は表示しない。loading / error / retry時も保存済み条件を消さない。
- [ ] 再設定案内はAPIの `requires_reconfiguration` を表示し、保存成功後のレスポンスでのみ消す。保存中は競合操作を無効化する。
- [ ] デバッグ入口を追加し、デバッグ利用の権限は既存guardを通す。通常設定に入口は追加せず、デバッグから開くときの機能フラグredirectだけを整える。
- [ ] Widgetテストで現在地・全国・地域追加・削除・閾値変更・保存失敗を操作し、モデルに保存される意味を検証する。見た目の細かいsnapshotテストは追加しない。
- [ ] `feat: デバッグ画面に揺れ検知の通知設定を追加` でコミットする。

## Task 9: 全体検証とPR

**Files:**
- Modify: `A/docs/knowledge/notification_location.md`
- Modify: `A/docs/todo/800_ui_and_navigation.md`
- Modify: `B/app/specs/backend/api/notification-settings.md`
- Modify: backendの既存揺れ検知通知・配布手順文書

- [ ] バックエンドのdatabase・API・notification-message・resolver対象テストと型検査を実行する。Valkeyの実サービスが必要な統合テストはローカル専用サービスで実行し、本番へ接続しない。
- [ ] アプリから次を実行する。

```sh
mise exec -- flutter test test/feature/settings/features/notification_settings test/feature/location --dart-define=CI=true
```

- [ ] アプリルートから `mise exec -- dart analyze app --fatal-infos --format machine`、APIパッケージから `mise exec -- dart test` を実行する。変更Dartファイルをformatし、文書はtextlintで確認する。
- [ ] `git --no-pager diff`で旧マスターAPI依存、手編集生成物、不要なsubmodule変更、秘匿情報がないか確認する。意図したファイルをstageして `mise exec -- hk check` を実行する。
- [ ] 実機の位置同期・APNs／FCMを実施できなければ、その項目だけ未検証として既存TODOに残す。実装済み項目はTODOから除く。
- [ ] コミットをpushし、バックエンドPRとアプリPRを作成する。アプリPRには依存するバックエンドPRとAPI非互換変更を記載する。PR本文は一時ファイルへ書き、`--body-file`で渡す。

```sh
gh pr create --repo YumNumm/eqmonitor-backend --base develop --head feat/shake-notification-regions --body-file /tmp/shake-backend-pr.md
gh pr create --repo YumNumm/EQMonitor --base develop --head feat/shake-notification-regions --body-file /tmp/shake-app-pr.md
```

- [ ] C#は変更不要であることを実際のコード・テストで最終確認する。必要になった場合は該当リポジトリの指示とbase branchを確認し、`--repo YumNumm/KyoshinEewViewer`を明示して別PRにする。
- [ ] PR URL、検証結果、未検証項目、DB / API / アプリの展開順を報告する。

## 計画の自己レビュー

- 契約・マスター: Task 1 / 2 / 6。現在地: Task 3 / 7。文面と再通知: Task 4 / 5。
- デバッグ入口・将来の通常設定: Task 8。移行: Task 1 / 2 / 8。実機・PR制約: Task 9。
- Review Focusの5項目は、それぞれの所有Taskに回帰テストを割り当てた。
- DB migrationのディレクトリ名はDrizzleが採番するため生成結果を使用し、snapshotを手編集しない。
- 実装時に契約変更が必要になった場合は、依存する型・生成物・テストを同じ変更で更新する。
