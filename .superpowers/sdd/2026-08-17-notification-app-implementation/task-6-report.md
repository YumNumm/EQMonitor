# Task 6 Report: Android通知知見の記録

## Status

完了。

## Documented

- Android 8.0以降では既存Channelのimportance/soundをアプリ更新で上書きできないこと。
- FCM配送priority、per-message設定、Channel importance/soundの責務分離。
- high/defaultのAndroid標準音、lowの無音、全ChannelのDND bypass無効。
- 同一IDのdelete/recreateで旧ユーザー設定が復元される場合があり、完全移行手段にならないこと。
- active Channel削除中のFCM fallback競合と、毎起動deleteの禁止。
- legacy 16 IDを契約として維持しつつ、activeな `eew_forecast` / `bgl_debug` を除いた14 IDだけを実削除すること。
- Android plugin解決失敗を `StateError` とし、no-opをnon-Androidだけに限定すること。
- 現行5 groups / 24 channelsとManifest `service_fallback`。
- app registry、initializer、Manifest、backend Channel選択の同時確認手順。
- `mise exec -- flutter test test/core/fcm` を含む具体的な確認コマンド。
- 未確認の専用音やChannel IDへ固定値fallbackしないこと。

## Sources Checked

- `docs/superpowers/specs/2026-08-16-notification-settings-and-android-channels-design.md`
- Task 5 implementation report and fix report
- `app/lib/core/fcm/channels.dart`
- `app/lib/core/fcm/android_notification_channel_initializer.dart`
- `app/android/app/src/main/AndroidManifest.xml`
- 既存の `docs/knowledge` 文書スタイル

## Verification

- knowledge document: 118 lines、500行以内。
- 必須6項目と追加運用知見を個別に照合した。
- source read-backで5 groups / 24 channels、legacy 16 / actual delete 14、active 2 ID除外、Android-null failure、Manifest fallbackを確認した。
- `git diff --check -- docs/knowledge/20260817_android_notification_channels.md`: exit 0。
- コード変更なし。
- ユーザーdirty 6ファイルは変更していない。

## Files Changed

- `docs/knowledge/20260817_android_notification_channels.md`

## Concerns

なし。
