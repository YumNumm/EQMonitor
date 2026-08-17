# Android Notification Channel の運用ルール

## Channel が通知表示を決める

Android 8.0（API 26）以降では、Channel作成後にアプリを更新しても、同じChannel IDの
`importance` や `sound` を上書きできない。EQMonitorのAndroid `minSdk` は29のため、
すべての対応端末でこの制約を前提にする。

- FCMの `android.priority` は端末までの配送priorityであり、Channelのimportanceとは別物。
- Android 8.0以降では、per-messageのsoundやnotification priorityより、端末に作成済みの
  Channelのsound・vibration・importanceが通知表示を決める。
- Appleのinterruption levelやper-message soundからAndroidのimportanceを推測しない。
- `high` と `default` は `sound: null` / `playSound: true` でAndroid標準音を使う。
- `low` は `playSound: false` とし、無音を初期値にする。
- 全Channelで `bypassDnd: false` とし、アプリからDND bypassを有効化しない。
- 存在や互換性を確認できていない専用音、Channel ID、importanceへ固定値で
  フォールバックしない。イベントに対応するChannelが不明なら契約不整合として修正する。

## IDの変更・削除は通常運用にしない

Channel IDを変更すると、利用者が旧Channelへ設定した音・バイブレーション・importanceを
新Channelへ引き継げない。ID変更や削除は、今回の一括置換のように影響を確認して
明示承認された場合だけ行う。

同じIDをdeleteして直後にcreateしても、Androidが削除前のユーザー設定を復元することがあり、
新しい既定値へ完全移行できるとは限らない。既定値を強制更新する手段として
delete/recreateへ依存しない。

さらに、通知対象として現役のChannelを起動中に削除すると、再作成までに受信したFCM通知が
Manifestのfallback Channelへ流れる競合が発生する。したがって、現行Channelを毎起動で
deleteしてはならない。

`legacyNotificationChannelIds` は移行契約上の16 IDを保持するが、initializerの実削除対象は
現行registryのIDを差し引いた14 IDである。現行の次の2 IDは削除対象から必ず除外する。

- `eew_forecast`
- `bgl_debug`

initializerは、実削除対象のlegacy ID削除、5 group作成、24 channel作成の順に、全操作を
逐次 `await` する。この順序やactive ID除外を変更する場合は、FCM受信との競合と
ユーザー設定への影響を再評価する。

## 初期化失敗を隠さない

Androidで `AndroidFlutterLocalNotificationsPlugin` を解決できない場合は `StateError` とし、
no-opで起動を継続してはならない。no-op platformを使用できるのはwebやiOSなど
non-Androidだけである。Androidでのno-opはChannel未作成を隠し、生命に関わる通知を
意図しないfallbackへ送るため禁止する。

## 現行registry

groupは次の5件である。

- `eew`
- `earthquake`
- `tsunami`
- `safety_information`
- `service`

Channelは次の24件である。追加・削除時は件数だけでなく、ID重複と参照groupも検証する。

- `eew`: `eew_warning_current_location`, `eew_warning_nationwide`,
  `eew_forecast`, `eew_low_accuracy_v2`
- `earthquake`: `earthquake_vxse51`, `earthquake_vxse52`, `earthquake_vxse53`,
  `earthquake_vxse61`, `earthquake_vxse62`, `earthquake_estimated_intensity`
- `tsunami`: `tsunami_major_warning`, `tsunami_warning`, `tsunami_advisory`,
  `tsunami_update`, `tsunami_passive`
- `safety_information`: `earthquake_notice`, `nankai_information`,
  `aftershock_advisory`, `shake_detection`, `training_information`
- `service`: `service_test`, `service_test_critical`, `service_fallback`, `bgl_debug`

AndroidManifestの
`com.google.firebase.messaging.default_notification_channel_id` は `service_fallback` を指す。
これはChannel未指定通知のFCM fallbackであり、意味別Channelの選択漏れを吸収するための
固定フォールバックとして使用しない。

## Channel契約を変更する手順

Channel IDを追加・変更するときはappだけ、またはbackendだけを先行変更せず、少なくとも
次を同時に確認する。

1. `app/lib/core/fcm/channels.dart` のgroup・Channel定義、importance、sound、DND設定。
2. `app/lib/core/fcm/android_notification_channel_initializer.dart` のlegacy削除対象と初期化順。
3. `app/android/app/src/main/AndroidManifest.xml` の `service_fallback`。
4. backend notification resolverが、EEW・地震・津波・防災・serviceの各イベントへ指定する
   Channel ID。
5. ID変更・削除について利用者設定への影響が明示承認されていること。

Webhookの任意Channel ID契約は維持する。未知のWebhook Channelをapp registryへ無条件に
固定追加したり、意味を推測して別Channelへ置換したりしない。

## 確認コマンド

Flutter / Dartコマンドは必ず `mise exec --` 経由で実行する。

```bash
cd app
mise exec -- flutter test test/core/fcm
mise exec -- flutter analyze lib/core/fcm test/core/fcm --fatal-infos
cd ..
```

registry、Manifest、backendのChannel IDを横断確認する。

```bash
rg -n "service_fallback|eew_warning_current_location|eew_warning_nationwide" \
  app/lib/core/fcm \
  app/android/app/src/main/AndroidManifest.xml \
  backend/service/notification-resolver
```

active IDを削除していないことと、Android plugin解決失敗がno-opになっていないことも確認する。

```bash
rg -n "legacyNotificationChannelIds|notificationChannels|StateError|Noop" \
  app/lib/core/fcm/android_notification_channel_initializer.dart \
  app/test/core/fcm/android_notification_channel_initializer_test.dart
```
