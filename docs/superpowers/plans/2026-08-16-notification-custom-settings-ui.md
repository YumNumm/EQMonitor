# Notification Custom Settings UI Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 通知カスタム設定をスロット中心に整理し、警報の重大な通知説明と Free 全国配信を Flutter・API・配信処理で一貫して提供する。

**Architecture:** Flutter はスロット一覧で設定要約を表示し、スロット詳細から予報・地震情報・警報を更新する。プリセット適用時のグローバル不変条件は `NotificationPresetApplier` に集約する。バックエンドはプランゲートを廃止し、設定 API と通知対象 SQL の双方で Free デバイスを全国警報の対象にする。

**Tech Stack:** Flutter, Dart, Riverpod 3 Mutation, Material 3, flutter_test, TypeScript, Hono, Drizzle SQL, Vitest, pnpm

## Global Constraints

- Flutter / Dart コマンドは必ず `mise exec --` 経由で実行する。
- `dynamic`、`Object`、null assertion (`!`) を新規コードで使用しない。
- Widget の状態管理は HookWidget / HookConsumerWidget / ConsumerWidget を使い、StatefulWidget を追加しない。
- 生命に関わる通知設定にランダム値や便宜的な固定フォールバックを追加しない。
- 警報の現在地配信と全国配信は `interruptionLevel: critical` の既存契約を維持する。
- 全国警報は Free / Pro を問わず設定・配信可能にする。
- ユーザーの未コミット差分 (`analysis_options.yaml` 群と `mise.lock`) は変更・ステージしない。
- 親リポジトリと `backend` サブモジュールは別ブランチ、別コミット、別 Draft PR とする。

---

### Task 1: プリセットのグローバル不変条件

**Files:**
- Modify: `app/test/feature/settings/features/notification_settings/notification_preset_applier_test.dart`
- Modify: `app/test/feature/settings/features/notification_settings/notification_preset_applier_lifecycle_test.dart`
- Modify: `app/lib/feature/settings/features/notification_settings/data/action/notification_preset_applier.dart`

**Interfaces:**
- Consumes: `EewGlobalSettingsNotifier.updateSettings({bool? enabled, bool? startLiveActivity, ...})`、`EarthquakeGlobalSettingsNotifier.updateSettings({bool? enabled, ...})`
- Produces: `NotificationPresetApplier.apply(NotificationPreset)` が EEW/地震情報の global enabled と Live Activity を決定的に更新する。

- [ ] **Step 1: グローバル設定を記録する Fake と失敗テストを追加する**

`notification_preset_applier_test.dart` に次の記録型と Fake Notifier を追加し、ProviderContainer の override に登録する。

```dart
final class _EewGlobalUpdateCall {
  const _EewGlobalUpdateCall({required this.enabled, required this.startLiveActivity});

  final bool? enabled;
  final bool? startLiveActivity;
}

class _RecordingEewGlobalSettingsNotifier extends EewGlobalSettingsNotifier {
  final calls = <_EewGlobalUpdateCall>[];

  @override
  Future<EewGlobalSettings> build() async => const EewGlobalSettings(
    enabled: false,
    defaultSound: 'default',
    defaultInterruptionLevel: InterruptionLevel.active,
    startLiveActivity: false,
    collapseNotification: true,
    warningEnabled: true,
  );

  @override
  Future<void> updateSettings({
    bool? enabled,
    String? defaultSound,
    InterruptionLevel? defaultInterruptionLevel,
    bool? startLiveActivity,
    bool? collapseNotification,
    bool? warningEnabled,
  }) async {
    calls.add(_EewGlobalUpdateCall(
      enabled: enabled,
      startLiveActivity: startLiveActivity,
    ));
  }
}

class _RecordingEarthquakeGlobalSettingsNotifier
    extends EarthquakeGlobalSettingsNotifier {
  final enabledCalls = <bool?>[];

  @override
  Future<EarthquakeGlobalSettings> build() async => const EarthquakeGlobalSettings(
    enabled: false,
    defaultSound: 'default',
    defaultInterruptionLevel: InterruptionLevel.active,
    estimatedIntensityEnabled: true,
    collapseNotification: true,
  );

  @override
  Future<void> updateSettings({
    bool? enabled,
    String? defaultSound,
    InterruptionLevel? defaultInterruptionLevel,
    bool? estimatedIntensityEnabled,
    bool? collapseNotification,
  }) async {
    enabledCalls.add(enabled);
  }
}
```

