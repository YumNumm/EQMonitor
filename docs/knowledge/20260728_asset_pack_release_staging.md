# Asset Pack は git にコミットせず backend Release からビルド時取得する

## 結論

`map/all.pmtiles`（約 100MB）を含む Asset Pack は **リポジトリへコミットしない**。
正本は `YumNumm/eqmonitor-backend` の GitHub Release `asset-pack-vX.Y.Z`。

Git LFS は使わない。100MB 制限回避のための対症療法に過ぎず、正本が既に
Release にあるため二重管理になる。

## プラットフォーム別

| プラットフォーム | 取得方法 |
|---|---|
| iOS | `upload-asset-pack.yaml` が Release を取得 → `ba-package` → ASC へ直接アップロード（アプリバンドルには入れない） |
| Android | `deploy-app.yaml` の `build-android` が `tool/asset_pack/stage_from_release.sh --target android` で AAB ビルド直前に展開（PAD install-time） |
| macOS | 同スクリプト `--target macos` をローカル / 将来 CI で実行。`app/assets/platform/` は gitignore |

## ローカルで Android / macOS をビルドする場合

```bash
# eqmonitor-backend に contents:read できる GH_TOKEN が必要
export GH_TOKEN=...
tool/asset_pack/stage_from_release.sh --target both
# または特定バージョン
tool/asset_pack/stage_from_release.sh --version 0.0.0 --target android
```

## 関連

- `tool/asset_pack/stage_from_release.sh`
- `docs/asset-pack-cd.md`
- `docs/knowledge/20260728_asset_pack_id_charset.md`（iOS ID は `eqmonitor-assets`）
