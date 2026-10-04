# ストア申告チェックリスト — プライバシー宣言整備 (#1499)

対象: `fix/1499-privacy-declarations`。β配布(TestFlight / Play内部テスト以降)前に、
Google Play Console と App Store Connect のプライバシー関連申告を実施するための
チェックリスト。エージェント(Claude Code)は Play Console / App Store Connect の
管理画面操作ができないため、以下は**人間が実施する**チェックリストとして残す。
担当者はチェックした項目に `[x]` を付けること。

## 0. 前提(コード調査で確認した事実)

| 項目 | 内容 | 根拠 |
|---|---|---|
| 常時位置情報 | `NSLocationAlwaysAndWhenInUseUsageDescription` / `NSLocationAlwaysUsageDescription` / `NSLocationWhenInUseUsageDescription` + `UIBackgroundModes: location` | `app/ios/Runner/Info.plist:148-153,183-` |
| Android位置情報 | `ACCESS_FINE_LOCATION` / `ACCESS_COARSE_LOCATION` / `ACCESS_BACKGROUND_LOCATION` | `app/android/app/src/main/AndroidManifest.xml:10-12` |
| 位置情報実装 | `geolocator` (フォア/バック権限取得) + `background_location_tracker` (バックグラウンド追跡、`LocationUpdateReceiver`) | `app/pubspec.yaml:57,118`、`AndroidManifest.xml:64-66` |
| 広告 | 広告 SDK・初期化・表示・非表示設定を削除。AdMob のアプリ ID と `SKAdNetworkItems` も削除 | `app/pubspec.yaml`、`app/lib/main.dart`、`app/android/app/src/main/AndroidManifest.xml`、`app/ios/Runner/Info.plist` |
| 課金 | RevenueCat (`purchases_flutter`) | `app/pubspec.yaml:152` |
| 計測/クラッシュ | Firebase Analytics / Crashlytics / Messaging / AppCheck / Installations。iOS の Analytics は広告 ID 対応なし、Android は広告 ID 収集を無効化 | `app/pubspec.yaml`、`mise.toml`、`.github/workflows/deploy-app.yaml`、`app/android/app/src/main/AndroidManifest.xml` |
| Google Sign-In | Info.plistに`GIDClientID`と`com.googleusercontent.apps.*`のURL Schemeが残存するが、`app/lib`・全パッケージに`google_sign_in`/`firebase_auth`依存が無く、呼び出しコードも見つからない | `Info.plist:32-59` / `app/pubspec.yaml`(依存なし) / `grep`結果(該当なし) |
| Critical Alerts | `com.apple.developer.usernotifications.critical-alerts` entitlement + `requestCriticalAlertPermission()` | `app/ios/Runner/Runner.entitlements`、`app/lib/feature/permission/data/repository/permission_repository.dart:35-40` |
| Live Activities | `NSSupportsLiveActivities` / `NSSupportsLiveActivitiesFrequentUpdates` | `Info.plist:156-159`、`docs/live-activity-specification.md` |

> Google Sign-In について: CLAUDE.md / タスクブリーフでは「Auth: Google Sign-In + Firebase」と
> 記載されているが、現行コードには実装が見当たらない(Info.plistの設定のみ残存する死んだ設定の可能性)。
> Play Console / App Store Connectのデータ型申告では「サードパーティのログインを収集していない」
> 前提で回答して問題ないが、**実際にGoogle Sign-Inを使う予定がある場合は事前に実装状況を確認すること**。
> リスクとして記載するのみで本PRでは削除・実装はしない(スコープ外)。

---

## 1. Google Play Console — Background Location Declaration

Play Console の「アプリのコンテンツ」→「権限の宣言」→
「バックグラウンドの位置情報へのアクセス権」セクションで以下を回答する。

### 1.1 利用目的の文案(日本語、フォーム記入用)