各プリセットの既存テストへ次を追加する。

```dart
expect(eewGlobalNotifier.calls.single.enabled, isTrue);
expect(
  eewGlobalNotifier.calls.single.startLiveActivity,
  preset == NotificationPreset.none ? isFalse : isTrue,
);
expect(earthquakeGlobalNotifier.enabledCalls, [true]);
```

- [ ] **Step 2: RED を確認する**

Run from repository root:

```bash
mise exec -- flutter test app/test/feature/settings/features/notification_settings/notification_preset_applier_test.dart
```

Expected: global notifier の呼び出しが 0 件で FAIL。

- [ ] **Step 3: 最小実装を追加する**

`NotificationPresetApplier.apply` の switch に入る前に次の Mutation を1回ずつ実行する。`startLiveActivity` は `preset != NotificationPreset.none` を渡す。

```dart
await EewGlobalSettingsNotifier.updateSettingsMutation.run(_ref, (tsx) async {
  await tsx.get(eewGlobalSettingsProvider.notifier).updateSettings(
    enabled: true,
    startLiveActivity: preset != NotificationPreset.none,
  );
});
await EarthquakeGlobalSettingsNotifier.updateSettingsMutation.run(
  _ref,
  (tsx) async {
    await tsx
        .get(earthquakeGlobalSettingsProvider.notifier)
        .updateSettings(enabled: true);
  },
);
```

必要な model/notifier import を追加する。

- [ ] **Step 4: GREEN と lifecycle 回帰を確認する**

```bash
mise exec -- flutter test app/test/feature/settings/features/notification_settings/notification_preset_applier_test.dart app/test/feature/settings/features/notification_settings/notification_preset_applier_lifecycle_test.dart
```

Expected: PASS。lifecycle テストにも global notifier の遅延 Fake を追加し、autoDispose 回帰を維持する。

- [ ] **Step 5: コミットする**

```bash
git add app/lib/feature/settings/features/notification_settings/data/action/notification_preset_applier.dart app/test/feature/settings/features/notification_settings/notification_preset_applier_test.dart app/test/feature/settings/features/notification_settings/notification_preset_applier_lifecycle_test.dart
git commit -m "Fix: 通知プリセットのグローバル設定を常時有効化"
```

---

### Task 2: カスタム設定一覧とスロット要約

**Files:**
- Modify: `app/test/feature/settings/features/notification_settings/notification_settings_page_eew_warning_test.dart`
- Modify: `app/lib/feature/settings/features/notification_settings/ui/page/notification_settings_page.dart`
- Delete: `app/lib/feature/settings/features/notification_settings/ui/page/eew_forecast_settings_page.dart`
- Delete: `app/lib/feature/settings/features/notification_settings/ui/page/earthquake_info_settings_page.dart`

**Interfaces:**
- Consumes: `notificationSlotsProvider`、`eewGlobalSettingsProvider`、`eewWarningConfigProvider`
- Produces: カスタム設定一覧に4項目だけを残し、`_SlotListTile` が Material Icon と改行区切りの要約を表示する。

- [ ] **Step 1: 一覧表示の失敗 Widget テストを書く**

既存テストの Fake slots を現在地・全国・地域の3件に変更し、カスタム画面へ遷移後に次を検証する。

```dart
expect(find.textContaining('EQMonitor Proにすると'), findsNothing);
expect(find.text('Live Activity'), findsNothing);
expect(find.text('推計震度分布図'), findsOneWidget);
expect(find.text('通知音・割り込みレベル'), findsOneWidget);
expect(find.text('震度別の音設定'), findsOneWidget);
expect(find.text('低精度の緊急地震速報'), findsOneWidget);
expect(find.byIcon(Icons.my_location), findsOneWidget);
expect(find.byIcon(Icons.public), findsWidgets);
expect(find.byIcon(Icons.location_on), findsOneWidget);
expect(find.textContaining('緊急地震速報(予報): 震度4以上'), findsWidgets);
expect(find.textContaining('緊急地震速報(警報): 有効'), findsNWidgets(2));
expect(find.textContaining('地震情報: 震度1以上'), findsWidgets);
```

