# 認証・課金・広告の残課題

数値は元の優先度。Console/署名実機の確認は未完了。旧設計の大量のサンプルコードは Git 履歴を参照し、現行 API を正本とする。

## 900: Native Social Auth の外部設定

- Google Cloud/Firebase に develop/production の iOS bundle ID、Android package、署名証明書を登録し、環境別 CI に `GOOGLE_IOS_CLIENT_ID` / `GOOGLE_IOS_REVERSED_CLIENT_ID` / `GOOGLE_ANDROID_CLIENT_ID` / `GOOGLE_SERVER_CLIENT_ID` を設定する。
- `app/ios/Runner.xcodeproj/` の scheme PreAction と `Environment.xcconfig` 経由で archive に値が入り、生成 Info.plist の `GIDClientID` / URL scheme / `GIDServerClientID` が環境と一致することを確認する。server client ID は Better Auth の許可 audience と揃える。
- Apple Service ID の環境別固定 callback URL、`APPLE_SERVICE_ID`、両 bundle ID の Sign in with Apple capability/provisioning を整備する。
- 完了条件: iOS/Android 署名実機で Google、Apple iOS、Apple Android callback を検証してから `IS_NATIVE_SOCIAL_AUTH_ENABLED=true` にする。欠損設定は `AuthFailureKind.configuration` で UI/HTTP 開始前に失敗する契約を維持する。
- 対象: `app/lib/feature/auth/`、`app/lib/core/model/environment.dart`、`.github/workflows/deploy-app.yaml`。

## 900: Firebase iOS 登録と FCM

- `app/ios/Runner/GoogleService-Info.plist` の App ID `1:179553945248:ios:a738f33a18702c7f6fabc5` が `eqmonitor-main` に存在するか、Firebase Installations API が有効かを Console で確認する。必要なら再登録し設定を更新する。
- `app/macos/Runner/GoogleService-Info.plist` でも同じ障害がないか確認する。iOS の `Info.plist` と Google plist の OAuth client ID 差異は、上記の環境別供給経路を含めて照合する。
- 完了条件: 実機で `App not registered` が出ず、FCM token を取得して通知を受信できる。tracked 設定だけで Console 側の修復を断定しない。

## 550: BETA × production の App Check 確認方法

- `BuildConfig.isDeveloperUiEnabled` が false になる TestFlight ではアプリ内 debug token 確認を使えない。
- `docs/beta/ios-testflight-checklist.md` を、Console の Verified requests 確認へ集約するか、debug UI に依存しない検証導線へ更新する。必要なら FLAVOR=dev の検証用配布手順を定義する。
- 完了条件: 通常の BETA×prod ビルドで実施可能な手順に沿って App Check の検証結果を記録する。

## 150: Pro 再有効化

- `app/lib/core/model/environment.dart` の `IS_PRO_FEATURES_ENABLED`、環境ファイル、`.github/workflows/deploy-app.yaml` と RevenueCat の iOS/Android API key を揃える。
- 完了条件: 以下089/090の契約・Sandbox検証後に、Paywall、購入/復元、広告非表示、通知のPro項目、任意地域Widget/App Group同期、`/subscription/*` の遷移を確認して有効化する。server の `planConstraints` / HTTP 402 は client flag だけで変わらない。

## 091: User API の一般ユーザー向け scope

- `app/lib/feature/auth/data/repository/user_api_client.dart` と session/JWT 管理は現在存在するため「アプリ側全面未着手」は旧情報。
- 残る判断: プロフィール表示/編集、紐付けデバイス/セッション一覧、アカウント削除、デバイス削除 UI の提供範囲を決める。`PATCH /v2/user/me` の requestBody は実装前に現行 OpenAPI を照合する。
- 完了条件: 採用する UI/API と所有 feature を明記し、認証切れ・削除のテストを追加する。通常の device 登録・通知 token 同期を User API の前提にしない。

## 090: 商品・広告・通知制限の整合と release gate

