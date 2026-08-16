# Asset Pack の R2 配布・アプリ同梱

Asset Pack の正規配布先は Cloudflare R2 のカスタムドメイン
`https://assets.eqmonitor.app/v1/assets`。iOS Managed Background Assets と
Android Play Asset Delivery は使用しない。

## 公開レイアウト

```text
v1/assets/
├── manifest.json
├── manifest.sig
└── packs/<version>/asset-pack-v<version>.zip
```

- `manifest.json` は更新一覧のトップレベル manifest。
- `manifest.sig` は manifest の Ed25519 署名 sidecar。
- ZIP は version ごとの immutable object。上書きしない。
- manifest と signature は再検証される短いキャッシュ、ZIP は immutable
  cache とする。

backend の `release-asset-pack.yaml` は ZIP を生成した後、R2 へ
`ZIP -> manifest.sig -> manifest.json` の順で公開し、公開物を再取得して
署名まで検証してから `asset_pack_released` を dispatch する。

EQMonitor の `.github/workflows/upload-asset-pack.yaml` は dispatch を受け、
公開カスタムドメインから 3 ファイルを再取得し、次を検証する。

1. `manifest.sig` の Ed25519 署名と manifest SHA-256
2. dispatch の version / SHA-256 と署名済み entry の一致
3. ZIP 実体の size / SHA-256
4. ZIP 内の必須ファイルと pack version

## アプリへのデフォルト Pack 同梱

`tool/asset_pack/stage_from_r2.sh --target bundled` は署名済み最新 Pack を
`app/assets/platform/` へ原子的に配置する。Android と iOS のリリース CI は
ビルド前に必ずこれを実行する。

- Android: `app/android/app/build.gradle.kts` が `app/assets/platform` だけを
  generated assets の `platform/` として base app に含める。初回解決時に
  app-private storage へ展開する。
- iOS / macOS: Xcode Runner の folder reference で `platform/` を Bundle
  Resources に含める。
- iOS native extension 用の縮小 JMA テーブルも必要な場合は
  `tool/asset_pack/stage_from_r2.sh --target all` を使う。

同梱 Pack はアプリの更新でのみ置き換わり、R2 更新を適用・削除しても残る。

## ランタイム更新

アプリは起動後に `manifest.json` / `manifest.sig` を取得する。署名、manifest
revision の巻き戻し、`minimum_app_version` を検証し、より新しい Pack がある
場合だけ Home に案内を表示する。

ユーザーがダイアログで同意した後に ZIP をダウンロードする。UI は進捗を
表示し、ZIP と展開後全ファイルの size / SHA-256、未宣言ファイル、Zip Slip、
symlink、展開サイズ上限を検証する。検証済み staging を app support directory
へ切り替え、active version 以外のダウンロード版を削除する。

active download が欠損・破損していれば preference と破損ディレクトリを外し、
同梱 `platform/` を即時利用する。同梱 Pack 自体は削除しない。
アプリ更新で同梱 Pack の方が新しくなった場合も、古い download を削除して
同梱 Pack を選ぶ。

download task ID は Pack version から決定し、起動後に downloader の永続DBを
復元する。OS がバックグラウンドで完了させた同一 ZIP は再取得せず、検証・展開へ
引き継ぐ。

## 鍵と GitHub 設定

現在の key id は `asset-pack-2026-08-16`。公開鍵はアプリと
`tool/asset_pack/trusted_keys/` に保持する。秘密鍵は backend のSOPS暗号化済み
`.env.json`をsource of truthとし、同じ値をrepositoryの
`ASSET_PACK_SIGNING_PRIVATE_KEY_BASE64` secretへ同期する。

backend repository に必要な値:

- secret `ASSET_PACK_SIGNING_PRIVATE_KEY_BASE64`
- variable `ASSET_PACK_SIGNING_KEY_ID=asset-pack-2026-08-16`
- secret `CLOUDFLARE_API_TOKEN`（対象 R2 bucket の object read/write）
- variable `CLOUDFLARE_ACCOUNT_ID`

鍵ローテーション時は旧 manifest が配信され得る期間、旧公開鍵もアプリに残す。

## 手動確認

```bash
curl -fsS https://assets.eqmonitor.app/v1/assets/manifest.json | jq .
curl -fsS https://assets.eqmonitor.app/v1/assets/manifest.sig | jq .
tool/asset_pack/stage_from_r2.sh --target bundled
```

Terraform は `backend/home8s/terraform/cloudflare` で R2 bucket
`eqmonitor-assets` と custom domain `assets.eqmonitor.app` を管理する。