現在地は `warningEnabled: true`、全国は `currentLocationAndNationwide`、地域は警報行なしの fixture とする。

- [ ] **Step 2: RED を確認する**

```bash
mise exec -- flutter test app/test/feature/settings/features/notification_settings/notification_settings_page_eew_warning_test.dart
```

Expected: emoji、旧詳細タイル、Live Activity が残っているため FAIL。

- [ ] **Step 3: カスタム設定一覧を整理する**

`_CustomNotificationSettingsPage` から Pro banner、global enabled、Live Activity の watch/callback を削除する。`_CustomSettingsSection` の constructor は次だけに縮小する。

```dart
const _CustomSettingsSection({
  required this.isPro,
  required this.estimatedIntensityEnabled,
  required this.onEstimatedIntensityChanged,
});
```

Column には `_InlineSwitchTile(title: '推計震度分布図', ...)` と3つの `LockedSettingTile` だけを残す。`_EewForecastDetailTile`、`_EarthquakeInfoDetailTile`、`_EewWarningDetailTile`、`_EewWarningSettingsPage`、`_TargetOptionTile`、`_ProUpsellBanner` を削除する。`_InlineSwitchTile` は推計震度分布図で引き続き使用する。

- [ ] **Step 4: スロット要約を Material Icon と複数行へ変更する**

`_SlotListSection` で warning state を一度 watch し、各 tile に渡す。

```dart
final warningEnabled =
    ref.watch(eewGlobalSettingsProvider).value?.warningEnabled ?? true;
final warningTarget = ref.watch(eewWarningConfigProvider).value?.target;
```

`_SlotListTile` は `IconData` を switch し、警報行を次で決める。

```dart
final warningVisible = switch (slot.slotType) {
  .currentLocation => warningEnabled,
  .nationwide => warningTarget == EewWarningTarget.currentLocationAndNationwide,
  .region => false,
};
final subtitleLines = <String>[
  eewText,
  if (warningVisible) '緊急地震速報(警報): 有効',
  earthquakeText,
];
```

`leading: Icon(icon)`、`subtitle: Text(subtitleLines.join('\n'))` とする。

- [ ] **Step 5: 到達不能ページと import を削除する**

`eew_forecast_settings_page.dart`、`earthquake_info_settings_page.dart` を削除し、参照と未使用 import が0件であることを確認する。

```bash
rg -n "EewForecastSettingsPage|EarthquakeInfoSettingsPage|_EewWarningSettingsPage|_ProUpsellBanner" app/lib
```

Expected: no matches。

- [ ] **Step 6: GREEN を確認する**

```bash
mise exec -- dart format app/lib/feature/settings/features/notification_settings/ui/page/notification_settings_page.dart app/test/feature/settings/features/notification_settings/notification_settings_page_eew_warning_test.dart
mise exec -- flutter test app/test/feature/settings/features/notification_settings/notification_settings_page_eew_warning_test.dart
```

Expected: PASS。

- [ ] **Step 7: コミットする**

```bash
git add app/lib/feature/settings/features/notification_settings/ui/page/notification_settings_page.dart app/lib/feature/settings/features/notification_settings/ui/page/eew_forecast_settings_page.dart app/lib/feature/settings/features/notification_settings/ui/page/earthquake_info_settings_page.dart app/test/feature/settings/features/notification_settings/notification_settings_page_eew_warning_test.dart
git commit -m "Fix: 通知カスタム設定一覧をスロット中心に整理"
```

---

### Task 3: スロット詳細の最小震度と警報設定

