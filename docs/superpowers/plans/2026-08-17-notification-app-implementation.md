# Notification App Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** iOSでEEW警報の現在地/全国配信レベルと重大な通知権限を正しく設定でき、Androidではbackendの全FCM通知に対応するChannelをOS設定として提供し、EEW予報しきい値UIを地域種別に合わせる。

**Architecture:** backend OpenAPIからDart clientを再生成し、アプリdomain modelへ現在地レベルを変換する。slot別しきい値・表記・subtitleは純粋なpolicy/formatterへ分離し、Android Channel定義と初期化順はテスト可能なregistry/serviceに分離する。

**Tech Stack:** Flutter 3.44、Dart 3.11、Riverpod 3、Freezed、flutter_hooks、flutter_local_notifications、firebase_messaging、Widget test。

## Global Constraints

- Flutter/Dartコマンドはすべて `mise exec --` 経由で実行する。
- 現在地警報は `passive` / `active` / `timeSensitive` / `critical`、既定値は `critical`。
- 全国警報は `passive` / `active` / `timeSensitive` のみで、criticalを表示・送信しない。
- 重大な通知Cardは警報有効、現在地levelがcritical、Apple重大通知対応、権限未許可の全条件成立時だけ表示する。
- Androidでは予想震度別設定、通知音・割り込みレベル、警報配信レベルを表示しない。
- Androidの音・バイブレーション・表示importanceはOS Channel設定を正とする。
- 現在地・地域のEEW予報しきい値は「すべて、震度4、震度5弱、震度5強、震度6弱、震度6強、震度7」。
- 全国のEEW予報しきい値は「すべて、震度1、震度2、震度3、震度4、震度5弱、震度5強、震度6弱、震度6強、震度7」。
- `5-` / `5+` / `6-` / `6+` は当該UIで `5弱` / `5強` / `6弱` / `6強` と表示する。
- Webhook、App/backend横断契約テスト、段階切り替えは変更しない。
- ユーザーの既存変更 `analysis_options.yaml`、`mise.lock`、各packageの`analysis_options.yaml` はステージしない。

---

### Task 1: backend API client再生成と警報domain model

**Files:**
- Modify: `backend` (submodule pointer; backend PRの検証済みcommit)
- Regenerate: `packages/eqmonitor_api/openapi/openapi.json`
- Regenerate: `packages/eqmonitor_api/lib/src/**`
- Modify: `app/lib/feature/settings/features/notification_settings/data/model/eew_warning_settings.dart`
- Modify: `app/lib/feature/settings/features/notification_settings/data/model/notification_override.dart`
- Modify: `app/lib/feature/settings/features/notification_settings/data/notifier/eew_warning_config_notifier.dart`
- Modify: `app/lib/feature/settings/features/notification_settings/data/repository/notification_slot_repository.dart`
- Test: `app/test/feature/settings/features/notification_settings/eew_warning_settings_model_test.dart`
- Test: `app/test/feature/settings/features/notification_settings/notification_slot_repository_test.dart`

**Interfaces:**
- Produces: `EewWarningSettings.currentLocationInterruptionLevel: InterruptionLevel`。
- Produces: 全国enumの `timeSensitive` converterと、現在地levelをPATCHするrepository API。

- [ ] **Step 1: domain変換とPATCH引数の失敗テストを書く**

```dart
test('maps current critical and nationwide time-sensitive', () {
  final model = const api.EewWarningConfigResponse(
    target: api.Target.currentLocationAndNationwide,
    currentLocationInterruptionLevel:
        api.CurrentLocationInterruptionLevel.critical,
    nationwideInterruptionLevel:
        api.NationwideInterruptionLevel.timeSensitive,
  ).toEewWarningSettings();
  expect(model.currentLocationInterruptionLevel, InterruptionLevel.critical);
  expect(model.nationwideInterruptionLevel, InterruptionLevel.timeSensitive);
});
```

