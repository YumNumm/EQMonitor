# ネイティブビルドと署名

2026-09-21 に現行設定と照合。配布の起動条件は [delivery_ci.md](delivery_ci.md)、
APNs・認証は [push_and_auth.md](push_and_auth.md) を参照する。

## ツールチェーン

- 共通のmise初期化・Linuxコンパイラ要件は [development_environment.md](development_environment.md)。
  Flutter は `mise.toml` / `mise.lock` のコミット固定を使い、旧記録の stable 版を指定しない。
- Flutter の実行ディレクトリは `app/`。環境ファイルは
  `--dart-define-from-file=../environment/.env.dev`（配布は `.env.prod`）を指定する。
- iOS は `mise exec -- flutter config --enable-swift-package-manager` を有効にする。

## iOS SDK と SwiftPM

- `.github/workflows/deploy-app.yaml` の build-ios は `runs-on: xcode-27`、
  `XCODE_VERSION: latest`。選択後に SDK の major が `27` であることを検査する。
- `setup-xcode` の `latest` は runner に導入済みの版を選ぶ。SDKをダウンロードする指定ではない。
  RC・正式版の有無は `xcodebuild -version` と `xcrun --sdk iphoneos --show-sdk-version` の実ログで確認する。
- `@available` / `#available` は実行OSの制約であり、旧SDKにないAPI・マクロをコンパイル可能にはしない。
  Swift の Native Assets hook も CI と同じ SDK で検証する。
- `app/ios/Flutter/{Debug,Release}.xcconfig` は `SWIFT_ENABLE_EXPLICIT_MODULES = NO`。
  `InternalCollectionsUtilities` が解決できない場合は explicit modules と build-tool plugin を確認する。
- `app/ios/Packages/EQMonitorAPI/Package.swift` は OpenAPI runtime/urlsession のみを依存に持ち、
  アプリビルド中に generator plugin を走らせない。生成済み Swift はコミットする。
  現行 manifest に generator がないため、旧記録の `swift package plugin ...` をそのまま実行しない。

## archive、バージョン、entitlement

- iOS の `--build-name` は pubspec の prerelease / build metadata を除いた `X.Y.Z` を渡す。
  `3.0.0-beta.11` の自動サニタイズによる4セグメント化は ASC の `ITMS-90060` の原因になる。
  CI の build number は `github.run_number`。
- CI は `CODE_SIGNING_ALLOWED=NO` で archive し、
  `scripts/ci/sign_ios_archive_for_export.sh` で entitlement を付けて ad-hoc 署名してから export する。
- 署名順は内側から framework → 各 `.appex` → Runner.app。
  extension を追加するときは同スクリプトへ target 固有の entitlement mapping も追加する。
- 全 target の team は `ExportOptions.plist` / `ExportOptionsAdHoc.plist` と揃える。
  App Group を共有する親・extension は最終 IPA に `group.net.yumnumm.eqmonitor` を保持する。
  archive/export 成功だけでは ASC の `90958 Missing Entitlement` を防げない。
- 最終 IPA を展開し、Runner と各 `.appex` を `codesign -d --entitlements :- <bundle>` で確認する。
  スクリプトの構造回帰は `bash scripts/ci/test_sign_ios_archive_for_export.sh` で確認できる。
- `app/assets/parameters/jma_code_table.json` は native bundle 用の slim 表としてコミットする。
  CI は `tool/asset_pack/stage_from_r2.sh --target all` で更新する。更新差分もコミット対象。
  同梱経路・staging・配信内容検証は [asset_pack.md](asset_pack.md) を参照する。

## archive エラーの読み方

- `xcodebuild ... | xcbeautify` は archive/export ともに `set -o pipefail` が必要。
  `Runner.app: No such file or directory` より前の archive 失敗を先に調べる。
- archive は stderr も `tee` し、`PhaseScriptExecution` / `Run Script` / `actool` の生ログを読む。
  現行 workflow は `/tmp/xcodebuild-archive.log` と失敗時の抜粋を作るが、
  この生ログを artifact にアップロードする step はない。旧記録の artifact 名を前提にしない。
- `CompileAssetCatalogVariant` と nil-array 例外なら `.icon/icon.json` の形式互換性を確認する。
  旧 actool では `features: ["specular-location"]` と文字列 `specular: "inside"` が原因だった。
  現行アイコンは `specular` を真偽値にしている。再保存後は使用するSDKで単体コンパイルする。
