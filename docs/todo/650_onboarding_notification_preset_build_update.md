# オンボーディングの通知プリセット初期化で build 中に状態更新される

## 現象

iOS 26.4 シミュレーターで新規インストール後のオンボーディングを進めると、
通知設定画面の初期表示時に次の Flutter エラーが記録される。

```text
setState() or markNeedsBuild() called during build.
```

`NotificationPresetSelector` の `useEffect` から
`_NewUserNotificationSettingsStepPage` が保持する `ValueNotifier` を同期更新しており、
親 Widget の build 中に再ビルドを要求している。

## 該当箇所

- `app/lib/feature/onboarding/ui/components/notification_settings_step_page.dart`
- `app/lib/feature/settings/features/notification_settings/ui/component/notification_preset_selector.dart`

## 対応案

- 初期プリセットの導出を build 前の状態初期化へ移す。
- コールバック通知が必要な場合は、初期 build 完了後に一度だけ実行する。
- 新規インストール相当の Widget テストまたは iOS シミュレーターで再発しないことを確認する。