```
EQMonitorは、緊急地震速報(警報)が発表された際に、ユーザーの現在地(高精度位置情報)を
用いて到達予想や震度を判定し、アプリがバックグラウンド/終了状態でもプッシュ通知および
重大な通知(Critical Alert)で速報を届けるために、バックグラウンドで位置情報を使用します。
この機能はユーザーがオンボーディング画面で個別に許可した場合のみ有効になり、
いつでも端末の設定からオフにできます。位置情報は現在地の観測点判定・通知配信のためにのみ
使用し、広告目的や第三者への販売には使用しません。
```

- [ ] 上記文案(または要旨を保った日本語訳版)をPlay Consoleのフォームに入力した
- [ ] 「なぜこの機能にバックグラウンドの位置情報が必要か」の説明が、実際のアプリ動作
      (EEW警報時の重大な通知配信)と一致していることを再確認した

### 1.2 デモ動画の要否

Google Playの審査ガイドラインでは、バックグラウンド位置情報の使用目的が
「フォアグラウンドでの使用から自明でない」場合、デモ動画の提出が求められる。
EQMonitorの場合:

- ユーザーがアプリを閉じている間も地震速報を届けるという価値提案は、
  地図アプリ(ナビ)のように使用中の画面から自明ではないため、
  **デモ動画の提出を推奨(実質必須になる可能性が高い)**。
- [ ] デモ動画を撮影する(推奨シナリオ: オンボーディングで「アプリを開いていない時の
      位置情報」を許可 → アプリをバックグラウンドに → (テスト用に)EEW警報通知が
      Critical Alertとして届く様子を録画)
- [ ] 動画内で「アプリがバックグラウンドの位置情報を使ってどの画面/通知が有効になるか」
      が視覚的に分かるようにする(Play Consoleの審査ガイド推奨事項)
- [ ] 動画をPlay Consoleの該当フォームにアップロードした

### 1.3 Prominent Disclosure(事前説明UI)の実装状況

Google Playポリシーは、OSの権限ダイアログを表示する**前**に、アプリ内で
「収集するデータ・利用目的・アプリを使用していない時も収集される旨」を明示する
prominent disclosureを要求する。

**調査結果: 部分的に実装済みだが、詳細説明リンクが未完成(β前に対応が必要)。**

- 実装位置: `app/lib/feature/onboarding/ui/components/permissions_step_page.dart`
  のオンボーディング「位置情報権限」ステップ。
  - `_PermissionActionCard(title: 'アプリを開いていない時の位置情報', ...)`
    (`permissions_step_page.dart:116-129`) が、OSの権限ダイアログ
    (`Geolocator.requestPermission()`, `background_location_permission_provider.dart` /
    `permission_repository.dart:48-51`)を呼び出す**前**に表示され、
    「現在地で緊急地震速報(警報)が発表された時に重大な通知でお知らせします」等の
    説明文とともに「許可する」ボタンを提示している。これは prominent disclosure の
    基本要件(事前説明 → OS権限ダイアログの順序)を満たす構造になっている。
  - 上部の「2. 位置情報権限」セクション見出し直下にも
    `EQMonitorにおける位置情報の扱い方` という詳細リンクがある
    (`permissions_step_page.dart:82-101`)。
- 問題点: この詳細リンク(`位置情報の扱い方`)と各カードの`詳しい情報`リンクは、
  `OnboardingWebViewRoute` で **`https://example.com` を開く仮実装** になっている
  (`permissions_step_page.dart:6,18-22,94-97,112-113`。設計意図は
  `docs/superpowers/specs/2026-07-08-onboarding-permissions-redesign.md:20,25,100-152`
  に明記されており、「正式なQ&Aページができるまでの暫定対応」とされている)。
  Google Playの求める「データの種類・使用目的・共有の有無」を具体的に説明する文書が
  実質存在しないため、**現状の実装だけでは prominent disclosure の内容要件
  (単に許可を求めるだけでなく、詳細な説明への到達可能性)を十分に満たさない可能性がある**。