repositoryテストは `currentLocationInterruptionLevel: .active` と `nationwideInterruptionLevel: .timeSensitive` が生成API requestへ渡ることを検証する。

- [ ] **Step 2: 現行生成modelで失敗を確認する**

Run: `cd app && mise exec -- flutter test test/feature/settings/features/notification_settings/eew_warning_settings_model_test.dart test/feature/settings/features/notification_settings/notification_slot_repository_test.dart`

Expected: current fieldまたはnationwide `timeSensitive` が存在せずFAIL。

- [ ] **Step 3: backend OpenAPIからclientを再生成する**

Run: `cd packages/eqmonitor_api && mise exec -- dart run bin/generate.dart`

Expected: current-location enum/fieldとnationwide `timeSensitive` が生成され、nationwideにcriticalがない。

- [ ] **Step 4: app domain/repository/notifierを新契約へ接続する**

```dart
const factory EewWarningSettings({
  required EewWarningTarget target,
  required InterruptionLevel currentLocationInterruptionLevel,
  required InterruptionLevel? nationwideInterruptionLevel,
}) = _EewWarningSettings;
```

`updateConfig` と `patchEewWarningConfig` に `currentLocationInterruptionLevel` を追加する。nationwide converterはpassive/active/timeSensitiveだけを網羅し、criticalへのnullable fallbackを置かない。

- [ ] **Step 5: code generationと対象テストを通す**

Run: `mise exec -- dart run build_runner build --delete-conflicting-outputs`

Run: `cd app && mise exec -- flutter test test/feature/settings/features/notification_settings/eew_warning_settings_model_test.dart test/feature/settings/features/notification_settings/notification_slot_repository_test.dart`

Run: `cd packages/eqmonitor_api && mise exec -- dart analyze`

Expected: すべて成功。

- [ ] **Step 6: コミットする**

```bash
git add backend packages/eqmonitor_api app/lib/feature/settings/features/notification_settings/data app/test/feature/settings/features/notification_settings/eew_warning_settings_model_test.dart app/test/feature/settings/features/notification_settings/notification_slot_repository_test.dart
git commit -m "Feat: EEW警報の配信レベル契約を反映"
```

---

### Task 2: iOS警報配信レベルと重大な通知Card

**Files:**
- Create: `app/lib/feature/settings/features/notification_settings/ui/component/critical_alert_permission_card.dart`
- Create: `app/lib/feature/settings/features/notification_settings/ui/component/interruption_level_selector.dart`
- Modify: `app/lib/feature/settings/features/notification_settings/ui/page/notification_settings_page.dart`
- Test: `app/test/feature/settings/features/notification_settings/notification_settings_page_eew_warning_test.dart`

**Interfaces:**
- Consumes: `EewWarningSettings.currentLocationInterruptionLevel`。
- Produces: iOS限定の現在地/全国level selectorと権限Card。

- [ ] **Step 1: Widgetの失敗テストを書く**

```dart
testWidgets('shows critical permission card only for enabled critical iOS',
    (tester) async {
  debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
  addTearDown(() => debugDefaultTargetPlatformOverride = null);
  await pumpWarningPage(
    tester,
    warningEnabled: true,
    currentLevel: InterruptionLevel.critical,
    criticalAlert: AppleNotificationSetting.disabled,
  );
  expect(find.text('重大な通知を許可'), findsOneWidget);
});

testWidgets('nationwide selector has no critical option', (tester) async {
  await pumpWarningPage(
    tester,
    target: EewWarningTarget.currentLocationAndNationwide,
  );
  expect(find.text('タイムセンシティブ'), findsOneWidget);
  expect(find.text('重大な通知'), findsOneWidget); // 現在地側のみ
});
```

同じhelperで警報無効、current active、権限granted、critical unsupportedの各条件ではCardがないことも検証する。ボタンtapでは既存 `showCriticalAlertPermissionDialog` が開くことを確認する。

