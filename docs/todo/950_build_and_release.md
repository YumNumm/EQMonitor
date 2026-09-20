# ビルド・配布の残課題

数値は元の優先度。設定の修正と署名済み成果物の検証は分けて完了判定する。

## 950: CI ローカル action / workflow の参照修正

- `.github/workflows/pr-flutter-check.yaml`、`wc-check-dart-{analyze,test}.yaml`、`deploy-app.yaml` などの `uses: $/.github/...` を、GitHub Actions の相対指定 `./.github/...` へ修正する。
- 完了条件: 全ローカル参照先が存在し、PR の解析・テストおよび配布 workflow の呼び出しを検証できる。設定 typo の修正と実際の配布成功は区別する。

## 950 / 880: Android AGP 移行と成果物確認

- 950: `app/android/app/build.gradle.kts` は `StageBundledAssetPackTask` と `variant.sources.assets.addGeneratedSourceDirectory` に移行済み。旧 Provider→SourceSet の build blocker は解消したが、実 SDK で release AAB を作り `assets/platform` の同梱と task dependency を確認する作業は残る。
- 880: `packages/eqmonitor_map/example/android/app/build.gradle.kts` は `getByName("profile")` へ変更済み。profile/release build と `validateSigningProfile` を現行 pin で再確認し、失敗時は stacktrace で切り分ける。
- app/example の `gradle.properties` に `android.newDsl=false` / `android.builtInKotlin=false` が残る。app・自前 plugin を公開 DSL / Built-in Kotlin へ移行し、両フラグを削除する。`android.sourceset.disallowProvider=false` による回避は採用しない。
- 完了条件: app release AAB の内容検査と example profile/release CI が成功し、legacy opt-out が不要になること。

## 900: Google Play versionCode

- `.github/workflows/deploy-app.yaml` は Android の `BUILD_NUMBER` に `github.run_number` を渡し、未定義 `LATEST_BUILD_NUMBER` の死んだ計算も残る。以前の1050/1051重複失敗を現在も必ず失敗すると断定せず、Play の現在最大値を取得する。
- 最新値＋1、十分な offset、日時方式のいずれかを運用として決め、再実行・並列実行でも既使用値を再利用しない採番に統一する。
- 完了条件: 不要な計算/出力を削除し、生成 AAB の versionCode が既存最大値を超え、実際の Play upload が成功する。

## 860: iOS cold archive の actool

- 対象: `app/ios/Runner.xcodeproj/project.pbxproj`、`app/ios/AppIcon-dev.icon` / `AppIcon-prod.icon`、`.github/workflows/deploy-app.yaml`。
- clean DerivedData での `CompileAssetCatalogVariant thinned` / actool クラッシュを再確認する。
- `ASSETCATALOG_COMPILER_INCLUDE_ALL_APPICON_ASSETS = YES` が残るため、未使用の代替アイコンを同時コンパイルする必要性を確認し、不要なら設定を整理する。
- 完了条件: 新しい専用 DerivedData で archive が成功する。warm cache の成功だけで閉じず、失敗時の生 xcodebuild log を保存する。

## 300: iOS extension の版番号

- `app/ios/Runner.xcodeproj/project.pbxproj` の Runner は1287、extension は1という固定値が残る。各 target の `CURRENT_PROJECT_VERSION` / `MARKETING_VERSION` を Flutter の build number/name と同期する。
- 完了条件: archive 内の Runner・Widget・AppIntent・FcmService 各 Info.plist が一致し、`ValidateEmbeddedBinary` の不一致 warning が消える。

## 300: production アイコン

- `environment/.env.prod` と CI secret `DART_DEFINE_PRODUCTION` の `APP_ICON` / `APP_NAME` をオーナーが確認する（secret の現在値は未検証）。βで dev アイコンを使う意図がなければ `AppIcon-prod` に変更する。
- 完了条件: production archive の選択アイコン/表示名を確認する。β専用の意図的設定なら `environment/.env.example` に運用を記載する。

実機での pack 検証は [Asset Pack](850_asset_pack.md)、Widget の OS 別検証は [Apple 拡張](930_apple_extensions.md) を参照。
