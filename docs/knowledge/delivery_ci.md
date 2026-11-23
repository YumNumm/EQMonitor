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
- 本番と beta の release-please ジョブは同一 GitHub App installation の REST 制限を共有する。
  並列実行すると commit backfill の API 呼び出しが重なり rate limit や 5xx になりやすいため、
  `.github/workflows/release-please.yaml` では beta 完了後に本番を走らせる（2026-11-22 確認）。
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
- 正式版を手動公開した場合も、正式版 manifest を公開済みタグのversionへ同期する。
  manifest は公開済み版を記録し、これからビルドする版を先取りしない。
- iOS 提出時は `app/pubspec.yaml` のプレリリース識別子を除いた `X.Y.Z` を使う。
  承認済み版の受付が終了すると `ITMS-90186` / `ITMS-90062` になるため、次のビルドは
  `X.Y.Z` 自体を承認済み版より上げる。beta番号やbuild番号だけの更新では解消しない。

## 配布ポリシー

正本は `scripts/ci/resolve_deploy_app_policy.sh` と `.github/workflows/deploy-app.yaml`。

| 起点 | iOS | Android track | `IS_PRODUCTION` | `IS_BETA_DISTRIBUTION` |
| --- | --- | --- | --- | --- |
| `develop` push | 内部、`[external]` を含むと外部 | `internal` | true | false |
| `v*-beta.*` push | TestFlight 外部 | `external` | true | true |
| 手動実行 | `ios` / `external` 入力 | `android` / `android_track` 入力（既定 `internal`） | true | false |

- `v*-beta.*` push のビルドはベータ配布専用。`resolve_deploy_app_policy.sh` の
  `beta-distribution` が true になり、iOS・Android の `flutter build` に `IS_BETA_DISTRIBUTION=true` を渡す。
  アプリアイコンは dev 用（iOS `AppIcon-dev`、Android `ic_launcher_dev`）になり、
  `BuildConfig.isSubscriptionAvailable` が false になる。
  同じビルドから配る Firebase App Distribution 向けバイナリも同じ挙動になる。
- `isSubscriptionAvailable` が false のビルドは、購入済みでも常に無料版として動作する。
  `SubscriptionNotifier` は RevenueCat・バックエンドへ問い合わせず `inactive` を返し、
  購入・復元・同期を実行しない。Paywall には購入不可の案内を表示する。
  クライアント側の判定だけを変えるため、バックエンドに登録済みの Pro 権限・通知設定は変更しない。

- `develop` push はその時点の `app/pubspec.yaml` を配布する。未マージのRelease PRのバージョンは使わないため、新しいバージョンの配布前にRelease PRを取り込む。Release PleaseはApp Store側の承認済みバージョンを自動照合しない。
- Android オープンテストは `android_track=beta`。`external` は独自のクローズドテスト。
- 手動実行の `source_run_id` に完了済み `Deploy App` run ID を指定すると、再ビルドせず
  元のバイナリと配布ノートを再利用する。元runのビルド成功・artifact有効期限・versionを検査する。
  iOS は署名済みIPA内のversion/build numberに一致する ASC buildを選び、Android はAABのSHA-256を照合して
  対象trackへ設定する。Firebaseへの重複配布は行わない。
- iOS の署名済みIPAのbuild numberはCI run numberと一致するとは限らない。
  export時の採番が入るため、CI番号をASCのビルド選択へそのまま渡さない。
- 一般公開には `v*-beta.*` タグのビルドを使わない。dev アイコン・課金無効のベータ配布専用バイナリのため、
  iOS は `develop` push か手動実行の run で作った ASC build を選択し、Android も同じく
  ベータタグの versionCode を Play Console で製品版へ昇格しない。
  `source_run_id` に beta タグの run を指定すると、同じベータ専用バイナリが対象 track へ配られる。

- 両OSとも対応する Firebase App Distribution へ配布する。iOSストアuploadとFirebaseは別job。
- 揺れ検知通知は `IS_SHAKE_DETECTION_ENABLED`（既定 true）だけで制御し、production かどうかを見ない。
  ワークフローはこの値を渡さないため、配布ビルドでは揺れ検知通知が有効になる。配布先ごとに止める場合は `false` を渡す。
  端末内の揺れ検知（地図・カードの表示）はこのフラグに依存せず、デバッグ画面の設定で有効にする。
  詳細は [EEW・リアルタイム](eew_realtime.md) を参照する。
