# 配布・Release Please・CI 運用

2026-09-21 に workflow / script / config と照合。
ネイティブビルドは [native_build_release.md](native_build_release.md) を参照する。

## Release Please の2系統

| 項目 | 本番 | beta |
| --- | --- | --- |
| config | `release-please-config.json` | `release-please-config.beta.json` |
| manifest | `.release-please-manifest.json` | `.release-please-manifest.beta.json` |
| changelog | `CHANGELOG.md` | `CHANGELOG.beta.md` |
| component | `eqmonitor_workspace` | `eqmonitor-beta` |
| tag | `vX.Y.Z` | `vX.Y.Z-beta.N` |

- `develop` push で両系統を実行する。通常のbeta配布は beta Release PR のmergeから始める。
  merge → prerelease/tag 作成 → `Deploy App` の `v*-beta.*` push、という経路。
- component はPRブランチ衝突の防止に必要。両configで `include-component-in-tag: false` を維持する。
- 両PRが `app/pubspec.yaml` を更新する。原則 beta を繰り返し、本番は最後にmergeする。
  Release PR ブランチは再生成されるため直接編集せず、設定変更は `develop` へ入れる。
- `extra-files` は generic updater、pubspec のversion行は `# x-release-please-version` を維持する。
  YAML全体の再シリアライズで native/data assets 等の運用コメントを消さない。
- 任意のversion指定はコミットfooterの `Release-As: X.Y.Z` を使い、merge後のメッセージにも残す。
  config の `release-as` は持続するため、使った場合はリリース後に削除する。
- commit search depth の既定500を超えたfooterは検出されない。古い指定が効かないときは
  footer付きコミットを入れ直す。検索深度の拡大はchangelogの範囲にも影響する。
- beta manifest がずれた場合は直近betaタグのversionと照合して `develop` 側で修正する。

## 配布ポリシー

正本は `scripts/ci/resolve_deploy_app_policy.sh` と `.github/workflows/deploy-app.yaml`。

| 起点 | iOS | Android track | `IS_BETA_TESTING` |
| --- | --- | --- | --- |
| `develop` push | 内部、`[external]` を含むと外部 | `internal` | false |
| `v*-beta.*` push | TestFlight 外部 | `external` | true |
| 手動実行 | `ios` / `external` 入力 | `android` 入力、trackは `internal` | 入力、既定false |

- 両OSとも対応する Firebase App Distribution へ配布する。iOSストアuploadとFirebaseは別job。
- 公開テストでは `IS_SHAKE_DETECTION_ENABLED=false` を追加する。
  iOSは `deploy-ios-external`、Androidは `android-track == external` が判定条件。
- `BuildConfig.isDeveloperUiEnabled` は `!(isBetaTesting && flavor == prod)`。
  prod betaのdebug導線は抑止され、App Check等の確認経路もこれを考慮する。
- `IS_PRO_FEATURES_ENABLED` は既定false。Pro判定・課金UI・subscription routeのゲートを揃える。
- Google Playの `external` はpublish前に `scripts/release/ensure_google_play_track.sh` で作成する。
  `CLOSED_TESTING` / `DEFAULT` のtrack作成後、Consoleでテスター・フィードバック先を別途設定する。
  外部配布失敗を `internal` への自動フォールバックで隠さない。
- Android Publisher APIへのトークンには `androidpublisher` scope が必要。
  `cloud-platform` だけでは拒否される。

## 配布ノートと緊急修復

- `scripts/ci/generate_release_note.sh` がOS別に生成し、末尾の `rev: <40桁SHA>` を維持する。
- iOS betaタグは `CHANGELOG.beta.md` の同version節をプレーンテキスト化する。
  節がない場合は失敗させる。比較リンクは直前betaからの差分、コミットリンクは除去する。
- その他のiOSは ASC test-notes、Androidは対象Play trackの前回ノートにある `rev:` を差分起点にする。
  iOS内部配布にもノートを書き、履歴をつなぐ。
- `truncate_release_note.py` は `rev:` を残して、TestFlight 4,000 / Firebase 2,000 /
  Google Play 500文字へ制限する。deploy jobの切り詰めは runner の `python3` を使う。
- `/beta` コメントは廃止。緊急タグ作成・既存本文修復だけ `create-beta-release.yaml` を手動実行する。
  `version` は必須。本文修復の例:

