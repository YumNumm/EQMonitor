# beta Releaseの外部配布とGitHub Deployment確認

## `/beta` から外部配布までの流れ

Release PRへ `/beta` とコメントすると、`Create Beta Release` がGitHub Appの
installation tokenで `v<version>-beta.<number>` タグをpushする。

`Deploy App` は `v*-beta.*` のtag pushを監視し、betaでは次を配布する。

- iOS
  - App Store Connectへアップロード
  - Firebase App Distributionへ配布
  - TestFlight外部グループへ公開
- Android
  - Firebase App Distributionへ配布
  - Google Playの `external` クローズドテストトラックへ公開

`google-play-cli 1.0.1` は既存trackの更新だけを行うため、`external` が無い状態で
直接publishすると失敗する。Google Play公開jobはpublish前に
`scripts/release/ensure_google_play_track.sh` を実行する。このスクリプトは
Android Publisher APIのedit内でtrack一覧を確認し、無い場合だけ
`CLOSED_TESTING` / `DEFAULT` の `external` trackを作成してeditをcommitする。

track作成後、Play Consoleの Testing > Closed testing > External で、外部テスターの
Google Groupまたはメールリストとフィードバック先を一度設定する。Publishing APIの
track作成だけではテスターは自動追加されない。

Google Play `external` が失敗しても `internal` へフォールバックしない。失敗は
該当jobとGitHub Deployment Statusのfailureとして扱う。

通常の `develop` pushと手動実行ではAndroidの `internal` trackを維持する。
`develop` pushの `[external]` は従来どおりiOSのTestFlight外部配布だけを有効にする。

## リポジトリ内スクリプトをjobで実行する

GitHub-hosted runnerのworkspaceは、job開始時点ではリポジトリのファイルを含まない。
`scripts/ci/resolve_deploy_app_policy.sh` のようなリポジトリ内スクリプトを実行する
jobは、そのstepより前に `actions/checkout` を置く。

checkoutを省略すると、スクリプトがコミット済みで実行権限を持っていても次のように
失敗する。

```text
scripts/ci/resolve_deploy_app_policy.sh: No such file or directory
```

workflow変更後は、stepの存在だけでなくcheckoutがスクリプト実行より前にあることを
focused testで確認する。

## GitHub Deploymentsで実配布を確認する

タグとReleaseの存在だけでは、アプリが配布された証拠にならない。
GitHub Deploymentsをbetaタグで絞り込む。

```bash
gh api --method GET \
  repos/YumNumm/EQMonitor/deployments \
  -f ref=v3.0.0-beta.2 \
  --jq '.[] | {id, environment, ref, sha, created_at, statuses_url}'
```

各deploymentの最新statusを確認する。

```bash
gh api --method GET \
  repos/YumNumm/EQMonitor/deployments/DEPLOYMENT_ID/statuses \
  --jq '.[0] | {state, description, environment, log_url, created_at}'
```

少なくとも `EQMonitor-iOS` と `EQMonitor-Android` のdeploymentがbetaタグをrefに
持つことを確認する。同じEnvironmentを使うApp Store/Google PlayとFirebaseの
各jobにより、同じEnvironment名のdeploymentが複数作成される場合がある。

Deploymentがsuccessでも、ストア側の処理完了とは限らない。次も確認する。

- App Store Connectでビルド処理が完了していること
- TestFlight外部グループへビルドが割り当てられていること
- Firebase App DistributionのiOS/Android releaseが存在すること
- Google Play `external` trackに対象version codeが存在すること

## Release Notesの `@` を安全に扱う

GitHubの自動生成Release Notesは、PRタイトルやコミットメッセージ中の `@foo` も
ユーザーメンションとして解釈する。これにより、実際の作者ではないユーザーが
Contributorsへ表示されることがある。

`Create Beta Release` は自動生成本文を
`scripts/release/sanitize_release_notes.py` に通す。変更項目のタイトル部分だけ、
すべての `@` を表示が同じになるHTML entity `&#64;` へ変換する。

```text
* fix: @Default(ja) by @YumNumm in ...
```

は次になる。

```text
* fix: &#64;Default(ja) by @YumNumm in ...
```

正式な `by @YumNumm` とNew Contributorsのメンションは変更しない。

## 既存beta Release本文を修復する

修正済みworkflowが `develop` に入った後、次を実行する。

```bash
gh workflow run create-beta-release.yaml \
  --ref develop \
  -f version=v3.0.0-beta.1 \
  -f repair_existing_release=true
```

修復モードは既存Release本文を取得して同じサニタイズを適用する。新しいタグや
Releaseは作成しない。`version` 未指定、Release不在、API失敗時はjobをfailureにする。

実行後はRelease本文で誤メンションが消え、正式な作者表記が残っていることを確認する。