- actool の再現には `--output-partial-info-plist` が必要。例（`app/ios/` から）:

```sh
mkdir -p "$TMPDIR/eqmonitor-actool"
xcrun actool AppIcon-dev.icon \
  --compile "$TMPDIR/eqmonitor-actool" \
  --output-partial-info-plist "$TMPDIR/eqmonitor-actool.plist" \
  --app-icon AppIcon-dev --include-all-app-icons \
  --target-device iphone --target-device ipad \
  --minimum-deployment-target 16.0 --platform iphoneos
```

## Android / AGP

- 現行 `app/android/app/build.gradle.kts` は Java/Kotlin JVM 17、compileSdk 37。
  SDK・NDKの具体的な版は同ファイルと `mise.toml` を正本にする。
- AGP 9 の生成 assets は出力を `DirectoryProperty` として公開し、
  `androidComponents.onVariants` の `variant.sources.assets.addGeneratedSourceDirectory` へ登録する。
  `sourceSets.main.assets.srcDir(provider)` は使わない。Variant API がタスク依存も引き継ぐ。
- `android.sourceset.disallowProvider=false` や `android.newDsl=false` への後退で回避しない。
  library のDSL移行では公開 `LibraryExtension` と `kotlin.compilerOptions` / `JvmTarget` を使う。
- 旧 `packages/assets_util/android/build.gradle.kts` は現在存在しない。
  その個別修正手順は不要だが、deprecated diagnostic が warnings-as-errors で失敗する点は維持する。
- Gradle の設定変更は Dart の解析だけでは確認できない。Android SDK がある環境で
  project evaluation または対象の APK/AAB ビルドを行う。
- 現行 release は minify/shrink 有効。配布時は AAB と R8 mapping、iOS は IPA と dSYM を保管する。

## Android release の JNI / R8

- MapLibreのjnigenはJavaクラスを名前で解決する。R8はDart/JNIの参照を追跡できず、
  debug成功でもreleaseで `Expression$Converter` 等の `ClassNotFoundException` が起こりうる。
- `app/android/app/proguard-rules.pro` の `-keep class org.maplibre.android.** { *; }` を維持する。
  全体のminify/resource shrinkingを無効にして回避しない。
- MapLibreはローカル `packages/` ではなく `YumNumm/flutter-maplibre` のGit依存。
  lockfile固定 `7080ae5676cae4fd6a722ee67a55f64488e20940` のconsumer rulesにも
  `-keep class org.maplibre.** { *; }` と `-keep class io.flutter.plugin.platform.** { public *; }` がある。
- PlatformViewのkeepを削ると元の完全修飾名とJNI参照が合わず、生成時にnullが返って白画面になる。
  `PlatformView.getView()` のNullPointerExceptionはPMTiles読込み前の障害として切り分ける。
- release APKは `tool/verify_maplibre_android_classes.sh <apk-path>`（apkanalyzer必須）で確認する。
  このscriptは `Expression$Converter` の存在だけを検査するため、mappingでも
  `PlatformView` / `PlatformViewFactory` の難読化後の名前が元と同じであることを確認する。
- 最後にrelease成果物を端末で起動し、PlatformView生成と地図表示を確認する。
  AAB内のPMTiles存在確認だけでは代用できない。このrelease smokeは今回未実施・未確認。

## 実機デバッグの切り分け

- インストール成功後に `errno = 65` / `No route to host` / `MDnsClient.lookup` で attach できない場合、
  macOS の「プライバシーとセキュリティ → ローカルネットワーク」で実行元IDE・ターミナルを許可する。
  許可の切替後はそのアプリを再起動する。`tccutil` では操作しない。
- `dns-sd` はデーモン経由なのでアプリ自身の権限確認には不十分。
  LAN/マルチキャスト宛UDPだけ失敗するかを切り分け、全宛先が失敗するなら経路・FWも確認する。
- iOS 27 で Xcode 起動時だけ `OS_dispatch_mach_msg _setContext:` が出る場合は、
  Run > Options > Queue Debugging の Enable backtrace recording を無効にして比較する。
  scheme の属性は `queueDebuggingEnableBacktraceRecording = "NO"`。
  ホーム画面からの直接起動との比較で診断する暫定回避で、OS修正後に再評価する。
- `app/ios` の Runner scheme にこの属性はまだない。同症状を再現した場合に適用を判断する。