```sh
gh workflow run create-beta-release.yaml --repo YumNumm/EQMonitor \
  --ref develop -f version=vX.Y.Z-beta.N -f repair_existing_release=true
```

- 修復は既存本文のみを更新する。`sanitize_release_notes.py` は変更項目タイトル中の `@` を
  `&#64;` にし、正式な `by @author` / New Contributors は保持する。

## 配布完了・フィードバックの確認

- tag/Release作成、archive成功、GitHub Deployment成功、ストア処理完了はそれぞれ別に確認する。
  `repos/YumNumm/EQMonitor/deployments?ref=<tag>` と各IDの `/statuses` の最新statusを読む。
  `EQMonitor-iOS` / `EQMonitor-Android` はストアとFirebaseで同名のdeploymentが複数存在しうる。
- ASCで処理完了と外部グループ割当、Firebaseの両OS release、Playの対象track/version codeを確認する。
- ASC認証はSOPS暗号化 `.env.json` とローカル `.config/age/age.txt` を使う。
  復号は子プロセス出力をメモリ内で読み、秘密鍵・平文JSONをログやGitへ出さない。
- 子プロセスへ `ASC_BYPASS_KEYCHAIN=1` と次の環境変数を渡す:

| asc | 復号JSONのキー |
| --- | --- |
| `ASC_KEY_ID` | `APP_STORE_CONNECT_API_KEY_ID` |
| `ASC_ISSUER_ID` | `APP_STORE_CONNECT_API_ISSUER_ID` |
| `ASC_PRIVATE_KEY_B64` | `APP_STORE_CONNECT_API_KEY_BASE64` |
| `ASC_APP_ID` | `APP_STORE_CONNECT_APP_APPLE_ID` |

```sh
asc testflight feedback list --paginate --include-screenshots --sort=-createdDate --output json
asc testflight crashes list --paginate --sort=-createdDate --output json
```

- `data` 件数、`meta.paging.total`、`links.next` で取得漏れを確認する。
  screenshot URLの `expirationDate` に注意し、投稿データはGit管理外に権限0600で保存する。

## CI の依存・権限・起動条件

- repository内scriptを実行するjobは、そのstepより前にcheckoutする。
- Flutter jobは public な `third_party/flutter_scene` だけを
  checkout 後の `git submodule update --init --depth 1 third_party/flutter_scene` で初期化する。private backendは通常不要。
  `submodules: true` は直下backendも取得するため、`recursive` から変えるだけでは404を防げない。
- private repositoryが本当に必要なjobだけGitHub App tokenの対象に追加する。
  再帰取得ならnested private repoもinstall対象と `repositories` 一覧に必要。
  install対象外を1件でも列挙するとtoken発行自体が422になる。
- CIの小さなjobは `mise exec python -- python3 ...` のように必要ツールを絞る。
  不要なFlutter等の導入を避ける。古いSwift/libncurses障害は現行mise設定の必須要件ではない。
- PR base branchの `/` を含む名前には `pull_request.branches: ["**"]` が必要。
  `"*"` は `/` を跨がない。pushのbranch filterは別ポリシーとして扱う。
- actionのSHA固定コメントは `# vX.Y.Z`。確認は `mise exec -- pinact run --check`。
- `uses: $/...` は正式な自リポジトリ参照構文。action として取得するとリポジトリ全体の
  archive 展開が走り、追跡済みの dangling な Terraform symlink で checkout 前に失敗する。
  Flutter submodule の初期化は `run` で直接実行し、archive 取得を避ける。再利用 workflow の
  `$/` 参照は維持する。`scripts/ci/test_flutter_job_setup.py` で取得方法と順序を検査する。
- ローカルで配布なしに確認できる回帰scriptは `scripts/ci/test_resolve_deploy_app_policy.sh`、
  `test_release_please_dual_track.sh`、`test_create_beta_release_workflow.sh`、`test_generate_release_note.sh`。

## backend の Argo v4 を扱う場合

backend 側の指示・現行 chart を先に確認する（今回の文書整理では未検証）。過去の v4 移行では、CronWorkflow を `spec.schedules` の配列へ変更し、global output を `{{io.argoproj.workflow.v1alpha1.outputs.parameters.cleanup-report}}` の形式で参照した。Helm 出力は `.yaml` 拡張子の一時ファイルに保存して strict lint へ渡す。旧 checkout の `deploy/k8s/` path をこの app repository のコマンドとして実行しない。
