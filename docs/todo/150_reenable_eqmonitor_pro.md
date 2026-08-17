# EQMonitor Pro 機能の再有効化

## 背景

`BuildConfig.isProFeaturesEnabled`(`app/lib/core/model/environment.dart`)を導入し、
`--dart-define IS_PRO_FEATURES_ENABLED` 未指定(既定 false)で EQMonitor Pro 機能・
課金導線を **一時的に無効化** している。

無効化により以下がすべて Free / 非表示になる。

- `isProProvider` が常に false(広告非表示・ホームウィジェットの任意地域・App Group 同期)
- `SubscriptionNotifier.build()` が RevenueCat を触らず `inactive` を返す
- 通知設定(`notification_settings_page.dart`)の `isPro` が false 固定
- 設定トップの「EQMonitor Pro」セクション非表示(`settings_page.dart`)
- `pro_upgrade_dialog` が「現在ご利用いただけません」を表示
- ルーターで `/subscription/*` を `HomeRoute` へリダイレクト(`router.dart`)

## 再有効化の手順

1. ビルドフラグを有効化する。
   - ローカル: `environment/.env.dev` / `.env.prod` に `IS_PRO_FEATURES_ENABLED=true` を追加。
   - CI(`.github/workflows/deploy-app.yaml`): iOS/Android の `flutter build` に
     `--dart-define IS_PRO_FEATURES_ENABLED=true` を追加する
     (現状は付与していないため、追加しない限り prod ビルドは Pro 無効のまま)。
2. RevenueCat の API キー(`REVENUECAT_API_KEY_IOS` / `_ANDROID`)が設定済みか確認する。
3. `router.dart` の `/subscription` リダイレクトが解除される(フラグ true で自動的に通過)。
4. 動作確認: Paywall 遷移・購入・復元・広告非表示・通知の Pro 項目。

## 備考

- サーバー側の `planConstraints` / HTTP 402 制限はバックエンド依存であり、
  クライアントフラグだけでは変化しない。
- Pro 判定の一本化(RevenueCat 直読み → `GET /v2/subscription/me`)は別タスク
  (`docs/todo/089_*` 参照)。
