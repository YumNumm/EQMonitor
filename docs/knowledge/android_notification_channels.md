# Android 通知 channel

正本は `app/lib/core/fcm/channels.dart`、`android_notification_channel_initializer.dart` と AndroidManifest。配信側の Channel ID も同時に照合する。

- Android の通知音・vibration・importance は作成済み channel と利用者設定が決める。FCM の配送 priority、Apple の interruption level、per-message sound と混同しない。
- 同 ID への再登録で sound や importance 引き上げは適用できない。未変更 channel の importance 引き下げは適用され得るため、registry 変更を安全な no-op とみなさない。
- high/default は Android 標準音、low は無音を初期値とし、全 channel の `bypassDnd` は false。不明なイベントを推測した音・ID・importance へ fallback しない。
- ID 変更は利用者の旧設定を引き継げないため影響を確認する。同 ID の delete/recreate でも旧設定が復元される場合があり、既定値の強制更新には使えない。
- 現役 channel を毎起動で削除しない。再作成までの受信が Manifest fallback へ流れる競合を作る。
- initializer は legacy ID から現行 registry を除外して削除し、group、channel の順に全操作を await する。`eew_forecast` と `bgl_debug` は削除対象から除外する。
- group は EEW・地震・津波・防災・service。ID 全一覧や件数を文書へ複製せず、registry とそのテストで重複・group 参照を確認する。
- Android で通知 plugin を取得できない場合は `StateError`。no-op で未作成を隠さない。no-op platform は non-Android に限定する。
- Manifest の `service_fallback` は Channel 未指定の FCM 用。意味別 channel の選択漏れを吸収する用途には使わない。
- Webhook の任意 ID は契約を維持し、未知の ID を registry へ固定追加したり別 ID へ置換したりしない。

変更時は app の registry・移行対象・Manifest と backend resolver を照合し、利用者設定への影響を確認する。`app/` で `mise exec -- flutter test test/core/fcm --dart-define=CI=true` を実行し、実際の通知表示も確認する。
