# iOS TestFlight 配布前検証チェックリスト

対象: `fix/1494-ios-entitlements`(#1494)で `app/ios/Runner/Runner.entitlements` の
`com.apple.developer.devicecheck.appattest-environment` を `development` から
`production` に統一した変更のリリース前確認。

この変更により Runner の entitlements は以下の3項目すべてが `production` 系の単一構成になる。

| entitlement                                              | 値                     |
| --------------------------------------------------------- | ---------------------- |
| `aps-environment`                                          | `production`            |
| `com.apple.developer.devicecheck.appattest-environment`    | `production`(今回変更) |
| App Check provider (release build, `main.dart`)           | `AppleAppAttestProvider` |

エージェント(Claude Code)は実機操作・Apple Developer Portal操作ができないため、
以下は**人間が実施する**チェックリストとして残す。担当者はチェックした項目に `[x]` を付けること。

## 0. 前提

- Team ID: `CPL7H8SHVM`(`app/ios/ExportOptions.plist` / `ExportOptionsAdHoc.plist` 参照)
- Bundle ID (Runner, production): `net.yumnumm.eqmonitor`
- CI (`.github/workflows/deploy-app.yaml`) は `-exportOptionsPlist ios/ExportOptions.plist`
  (`method: app-store-connect`, `signingStyle: automatic`) で `EQMonitor.ipa` を生成し、
  GitHub Actions artifact `EQMonitor-ios.ipa` としてアップロードする。
- 作業は macOS 実機(Xcode / Apple Developer Portalへのアクセス権限があるもの)で行う。
  Linux環境には `plutil` / `codesign` / `security` が無いため、この文書のコマンドは macOS 上で実行する。

## 1. Apple Developer Portal — App ID Capability 確認

1. https://developer.apple.com/account/resources/identifiers/list へアクセスし、
   `net.yumnumm.eqmonitor` (App ID) を開く。
2. Capabilities一覧で以下が有効(チェック済み)になっていることを確認する。
   - [ ] `App Attest`
   - [ ] `Critical Alerts`(`com.apple.developer.usernotifications.critical-alerts`)
   - [ ] `Time Sensitive Notifications`(`com.apple.developer.usernotifications.time-sensitive`)
   - [ ] `Associated Domains`
   - [ ] `App Groups` (`group.net.yumnumm.eqmonitor`)
3. `Critical Alerts` は Apple の審査(申請)が必要な entitlement。
   Capabilities一覧に表示されていても "承認待ち"／"未承認" の場合はビルドに反映されないため、
   ステータスが **Approved / Enabled** になっていることを目視で確認する。
   - [ ] Critical Alerts が Approved 状態であることを確認した
4. 疑わしい場合は Apple Developer Support (https://developer.apple.com/contact/) の
   Entitlement申請履歴からステータスを再確認する。

## 2. Provisioning Profile 内の entitlements 確認

Xcode の Automatic Signing (`CODE_SIGN_STYLE = Automatic`) を使っているため、
実際に配布されるプロファイルは `xcodebuild -exportArchive` 実行時に
App Store Connect API Key 経由で自動生成される。ローカルで最新プロファイルを取得し確認する。

```bash
# 1. Xcode でプロビジョニングプロファイルを更新(ダウンロード)させる
open app/ios/Runner.xcworkspace
# Xcode > Signing & Capabilities で対象ターゲット(Runner)を選択し、
# "Automatically manage signing" が有効な状態で一度ビルドし直すか、
# Xcode > Settings > Accounts > チーム選択 > "Download Manual Profiles" でも良い

# 2. ダウンロード済みプロファイルの一覧から対象を特定する
ls -la ~/Library/MobileDevice/Provisioning\ Profiles/

# 3. 各プロファイルの entitlements を確認する(更新日時が新しいものを対象にする)
security cms -D -i ~/Library/MobileDevice/Provisioning\ Profiles/<UUID>.mobileprovision \
  > /tmp/profile.plist
plutil -extract Entitlements xml1 -o - /tmp/profile.plist
```

出力に以下が含まれることを確認する。

- [ ] `com.apple.developer.devicecheck.appattest-environment` = `production`
- [ ] `com.apple.developer.devicecheck.app-attest-opt-in` = `["CDhash"]`
- [ ] `aps-environment` = `production`
- [ ] `com.apple.developer.usernotifications.critical-alerts` = `true`
- [ ] `com.apple.developer.usernotifications.time-sensitive` = `true`
- [ ] `com.apple.security.application-groups` に `group.net.yumnumm.eqmonitor` を含む

`security` コマンドが使えない場合(macOS以外)や `mobileprovision` が手元にない場合は、
セクション3のIPA検査で代替できる(エクスポート済みIPAには最終的な entitlements が埋め込まれている)。

## 3. IPA (実配布物) の entitlements 検査

CIが生成する `EQMonitor.ipa`(GitHub Actions artifact `EQMonitor-ios.ipa`、
App Store Connect提出用)、または手元でエクスポートしたIPAを検査する。

```bash
# 1. GitHub Actions の Run から artifact `EQMonitor-ios.ipa` をダウンロードし、展開する
mkdir -p /tmp/eqmonitor-ipa-check
unzip -q EQMonitor.ipa -d /tmp/eqmonitor-ipa-check
APP_PATH=/tmp/eqmonitor-ipa-check/Payload/Runner.app

# 2. entitlements を直接ダンプする(macOS 11+ の codesign では ':-' でプレーンplist出力)
codesign -d --entitlements :- "$APP_PATH" | plutil -p -

# 3. コード署名自体の検証(App Store配布用の署名になっているか)
codesign -dv "$APP_PATH" 2>&1 | grep -E "Authority|TeamIdentifier|Identifier"
```

確認項目:

- [ ] `com.apple.developer.devicecheck.appattest-environment` が `production`
- [ ] `aps-environment` が `production`
- [ ] `TeamIdentifier` が `CPL7H8SHVM`
- [ ] `Authority` に `Apple Distribution` または `Apple Iphone Distribution` を含む
      (ad-hoc/開発署名ではないことの確認)

Widget/AppIntent extension も同様に確認する(該当する場合)。

```bash
codesign -d --entitlements :- "$APP_PATH/PlugIns/WidgetExtension.appex" | plutil -p -
codesign -d --entitlements :- "$APP_PATH/PlugIns/AppIntentExtension.appex" | plutil -p -
```

- [ ] 両 extension の entitlements に `com.apple.security.application-groups`
      = `group.net.yumnumm.eqmonitor` が含まれる
- [ ] 両 extension に `appattest-environment` は含まれない(Runner本体のみが保持する想定。
      含まれていた場合は意図しない追加なので要確認)

## 4. Firebase App Check トークン発行確認(TestFlightビルド)

### 4.1 アプリ内デバッグページで確認する

> [!IMPORTANT]
> develop push の TestFlight ビルドは `.env.prod`(`FLAVOR=prod`) のみ（`IS_BETA_TESTING` なし）。  
> `v*-beta.*` / 手動で `is_beta_testing=true` のときだけ `IS_BETA_TESTING=true`。
> でビルドされる。この組み合わせでは `buildConfig.isDeveloperUiEnabled` が
> **false** になり(`app/lib/core/model/environment.dart`)、デバッグメニュー・
> HTTP キャッシュ表示・`DebugLauncher` のシェイク/ショートカット起動が
> **すべて無効化される**。そのため、以下の「アプリ内デバッグページで確認する」手順は
> 通常の TestFlight ビルドでは実施できない。
>
> App Check の確認は「4.2 Firebaseコンソールで確認する」を正とする。
> どうしてもアプリ内デバッグページで確認したい場合は、`FLAVOR=dev` など
> `isDeveloperUiEnabled` が true になるビルドを別途作成して検証する。

<details>
<summary>(参考)デバッグ UI が有効なビルドでの確認手順</summary>

1. デバッグ UI が有効なビルド(`isDeveloperUiEnabled == true`)をインストールして起動する。
2. 端末をシェイクする(`DebugLauncher` のジェスチャ)、
   または対応するショートカットでデバッグページを開く。
3. "Firebase App Check" セクションを確認する
   (`app/lib/feature/settings/children/config/debug/debug_page.dart` の `_AppCheckSection`)。

- [ ] `Provider` が `AppleAppAttestProvider` 系の値になっている
      (`kDebugMode` が false の場合 `main.dart` は `AppleAppAttestProvider` を使う)
- [ ] `Token` に `null`/エラー以外の値(JWTらしき文字列)が表示される
- [ ] 右上の再読み込みアイコンでトークンを再取得しても正常に取得できる

</details>

### 4.2 Firebaseコンソールで確認する

1. https://console.firebase.google.com/ → 対象プロジェクト → `App Check` を開く。
2. 対象iOSアプリの Metrics(検証済み/未検証リクエスト数)を確認する。
3. TestFlightビルドでAPIアクセス(例: ログイン、デバイス登録など App Check 必須なAPIの呼び出し)
   を行った直後に、"Verified requests" が増加していることを確認する。

- [ ] TestFlightビルドからのリクエストが "Verified" として計上されている
- [ ] "Unverified"(未検証)の急増がない
      (発生している場合、entitlements の environment 不整合や App Attest 未承認が疑われる)

参考ログ確認(端末をMacに接続した状態):

```bash
# Xcode > Window > Devices and Simulators からデバイスログを開くか、
# 以下でコンソールログをストリームして "AppAttest" 関連ログを絞り込む
xcrun devicectl device list
xcrun devicectl device process launch --console --device <DEVICE_ID> net.yumnumm.eqmonitor
```

もしくは Console.app で対象デバイスを選択し、`AppAttest` / `DCAppAttestService` で絞り込む。

- [ ] `DCAppAttestService` / App Attest 関連のログにエラー(environment mismatch等)が出ていない

## 5. 実機起動確認

`app/ios/Runner.xcodeproj/project.pbxproj` の `IPHONEOS_DEPLOYMENT_TARGET` は
Runner本体が `16.0`、`Widget` / `AppIntentExtension` は `26.0`(**今回変更しない、決定済み**)。
そのため iOS 26 未満の端末では **Widget/AppIntentが提供されないのは既知の仕様** であり、
本体アプリの動作確認とWidget確認は端末を分けて実施する。

### 5.1 iOS 16 / 17 / 18 端末 — 本体アプリ確認

各バージョンの実機(またはApple Developer PortalのTestFlightで対象端末を用意)で、次を確認する。

- [ ] TestFlightからインストールでき、初回起動でクラッシュしない
- [ ] Push通知の許可ダイアログが表示され、許可後に通知が届く(Critical Alert / Time Sensitiveを含む通知がある場合は種別も確認)
- [ ] ログイン/デバイス登録などApp Checkが必要なAPI呼び出しが成功する
      (失敗する場合は4章のApp Checkトークン発行確認を再実施する)
- [ ] 位置情報・地図(MapLibre)等の主要機能が表示・動作する
- [ ] ホーム画面に **Widgetの追加候補としてEQMonitorが表示されない**
      (26.0未満のため非表示が正しい挙動。表示される場合は不具合)

### 5.2 iOS 26 端末 — Widget / AppIntent確認

- [ ] 上記5.1の本体アプリ確認項目をすべて満たす
- [ ] ホーム画面のWidget追加メニューにEQMonitorのWidgetが表示され、追加できる
- [ ] 追加したWidgetが最新の地震情報などで更新される
- [ ] AppIntent(Siriショートカット / インタラクティブWidgetの操作)が正常に動作する
- [ ] WidgetExtension単体の entitlements(3章参照)が本体と矛盾しない
      (App Groupが一致している、余計なapp-attest関連キーが無い)

## 6. 最終確認

- [ ] 1〜5のチェックがすべて完了し、問題があれば Issue化されている
- [ ] `app/ios/Runner/Runner.entitlements` の3項目(aps-environment / appattest-environment /
      App Check provider)がすべて production 系で一致していることを再確認した