- [ ] **Step 2: 現行画面で失敗を確認する**

Run: `cd app && mise exec -- flutter test test/feature/settings/features/notification_settings/notification_settings_page_eew_warning_test.dart`

Expected: current selector、time-sensitive、CardがなくFAIL。

- [ ] **Step 3: selectorとCardを実装する**

```dart
const currentLocationLevels = [
  InterruptionLevel.passive,
  InterruptionLevel.active,
  InterruptionLevel.timeSensitive,
  InterruptionLevel.critical,
];
const nationwideLevels = [
  InterruptionLevel.passive,
  InterruptionLevel.active,
  InterruptionLevel.timeSensitive,
];
```

表示ラベルは `パッシブ`、`アクティブ`、`タイムセンシティブ`、`重大な通知` とする。Card本文は「現在地が緊急地震速報（警報）の対象になった場合に、消音モード中でも通知するには重大な通知の許可が必要です。」、ボタンは「重大な通知を許可」とする。

- [ ] **Step 4: Androidではlevel編集を出さずOS設定導線を出す**

`Theme.of(context).platform == TargetPlatform.iOS` の場合だけselectorを構築する。Androidでは「Androidの通知設定」ListTileから既存の `AppSettings.openAppSettings(type: AppSettingsType.notification)` を呼ぶ。

- [ ] **Step 5: Widgetテストを通す**

Run: `cd app && mise exec -- flutter test test/feature/settings/features/notification_settings/notification_settings_page_eew_warning_test.dart`

Expected: すべて成功。

- [ ] **Step 6: コミットする**

```bash
git add app/lib/feature/settings/features/notification_settings/ui app/test/feature/settings/features/notification_settings/notification_settings_page_eew_warning_test.dart
git commit -m "Feat: iOS警報レベルと重大通知権限を追加"
```

---

### Task 3: EEW予報しきい値policy・表記・subtitle

**Files:**
- Create: `app/lib/feature/settings/features/notification_settings/data/model/eew_forecast_threshold_policy.dart`
- Create: `app/lib/feature/settings/features/notification_settings/ui/formatter/notification_slot_formatter.dart`
- Modify: `app/lib/feature/settings/features/notification_settings/ui/page/slot_detail_page.dart`
- Modify: `app/lib/feature/settings/features/notification_settings/ui/page/eew_forecast_settings_page.dart`
- Test: `app/test/feature/settings/features/notification_settings/eew_forecast_threshold_policy_test.dart`
- Create: `app/test/feature/settings/features/notification_settings/notification_slot_formatter_test.dart`
- Create: `app/test/feature/settings/features/notification_settings/eew_forecast_settings_page_test.dart`
- Create: `app/test/feature/settings/features/notification_settings/slot_detail_page_test.dart`

**Interfaces:**
- Produces: `EewForecastThresholdPolicy.valuesFor(NotificationSlotType)`。
- Produces: `NotificationSlotFormatter.intensityLabel`、`displayName`、`thresholdSubtitle`。

- [ ] **Step 1: 純粋policy/formatterの失敗テストを書く**

```dart
expect(
  EewForecastThresholdPolicy.valuesFor(NotificationSlotType.currentLocation),
  [JmaIntensity.zero, JmaIntensity.four, JmaIntensity.fiveLower,
   JmaIntensity.fiveUpper, JmaIntensity.sixLower,
   JmaIntensity.sixUpper, JmaIntensity.seven],
);
expect(NotificationSlotFormatter.intensityLabel(JmaIntensity.zero), 'すべて');
expect(NotificationSlotFormatter.intensityLabel(JmaIntensity.fiveLower), '震度5弱');
expect(NotificationSlotFormatter.thresholdSubtitle(current),
  '現在地でこの震度以上が予想された場合に通知します');
expect(NotificationSlotFormatter.thresholdSubtitle(prefecture),
  '東京都でこの震度以上が予想された場合に通知します');
expect(NotificationSlotFormatter.thresholdSubtitle(city),
  '東京都新宿区でこの震度以上が予想された場合に通知します');
expect(NotificationSlotFormatter.thresholdSubtitle(nationwide),
  '全国でこの震度以上が予想された場合に通知します');
```