**Files:**
- Create: `app/test/feature/settings/features/notification_settings/slot_detail_page_test.dart`
- Modify: `app/lib/feature/settings/features/notification_settings/ui/page/slot_detail_page.dart`
- Verify: `app/lib/feature/settings/features/notification_settings/data/flow/slot_update_action.dart`
- Verify: `app/lib/feature/settings/features/notification_settings/data/notifier/notification_slots_notifier.dart`
- Modify: `app/test/feature/settings/features/notification_settings/notification_slot_repository_test.dart`

**Interfaces:**
- Consumes: `SlotUpdateAction.execute`、`EewGlobalSettingsNotifier`、`EewWarningConfigNotifier`
- Produces: 現在地は warningEnabled、全国は target を更新し、地域には警報 UI を出さない。現在地の選択した最小震度を API まで保持する。

- [ ] **Step 1: スロット種別ごとの失敗 Widget テストを書く**

`slot_detail_page_test.dart` に ProviderScope と Fake notifiers を用意する。現在地 fixture では次を検証する。

```dart
expect(find.text('緊急地震速報（警報）'), findsOneWidget);
expect(
  find.text('緊急地震速報（警報）は、現在地や全国を対象に重大な通知として配信されます。'),
  findsOneWidget,
);
expect(find.byType(DropdownMenu<JmaIntensity>), findsNWidgets(2));
```

現在地の警報 switch を tap して Fake `EewGlobalSettingsNotifier.lastWarningEnabled == false` を検証する。全国 fixture では Free (`isPro: false`) でも switch が enabled で、tap 後に `lastTarget == currentLocationAndNationwide` と `lastNationwideInterruptionLevel == active` を検証する。地域 fixture では警報見出しと説明が0件であることを検証する。

- [ ] **Step 2: RED を確認する**

```bash
mise exec -- flutter test app/test/feature/settings/features/notification_settings/slot_detail_page_test.dart
```

Expected: 警報セクションが存在しないため FAIL。

- [ ] **Step 3: 警報セクションを実装する**

`SlotDetailPage` で `eewGlobalSettingsProvider.warningEnabled` と `eewWarningConfigProvider.target` を watch し、両 Mutation のエラー listener を追加する。地域以外の children に次を挿入する。

```dart
if (slot.slotType != NotificationSlotType.region) ...[
  const SettingsSectionHeader(text: '緊急地震速報（警報）'),
  _WarningSettingsCard(
    enabled: slot.slotType == NotificationSlotType.currentLocation
        ? warningEnabled
        : warningTarget == EewWarningTarget.currentLocationAndNationwide,
    onChanged: warningCallback,
  ),
  const _WarningDeliveryDescription(),
],
```

現在地 callback は `EewGlobalSettingsNotifier.updateSettingsMutation` で `warningEnabled` を更新する。全国 callback は `EewWarningConfigNotifier.updateConfigMutation` で、ON 時は target と `InterruptionLevel.active`、OFF 時は `currentLocationOnly` と null を渡す。Free ロックや Paywall 分岐は追加しない。

- [ ] **Step 4: 現在地の最小震度 API 回帰テストを強化する**

`notification_slot_repository_test.dart` の `putCurrentLocation` テストで、選択値が request body に保持されることを検証する。

```dart
expect(adapter.lastRequestBody!['eew_min_intensity'], api.JmaIntensity.value4);
expect(
  adapter.lastRequestBody!['earthquake_min_intensity'],
  api.JmaIntensity.value1,
);
```

呼び出しにも `earthquakeEnabled: true` と `earthquakeMinIntensity: JmaIntensity.one` を追加する。この期待値は現実装ですでに通るため、Widget テスト側で Dropdown 操作から notifier 記録までを RED/GREEN の主回帰とする。

- [ ] **Step 5: GREEN を確認する**

```bash
mise exec -- dart format app/lib/feature/settings/features/notification_settings/ui/page/slot_detail_page.dart app/test/feature/settings/features/notification_settings/slot_detail_page_test.dart app/test/feature/settings/features/notification_settings/notification_slot_repository_test.dart
mise exec -- flutter test app/test/feature/settings/features/notification_settings/slot_detail_page_test.dart app/test/feature/settings/features/notification_settings/notification_slot_repository_test.dart
```

