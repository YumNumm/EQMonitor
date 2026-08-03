# CD の App Store Connect 通信を asc CLI へ移行する設計

日付: 2026-08-04
参照: https://github.com/rorkai/App-Store-Connect-CLI/blob/main/docs/WORKFLOWS.md

## 目的

CD（GitHub Actions）における App Store Connect との通信・TestFlight 処理を、
自前実装（`xcrun altool` / TypeScript 製 REST クライアント / Python 製 REST
クライアント）から asc CLI（rorkai/App-Store-Connect-CLI）へ置き換え、保守対象の
自前コードを削減する。

WORKFLOWS.md の使い分けに従う:

- TestFlight への配布は canonical path である `asc publish testflight` を直接使う
- 多段フロー（Background Assets）は `.asc/workflow.json` + `asc workflow run` で
  オーケストレーションする

## 置き換え対象

| 対象 | 現状 | 移行後 |
|---|---|---|
| iOS IPA アップロード（deploy-app.yaml / deploy-ios） | `xcrun altool --upload-app` | `asc publish testflight` |
| TestFlight 外部配布（deploy-app.yaml / deploy-ios） | `scripts/testflight/distribute-external.ts`（jose + 生 REST、約 270 行、pnpm install が毎回必要） | 同上の `asc publish testflight` に統合 |
| Background Assets アップロード（upload-asset-pack.yaml） | `tool/asset_pack/upload_ios_background_assets.py` + `asc_client.py` | `.asc/workflow.json` の `asset_pack_ensure` / `asset_pack_upload` |

変更しないもの:

- build-ios の Flutter ビルド / `xcodebuild archive`・`-exportArchive` / ad-hoc 署名
  （`asc xcode archive/export` への移行は今回のスコープ外。署名用 `.p8` 書き出しも
  export で必要なため build-ios では維持）
- Firebase App Distribution / Google Play 系ジョブ
- ランナー種別（deploy-ios は macos-26 のまま。asc は Linux でも動くため
  ubuntu 移行は将来の最適化として別途検討）

## 1. asc CLI の導入（mise github バックエンド）

mise.toml には `"github:rorkai/App-Store-Connect-CLI" = "latest"` が追加済みだが、
リリースアセットのバイナリ名が `asc_<version>_<os>_<arch>` のため、そのままでは
`asc` コマンドとして解決されない。`rename_exe` を指定する:

```toml
"github:rorkai/App-Store-Connect-CLI" = { version = "latest", rename_exe = "asc" }
```

検証済み: mise 2026.8.0 で上記により `asc` として実行可能（SLSA provenance 検証付き、
バージョン 3.4.1 / commit a5cbf6e で確認）。

CI 側の注意:

- mise の github バックエンドは GitHub API を叩くため、未認証だとレート制限に当たる。
  mise-action のステップに `GITHUB_TOKEN: ${{ github.token }}` を渡す。
- `mise.lock` に macos-arm64 のアセット URL/チェックサムが記録されることを確認する
  （過去に platform URL 欠落で deploy-app が落ちた実績があるため）。
- 対象ジョブの mise-action `install_args` に `github:rorkai/App-Store-Connect-CLI`
  を追加する。

## 2. deploy-app.yaml / deploy-ios ジョブ

現行の 2 ステップ（altool アップロード + 条件付き外部配布）を、`asc publish
testflight` 1 ステップに統合する。フラグをシェルで組み立てる:

```bash
args=(--app "$ASC_APP_ID" --ipa build/EQMonitor.ipa)
if [ "$DEPLOY_IOS_EXTERNAL" = "true" ]; then
  args+=(
    --group "$ASC_BETA_GROUP_ID"
    --test-notes "$TEST_NOTES"
    --locale ja
    --wait
    --submit --confirm
    --timeout 30m
  )
fi
asc publish testflight "${args[@]}"
```

- 通常時（develop push）: アップロードのみ。現行 altool と同等
  （内部グループは自動配布のため後続処理は不要）。
- 外部配布時（`[external]` コミット / workflow_dispatch）: アップロード →
  処理完了待ち → What to Test 設定 → 外部グループ追加 → Beta レビュー申請までを
  asc が実施。
- What to Test（`TEST_NOTES`）は現行ロジックを踏襲し、直前のステップで
  `git log <最終タグ>..HEAD --pretty='- %s'` を 4000 文字上限で丸めて生成する
  （数行のシェル）。
- 現行の「IPA を unzip して CFBundleVersion を照会する」ワークアラウンドは削除
  （asc が IPA から version/build number を自動抽出し、そのままビルド探索に使う）。
