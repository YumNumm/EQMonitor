# RevenueCat #1831 実装契約・検証手順

更新日: 2026-09-26。親Issue: https://github.com/YumNumm/EQMonitor/issues/1831
状態: アプリ・backendのPR実装。配備・ストア設定変更・実購入検証は未実施。

## 確定した仕様

- ユーザー決定: 同じストアアカウントの複数端末でProを同時利用可能とし、復元で旧端末の権限を解除しない。
- ユーザー決定: EQMonitorアカウントへのログインは不要。ストア購入の復元だけで利用する。
- アプリのRevenueCat App User IDにはサーバー登録済みdevice IDを使う。購入と利用deviceはbackendで別に管理し、SDKのTRANSFERによる権限移動をそのままアプリの権限喪失にしない。
- 通知・広告・WidgetのPro判定はすべて認証済みbackend確認値を正本にする。SDKだけのactive値では付与しない。

## 実装と安全条件

- iOS月額商品は #1839 のASC確認記録の `net.yumnumm.eqmontior.pro.monthly`（綴りも一致させる）。Androidは `eqmonitor.pro.monthly:eqmonitor-pro-monthly`。
- Product ID、monthly package、`P1M`期間がすべて一致する唯一のpackageのみ購入可能。取得したpriceStringを表示し、表示したpackage自体を購入へ渡す。商品がない・取得中・エラーなら購入できない。
- device登録確認 → JWTとdevice ID照合 → 匿名SDK configure → 必要なlogIn(deviceId) → SDK identity一致確認 → 操作、をprocess全体のSDKロック内で行う。無条件logOut/restoreは行わない。
- credential保存・削除でdevice IDをinvalidateし、操作前後にtokenを照合する。旧世代の非同期応答は新deviceへ反映しない。
- 購入/復元前にGET `/v2/subscription/me` で認証を確認し、その後POST `/v2/subscription/sync` で反映を確認する。POSTのbodyに購入・端末IDを申告しない。
- 同期失敗・反映待ちを購入成立失敗と混同しない。再試行ボタンは同期のみ実行し、再購入しない。SDK更新・foreground復帰・確認済み期限で再評価する。
- 初回取得失敗と401ではProを付与しない。同期通信エラーでは同一deviceで既に確認済みの権限を期限までメモリ上で維持可能だが、再起動をまたぐ権限キャッシュは追加しない。更新中は前deviceの権限を使わない。
- start APIのFree/Pro制限を選び、開いたままの通知設定画面にも反映する。上限超過の保存済み地域は削除しない。制限が不明なら固定数にフォールバックせず再取得を表示する。
- backend companion: [#1297（マージ済み）](https://github.com/YumNumm/eqmonitor-backend/pull/1297) と [#1299（検証済み購入のみに共有を限定する修正）](https://github.com/YumNumm/eqmonitor-backend/pull/1299)。認証済みdeviceのサーバー照会結果を、保持済みWebhookの取引・商品・store・environmentと照合して共有を認める。TRANSFERには取引IDがないため、それだけでは復元先の権限を付与しない。取引を特定できるWebhookまたは認証済み同期の照合で付与する。既存Main entitlement・商品は変更しない。

## 検証コマンド

Flutter/Dartはrepo指定のmise経由で、Widget testはshader assetを解決できる `app/` から実行する。

```sh
cd app
mise exec -- flutter test test/feature/subscription
mise exec -- flutter test test/feature/devices test/feature/settings/features/notification_settings test/core/provider/interceptor/device_auth_token_interceptor_test.dart
mise exec -- flutter analyze lib/feature/subscription lib/feature/settings/features/notification_settings
```

- API生成はbackendのOpenAPIを使い、`packages/eqmonitor_api` で `mise exec -- dart run bin/generate.dart --openapi <file>` を実行する。subscription応答のstatus分岐も生成元で維持する。
- 生成: `mise exec -- dart run build_runner build --delete-conflicting-outputs`。build-filter利用時も対象外のtracked生成物が削除される場合があるため、生成後の `git --no-pager diff --name-status` を確認し、無関係な削除を含めない。
- repoはmise `2026.09.12` 以上が必要。今回の環境では署名元releaseのchecksumを照合したtask-local mise `2026.9.14` を使い、`MISE_AUTO_INSTALL=false` で無関係なgcloud/codemagicの自動導入を避け、通常commit hookを実行した。

## 今回の自動検証結果

- アプリの購読・device・通知設定・広告・App Group・認証interceptor: 294成功、既存の3失敗。
- 3失敗は独立したdevelop `81386a797` でも同じ結果（該当2ファイルは6成功/3失敗）。プリセット確認ダイアログの本文1件、slot詳細の警報見出し2件の期待文言が一致しない。今回の変更による失敗はない。
- 購読テスト47件（上記に含む）とAPI packageテスト26件はすべて成功。変更対象のアプリ静的解析は指摘なし。
- SDK初期化・認証変更・同時操作、購入後の反映待ち/通信失敗/401と再試行、復元元Proの維持、期限切れ、feature flag off、価格未取得/失敗/大文字サイズ、Free→Pro→Free・超過地域保持を検証。
- 実ストアでの購入成立や通知配信を保証する結果ではない。以下の実機・配備確認は未実施。

## 未実施の受け入れ検証（#1844）

- backend #1299 の `is_verified` migration・backfill-dry-run・backfill・配備、server RevenueCat secret、Webhook接続、restore behaviorとSandbox overrideの実設定確認。
- TestFlight/Play内部テストの新規購入、更新、自動更新停止、失効、復元、匿名移行、再インストール。端末Bで復元後もA/B双方がProで、返金/失効が双方へ反映されること。
- RevenueCatの標準移管とlegacy共有は同一ではない。[公式restore仕様](https://www.revenuecat.com/docs/projects/restore-behavior)を踏まえ、実project設定・build・API環境を検証記録に残す。
- 最初のWebhook取引記録が未到着ならサーバー照会だけで元取引IDを推測しない。409 pendingとし、Webhook到着/再送後に同期する。任意の欠落イベントを完全復旧する実装とは扱わない。
- ASC/Playのプライバシー申告と公開ポリシー反映は未実施。`docs/beta/privacy-store-declarations.md` の課金追記を参照。

## 実装前の調査記録（develop `81386a797`）

- `app/lib/feature/subscription/data/repository/revenue_cat_configurator.dart` は匿名configureのみ。`isConfigured` の確認とconfigureの間に排他がない。
- 同ディレクトリの `subscription_repository.dart` はdevice登録・identity変更に依存しない。購入・復元ともSDKの `pro` のみで成功を判定する。
- 商品ID一致packageがなければ `current.monthly` を購入するため、設定ミスを隠す。
- `app/lib/feature/subscription/data/provider/subscription_product_id_provider.dart` のiOS定数は `net.yumnumm.eqmonitor.pro.monthly`。
- #1839の9/24のASC確認記録は `net.yumnumm.eqmontior.pro.monthly`。今回ストア実設定は再確認していない。
- `app/lib/feature/subscription/ui/page/paywall_page.dart` は価格 `¥300` 固定。表示時と購入時のpackageを共有していない。
- `app/lib/core/provider/device_id.dart` は既存JWTからdevice IDを取得する。これだけをawaitしても登録処理の完了待ちにはならない。
- `device_provisioning_notifier.dart` のbuildは登録要否を返す。実登録は `provision()`。購入側から別の登録処理を重複起動しない。
- `subscription_notifier.dart` はkeepAlive。更新listener・復帰時更新・期限再評価・旧identity結果の破棄がない。
- `packages/eqmonitor_api/lib/src/clients/subscription_api_client.dart` はGET `/v2/subscription/me` のみ。アプリからの利用も見つからない。
- `notification_settings_page.dart` は `planConstraints.free` 固定。`is_pro_provider.dart` のSDK由来状態は広告とWidget/App Groupへ伝播する。
- 既存subscriptionテストはfake repositoryによるNotifierとisPro判定。SDK連携・所有者移行・Webhookは検証していない。