- GitHub Actions の iOS / Android ビルドは、配布先によらず `IS_PRODUCTION=true` を渡す。
  ローカルでは未指定時 false、`--dart-define=IS_PRODUCTION=true` で切り替える。
- `BuildConfig.isDeveloperUiEnabled` は `!isProduction`。設定画面のキャッシュ項目の表示にだけ使う。
- デバッグ画面は配布先によらず、デバッグモードが有効な端末で開ける。有効化は設定画面のビルド番号を
  10 回タップし、全画面の警告ダイアログ（`DebugModeWarningDialog`）に同意して行う。同意は保存せず、有効にするたびに求める。
  無効化はデバッグ画面最上部のトグルで行う。debug ビルドでは未設定時に有効として扱う。
- 権限は `DebugAccessLevelResolver` が決める。デバッグモードが無効なら `none`、有効で Admin ロールなら `full`、
  それ以外は `restricted`。`restricted` では Admin 限定の項目を表示せず、`DebugMenuRouteGuard` が該当ルートへの遷移も拒否する。
  Admin 限定は Chuck、オンボーディングとそのリセット、ログ、サーバ選択、認証、App Groups UserDefaults、SharedPreferences、
  SecureStorage、HTTP キャッシュとその無効化、WebSocket、ナビゲーション、デバイス・通知、通知 Webhook、デバイス管理、
  Start API、Firebase App Check。項目を追加するときは、画面の表示条件とガードの一覧の両方を更新する。
- production では Telemetry の記録・端末内保存・API 送信を無効にする。
  DB のパス解決・接続、起動と resume の記録、起動時計測の保存を開始せず、
  通知タップ・push token 同期失敗の記録は保存先も API client も持たない実装を使う。
  iOS 通知拡張の TelemetryWriter もコンパイル対象から外す。
- iOS の `extract_dart_defines.sh` は同じフラグを全 app extension の Swift へ渡す。
  production では Siri / Shortcuts / Control Center の AppIntent をコンパイル対象から外す。
  ホーム画面 Widget の設定用 Intent は維持し、Shortcuts からの検出を無効にする。
- BETA バナー・beta 同意への自動遷移・設定画面の commit hash 表示は廃止する。
  揺れ検知の UI・REST 同期・realtime event・デバッグ挿入は共通の利用可否で判定する。
- production では揺れ検知の一般向け設定導線を隠し、通知設定の変更操作を無効にする。
  デバッグメニューへのアクセス権があれば、揺れ検知の利用可否によらず
  `/settings/debug/shake-detection-settings` を開ける。通知設定の変更には揺れ検知の有効化が必要。
  起動時には保存済みの揺れ検知通知を `enabled=false` へ同期する。地域・閾値は保持する。
  通信に失敗した場合は次の起動・再プロビジョニングで再試行するため、
  サーバー側の通知停止は設定の同期成功後に反映される。
  揺れ検知だけを理由とする位置情報監視を停止し、iOS Live Activity も揺れ検知を表示しない。
  Android の OS 通知設定でも揺れ検知チャネルを作成せず、更新前の同チャネルは削除する。
- Proの購入・復元・設定導線は `isSubscriptionAvailable` が true のビルドで有効。有料権限はバックエンド確認値で判定する。
- RevenueCatの公開SDKキーは、GitHub secret `AGE_KEY` → SOPS `.env.json` →
  `DART_DEFINE_PRODUCTION` → `environment/.env.prod` → `--dart-define-from-file` で供給する。
  iOS/Androidとも同じproduction defineを使う。ローカルの環境ファイルとは別管理。
  2026-09-29に暗号化設定の両SDKキーがRevenueCat登録値と一致することを確認済み。
- Google Playの `external` はpublish前に `scripts/release/ensure_google_play_track.sh` で作成する。
  `CLOSED_TESTING` / `DEFAULT` のtrack作成後、Consoleでテスター・フィードバック先を別途設定する。
  外部配布失敗を `internal` への自動フォールバックで隠さない。