- `--timeout 30m` は現行 TS 実装のポーリング上限（30 分）を踏襲。

削除するもの:

- `scripts/testflight/` 一式（distribute-external.ts、テスト、package.json、
  pnpm-lock.yaml）
- deploy-ios の mise `install_args` から `node pnpm` を除去（asc 用に置き換え）
- deploy-ios の `.p8` 書き出しステップ（認証は環境変数直渡しへ。§4）

## 3. upload-asset-pack.yaml / iOS Background Assets

`.asc/workflow.json` を新設し、2 つのワークフローを定義する:

- `asset_pack_ensure`: `asc background-assets list --app "$APP_ID"` の結果から
  `assetPackIdentifier == "eqmonitor-assets"` を jq で検索し、なければ
  `asc background-assets create` する（現行 ensure-exists 相当）。
  ba-package 実行前の fail-fast として CI から単独実行する。
- `asset_pack_upload`: ensure と同じ解決ステップ →
  `asc background-assets versions create --background-asset-id …` →
  `asc background-assets upload-files create --version-id … --file "$ARCHIVE_PATH"
  --asset-type ASSET --checksum`（reserve → アップロード → commit を内包）→
  `asc background-assets versions view` による terminal state のポーリング
  （現行 Python の poll 相当。upload-files create が state 完了まで面倒を見る場合は
  実装時にポーリングステップを省略する）。

CI からの実行:

```bash
asc workflow validate
asc workflow run asset_pack_ensure APP_ID:… ASSET_PACK_ID:…
asc workflow run asset_pack_upload APP_ID:… ASSET_PACK_ID:… ARCHIVE_PATH:…
```

`.asc/workflow.json` の env に `"ASC_BYPASS_KEYCHAIN": "1"` を設定し、CI では
環境変数から認証を解決させる。

削除するもの:

- `tool/asset_pack/upload_ios_background_assets.py`
- `tool/asset_pack/asc_client.py`
- `tool/asset_pack/test_asc_client.py`
- upload-asset-pack.yaml の `.p8` 書き出し / 削除ステップ（環境変数直渡しへ）

備考: `docs/asset-pack-cd.md`・`docs/ios-background-assets.md` に Python スクリプト
への言及があれば追随して更新する。

## 4. 認証

既存 secrets をそのまま流用し、`.p8` ファイルの書き出しを廃止して asc の環境変数に
直接マップする（deploy-ios / upload-asset-pack の ASC 通信ステップ）:

| asc 環境変数 | 供給元 |
|---|---|
| `ASC_KEY_ID` | `APP_STORE_CONNECT_API_KEY_ID` |
| `ASC_ISSUER_ID` | `APP_STORE_CONNECT_API_ISSUER_ID` |
| `ASC_PRIVATE_KEY_B64` | `APP_STORE_CONNECT_API_KEY_BASE64`（base64 のまま渡せる） |
| `ASC_APP_ID` | 既存の定数 `6447546703` |
| `ASC_BYPASS_KEYCHAIN` | `1`（CI で keychain を参照させない） |

## テスト・検証

- `asc workflow validate` と `asc workflow run --dry-run` をローカルで実行して
  workflow.json を検証する。
- deploy-app.yaml は workflow_dispatch（ios のみ）で通常アップロードを実走確認、
  その後 external 入力付きで外部配布を実走確認する。
- upload-asset-pack.yaml は workflow_dispatch で実走確認する。
- 削除する TS/Python のテスト（distribute-external の単体テスト、
  test_asc_client.py）は実装ごと削除する。asc CLI 自体の動作は上流でテストされて
  いるため、リポジトリ側では YAML 上のフラグ組み立てシェルのみが検証対象。
- actionlint / zizmor（pre-commit）を通す。

## リスクと対応

- **asc のバージョン追随**: mise.lock で実質ピンされる。上流の破壊的変更は
  lockfile 更新時に CI で検出される。
- **`asc publish testflight` の想定外挙動**（例: グループ名解決・409 済み申請の
  扱い）: 現行 TS は「Beta レビュー申請済み（409）」を非致命として扱う。asc の
  挙動を実走で確認し、差異があれば `asc builds` 系の低レベルコマンドに分解して
  対応する。
- **Background Assets API 面の変化**: 現行 Python も「UNVERIFIED SURFACE」を明記
  した best-effort 実装であり、asc への移行で自前保守を上流へ移せる。失敗時の
  手動フォールバック（Transporter / `altool --upload-asset-pack`、
  docs/asset-pack-cd.md）は従来どおり有効。
