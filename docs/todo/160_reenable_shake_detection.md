# 揺れ検知機能の再有効化

## 背景

初回 beta リリースで揺れ検知を配布対象から外すため、
`BuildConfig.isShakeDetectionEnabled`(`app/lib/core/model/environment.dart`)を導入した。
既定は **true**(有効)で、`--dart-define IS_SHAKE_DETECTION_ENABLED=false` を
渡したビルドでのみ無効になる。

CI では公開テスト配布のビルドにのみ false を付与している
(`.github/workflows/deploy-app.yaml`: iOS は `deploy-ios-external`、
Android は `android-track == 'external'`)。

無効化により以下が停止する。

- `ShakeDetectionAcceptedSnapshot` が WebSocket / REST を購読せず常に null
- ホーム地図の揺れ検知レイヤー・ホームの揺れ検知カード
- Live Monitor の揺れ検知ベースライン・カード・レイヤー
- タイムシフト自動復帰の揺れ検知トリガー
- ルーターで `/settings/notification/shake` を `HomeRoute` へリダイレクト

## 再有効化の手順

1. `.github/workflows/deploy-app.yaml` の
   `IS_SHAKE_DETECTION_ENABLED="false"` を付与する分岐(iOS / Android の 2 箇所)を削除する。
2. 動作確認: ホーム地図のグリッド表示・揺れ検知カード・Live Monitor・
   `/settings/notification/shake`。

## 残課題

- **サーバー側 push は本フラグの対象外**。クライアントの表示・購読を止めるだけなので、
  デバイスに揺れ検知の通知設定が登録済みの場合、無効ビルドでも push 通知は届きうる。
  公開テスト配布で通知まで完全に止めたい場合は、バックエンド側の配信抑止か、
  無効ビルド起動時に登録済み揺れ検知設定を削除する処理が別途必要。
- 揺れ検知履歴 UI(`shake_detection_history_page` / `_details_page` と
  セッション蓄積 provider)は機能していなかったため本対応で削除した。
  履歴機能が必要になった場合は、REST API を持つ履歴として再設計すること。
