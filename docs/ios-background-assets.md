# iOS Background Assets 廃止

iOS Managed Background Assets による Asset Pack 配布は廃止した。

- `AssetDownloader` ExtensionKit target は削除済み。
- `BAAppGroupID` / `BAHasManagedAssetPacks` / `BAUsesAppleHosting` は
  Runner の Info.plist から削除済み。
- `BackgroundAssets.framework` と `ba-package` は使用しない。
- デフォルト Pack は `app/assets/platform/` を Runner Bundle Resources に
  同梱する。
- 更新は Android と共通の署名済み Cloudflare R2 ZIP をアプリ内で取得する。

現在の設計と運用は [asset-pack-cd.md](asset-pack-cd.md) を参照する。
