# iOS Firebase App Distribution 配布の追加

## 背景と目的

現在 `deploy-app.yaml` では、

- iOS: IPA を `method: app-store-connect` でエクスポートし App Store Connect (TestFlight) にアップロード。`[external]` 指定時は TestFlight 外部グループへ配布。
- Android: AAB を Firebase App Distribution（`main` グループ）と Google Play (internal) の2経路へ配布。

iOS の外部配布は TestFlight 経由のため **Beta App Review 待ち**が発生する。審査を待たずに即時配布したいというニーズに対し、**iOS を Firebase App Distribution にも配布する追加チャネル**を設ける。

TestFlight パイプライン（App Store 申請用）は現状のまま残し、Firebase を「審査不要の即時配布チャネル」として並走させる。

## 前提・スコープ外

- Firebase プロジェクトには iOS アプリ `1:179553945248:ios:a738f33a18702c7f6fabc5` が既に登録済み。
- **iOS 固有の制約**: Firebase App Distribution で実機インストールするには、App Store 署名ではなく **ad-hoc 署名（`release-testing`）**の IPA が必要で、配布先端末の UDID が Apple Developer に登録済みである必要がある。
- **スコープ外（ユーザー対応）**: Firebase コンソールでの iOS App Distribution 有効化、および Firebase↔Apple Developer 連携による端末 UDID 自動登録の設定。これらが未設定の場合、既に Apple Developer に登録済みの端末にしかインストールできない（CI 自体は失敗しない）。
- Firebase の配布グループ `main` は iOS 用にも利用できる前提。

## 設計

### 1. ad-hoc 用 ExportOptions の追加

新規ファイル `app/ios/ExportOptionsAdHoc.plist` を追加する。既存 `app/ios/ExportOptions.plist` をベースに、Firebase App Distribution 向けの ad-hoc 署名にする。

- `method`: `release-testing`（Xcode 15.4+ における ad-hoc の名称）
- `signingStyle`: `automatic`
- `teamID`: `CPL7H8SHVM`（既存と同じ）
- `destination`: `export`
- `stripSwiftSymbols`: `true`
- `uploadSymbols`: `false`（App Store 専用のため不要）
- `manageAppVersionAndBuildNumber`: `false`（App Store Connect 管理のためのキー。ad-hoc では不要）

### 2. `build-ios` ジョブに ad-hoc IPA エクスポート step を追加

既存の `build/ios/Runner.xcarchive`（無署名アーカイブ）を再利用し、App Store 用 `Create IPA` step の直後にもう1本 ad-hoc IPA をエクスポートする。ビルド・アーカイブの再実行は行わない。

新 step「Create Ad-Hoc IPA」:

```bash
KEY_PATH="$HOME/.private_keys/AuthKey_${APP_STORE_CONNECT_API_KEY_ID}.p8"
xcodebuild -exportArchive \
  -archivePath build/ios/Runner.xcarchive \
  -exportOptionsPlist ios/ExportOptionsAdHoc.plist \
  -exportPath adhoc \
  -allowProvisioningUpdates \
  -authenticationKeyIssuerID "$APP_STORE_CONNECT_API_ISSUER_ID" \
  -authenticationKeyID "$APP_STORE_CONNECT_API_KEY_ID" \
  -authenticationKeyPath "$KEY_PATH" \
| xcbeautify --renderer github-actions
```

- `-allowProvisioningUpdates` により、Apple Developer に登録済みの端末を含む ad-hoc プロビジョニングプロファイルが自動生成される。
- 出力は `adhoc/EQMonitor.ipa`。

新 step「Upload ad-hoc ipa as artifact」で `EQMonitor-ios-adhoc.ipa` として別アーティファクトにアップロード（既存 `EQMonitor-ios.ipa` はそのまま）:

```yaml
- uses: actions/upload-artifact@... # 既存と同じ pin
  with:
    name: EQMonitor-ios-adhoc.ipa
    path: app/adhoc/EQMonitor.ipa
    if-no-files-found: error
```

### 3. 新ジョブ `deploy-ios-firebase-app-distribution`

Android の `deploy-android-firebase-app-distribution` と同型で追加する。

- `name`: `Deploy iOS (Firebase App Distribution)`
- `needs`: `[build-ios, define-matrix]`（`build-ios` が `if: deploy-ios` のため、iOS デプロイ時のみ連動して走る）
- `runs-on`: `ubuntu-24.04`（**x64 固定**。firebase-tools は linux-arm64 バイナリ非配布のため arm ランナー不可）
- `timeout-minutes`: `10`
- `permissions`: `contents: read` / `id-token: write`
- `environment`: `EQMonitor-iOS`

steps:

1. Checkout（`fetch-depth: 0`、`persist-credentials: false`）— git log で changelog を作るため全履歴が必要
2. Extract SOPS Age Key File
3. Copy mise.local.toml
4. Install Mise dependencies: `install_args: "firebase yq"`
5. Set environment variables（`mise env --redacted --dotenv`）
6. Download artifact `EQMonitor-ios-adhoc.ipa` → `build/`
7. List files & rename: `mv build/*.ipa build/app.ipa`
8. Output release version（`yq .version app/pubspec.yaml`）→ `changelog.tmp`
9. Output git log（`git log <LAST_TAG>..HEAD ...`、最大2000文字）→ `changelog.txt`（Android Firebase ジョブと同じロジック）
10. Authenticate to Google Cloud Platform（WIF、`token_format: access_token`）
11. Upload to Firebase App Distribution:

```bash
firebase appdistribution:distribute \
  --app 1:179553945248:ios:a738f33a18702c7f6fabc5 \
  --release-notes-file "changelog.txt" \
  --groups "main" \
  build/app.ipa
```

## データフロー

```
build-ios (macos-26)
  └─ xcarchive（無署名）
       ├─ Create IPA (app-store-connect)      → EQMonitor.ipa      → artifact: EQMonitor-ios.ipa
       └─ Create Ad-Hoc IPA (release-testing)  → adhoc/EQMonitor.ipa → artifact: EQMonitor-ios-adhoc.ipa
                                                                          │
deploy-ios (macos-26) ← EQMonitor-ios.ipa ──── App Store Connect / TestFlight
                                                                          │
deploy-ios-firebase-app-distribution (ubuntu-24.04) ← EQMonitor-ios-adhoc.ipa ── Firebase App Distribution (group: main)
```

## エラーハンドリング / 留意点

- ad-hoc エクスポートは、登録端末が0でも `-allowProvisioningUpdates` によりプロファイルが生成され export は成功する（インストール可能端末が無いだけ）。CI がこれで失敗することはない。
- Firebase 配布ジョブは `deploy-ios`（TestFlight）とは独立。片方が失敗してももう片方には影響しない。
- firebase-tools は arm64 非対応のため `ubuntu-24.04`(x64) を厳守する。

## テスト / 検証

- `actionlint .github/workflows/deploy-app.yaml` がパスすること。
- pre-commit hooks（gitleaks / zizmor / pinact 等）がパスすること。
- `ExportOptionsAdHoc.plist` が有効な plist であること（`plutil -lint`）。
- 実配布の最終確認は develop への push 後の実 CI 実行で行う（ad-hoc IPA 生成・Firebase 配信の成功をログで確認）。
