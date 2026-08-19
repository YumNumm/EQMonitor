# assets_util 削除後に残ったネイティブ資産・ドキュメントを片付ける

## 背景

`packages/assets_util` を削除し、同梱 Asset Pack の解決を Dart 側
（`BundledAssetPackRepository`）へ移した。Dart 側の参照はすべて解消済みだが、
ネイティブ側とドキュメントに残骸がある。

## 残っているもの

### Xcode プロジェクト

- `app/ios/Runner/Frameworks/AssetsUtil.xcframework`
- `app/macos/Runner/Frameworks/AssetsUtil.xcframework`
- `app/ios/Runner.xcodeproj/project.pbxproj` の `AssetsUtil.xcframework`
  参照（Frameworks / Embed Frameworks）
- `app/macos/Runner.xcodeproj/project.pbxproj` の同参照

呼び出し元が無くなったため動作には影響しないが、IPA / app bundle に
未使用バイナリが載り続ける。Xcode で参照を外し、ディレクトリを削除する。

### 陳腐化したドキュメント

- `docs/knowledge/20260816_assets_util_agp9_gradle_dsl.md`
- `docs/todo/500_ffigen_assets_util_host_dependent_output.md`
- `docs/todo/400_android_asset_pack_followups.md`
- `docs/todo/950_app_android_agp9_source_provider.md`
- `docs/superpowers/specs/2026-07-31-ios-asset-pack-diagnostics-design.md`
- `docs/superpowers/specs/2026-08-01-ios-asset-pack-file-resolution-design.md`
- `docs/superpowers/plans/2026-08-16-assets-util-agp9-dsl.md`

いずれも assets_util のネイティブ実装が前提。削除するか、現行構成に
合わせて書き換える。