Expected: PASS。

- [ ] **Step 6: コミットする**

```bash
git add app/lib/feature/settings/features/notification_settings/ui/page/slot_detail_page.dart app/test/feature/settings/features/notification_settings/slot_detail_page_test.dart app/test/feature/settings/features/notification_settings/notification_slot_repository_test.dart
git commit -m "Fix: スロット詳細に警報と可変最小震度を統合"
```

---

### Task 4: Flutter の知見記録と検証

**Files:**
- Create: `docs/knowledge/20260816_notification_slot_settings.md`

**Interfaces:**
- Consumes: Task 1〜3 の最終仕様
- Produces: 現在地最小震度、Live Activity、警報統合、Free 全国警報を将来の変更でも維持する運用知識。

- [ ] **Step 1: 知見文書を書く**

次の事実と検証コマンドを500行以内で記録する。

```markdown
# 通知スロット設定の不変条件

- 現在地の予報・地震情報の最小震度は固定値ではなく、保存済みスロット値を編集できる。
- 震度4 / 震度1は現在地作成時とプリセット適用時の初期値である。
- recommended / all / custom は EEW Live Activity を常に有効化する。
- EEW・地震情報の global enabled は常に true とし、個別の有効状態はスロットで管理する。
- 緊急地震速報（警報）は現在地・全国とも重大な通知として配信する。
- 全国警報は Free / Pro 共通機能であり、UI・API・配信 SQL のいずれにも Pro gate を追加しない。

検証:
`mise exec -- flutter test app/test/feature/settings/features/notification_settings/`
```

- [ ] **Step 2: Flutter 対象テストと解析を実行する**

```bash
mise exec -- flutter test app/test/feature/settings/features/notification_settings/
mise exec -- dart analyze app/lib/feature/settings/features/notification_settings app/test/feature/settings/features/notification_settings
git --no-pager diff --check
```

Expected: tests 0 failures、analyzer error 0、diff-check 0。既知の analyzer plugin 障害が発生した場合は出力を保存し、通常の Dart warning/error と区別する。

- [ ] **Step 3: 知見をコミットする**

```bash
git add docs/knowledge/20260816_notification_slot_settings.md
git commit -m "Docs: 通知スロット設定の不変条件を記録"
```

---

### Task 5: バックエンド API とプラン制約を Free 対応

**Files:**
- Modify: `backend/api/api/test/device/eew-warning-routes.test.ts`
- Modify: `backend/api/api/test/device/plan-constraints.test.ts`
- Modify: `backend/api/api/src/features/device/routes/settings/eew-warning.ts`
- Modify: `backend/api/api/src/features/device/plan-constraints.ts`

**Interfaces:**
- Consumes: `EewWarningConfigRequest` の既存 target/level invariant
- Produces: Free デバイスも全国 target を保存でき、start response は全プランで `eew_warning_nationwide: true` を返す。

- [ ] **Step 1: backend ブランチを作る**

```bash
git -C backend switch -c codex/free-eew-warning-nationwide
```

- [ ] **Step 2: Free API 成功の失敗テストを書く**

既存の 402 テストを次へ置き換える。

```ts
it('allows a Free user to request nationwide warnings', async () => {
  mocks.getNotificationDefaults.mockResolvedValue({ isPro: false });
  const res = await app.request('/', {
    method: 'PATCH',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({
      target: 'current_location_and_nationwide',
      nationwide_interruption_level: 'active',
    }),
  });
  expect(res.status).toBe(200);
  expect(mocks.upsertEewWarningConfig).toHaveBeenCalledWith(VALID_DEVICE_ID, {
    target: 'current_location_and_nationwide',
    nationwideInterruptionLevel: 'active',
  });
});
```

plan constraints は Free/Pro の双方で `eew_warning_nationwide === true` を期待し、廃止する2環境変数と2 config property の期待を削除する。

- [ ] **Step 3: RED を確認する**

```bash
cd backend/api/api && pnpm test -- test/device/eew-warning-routes.test.ts test/device/plan-constraints.test.ts
```