- [ ] **β配布前に要対応(リスク)**: `位置情報の扱い方` / `詳しい情報` の遷移先を
      `https://example.com` から実際の説明ページ(位置情報の収集内容・利用目的・
      保存/共有の有無を明記したページ)に置き換える。実装追加は本PRのスコープ外。
      対応Issueを別途起票すること。
- [ ] 上記対応が完了するまでは、少なくともカード本文の説明文
      (`permissions_step_page.dart:105-106,117-119`)がPlay Consoleの
      「利用目的の文案」と矛盾しないことを確認する(現状は概ね整合している)。

---

## 2. App Store Connect — App Privacy Answers 対応表

App Store Connect の「App Privacy」→「Data Types」の質問票は、`.xcprivacy`
プライバシーマニフェスト(SDKに同梱されているものを含む)から**自動入力されない**。
これはXcode 15以降のビルド時プライバシーレポート(コンパイル警告・Privacy Manifest
Summary)向けの別機構であり、App Store Connect上の質問票は**開発者が自身の判断で
毎回手動回答する**必要がある。統合しているサードパーティSDK(Firebase/RevenueCat等)が
収集するデータも、SDKベンダーが公式に公開している「ASC回答ガイダンス」に従って
**アプリ側の申告に含める**必要がある(SDKが自分の`.xcprivacy`を持っているからといって
申告不要にはならない)。

| データ型(App Store Connectの選択肢) | 収集する? | ユーザーに関連付け(Linked)? | トラッキングに使用? | 目的 | 根拠/出どころ |
|---|---|---|---|---|---|
| Precise Location(高精度位置情報) | Yes | No | No | App Functionality | `geolocator`/`background_location_tracker`。本PRで`PrivacyInfo.xcprivacy`に追加 |
| User ID | Yes | No | No | Analytics | 既存宣言(Firebase系識別子)。変更なし |
| Crash Data | Yes | No | No | Analytics | 既存宣言(Crashlytics)。変更なし |
| Performance Data | Yes | No | No | Analytics | 既存宣言(Firebase Performance系)。変更なし |
| Device ID | 要再確認 | 要再確認 | 要再確認 | 残存 SDK の利用目的を確認 | AdMob 由来の収集は削除。Firebase 等の残存 SDK と配布成果物を確認して回答する |
| Advertising Data | No（広告削除後の版） | — | No | — | 広告 SDK と広告表示を削除。配布成果物と Console の回答は未確認 |
| Purchase History | **Yes** | **Yes（申告案）**: `revenue_cat_session.dart` が登録済みdevice IDへlogInし、backendでも購入と複数端末を対応付ける。匿名IDのみという旧根拠は適用不可 | No（今回、広告目的の購入情報連携は追加しない） | App Functionality, Analytics | RevenueCat公式Apple App Privacyと下記 #1843 の実装根拠。Console回答は未変更 |
| User ID（RevenueCat） | **Yes** | **Yes（申告案）** | No | App Functionality, Analytics | custom App User IDとしてサーバー発行device IDを送信。既存Analytics向けUser IDとは別途集約して回答 |
| Other Diagnostic Data / Product Interaction | Yes(既存宣言のAnalyticsで代替) | No | No | Analytics | Firebase Analytics |

> 広告を削除したソースに合わせた申告案であり、Console の保存・公開は未実施。
> 広告削除前の公開版と区別し、新しい配布成果物と残存 SDK のデータ収集を確認してから回答を更新する。

### 2.1 SDK同梱の`.xcprivacy`マニフェストとの重複宣言回避(参考情報)

**この節は、あくまで`app/ios/PrivacyInfo.xcprivacy`(アプリ本体ターゲットのプライバシー
マニフェスト)に何を追記すべきかの判断に限定した話であり、上記2.のApp Store Connect
質問票の回答義務とは別問題である。** SDKが自身の`.xcprivacy`を同梱していても、
App Store Connectの質問票への回答は免除されない。残存 SDK の収集実態に合わせて回答する。

