# Firebase通知権限の永久拒否状態

- `firebase_messaging_platform_interface` 4.10.0 の `AuthorizationStatus` には `deniedPermanently` がある。
- 権限状態を列挙するswitchではこの値も明示的に扱う。デバッグ端末設定画面では「拒否（端末の設定から変更）」と表示する。
- 未対応のままだとルーター経由でこの画面を参照するWidgetテストもコンパイルできない。
- 表示ラベルの追加のみで通知条件は変更しない。新規テストは追加せず、画面の静的解析と関連Widgetテストのコンパイルで検証する。

```sh
cd app
mise exec -- dart analyze --fatal-infos lib/feature/devices/ui/page/debug_device_settings_page.dart
```
