# ダイアログ・フィードバック系を adaptive_platform_ui に統一

## 背景

DESIGN.md では「すべての確認ダイアログは `AdaptiveAlertDialog` を利用する」「一時的な通知は `AdaptiveSnackBar` を利用する」と定めている。
現状、複数の画面が Material の `AlertDialog` / `SnackBar` を直接使っており、iOS で Material らしい見た目が出てしまっている。

## 対象

### AlertDialog（6 箇所）

| ファイル | 用途 |
|---|---|
| `feature/settings/features/notification_settings/ui/page/eew_settings_page.dart:328` | EEW 通知設定の確認 |
| `feature/settings/features/notification_settings/ui/page/earthquake_settings_page.dart:367` | 地震通知設定の確認 |
| `feature/kyoshin_monitor/page/components/kyoshin_monitor_layer_information_dialog.dart:14` | レイヤー情報 |
| `feature/nied/ui/fnet/fnet_catalog_page.dart:228` | F-net イベント詳細 |
| `feature/nied/ui/aqua/aqua_catalog_page.dart:246` | AQUA イベント詳細 |
| `feature/settings/features/display_settings/color_scheme/color_scheme_config_page.dart:289` | カラースキーム確認 |

### SwitchListTile（2 箇所）

| ファイル | 用途 |
|---|---|
| `feature/devices/ui/page/debug_device_settings_page.dart:232` | デバッグデバイス設定 |
| `feature/devices/ui/page/debug_device_settings_page.dart:243` | デバッグデバイス設定 |

## やること

1. `AlertDialog` → `AdaptiveAlertDialog`（`adaptive_platform_ui` パッケージ）に置き換える。
2. デバッグページの `SwitchListTile` → `AppSwitchListTile`（または `ListTile` + `AppSwitch`）に置き換える。
3. `SnackBar` の raw 使用は数が多い（30+）ため、まず設定画面・ユーザー向け画面を優先し、デバッグ専用画面は後回しにする。

## 参照

- https://pub.dev/packages/adaptive_platform_ui
- `app/lib/core/component/widget/app_switch.dart`