Expected: Free route は 402、Free constraint は false で FAIL。

- [ ] **Step 4: API plan gate と可変 capability を削除する**

`eew-warning.ts` から `loadPlanConstraintConfig` import、notification defaults 読み込み、`isPro`/`nationwideAllowed`、402 response を削除する。route description を `EEW 警報設定を更新` に変更する。route test の `getNotificationDefaults` mock、Fake method、beforeEach setup も削除し、廃止した plan 判定への依存を残さない。

`plan-constraints.ts` から `freeEewWarningNationwide` と `proEewWarningNationwide` を interface/default/env load から削除し、response は次の固定契約にする。

```ts
eew_warning_nationwide: true,
```

- [ ] **Step 5: GREEN を確認する**

```bash
cd backend/api/api && pnpm test -- test/device/eew-warning-routes.test.ts test/device/plan-constraints.test.ts
```

Expected: PASS。

- [ ] **Step 6: コミットする**

```bash
git -C backend add api/api/src/features/device/routes/settings/eew-warning.ts api/api/src/features/device/plan-constraints.ts api/api/test/device/eew-warning-routes.test.ts api/api/test/device/plan-constraints.test.ts
git -C backend commit -m "Fix: Freeの全国警報設定を許可"
```

---

### Task 6: バックエンド通知配信と仕様書を Free 対応

**Files:**
- Modify: `backend/service/notification-resolver/test/repository/device.test.ts`
- Modify: `backend/service/notification-resolver/src/repository/device.ts`
- Modify: `backend/app/specs/backend/notification/delivery.md`
- Modify: `backend/app/specs/backend/api/notification-settings.md`
- Modify: `backend/app/specs/backend/api/subscription.md`

**Interfaces:**
- Consumes: `findEewWarningMatchedDevices(regionCodes)`
- Produces: 全国 target のデバイスは plan に関係なく警報対象となる。

- [ ] **Step 1: SQL 契約の失敗テストを書く**

既存 SQL test の全国 JOIN 期待を次へ変更する。

```ts
expect(normalizedSql).toContain(
  'JOIN device_notification dn ON dn.device_id = ewc.device_id AND dn.eew_enabled = true AND dn.notification_enabled = true',
);
expect(normalizedSql).not.toContain('dn.is_pro = true');
```

テスト名を「Free を含む全国警報対象でもグローバル EEW と通知マスターを適用する」に変更する。

- [ ] **Step 2: RED を確認する**

```bash
cd backend/service/notification-resolver && pnpm test -- test/repository/device.test.ts
```

Expected: SQL に `dn.is_pro = true` が残っているため FAIL。

- [ ] **Step 3: 配信 SQL から Pro 条件だけを削除する**

全国側 JOIN を次へ変更する。global EEW と notification master の条件は維持する。

```ts
JOIN device_notification dn
  ON dn.device_id = ewc.device_id
  AND dn.eew_enabled = true
  AND dn.notification_enabled = true
```

- [ ] **Step 4: GREEN を確認する**

```bash
cd backend/service/notification-resolver && pnpm test -- test/repository/device.test.ts
```

Expected: PASS。

- [ ] **Step 5: 仕様書を実装契約へ更新する**

`delivery.md` は Free 不可と `is_pro` 保険の説明を削除し、全国 target が plan 非依存で対象になると記載する。`notification-settings.md` は Free/Pro response 例を双方 true にし、402 行と2環境変数行を削除する。`subscription.md` は EEW 全国警報を Free/Pro 共通機能として記載し、plan gate 手順を削除する。Critical Alert 固定の既知事項は変更しない。

- [ ] **Step 6: backend 全体の関連検証を行う**

```bash
cd backend && pnpm --filter @eqmonitor-backend/api test -- test/device/eew-warning-routes.test.ts test/device/plan-constraints.test.ts
cd backend && pnpm --filter @eqmonitor-backend/notification-resolver test -- test/repository/device.test.ts
cd backend && pnpm --filter @eqmonitor-backend/api type-check
cd backend && pnpm --filter @eqmonitor-backend/notification-resolver check-types
cd backend && pnpm exec oxfmt --check api/api/src/features/device/routes/settings/eew-warning.ts api/api/src/features/device/plan-constraints.ts api/api/test/device/eew-warning-routes.test.ts api/api/test/device/plan-constraints.test.ts service/notification-resolver/src/repository/device.ts service/notification-resolver/test/repository/device.test.ts
git -C backend --no-pager diff --check
```