- [ ] **Step 2: 現行共通selectableValues/labelで失敗を確認する**

Run: `cd app && mise exec -- flutter test test/feature/settings/features/notification_settings/eew_forecast_threshold_policy_test.dart test/feature/settings/features/notification_settings/notification_slot_formatter_test.dart`

Expected: policy/formatter不在でFAIL。

- [ ] **Step 3: policyとformatterを実装する**

`zero` は「すべて」、weak/strongは日本語表記にする。地域名は `regionName` と `cityName` を空白なしで連結する。unknown、fiveUnknown、sixUnknown、およびslot別許可外の値は黙って「すべて」へ変換せず `StateError` にする。

- [ ] **Step 4: 両画面を共通policyへ接続する**

表示名を「通知する予想震度のしきい値」へ変更し、subtitleをListTileへ追加する。`EewForecastSettingsPage` のsection名も同じ文言にする。dropdownはslot typeを受け取り、`valuesFor` のみを列挙する。

- [ ] **Step 5: model・Widgetテストを通す**

Run: `cd app && mise exec -- flutter test test/feature/settings/features/notification_settings/eew_forecast_threshold_policy_test.dart test/feature/settings/features/notification_settings/notification_slot_formatter_test.dart test/feature/settings/features/notification_settings/eew_forecast_settings_page_test.dart test/feature/settings/features/notification_settings/slot_detail_page_test.dart`

Expected: すべて成功。

- [ ] **Step 6: コミットする**

```bash
git add app/lib/feature/settings/features/notification_settings/data/model/eew_forecast_threshold_policy.dart app/lib/feature/settings/features/notification_settings/ui/formatter app/lib/feature/settings/features/notification_settings/ui/page/slot_detail_page.dart app/lib/feature/settings/features/notification_settings/ui/page/eew_forecast_settings_page.dart app/test/feature/settings/features/notification_settings
git commit -m "Feat: EEW予報しきい値を地域別に表示"
```

---

### Task 4: iOS限定設定と不要コピーの削除

**Files:**
- Modify: `app/lib/feature/settings/features/notification_settings/ui/page/notification_settings_page.dart`
- Modify: `app/lib/feature/settings/features/notification_settings/ui/page/slot_detail_page.dart`
- Create: `app/test/feature/settings/features/notification_settings/notification_platform_visibility_test.dart`
- Modify: `app/test/feature/settings/features/notification_settings/notification_settings_page_eew_warning_test.dart`

**Interfaces:**
- Produces: iOS/Android別の設定項目visibility。

- [ ] **Step 1: platform visibilityとコピー削除の失敗テストを書く**

```dart
testWidgets('Android hides sound, interruption and per-intensity settings',
    (tester) async {
  debugDefaultTargetPlatformOverride = TargetPlatform.android;
  addTearDown(() => debugDefaultTargetPlatformOverride = null);
  await pumpCustomSettings(tester, isPro: true);
  expect(find.text('通知音・割り込みレベル'), findsNothing);
  expect(find.text('震度別の音設定'), findsNothing);
  expect(find.text('震度別設定'), findsNothing);
});

testWidgets('does not show downgrade retention copy', (tester) async {
  await pumpCustomSettings(tester, isPro: false);
  expect(find.textContaining('ダウングレード時も設定は保持され'), findsNothing);
});
```

- [ ] **Step 2: 現行Android UIで失敗を確認する**

Run: `cd app && mise exec -- flutter test test/feature/settings/features/notification_settings/notification_platform_visibility_test.dart`

Expected: Androidにも対象項目とコピーが表示されFAIL。

