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
- `ba-package` マニフェストの `assetPackID`（CI が上記 env から生成）
- App Store Connect の Background Assets レコード

## Xcode プロジェクトには ID が存在しない

Apple ホスティングの Managed Asset Pack では、**Xcode 側に pack ID を書く場所が
一切ない**。Background Assets capability が付与するのは以下だけで、いずれも
pack 単位ではなくアプリ単位:

- `Runner/Info.plist`: `BAAppGroupID` / `BAHasManagedAssetPacks` / `BAUsesAppleHosting`
- `AssetDownloader` ExtensionKit ターゲット（`StoreDownloaderExtension` 準拠）
- Apple Developer Portal の capability 登録（App ID 単位）

つまり ID は「実行時に Dart が渡す値」と「CI がアップロードした値」の一致だけが
頼りで、不一致でもビルドは通り、端末上で pack が落ちてくるのに解決できない、
という形でしか表面化しない。

## ドリフト防止

`tool/asset_pack/check_asset_pack_id.py` が Dart 定数と workflow env の一致、
および上記の文字種制約を検証する。`upload-asset-pack.yaml` の
`Verify asset pack id` ステップがパッケージング前に実行する。

```bash
python3 -m tool.asset_pack.check_asset_pack_id --asset-pack-id eqmonitor-assets
python3 -m unittest tool.asset_pack.test_check_asset_pack_id
```

## 実測

2026-07-27 の `upload-asset-pack.yaml` 実行で
`net.yumnumm.eqmonitor.assets` を指定したところ ASC が 409 で拒否。
`eqmonitor-assets` に変更して成功。