- `app/lib/feature/subscription/` に購入/復元/管理UI、`app/lib/feature/ads/` に広告判定/opt-out が存在する。新規実装計画としてやり直さず、未達契約を確認する。
- 商品価格、月額/年額、trial、family sharing、premium機能範囲を最終決定し、Store/RevenueCat の product/package/entitlement `pro` と app の product ID を照合する。旧案の月300円/年3000円は確定値ではない。
- 通知制限は `app/lib/feature/settings/features/notification_settings/` と backend の現行 `planConstraints` を照合する。旧案は Free=EEW/地震共有3地点・揺れ現在地のみ、Pro=EEW/地震各5・揺れ3。旧案の数値を現行契約へ無条件に上書きしない。
- Free共有pool UI、Free→Proの地点引継ぎ、失効後の超過地点を非破壊で通知無効にする順序/表示を確定し、API制限と配信側が一致する境界値テストを追加する。
- 広告は Pro、server `ads_enabled=false`、EEW活性、opt-out 時の非表示を維持する。配置（設定/履歴一覧/古い履歴詳細）、24時間境界、強い地震時の猶予、AdUnitId粒度を決め、Home/EEW/強震画面に即時性を妨げる広告を出さない。
- 完了条件: Sandbox購入→Webhook→DB→app反映、強制終了/再起動、復元/端末変更、解約後期限までは有効、失効、通信失敗/キャンセル、広告一斉停止を検証する。Paywallの価格/期間/自動更新/規約/プライバシー/管理導線と読み上げ、必要なATT/同意/Store申告、削除要求時の扱いを整え段階公開する。

## 089: 購入状態の正本・identity とアプリ登録

- 2026-09-26決定: 同じストアアカウントの複数端末でProを同時利用可能にする。device IDと購入所有者の1対1前提を見直し、共有所有者・端末紐付け・認証済み再同期の契約を #1837/#1840 とbackend #1291で確定する。
- 調査結果・実装順序・未確認事項: [#1831実装準備](../knowledge/20260926_revenuecat_1831_preparation.md)。現時点では設計案で、実装・配備・実購入検証は未完了。

- `app/lib/feature/subscription/data/repository/subscription_repository.dart` は RevenueCat の `getCustomerInfo()` を読む。旧089は `GET /v2/subscription/me` を正本とし旧090はSDK優先で矛盾していた。購入直後のWebhook遅延・offline cache・失効反映を含む一つの契約へ決める。
- `revenue_cat_configurator.dart` は現在匿名 configure。device/user と RevenueCat AppUserID の対応、移行時の alias/transfer、再インストール/restore、複数端末を server 契約と揃えてテストする。`logIn` だけで全移行が成功すると仮定しない。
- 登録は `app/lib/feature/devices/data/repository/device_repository.dart` の POST `/v2/device`・`/me`、`device_auth_repository.dart` の secure token 保存が実装済み。旧「SharedPreferences に JWT」「migration 不要」は現行に適用しない。
- 残る確認: challenge 登録の必要性/隠し導線、認証失効時の復旧、keychain再インストール、Android再登録、offline Paywall、非対応platformの案内。採用したフローにテストを追加する。

## 088: backend 課金・登録契約の照合

- 対象: `backend/api/api/src/features/` と公開 OpenAPI、`packages/eqmonitor_api/`。backend の実装・運用はこの整理では未検証。
- device本人性、App Check登録、Bearer `/me` / realtime ticket、challenge一回性/期限/レート制限、revoke/監査、管理CLI、Webhook認証・event ID冪等性、購読API/有料API guard の現行実装を照合し、未達だけを実装する。challenge通知のSlack連携は任意。
- JWT鍵rotation、macOS/Web対応、手動付与（期限付き/永続）、tier、RevenueCat TRANSFER を決定する。旧案のDB初期化・migration撤去・無期限JWTをそのまま実行しない。
- 完了条件: 重複/順不同Webhook、期限/grace/失効、revoke、購入復元/identity移行、通知設定と配信制限、challenge再使用を契約テストで固定し、OpenAPI再生成と app E2E が一致する。