Appleの仕様上、Xcodeのビルド時に生成される「プライバシーレポート」は、
アプリ本体のPrivacyInfo.xcprivacyと、**ipaに含まれる全てのフレームワーク/リソースバンドル
に同梱されたPrivacyInfo.xcprivacyを集約したもの**になる。以下のSDKは近年のバージョンで
ベンダー自身のPrivacyInfo.xcprivacyを同梱するため、**アプリ本体の`.xcprivacy`ファイルに
同じデータ型を重複宣言する必要はない**(重複させると実装と食い違う過剰申告になり得る)。
バージョン番号は公開情報から確認した範囲の参考値であり、**実際に使用しているPod/SDK
バイナリでの実測確認が必要(要実測確認)**。

- Firebase iOS SDK (`firebase_analytics: ^12.0.0` / `firebase_crashlytics: ^5.0.0` /
  `firebase_messaging: ^16.0.0` / `firebase_core: ^4.0.0` などが依存する
  `Firebase/*` CocoaPods) — firebase-ios-sdkリポジトリの各モジュール
  (`FirebaseCore`/`FirebaseMessaging`等)に`PrivacyInfo.xcprivacy`が同梱されている
  ことをGitHub上で確認した。**導入された正確なバージョン番号は要実測確認**。
- RevenueCat Purchases iOS SDK (`purchases_flutter: ^10.0.1` が依存する
  `RevenueCat`/`PurchasesHybridCommon` CocoaPod) — 公開情報ではPurchases iOS SDK
  4.37.0以降でPrivacyInfo.xcprivacyを同梱するとされる。**要実測確認**。

- [ ] `flutter build ipa` (または CI が生成する `.ipa`)を展開し、
      `unzip -l` で各フレームワーク配下に `PrivacyInfo.xcprivacy` が
      実際に含まれていることを確認する(Linux開発機では`plutil`が無いため、
      `python3 -c "import plistlib; plistlib.load(open('<path>','rb'))"`で
      各ファイルの構文だけでも検証しておく)
- [ ] Xcode Organizerのビルド時プライバシーレポートで、上記データ型がSDK起因で
      自動的に表示されることを確認する。表示されない場合は当該SDKのポッドが
      静的リンクでリソースバンドルが欠落している可能性があるため、
      `pod install` ログ(`Firebase*`/`RevenueCat`の
      `resource_bundles`)を確認する
- [ ] このビルド時プライバシーレポートの確認は**App Store Connectの質問票への
      回答を代替しない**ことを担当者間で認識合わせする。質問票は残存 SDK の実態と
      2.の表を照合して回答する

### 2.2 ATT(App Tracking Transparency)の設定

