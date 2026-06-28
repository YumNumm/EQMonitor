# Notification Settings Slot UI Design

- 作成日: 2026-06-29
- 対象: Flutter アプリ (`app/`)
- ステータス: UI プロトタイプ設計

## 背景・目的

通知設定 API が、EEW/地震ごとの地域設定から、`current_location` / `nationwide` / `region` の通知スロット設計へ移行している。
アプリ側も旧 `isCurrentLocation` 付き region 設定 UI から、場所を軸にした UI へ作り直す。

最初の実装では状態保存や API 接続を深追いせず、既存の通知設定トップ画面を新しい UI の静的プロトタイプに置き換える。
この画面を見ながら、情報密度・文言・Free/Pro 表現・操作単位を詰める。

関連:

- https://github.com/YumNumm/eqmonitor-backend/issues/722
- https://github.com/YumNumm/eqmonitor-backend/issues/723

## 対象範囲

対象は `NotificationSettingsPage` の UI 置き換え。
既存の EEW / 地震情報 / 揺れ検知の詳細ページ導線は、このプロトタイプでは使わない。

オンボーディングは同じ通知設定概念へ後続で接続するが、今回の UI プロトタイプでは直接変更しない。

## 画面構成

通知設定トップは、以下の順に縦スクロールで配置する。

1. 全体設定
2. 現在地
3. 全国
4. 登録地域
5. ツール

### 全体設定

スロットに依存しない設定を上部に置く。

- 通知全体
- EEW 予報のデフォルト音・割り込みレベル
- 地震情報のデフォルト音・割り込みレベル
- Live Activity
- 推定震度発表時の通知
- 1点検知

初回プロトタイプでは実際の変更処理を持たず、スイッチやセレクタは見た目のみとする。

### 現在地

現在地で受け取る通知を1つのカードにまとめる。

- EEW 予報: ON/OFF、最小予想震度
- 地震情報: ON/OFF、最小観測震度
- EEW 警報: ON/OFF、重大な通知として受信

現在地は `device_location` に紐づくため、地域名の手動編集 UI は置かない。

### 全国

全国対象の通知を1つのカードにまとめる。

- EEW 予報: ON/OFF、最小予想震度
- 地震情報: ON/OFF、最小観測震度
- EEW 警報: Pro 制約付き。通常またはサイレントの表現を置く

Free では全国 EEW 警報が使えないことを、無効状態と Pro バッジで表現する。

### 登録地域

登録地域スロットを一覧表示する。

- Free: 共有1地域
- Pro: 共通5地域
- 各地域カードに EEW 予報 / 地震情報を並べる
- Free で上限超過した地域は、グレーアウトと「Proで有効化」バッジで表現する
- Free 状態でも削除はできる前提の見た目にする

地域追加ボタンは置くが、初回プロトタイプでは保存処理を持たない。

### ツール

既存の通知履歴、テスト通知、Android 通知設定への導線は残す。
ただし通知設定の詳細ページへの旧導線は外す。

## UI 方針

- 画面の主軸は「場所」とする。
- 「全体設定」は場所別カードより上に置く。
- 既存の Material 3 / SettingsSectionHeader / ListTile ベースの見た目を維持する。
- 複雑な詳細設定は、この段階ではカード内のコンパクトな行として見せる。
- 保存状態は実装しないため、操作時は軽い SnackBar でプロトタイプであることを示す。

## データ層方針

今回の UI プロトタイプでは、新しい notifier / repository / Mutation を実装しない。
後続実装では、以下の API を中心に接続する。

- `GET /v2/device/me/settings/slots`
- `PUT /v2/device/me/settings/slots/current-location`
- `PUT /v2/device/me/settings/slots/nationwide`
- `GET /v2/device/me/settings/slots/regions`
- `POST /v2/device/me/settings/slots/regions`
- `PATCH /v2/device/me/settings/slots/regions/{slotId}`
- `DELETE /v2/device/me/settings/slots/regions/{slotId}`
- `GET/PATCH /v2/device/me/settings/notification-defaults`
- `GET/PATCH /v2/device/me/settings/eew-warning`
- `StartResponse.planConstraints`

状態変更は Riverpod 3 の Mutation で扱う予定。

## エラー・ローディング

初回プロトタイプでは API を呼ばないため、ローディングとエラー表示は実装しない。
後続の API 接続時に、設定読み込み失敗時の再試行 UI と保存失敗時の SnackBar を追加する。

## テスト

初回プロトタイプでは UI の構造変更が中心のため、手動確認を優先する。
後続のデータ層接続時に、以下を追加する。

- スロットモデル変換の単体テスト
- Free/Pro 制約判定の単体テスト
- 通知設定ページの主要セクションが描画される Widget テスト

## スコープ外

- 新 API への実接続
- 通知設定保存処理
- 音選択 UI
- ユーザーインポート通知音
- Paywall 遷移
- オンボーディングから新スロット API への保存
- 既存旧 notifier / repository の削除

## 主要参照ファイル

- 通知設定トップ: `app/lib/feature/settings/features/notification_settings/ui/page/notification_settings_page.dart`
- 旧 EEW 設定: `app/lib/feature/settings/features/notification_settings/ui/page/eew_settings_page.dart`
- 旧地震設定: `app/lib/feature/settings/features/notification_settings/ui/page/earthquake_settings_page.dart`
- 旧 repository: `app/lib/feature/settings/features/notification_settings/data/repository/device_notification_settings_repository.dart`
- 生成 API client: `packages/eqmonitor_api/lib/src/clients/device_api_client.dart`
- スロット型: `packages/eqmonitor_api/lib/src/models/slot_response.dart`
- プラン制約型: `packages/eqmonitor_api/lib/src/models/plan_constraints.dart`