Expected: all exit 0。

- [ ] **Step 7: コミットする**

```bash
git -C backend add service/notification-resolver/src/repository/device.ts service/notification-resolver/test/repository/device.test.ts app/specs/backend/notification/delivery.md app/specs/backend/api/notification-settings.md app/specs/backend/api/subscription.md
git -C backend commit -m "Fix: Freeデバイスへ全国警報を配信"
```

---

### Task 7: 最終検証、push、Draft PR

**Files:**
- Verify only: parent repository intended diff
- Verify only: `backend` intended diff

**Interfaces:**
- Consumes: Task 1〜6 のコミット
- Produces: YumNumm/EQMonitor と YumNumm/eqmonitor-backend の Draft PR URL。

- [ ] **Step 1: 両リポジトリの scope を再確認する**

```bash
git --no-pager status --short
git --no-pager log --oneline --decorate -6
git --no-pager diff origin/develop...HEAD --stat
git -C backend --no-pager status --short
git -C backend --no-pager log --oneline --decorate -6
git -C backend --no-pager diff origin/develop...HEAD --stat
```

親の未コミット `analysis_options.yaml` 群と `mise.lock` は staging/PR に含めない。親 PR に backend submodule pointer を含めない。

- [ ] **Step 2: fresh verification を実行する**

```bash
mise exec -- flutter test app/test/feature/settings/features/notification_settings/
mise exec -- dart analyze app/lib/feature/settings/features/notification_settings app/test/feature/settings/features/notification_settings
cd backend && pnpm --filter @eqmonitor-backend/api test -- test/device/eew-warning-routes.test.ts test/device/plan-constraints.test.ts
cd backend && pnpm --filter @eqmonitor-backend/notification-resolver test -- test/repository/device.test.ts
cd backend && pnpm --filter @eqmonitor-backend/api type-check
cd backend && pnpm --filter @eqmonitor-backend/notification-resolver check-types
```

Expected: all relevant tests/type checks 0 failures。

- [ ] **Step 3: GitHub 認証を確認する**

```bash
gh auth status
```

Expected: YumNumm authenticated。失敗する場合はユーザーに `gh auth login -h github.com` を依頼し、push/PR のみ停止する。

- [ ] **Step 4: backend を push して Draft PR を作る**

```bash
git -C backend push -u origin codex/free-eew-warning-nationwide
gh pr create --repo YumNumm/eqmonitor-backend --draft --base develop --head codex/free-eew-warning-nationwide --title "Freeユーザーの全国緊急地震速報（警報）を有効化" --body-file /tmp/eqmonitor-backend-pr.md
```

PR body は変更理由、API 402 削除、配信 SQL の Pro 条件削除、plan constraint、テスト結果、Critical Alert 契約維持を記載する。

- [ ] **Step 5: Flutter を push して Draft PR を作る**

```bash
git push -u origin codex/notification-custom-settings-ui
gh pr create --repo YumNumm/EQMonitor --draft --base develop --head codex/notification-custom-settings-ui --title "通知カスタム設定をスロット中心のUIへ整理" --body-file /tmp/eqmonitor-app-pr.md
```

PR body は UI 整理、最小震度、警報統合、重大な通知説明、Live Activity/グローバル不変条件、テスト結果、backend Draft PR の依存関係を記載する。

- [ ] **Step 6: PR を read-back する**

```bash
gh pr view --repo YumNumm/eqmonitor-backend codex/free-eew-warning-nationwide --json url,isDraft,title,baseRefName,headRefName
gh pr view --repo YumNumm/EQMonitor codex/notification-custom-settings-ui --json url,isDraft,title,baseRefName,headRefName
```

Expected: 2件とも Draft、base `develop`、意図した head branch。
