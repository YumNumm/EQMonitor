# `ba-package` CLI（Managed Background Assets アーカイブ生成）

Apple 公式: [Creating managed asset packs](https://developer.apple.com/documentation/backgroundassets/creating-managed-asset-packs)

## 確認環境

- macOS 上の Xcode 27 系（`xcrun ba-package --help` が利用可能）
- CI: `.github/workflows/upload-asset-pack.yaml` の `upload-ios` ジョブ（`IOS_ASSET_PACK_XCODE_VERSION`）

## 正しいコマンド形式

WWDC25 トランスクリプトの旧形式 `ba-package <manifest> <output>` は **現在の CLI では使えない**。
現行 CLI はサブコマンド必須:

```bash
# マニフェスト雛形
xcrun ba-package template -o Manifest.json

# アーカイブ生成（manifest の fileSelectors は CWD 相対）
cd /path/to/pack-contents-root
xcrun ba-package package Manifest.json -o /path/to/output.aar
```

要点:

- サブコマンドは `package`（省略時のデフォルトだが、CI では明示推奨）
- 出力は `-o` / `--output-path` で指定
- **拡張子は `.aar` 必須**（それ以外はエラー）
- `fileSelectors` の `file` / `directory` パスは `ba-package` 実行時のカレントディレクトリ基準

## EQMonitor での利用箇所

- `.github/workflows/upload-asset-pack.yaml` の `Package archive with ba-package` ステップ
- 生成物は App Store Connect API（`tool/asset_pack/upload_ios_background_assets.py`）でアップロード

## よくある間違い

| 誤り | 正しい |
|------|--------|
| `xcrun ba-package manifest.json ../out.archive` | `xcrun ba-package package manifest.json -o ../out.aar` |
| 出力拡張子 `.archive` / 拡張子なし | `.aar` |
| manifest だけリポジトリに置き、アセット本体の CWD を合わせない | `cd` で `fileSelectors` の基準ディレクトリに移動してから実行 |
| `"fileSelectors": [{ "directory": "." }]` | `manifest.json` / `map` / `parameters` など具体パスを列挙する（`.` は staging 衝突で失敗する） |

## Terminal state (live-confirmed 2026-07-27)

After `ba-package` → reserve → multipart upload → commit, App Store Connect
moves the `backgroundAssetVersion` through:

1. `PROCESSING`
2. `COMPLETE` ← **success** (this is what the live API returned)

`tool/asset_pack/asc_client.py`'s `KNOWN_SUCCESS_STATES` therefore includes
`COMPLETE`. Older guessed names (`READY_FOR_TESTING`, `PROCESSING_COMPLETE`)
remain as additional allow-list entries.

## 手動フォールバック

自動アップロードが失敗した場合は [Upload Apple-hosted asset packs](https://developer.apple.com/jp/help/app-store-connect/manage-asset-packs/upload-apple-hosted-asset-packs) のとおり Transporter へ `.aar` をドラッグ＆ドロップする。

