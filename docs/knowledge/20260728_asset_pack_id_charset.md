# App Store Connect: assetPackIdentifier の文字種制約 (ITMS-91133)

## 制約

App Store Connect API で `POST /v1/backgroundAssets` するとき、
`attributes.assetPackIdentifier` は次のみ許可される（エラーコード
`ENTITY_ERROR.ATTRIBUTE.INVALID` / `ITMS-91133`）:

- ローマ字 `A–Z` / `a–z`（大文字小文字を区別）
- 数字 `0–9`
- ハイフン `-`
- 先頭・末尾のハイフンは不可

**ドット (`.`) やアンダースコア (`_`) は不可。** reverse-DNS 形式
（例: `net.yumnumm.eqmonitor.assets`）は拒否される。

## EQMonitor での正規 ID

| 用途 | 値 |
|------|-----|
| iOS Managed Background Assets (`assetPackID` / ASC) | `eqmonitor-assets` |
| Android Play Asset Delivery pack name | `eqmonitor_assets`（Gradle 規約で `_` 可） |

iOS 側の参照箇所:

- `packages/assets_util/lib/assets_util.dart` (`_iosAssetPackIdentifier`)
- `.github/workflows/upload-asset-pack.yaml` (`IOS_BACKGROUND_ASSET_PACK_ID`)
- `ba-package` マニフェストの `assetPackID`
- App Store Connect の Background Assets レコード

## 実測

2026-07-27 の `upload-asset-pack.yaml` 実行で
`net.yumnumm.eqmonitor.assets` を指定したところ ASC が 409 で拒否。
`eqmonitor-assets` に変更して再試行する。
