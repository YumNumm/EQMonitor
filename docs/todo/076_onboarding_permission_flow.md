# オンボーディング — 権限リクエストフローの実装

## 背景

`/onboarding` ルートにオンボーディング画面を追加した（`a21e1b0f`）。
通知ステップの UI は「通知を許可してください」と表示しているが、実際の OS 権限リクエストは行っていない。
このままでは UI が嘘をついている状態になる。

## やること

1. **通知権限リクエスト**
   - 通知ステップの「次へ」ボタン押下時に `FirebaseMessaging.instance.requestPermission()` を呼び出す。
   - 既に許可済みの場合はスキップする（`AuthorizationStatus.authorized / provisional`）。
   - 拒否された場合でもオンボーディングを完了できるようにし、拒否時は補足文（設定から後で変更できる旨）を表示する。

2. **位置情報権限リクエスト（オプション）**
   - 「現在地の揺れを確認する」機能がある場合、位置情報権限も案内するステップを追加するか検討する。
   - 現状は `geolocator` で都度リクエストしているため、オンボーディングで事前に説明するとユーザー体験が向上する。

3. **オンボーディング完了フラグ**
   - 完了済みかどうかを `SharedPreferences` などに保存し、2 回目以降はスキップする。
   - `goRouter` の `redirect` でフラグを見て `/onboarding` にリダイレクトする実装を追加する。

4. **デバッグ用リセット**
   - デバッグページにオンボーディング完了フラグをリセットするエントリーを追加する。

## 参照

- `app/lib/feature/onboarding/ui/onboarding_page.dart`
- `app/lib/feature/settings/features/notification/data/provider/notification_token_stream.dart`（既存の権限リクエスト）
- `app/lib/core/router/router.dart`（redirect 追加箇所）
