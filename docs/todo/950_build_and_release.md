# ビルド・配布の残課題

数値は元の優先度。設定の修正と署名済み成果物の検証は分けて完了判定する。

## 950 / 880: Android AGP 移行と成果物確認

- 950: `app/android/app/build.gradle.kts` は `StageBundledAssetPackTask` と `variant.sources.assets.addGeneratedSourceDirectory` に移行済み。旧 Provider→SourceSet の build blocker は解消したが、実 SDK で release AAB を作り `assets/platform` の同梱と task dependency を確認する作業は残る。
- 880: `packages/eqmonitor_map/example/android/app/build.gradle.kts` は `getByName("profile")` へ変更済み。profile/release build と `validateSigningProfile` を現行 pin で再確認し、失敗時は stacktrace で切り分ける。
- app/example の `gradle.properties` に `android.newDsl=false` / `android.builtInKotlin=false` が残る。app・自前 plugin を公開 DSL / Built-in Kotlin へ移行し、両フラグを削除する。`android.sourceset.disallowProvider=false` による回避は採用しない。
- app の `gradle.properties` / `gradle.ci.properties` は Cronet の namespace 重複を `android.uniquePackageNames=false` で暫定回避する。[upstream issue #1932](https://github.com/dart-lang/http/issues/1932) の解消後に両方から削除し、release Manifest 統合と AAB ビルドを確認する。AGP 10 ではこの無効化設定が使えなくなるため、更新前に解消する。
- 完了条件: app release AAB の内容検査と example profile/release CI が成功し、legacy opt-out が不要になること。

## 900: Google Play versionCode

- `.github/workflows/deploy-app.yaml` は Android の `BUILD_NUMBER` に `github.run_number` を渡し、未定義 `LATEST_BUILD_NUMBER` の死んだ計算も残る。以前の1050/1051重複失敗を現在も必ず失敗すると断定せず、Play の現在最大値を取得する。
- 最新値＋1、十分な offset、日時方式のいずれかを運用として決め、再実行・並列実行でも既使用値を再利用しない採番に統一する。
- 完了条件: 不要な計算/出力を削除し、生成 AAB の versionCode が既存最大値を超え、実際の Play upload が成功する。

## 900: 3.0.1 のリリース確認

- [ ] アプリ名の修正を含む変更をマージし、`Release-As: 3.0.1` をマージ後のコミットメッセージにも残す。自動生成される本番 Release PR が 3.0.1 になったことを確認してからマージする。
- [ ] 新しい配布用 IPA の表示名が `EQMonitor`、バージョンが `3.0.1` であることを確認する。Android AAB の表示名とバージョンも確認する。
- [ ] iOS / Android の実機でホーム画面のアプリ名を確認し、App Store / Google Play の公開状態が 3.0.1 になったことを確認する。

## 900: iOS ATT 利用目的キー削除後の提出確認

- [ ] 修正を含む配布用 IPA の `Payload/Runner.app/Info.plist` に `NSUserTrackingUsageDescription` が含まれないことを確認する。ソースのキー削除のみ確認済みで、配布成果物は未検証。
- [ ] 新しいビルドを App Store Connect にアップロードし、そのビルドを審査対象に選択して警告の解消を確認する。アップロードと審査画面での確認は未実施。
- 設定と申告の確認先: [ストア申告チェックリスト](../beta/privacy-store-declarations.md#22-attapp-tracking-transparencyの設定)。

## 860: iOS cold archive の actool

- 対象: `app/ios/Runner.xcodeproj/project.pbxproj`、`app/ios/AppIcon-dev.icon` / `AppIcon.icon`、`.github/workflows/deploy-app.yaml`。
- clean DerivedData での `CompileAssetCatalogVariant thinned` / actool クラッシュを再確認する。
- `ASSETCATALOG_COMPILER_INCLUDE_ALL_APPICON_ASSETS = YES` が残るため、未使用の代替アイコンを同時コンパイルする必要性を確認し、不要なら設定を整理する。
- 完了条件: 新しい専用 DerivedData で archive が成功する。warm cache の成功だけで閉じず、失敗時の生 xcodebuild log を保存する。

## 860: Xcode 27.0 正式版でのストア提出確認

- 配布 workflow は Xcode 27.0 / `27A266a` と iOS SDK 27.0 に固定済み。変更後の署名済みビルドとストア提出は未確認。
- 完了条件: 新しいビルド番号で再ビルドし、CI の Xcode・SDK 検査と App Store Connect の処理が成功する。ベータ版 Xcode を理由に提出を拒否されないことを確認する。

## 300: iOS extension の版番号

- `app/ios/Runner.xcodeproj/project.pbxproj` の Runner は1287、extension は1という固定値が残る。各 target の `CURRENT_PROJECT_VERSION` / `MARKETING_VERSION` を Flutter の build number/name と同期する。
- 完了条件: archive 内の Runner・Widget・AppIntent・FcmService 各 Info.plist が一致し、`ValidateEmbeddedBinary` の不一致 warning が消える。

## 300: production アイコン

- `IS_PRODUCTION=true` 時に `APP_ICON=AppIcon` を強制する設定は実装済み。production archive と実機での表示は未検証。
- SOPS `.env.json` の `DART_DEFINE_PRODUCTION` は `APP_NAME=EQMonitor` に修正済み。CI が復号する設定で、iOS の表示名に使う。配布成果物と実機での表示は未検証。
- 完了条件: production archive の選択アイコン/表示名と実機でのアイコン表示を確認する。

実機での pack 検証は [Asset Pack](850_asset_pack.md)、Widget の OS 別検証は [Apple 拡張](930_apple_extensions.md) を参照。

## 800: ネイティブ HTTP の端末検証

- `NativeDioFactory` の URLSession / Cronet 通信について、HTTP/2・HTTP/3 対応の接続先で端末が実際に選択した通信規格を確認する。HTTP/3 非対応の回線・接続先でも通信が完了することを確認する。
- Android の Cronet provider がすべて無効な環境で `IOHttpClientAdapter` に切り替わることと、通常の通信・TLS エラーで fallback しないことを確認する。
- Better Auth と Hi-net のログイン・ログアウト・Cookie 更新、K-NET の認証確認とダウンロード、強震モニタの連続取得、headless 位置同期を実機で確認する。再取得・画面の再表示・provider 無効化後にネイティブ接続が残らないことも確認する。
- 共通アダプターの送信準備・接続・レスポンスヘッダー待ちは `connectTimeout + receiveTimeout`。応答停止・本文受信停止・キャンセル時の完了と、認証・オンボーディングの待機表示が解除されることを実機で確認する。
- 未検証: Android / iOS のネイティブビルドと実機通信。この変更を確認した Linux 環境には Android SDK と Xcode がない。