- Android Publisher APIへのトークンには `androidpublisher` scope が必要。
  `cloud-platform` だけでは拒否される。

## 配布ノートと緊急修復

- `scripts/ci/generate_release_note.sh` がOS別に生成し、末尾の `rev: <40桁SHA>` を維持する。
- iOS betaタグは `CHANGELOG.beta.md` の同version節をプレーンテキスト化する。
  節がない場合は失敗させる。比較リンクは直前betaからの差分、コミットリンクは除去する。
  同じ節の同文の項目は1件にまとめる（下記の二重計上への対処）。
- その他のiOSは ASC test-notes、Androidは対象Play trackの前回ノートにある `rev:` を差分起点にする。
  iOS内部配布にもノートを書き、履歴をつなぐ。
- iOS の test-notes は `asc builds list` の build ID で `asc builds test-notes list --build-id` を引く。
  `--build-number` 指定は同じ番号のビルドが複数あると一意に決まらず失敗するため使わない。
  取得失敗は理由をログへ出して次のビルドへ進む。
- 本文が空の merge commit（CLI・API でのmerge）は `gh pr view` で PR タイトルを補う。
  `generate-release-note-*` job には `GH_TOKEN` と `pull-requests: read` が必要で、
  欠けるとブランチ名が項目名になる。
- Release Please は merge commit 本文の `feat: ...` と PR 内のコミットを別々に数えるため、
  同じ項目が二重に載る。`release-please.yaml` はリリース作成後に
  `scripts/release/dedupe_release_please_notes.py` で GitHub Release 本文の同文項目を除く。
  Release PR 本文と `CHANGELOG*.md` には重複が残る。発生源から止めるには、リポジトリ設定で
  merge commit の本文を空にする（`merge_commit_message: BLANK`）。タイトルを PR タイトルにする
  設定（`merge_commit_title: PR_TITLE`）では、タイトル側が同じく二重に数えられる。
- iOS内部配布は `asc builds upload --wait --test-notes` でApple側の処理完了を待ち、返却された `buildId` で処理状態と内部グループを確認する。アップロード成功だけでは配布成功とみなさず、ノートの更新に `--latest` を使わない。
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

## アップデート後の新機能の案内

- ホームに出す新機能の案内は `app/lib/feature/release_highlight/data/model/release_highlight.dart` の `ReleaseHighlight` に値を追加して定義する。値が無いリリースでは何も表示しない。主ボタンの行き先と表示条件は `visible_release_highlight_provider.dart` と `ReleaseHighlightFlow` の `switch` に追加する。
- 既読のバージョン（`release_highlight_seen_version`）より新しく、現在のバージョン以下の案内のうち最新の 1 件を表示する。新規インストールではオンボーディング完了時に現在のバージョンを既読にする。
- 配布ビルドは beta でも `x.y.z` を名乗るため、バージョンは `x.y.z` だけで比較する。beta で既読にした端末には、同じ `x.y.z` の正式リリースで再表示されない。
- 案内する機能を使えない端末では表示せず、既読にもしない。後から使えるようになった時点で表示される。

## CI の依存・権限・起動条件

- repository内scriptを実行するjobは、そのstepより前にcheckoutする。
- Flutter jobにprivate backendは通常不要。
  `submodules: true` は直下backendも取得するため、`recursive` から変えるだけでは404を防げない。
- private repositoryが本当に必要なjobだけGitHub App tokenの対象に追加する。
  再帰取得ならnested private repoもinstall対象と `repositories` 一覧に必要。
  install対象外を1件でも列挙するとtoken発行自体が422になる。
- CIのツール対象はjobの `MISE_ENABLE_TOOLS` で絞る。`mise-action` の `install_args` や
  `mise exec python -- ...` の引数だけでは、その後の `mise exec` による全ツール導入を防げない。
- Flutter検証jobは `flutter,node,python` を許可し、DartはFlutter同梱版を使う。
  この制限はMelosから起動する子プロセスにも引き継ぐ。`MISE_NO_HOOKS=true` でローカルcommit用のhook導入を省く。
- clean checkoutでは解析・テスト前に `tool/asset_pack/stage_from_r2.sh --target bundled` で
  同梱Asset Packを配置する。署名検証にNode、レイアウト検証にPythonを使う。
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