- `app_tracking_transparency` パッケージへの依存や、
  `ATTrackingManager.requestTrackingAuthorization` 相当の呼び出しはない。
  `app/ios/Runner/Info.plist` にも `NSUserTrackingUsageDescription` を設定しない。
  このキーは、[Appleの説明](https://developer.apple.com/documentation/bundleresources/information-property-list/nsusertrackingusagedescription)ではATTの許可要求に使う利用目的の説明文である。
- `PrivacyInfo.xcprivacy` は `NSPrivacyTracking = false`、
  `NSPrivacyTrackingDomains` は空配列。ATTを呼ばないことだけでは
  トラッキングの有無を断定できないため、SDKを含む実際のデータ利用に基づいて申告する。
- `GADApplicationIdentifier` と `SKAdNetworkItems` は削除済み。
  配布成果物にも広告 SDK と設定が含まれないことを確認する。
- 将来トラッキングを導入する場合は、ATTの許可要求と利用目的の説明文を実装し、
  `NSPrivacyTracking` / `NSPrivacyTrackingDomains` とストア申告を見直す。
- 新しいビルドのアップロードとApp Store Connectでの警告解消は未確認。
  確認項目は[ビルド・配布の残課題](../todo/950_build_and_release.md)に記載する。

### 2.3 App Store Connect 入力手順チェックリスト

- [ ] App Store Connect → App → App Privacy → 「Get Started」/ 「Edit」
- [ ] Location → Precise Location: Yes / Linked to you: No / Used for Tracking: No /
      Purpose: App Functionality
- [ ] Identifiers → User ID: Yes / Linked to you: Yes（課金device ID連携を含む申告案） /
      Tracking: No / Purpose: App Functionality, Analytics。既存回答との差分を確認する
- [ ] Diagnostics → Crash Data, Performance Data: Yes / Linked: No / Tracking: No /
      Purpose: Analytics(既存回答、変更なし)
- [ ] Purchases → RevenueCat公式ASC回答ガイダンス
      (`revenuecat.com/docs/platform-resources/apple-platform-resources/apple-app-privacy`)
      に従い、Purchase History を **Collected: Yes** で申告し、
      Purpose に **App Functionality と Analytics の両方**を選択したか確認する
      (Linked to you はdevice IDと購入の対応に基づきYesを申告案とする。
      §2表・末尾の #1843 追記参照。Consoleは未変更)
- [ ] 広告削除を含む配布成果物を確認し、Advertising Data と Third-Party Advertising の
      回答を見直す。Device ID は残存 SDK の利用実態を再確認する（§2表参照）
- [ ] 上記の「Yesで申告」は`.xcprivacy`(SDK同梱分を含む)の内容確認では代替できない
      ことを担当者間で共有した(2.1参照。ビルド時プライバシーレポートの確認は
      あくまで補助的なダブルチェックとして扱う)
- [ ] 回答完了後、「Publish」前に差分プレビューをスクリーンショットで保存し、
      本チェックリストに実施日を追記する(実施者記入欄)

実施者記入欄: 実施日 ____________ / 実施者 ____________

---

## 3. Critical Alerts / Live Activities — 審査ノート文案

App Store Connectの提出時、「App Review Information」→「Notes」に
以下を記載することを推奨する(英語提出が基本だが、日本語アプリのため日本語補足も有効)。

### 3.1 Critical Alerts

```
This app requests the Critical Alerts entitlement
(com.apple.developer.usernotifications.critical-alerts) solely to deliver
Japan Meteorological Agency Earthquake Early Warning (EEW) "Warning" level
alerts for the user's current or registered location, even when the device
is in Do Not Disturb / silent mode. This is a life-safety notification
feature (similar to government emergency alerts) and is only triggered by
JMA-issued EEW warnings for areas the user has explicitly selected or for
their current location (with permission). Users can opt out of this
specific alert category at any time from in-app settings
(Notification Settings) without disabling the app's other notifications.
```

- [ ] Critical Alertsが「緊急地震速報(警報)」という公共性の高い災害通知にのみ
      使われることが分かるよう、上記英文(または日本語要約)を提出ノートに記載した
- [ ] Apple Developer Portalで `Critical Alerts` capability が Approved
      状態であることを確認した(`docs/beta/ios-testflight-checklist.md` 1章と重複確認)

### 3.2 Live Activities

```
This app uses Live Activities to show real-time earthquake shaking
detection and EEW status on the Lock Screen / Dynamic Island. A Live
Activity is started only when (a) the user's notification conditions are
met and (b) Live Activity is enabled in APNs settings. Activities include
event ID, shaking level, detection time, and (optionally) the user's
current location if the event was detected at their location. Activities
automatically end 10 minutes after start or when no new data arrives for
60 seconds (see docs/live-activity-specification.md). No location or
event data is retained after the Live Activity ends beyond what is already
covered by the app's Analytics/Crash data collection.
```

- [ ] Live Activityの開始トリガー・表示内容・終了条件が
      `docs/live-activity-specification.md` の記載と一致していることを再確認してから
      審査ノートに転記した
- [ ] `NSSupportsLiveActivitiesFrequentUpdates` を有効化している理由
      (揺れ検知中の高頻度更新)も一言添えると審査がスムーズになりやすい

---

## 4. Privacy Policy との矛盾チェック結果(報告のみ、`privacy_policy.md`は変更しない)

`app/assets/docs/privacy_policy.md` を読んだ結果、以下の乖離を確認した。
**法的文書のため本PRでは一切変更せず、ここに報告するのみ。**

- [ ] **位置情報の記載が無い**: ポリシー本文(第2条)は収集情報を
      「ネットワークの情報」「デバイスの情報」「行動履歴」の3種類に限定しており、
      常時/バックグラウンドで収集する**位置情報**についての言及が一切ない。
      実際のアプリは高精度・バックグラウンド位置情報を収集しているため、
      現状のポリシーは実態と一致していない。**β配布前にポリシー文面の追記を
      ユーザー(法務判断者)に依頼することを推奨。**
- [ ] **課金(RevenueCat)の記載が無い**: サブスクリプション/購入情報の収集・
      RevenueCatへの提供について言及がない。
- [ ] **計測SDK(Firebase Analytics等)の名称が明記されていない**: 「行動履歴」
      という抽象的な表現のみで、Firebase Analytics/Crashlyticsという具体的な
      サービス名や、データがGoogle/Firebaseに送信される旨の記載がない。
- [ ] 上記3点について、法務判断者(ユーザー)へ改訂の必要性を確認すること。
      改訂する場合は本ポリシーの制定日(2023年12月1日)の更新も伴う。

---

## 5. 最終確認

- [ ] `app/ios/PrivacyInfo.xcprivacy` が `python3 -c "import plistlib; plistlib.load(...)"`
      で構文検証OK(本PRのコミットで確認済み。macOS環境では`plutil -lint`でも再確認すること)
- [ ] 1〜4の全項目を確認し、対応不能/対応保留の項目はIssue化されている
- [ ] Google Play Console / App Store Connectの申告が完了した日時と担当者を
      本ファイルまたは関連Issueに記録した


## #1843 課金device ID連携の変更（2026-09-26）

- コード: `app/lib/feature/subscription/data/repository/revenue_cat_session.dart` が登録済みdevice IDをcustom App User IDとしてRevenueCatへ渡す。EQMonitorアカウントへのログインは必須にしない。
- 送信するもの: storeの購入・商品・有効期限等の課金情報とdevice ID。サーバーJWTはRevenueCatへ送らない。メールアドレス・氏名のCustomer Attributes追加は行わない。
- 利用目的: 購入検証、不正防止、複数端末へのPro付与・復元、更新・返金・失効の反映。今回の課金連携を広告ターゲティングには利用しない。
- backendは検証済み取引、RevenueCat顧客IDとの対応、サーバー照会snapshotを保持する。端末削除では端末権限とその端末向け照会記録を削除するが、他端末の購入復元・イベント再処理に必要な購入/顧客IDの記録は保持する。device削除だけでストア解約やRevenueCat顧客削除が完了したと表示してはいけない。
- 保持期間・削除請求時のRevenueCat/会計記録の消去範囲は未確定。公開ポリシーの保持・削除条項を運用担当と確定してから配布する。
- [RevenueCat公式App Privacy](https://www.revenuecat.com/docs/platform-resources/apple-platform-resources/apple-app-privacy)（2026-09-26確認）はcustom App User ID利用時にUser IDの申告を求める。Linkedの回答は自社/第三者での紐付け実態も含めるため、匿名のみを根拠とした旧No回答を引き継がない。
- [ ] ASC App PrivacyとPlay Data Safetyにdevice ID・購入情報・利用目的を反映し、公開前に差分を保存する。
- [ ] 公開プライバシーポリシーのRevenueCat利用・購入共有・保持/削除方針を更新する。
- **実施状態:** 文書・実装根拠の更新のみ。Consoleの保存/公開および公開サイトの更新は未実施。
