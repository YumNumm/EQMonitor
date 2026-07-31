# iOS Managed Asset Pack のTestFlight調査手順

## 前提

`AssetPackNotReadyException` は「download未完了」だけを意味しない。
現行実装では、iOS version未対応、manifest未取得、manifest不正、asset欠落、
size不一致が同じ例外へ集約される。画面の文言だけで原因を断定しない。

## CIと端末状態を分けて確認する

1. `Upload Asset Pack` workflowで次を確認する。
   - app IDとpack ID（`eqmonitor-assets`）
   - `backgroundAssetVersion` の最終状態が `COMPLETE`
   - upload対象のpack versionとarchive size
2. `Deploy App` workflowで次を確認する。
   - `AssetDownloader.appex` のcompile・embed
   - IPA exportとApp Store Connect uploadの成功
   - embedded extensionのbundle version警告
3. Apple Developer PortalでBackground Assets capabilityと最新profileを確認する。
4. App Store Connectで対象pack versionの状態を確認する。
5. 端末でiOS 26.0以上であることを確認する。

workflowが成功しても、端末上でmanifestと全assetが利用可能とは限らない。
逆に、端末の未取得表示だけでupload失敗と判断してはいけない。

## 今回確認できた事実

- Asset Pack v0.0.2は `eqmonitor-assets` としてASCへuploadされ、API状態は
  `PROCESSING` から `COMPLETE` へ遷移した。
- 対応するTestFlight buildでは `AssetDownloader.appex` がcompile・embedされ、
  IPA uploadも成功した。
- Apple Developer PortalのBackground Assets capabilityは有効だった。
- archive時点では親appと複数extensionの `CFBundleVersion` が一致せず、
  `ValidateEmbeddedBinary` warningが出ていた。App Store exportでは
  `manageAppVersionAndBuildNumber=true` のため、最終IPAを別途確認しない限り、
  archive時の値がそのまま配布されたとは断定できない。
- v0.0.2の展開artifactは約9.5MBである。v0.0.1のPMTiles欠落問題と同程度の
  サイズであるため、ファイル存在・size検証とは別に地物数検証が必要である。

## 調査時の注意

- `AssetPackManager.url(for:)` は存在しないpathにもwell-formed URLを返し得る。
  URL取得成功だけでdownload完了と判断しない。
- manifestが存在しても、Background Assetsはファイル単位でdownloadされるため、
  全assetの存在とsizeを確認する。
- `checkForUpdates()` は状態を変更し得る。最初に診断情報を保存し、明示操作でのみ
  実行する。
- `checkForUpdates()` のreturnは全ファイルのdownload完了通知ではない。
  `updatingIDs`を記録し、その後manifestと全assetを再診断して完了を判断する。
- 調査目的でpackを削除して強制再downloadしない。端末状態を失い、元の原因を
  観測できなくなる。
- 固定値やbundled assetへフォールバックして障害を隠さない。

## 関連コマンド

```bash
# workflowの直近状態
gh run list --repo YumNumm/EQMonitor --workflow deploy-app.yaml --limit 10
gh run list --repo YumNumm/EQMonitor --workflow upload-asset-pack.yaml --limit 10

# Asset Pack releaseのサイズ
gh release view asset-pack-v0.0.2 \
  --repo YumNumm/eqmonitor-backend \
  --json assets --jq '.assets[] | "\(.name) \(.size)"'
```

端末側の原因分類は
`docs/superpowers/specs/2026-07-31-ios-asset-pack-diagnostics-design.md` の
構造化診断APIで行う。
