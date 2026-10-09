# Android 通知 channel

正本は `app/lib/core/fcm/channels.dart`、`android_notification_channel_initializer.dart` と AndroidManifest。配信側の Channel ID も同時に照合する。

- Android の通知音・vibration・importance は作成済み channel と利用者設定が決める。FCM の配送 priority、Apple の interruption level、per-message sound と混同しない。
- 同 ID への再登録で sound や importance 引き上げは適用できない。未変更 channel の importance 引き下げは適用され得るため、registry 変更を安全な no-op とみなさない。
- high/default は Android 標準音、low は無音を初期値とし、全 channel の `bypassDnd` は false。不明なイベントを推測した音・ID・importance へ fallback しない。
- ID 変更は利用者の旧設定を引き継げないため影響を確認する。同 ID の delete/recreate でも旧設定が復元される場合があり、既定値の強制更新には使えない。
- 現役 channel を毎起動で削除しない。再作成までの受信が Manifest fallback へ流れる競合を作る。
- initializer は legacy ID から現行 registry を除外して削除し、group、channel の順に全操作を await する。`eew_forecast` と `bgl_debug` は削除対象から除外する。
- `IS_PRODUCTION=true` では揺れ検知 channel を作成せず、既存の同 channel を削除する。前面で届いた揺れ検知通知もローカル表示しない。
- group は EEW・地震・津波・防災・service。ID 全一覧や件数を文書へ複製せず、registry とそのテストで重複・group 参照を確認する。
- Android で通知 plugin を取得できない場合は `StateError`。no-op で未作成を隠さない。no-op platform は non-Android に限定する。
- Manifest の `service_fallback` は Channel 未指定・OS 未登録 ID に対する標準 FCM と同じ既定値。イベント型から重要度を推測して別 channel を選ばず、意味別 channel の選択漏れは配信側で修正する。
- Webhook の任意 ID は OS の既存 channel と利用者設定を維持する。OS 未登録なら FCM と同じ既定値で表示し、未知の ID を registry へ固定追加しない。

前面の FCM 通知は Android で自動表示されないため、`firebaseMessagingForegroundProvider` が受信し、`LocalNotificationRepository` でローカル通知として表示する。Apple の `setForegroundNotificationPresentationOptions` は Android へ適用されない。

- `notification` のないデータ通知は表示しない。チャンネル初期化を待ってから表示し、音・importance は既存 channel の設定を使う。旧 `test` / `test_critical` は移行先の `service_test` / `service_test_critical` を使う。
- 前面通知のアイコンは同梱 drawable の `ic_notification_icon` を使う。FCM の `@mipmap/...` 形式をローカル通知へ直接渡さない。
- Dart から名前で参照するアイコンは Android の resource shrinking が参照を追跡できないため、`app/android/app/src/main/res/raw/eqmonitor_notification_keep.xml` で保持する。削除されると通知プラグインの初期化が `invalid_icon` で失敗する。release 成果物の画像とリソース登録を確認し、debug の表示成功だけで判断しない。
- ローカル通知の payload に FCM の data を保存し、タップは既存の通知リンク判定・計測へ接続する。通知による起動の確認が完了するまで splash は待機し、通知がない場合や確認に失敗した場合も待機を解除する。
- Android だけローカル表示し、Apple の前面通知と二重表示しない。個別の表示失敗は記録し、次の受信を処理する。

変更時は app の registry・移行対象・Manifest と backend resolver を照合し、利用者設定への影響を確認する。`app/` で `mise exec -- flutter test test/core/fcm --dart-define=CI=true` を実行し、実際の通知表示も確認する。