- [ ] **Step 3: platform分岐とコピー削除を実装する**

`Theme.of(context).platform == TargetPlatform.iOS` の場合だけ、カスタム設定の通知音・割り込みレベル、震度別の音設定、slot detailの震度別設定を構築する。Androidは画面下部のChannel設定導線を残す。指定されたダウングレード文章のPadding全体を削除する。

- [ ] **Step 4: Widgetテストを通す**

Run: `cd app && mise exec -- flutter test test/feature/settings/features/notification_settings/notification_platform_visibility_test.dart test/feature/settings/features/notification_settings/notification_settings_page_eew_warning_test.dart`

Expected: すべて成功。

- [ ] **Step 5: コミットする**

```bash
git add app/lib/feature/settings/features/notification_settings/ui/page/notification_settings_page.dart app/lib/feature/settings/features/notification_settings/ui/page/slot_detail_page.dart app/test/feature/settings/features/notification_settings
git commit -m "Fix: AndroidでiOS専用通知設定を非表示"
```

---

### Task 5: Android Channel registryと初期化

**Files:**
- Replace: `app/lib/core/fcm/channels.dart`
- Create: `app/lib/core/fcm/android_notification_channel_initializer.dart`
- Modify: `app/lib/main.dart`
- Modify: `app/android/app/src/main/AndroidManifest.xml`
- Create: `app/test/core/fcm/channels_test.dart`
- Create: `app/test/core/fcm/android_notification_channel_initializer_test.dart`

**Interfaces:**
- Produces: `notificationChannelGroups`、`notificationChannels`、`legacyNotificationChannelIds`。
- Produces: `AndroidNotificationChannelInitializer.initialize()`。

- [ ] **Step 1: registry整合性の失敗テストを書く**

```dart
test('channel ids are unique and every group exists', () {
  final ids = notificationChannels.map((channel) => channel.id).toList();
  expect(ids.toSet(), hasLength(ids.length));
  final groups = notificationChannelGroups.map((group) => group.id).toSet();
  for (final channel in notificationChannels) {
    expect(groups, contains(channel.groupId));
  }
});

test('deletes legacy channels before creating new channels', () async {
  final fake = FakeAndroidNotificationChannelPlatform();
  await AndroidNotificationChannelInitializer(platform: fake).initialize();
  expect(fake.operations.take(legacyNotificationChannelIds.length),
      everyElement(startsWith('delete:')));
  expect(fake.operations.last, startsWith('channel:'));
});
```

- [ ] **Step 2: 現行registryで失敗を確認する**

Run: `cd app && mise exec -- flutter test test/core/fcm/channels_test.dart test/core/fcm/android_notification_channel_initializer_test.dart`

Expected: semantic ID、全group、削除順serviceがなくFAIL。

- [ ] **Step 3: 設計書どおりの5 group・24 channelを定義する**

Groupは `eew`、`earthquake`、`tsunami`、`safety_information`、`service`。Channel ID、用途、importanceは設計書 `2026-08-16-notification-settings-and-android-channels-design.md` の表を完全一致させる。high/defaultはAndroid標準音、lowは `playSound: false` とする。DND bypassは設定しない。

削除対象には既存の `fromdev`、`bgl_debug`、`eew_warning`、`eew_forecast`、`eew_low_accuracy`、`VXSE51`、`VXSE52`、`VXSE53`、`VXSE61`、`VXSE62`、`VZSE40`、`VYSE50`、`VYSE51`、`VYSE52`、`test`、`test_critical` を含める。

- [ ] **Step 4: testable initializerへmainの処理を移す**

```dart
abstract interface class AndroidNotificationChannelPlatform {
  Future<void> deleteChannel(String id);
  Future<void> createGroup(AndroidNotificationChannelGroup group);
  Future<void> createChannel(AndroidNotificationChannel channel);
}
```

