# Task 6 Fix Report

## 対応内容

`docs/knowledge/20260817_android_notification_channels.md` 冒頭の既存Channel更新に関する
絶対表現を、Android `NotificationManager.createNotificationChannel` のAPI契約に合わせて
修正した。

- `sound` などの通知behaviorと `importance` の引き上げは既存の同一IDへ適用できない。
- ユーザーが変更したChannel設定はアプリ側の再登録より優先される。
- ユーザーが設定を変更していない場合、既存値より低い `importance` への引き下げは
  適用されることがある。
- registry変更を安全なno-opとみなさず、生命安全への影響を評価する必要がある。

## 検証

- 修正箇所をreadbackし、指摘された例外と運用上の注意が含まれることを確認した。
- 対象2ファイルの `git diff --check` を実行した。
- アプリおよびbackendのコードは変更していない。
- 既存のdirty 6ファイルはステージも変更もしていない。
