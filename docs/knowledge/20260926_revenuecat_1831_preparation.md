# RevenueCat #1831 実装契約・検証手順

更新日: 2026-09-29。親Issue: https://github.com/YumNumm/EQMonitor/issues/1831
状態: アプリ・backend実装、iOS商品のメタデータ適用、両環境のDB migration・backfillとAPI配備は完了。Webhook受信処理を検証済み。RevenueCat側のWebhook登録・実送信と実購入検証は未完了。

## 確定した仕様

- ユーザー決定: 同じストアアカウントの複数端末でProを同時利用可能とし、復元で旧端末の権限を解除しない。
- ユーザー決定: EQMonitorアカウントへのログインは不要。ストア購入の復元だけで利用する。
- アプリのRevenueCat App User IDにはサーバー登録済みdevice IDを使う。購入と利用deviceはbackendで別に管理し、SDKのTRANSFERによる権限移動をそのままアプリの権限喪失にしない。
- 通知・広告・WidgetのPro判定はすべて認証済みbackend確認値を正本にする。SDKだけのactive値では付与しない。
- Proの購入・復元・設定導線は常時有効とし、ビルド時の機能フラグを持たない。

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

## 実装時の自動検証結果（2026-09-26）

- アプリの購読・device・通知設定・広告・App Group・認証interceptor: 294成功、既存の3失敗。
- 3失敗は独立したdevelop `81386a797` でも同じ結果（該当2ファイルは6成功/3失敗）。プリセット確認ダイアログの本文1件、slot詳細の警報見出し2件の期待文言が一致しない。今回の変更による失敗はない。
- 購読テスト47件（上記に含む）とAPI packageテスト26件はすべて成功。変更対象のアプリ静的解析は指摘なし。
- SDK初期化・認証変更・同時操作、購入後の反映待ち/通信失敗/401と再試行、復元元Proの維持、期限切れ、価格未取得/失敗/大文字サイズ、Free→Pro→Free・超過地域保持を検証。
- 実ストアでの購入成立や通知配信を保証する結果ではない。実機での受け入れ検証は別途必要。配備・外部設定の確認状況は次節を参照する。

## 配布・ストアの設定確認（2026-09-29）

- 配布用SOPS設定のiOS/Android公開SDKキーがRevenueCatの登録値と一致する。供給経路は [配布CI](delivery_ci.md) を参照。実機内のキーと購入結果は別途確認する。
- iOS月額商品は説明、グループ表示名 `EQMonitor Pro`、プライバシーURL `https://eqmonitor.app/privacy_policy`、購入・復元の審査メモを適用し、`READY_TO_SUBMIT` を確認した。価格は変更していない。審査画像は白紙fallbackのため実画面に差し替えてから提出する。審査提出は未実施。
- backendのdevelop/production両namespaceで `eqmonitor-revenuecat-secrets` のSealedSecretが `Synced=True`。API v1サーバーキーと環境別Webhook Secretの値一致、両環境のAPI Pod内で両キーが非空であることを確認済み。
- develop/production両DBで、購入共有用3テーブルと `is_verified` を含む3 migrationを適用済み。両環境のmigration journalは86件。backfillのdry-run・本適用は完了し、変更対象は0件だった。
- 両環境のAPIは `2.8.0`、image digestは `sha256:531f462dff31480ba9e9dabb88f4bcf3d67c6e1f1867a24dfea9749b0ec22450`。各2 PodがReady、restart 0。source `01fa007ff` のビルドと一致する。
- productionのAPI RolloutはHealthy、stable/currentはともに `656c7ffff5`。Analysisは6回成功・失敗0。ただし通常promote後に `Full promotion requested` も観測したため、5分pauseを2段階とも完走した結果とは扱わない。両環境のArgo CDはSynced/Healthy。
- productionのnotification-resolver `0.22.3` はHealthy、1/1 Ready、restart 0。consumerのpollとlag/pending 0を確認したが、実イベント処理は0件。developはreplicas 0で実動作未検証。
- 両環境のWebhook受信処理へ合成TESTを送信し、初回200・重複200・不正Bearer 401を確認した。DBのprocessed記録は各環境1件。これは受信処理・認証・重複処理の検証であり、RevenueCatからの実送信確認ではない。
- RevenueCat側のWebhook登録は0件。Chromeの登録フォームにはname/URL・両environment・全apps・全eventsを準備済みだが、Authorizationの手入力と保存が必要。登録後のRevenueCat実送信を別途確認する。
- フラグ削除に関連する既存テスト64件が成功し、app全体の静的解析は指摘なし。

## 未実施の受け入れ検証（#1844）

- RevenueCat側のWebhook登録・実送信、restore behaviorとSandbox overrideの実設定確認。
- productionのnotification-resolverによる実イベント処理。developのresolverはreplicas 0のため、必要な検証時に実動作を確認する。
- TestFlight/Play内部テストの新規購入、更新、自動更新停止、失効、復元、匿名移行、再インストール。端末Bで復元後もA/B双方がProで、返金/失効が双方へ反映されること。
- RevenueCatの標準移管とlegacy共有は同一ではない。[公式restore仕様](https://www.revenuecat.com/docs/projects/restore-behavior)を踏まえ、実project設定・build・API環境を検証記録に残す。
- 最初のWebhook取引記録が未到着ならサーバー照会だけで元取引IDを推測しない。409 pendingとし、Webhook到着/再送後に同期する。任意の欠落イベントを完全復旧する実装とは扱わない。
- ASC/Playのプライバシー申告と公開ポリシー反映は未実施。`docs/beta/privacy-store-declarations.md` の課金追記を参照。

## 変更時に維持する実装境界

- `device_provisioning_notifier.dart` のbuildは登録要否を返し、実登録は `provision()` が行う。`device_id.dart` の既存JWT読取だけで登録完了とみなさず、購入側から登録処理を重複起動しない。
- RevenueCat SDKの初期化・identity照合・操作は `revenue_cat_session.dart` とRepositoryに集約する。NotifierやUIからSDKの状態だけでPro権限を付与しない。
- `subscription_product_id_provider.dart` の商品IDはストア登録値と一致させる。Paywallは取得したpackageの価格を表示し、商品不一致時にmonthly packageへフォールバックしない。
- 過去の実装前調査と移行経緯はGit履歴と親Issue #1831を参照する。