initializerは旧ID削除、group作成、channel作成の順で全件awaitする。実装adapterは `AndroidFlutterLocalNotificationsPlugin` を包み、Android以外ではno-opにする。`main.dart` の既存private登録関数は削除してinitializerをawaitする。

- [ ] **Step 5: Manifest fallbackを設定する**

```xml
<meta-data
    android:name="com.google.firebase.messaging.default_notification_channel_id"
    android:value="service_fallback" />
```

- [ ] **Step 6: Channelテストを通す**

Run: `cd app && mise exec -- flutter test test/core/fcm/channels_test.dart test/core/fcm/android_notification_channel_initializer_test.dart`

Expected: すべて成功。

- [ ] **Step 7: コミットする**

```bash
git add app/lib/core/fcm app/lib/main.dart app/android/app/src/main/AndroidManifest.xml app/test/core/fcm
git commit -m "Feat: Android通知チャネルを再構成"
```

---

### Task 6: Android通知知見の記録

**Files:**
- Create: `docs/knowledge/20260817_android_notification_channels.md`

**Interfaces:**
- Produces: 今後のChannel変更で守る運用ルール。

- [ ] **Step 1: platform固有知見を記録する**

文書には次を具体的に記載する。

```text
- Android 8.0+では既存Channelのimportance/soundをアプリ更新で変更できない。
- FCM android.priorityは配送priorityで、Channel importanceとは別。
- Android 8.0+ではper-message sound/notification priorityよりChannel設定が優先される。
- Channel ID変更・削除はユーザー設定を失うため、今回の一括置換のように明示承認された場合だけ行う。
- backendのChannel ID追加時はapp registryとManifest fallbackを同時に確認する。
- 確認コマンド: `mise exec -- flutter test test/core/fcm`。
```

- [ ] **Step 2: 文書をコミット・pushする**

```bash
git add docs/knowledge/20260817_android_notification_channels.md
git commit -m "Docs: Android通知チャネル運用を記録"
git push
```

---

### Task 7: App全体検証とPR

**Files:**
- Verify: App/root working tree全体

**Interfaces:**
- Consumes: backend PRのcommit SHA。
- Produces: EQMonitor draft PR URL。

- [ ] **Step 1: formatと差分検査を実行する**

Run: `mise exec -- dart format app/lib app/test packages/eqmonitor_api/lib packages/eqmonitor_api/test`

Run: `git --no-pager diff --check`

Run: `git --no-pager status --short`

Expected: 対象差分のみ。ユーザー既存変更はunstagedのまま。

- [ ] **Step 2: 対象テストをまとめて実行する**

Run: `cd app && mise exec -- flutter test test/feature/settings/features/notification_settings test/core/fcm test/core/provider/notification`

Run: `cd packages/eqmonitor_api && mise exec -- dart test`

Expected: すべてexit 0。

- [ ] **Step 3: analyzeを実行する**

Run: `cd app && mise exec -- dart analyze lib/feature/settings/features/notification_settings lib/core/fcm test/feature/settings/features/notification_settings test/core/fcm --fatal-infos`

Run: `cd packages/eqmonitor_api && mise exec -- dart analyze`

Expected: 今回変更範囲にwarning/errorなし。

- [ ] **Step 4: 最終差分をレビューしpushする**

Run: `git --no-pager diff origin/main...HEAD --stat`

Run: `git --no-pager log --oneline origin/main..HEAD`

Expected: 小分けコミット、backend pointerはbackend PRのhead commit、不要なユーザー変更なし。

Run: `git push`

- [ ] **Step 5: App draft PRを作成する**

```bash
gh pr create --repo YumNumm/EQMonitor --draft \
  --title "Feat: 通知設定とAndroid通知チャネルを再設計" \
  --body-file /tmp/eqmonitor-app-notification-pr.md
```

PR本文にはbackend PRへの依存リンク、iOS/Android差分、しきい値選択肢、重大通知Card、Channel一覧、旧Channel削除、テスト結果を記載する。
