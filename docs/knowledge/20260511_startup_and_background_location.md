# 起動失敗フォールバックとAndroid位置更新の注意点

## 背景
- `Firebase.initializeApp` より前の例外で `FirebaseCrashlytics.instance` を参照すると、デフォルトFirebaseアプリ未作成のため二次例外になり得る。
- Android の `PendingIntent`/`BroadcastReceiver` で受けた位置更新は、Flutterエンジン稼働中でも自動では Dart の `FlutterApi` に届かない。

## ルール
- 起動失敗フォールバックでは、Firebase初期化済みであることを確認してからCrashlyticsへ記録する。
- Crashlytics記録に失敗しても、エラー画面表示を妨げない。
- Androidの位置更新は、Flutter APIへ明示的に橋渡しし、Dart側リスナー登録前に届く可能性も考慮して最新値を保持する。

## 確認コマンド
```bash
mise exec -- flutter test app/test/feature/location/background_location_tracker_test.dart
mise exec -- flutter analyze app/lib/main.dart app/lib/feature/location/data/background_location_service.dart
```
