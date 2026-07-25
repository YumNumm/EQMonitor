# Beta Release Deployment Design

## 背景

Release PR のコメントに `/beta` を投稿すると、`Create Beta Release` は
betaタグとGitHub prereleaseを作成する。しかし `Deploy App` は `develop`
ブランチへのpushと手動実行だけを監視しているため、betaタグ作成後にアプリの
ビルド・配布が開始されず、betaタグに対応するGitHub Deploymentも作成されない。

また、GitHubの自動生成Release NotesはPRタイトル中の `@` をメンションとして
解釈する。`@Default(ja)` を含む過去のPRタイトルにより、実際の作者ではない
`default` ユーザーがReleaseのContributorsに表示された。

## 成功条件

- `/beta` が作成した `v<version>-beta.<number>` タグで `Deploy App` が起動する。
- betaタグではiOSとAndroidをビルドし、次の配布を行う。
  - iOS: App Store Connect、Firebase App Distribution、TestFlight外部グループ
  - Android: Firebase App Distribution、Google Playの `external` テストトラック
- Environmentを参照する各配布ジョブにより、betaタグをrefとするGitHub
  DeploymentとDeployment Statusが記録される。
- 通常の `develop` pushと手動実行の既存配布動作を維持する。
- Release NotesのPRタイトルまたはコミットメッセージ部分に含まれるすべての
  `@` は、見た目を保ったままGitHubメンションとして解釈されない。
- GitHubが生成する正式な作者表記（`by @user`）とNew Contributorsのメンションは
  維持する。
- 既存の `v3.0.0-beta.1` Release本文にも同じサニタイズを適用できる。

## 設計

### 1. betaタグをデプロイトリガーにする

`deploy-app.yaml` の `push` に `v*-beta.*` のtag filterを追加する。
タグpushはデプロイ対象の不変なrefをそのままワークフローへ渡せるため、
`workflow_run` で「最新タグ」を再探索する方式や、巨大なワークフロー全体を
`workflow_call` 化する方式より競合が少なく、変更範囲も小さい。

`define-matrix` はpushの種類を明示的に分ける。

- betaタグ: iOS/Androidを有効化、iOS externalを有効化、Android trackを
  `external` にする。
- `develop` push: 現在と同じくiOS/Androidを有効化する。iOS externalは既存の
  `[external]` 判定を維持し、Android trackは `internal` のままにする。
- `workflow_dispatch`: 現在の入力を維持し、Android trackは `internal` とする。

AndroidのGoogle Play公開ジョブはmatrixが出力するtrack名を受け取り、固定値の
`internal` の代わりに使用する。`external` はGoogle Playのクローズドテスト用
トラックとして最初の公開時に作成する。

各deploy jobには既に `EQMonitor-iOS` または `EQMonitor-Android` Environmentが
設定されている。したがって追加のDeployments API呼び出しは行わず、GitHub
Actionsが作成するDeploymentを正とする。

### 2. Release Notesを作成前にサニタイズする

`gh release create --generate-notes` を直接使わず、GitHub Release APIで生成した
本文をファイルへ保存し、専用スクリプトでサニタイズしてから
`gh release create --notes-file` に渡す。

生成ノートの変更項目は次の形を持つ。

```text
* <PR title or commit message> by @author in <URL>
```

スクリプトは、末尾の ` by @author in <URL>` を正式な作者suffixとして分離する。
そのsuffixより前にあるすべての `@` をHTML entity `&#64;` に変換し、表示上の
`@` を維持しながらメンション通知とContributorsへの誤集計を防ぐ。suffix、
New Contributors、Full Changelogなど、変更項目タイトル以外の行は変更しない。
作者suffixとして厳密に識別できない行は、正式メンションを誤って壊さないため
変更しない。

変換は冪等にし、既に `&#64;` になった箇所を再変換しない。

### 3. 既存Releaseの修復

`Create Beta Release` の `workflow_dispatch` に既存Release修復用のboolean入力を
追加する。修復時は必須の `version` で指定したRelease本文を取得し、同じ
サニタイズスクリプトを適用して `gh release edit --notes-file` で更新する。
タグ作成とRelease新規作成は実行しない。

`v3.0.0-beta.1` は修正後のワークフローを手動実行して修復する。version未指定、
Release不在、API失敗のいずれもjobを失敗させ、成功扱いにはしない。

## エラー処理と安全性

- betaタグのpatternに一致しないタグではデプロイを起動しない。
- tag、生成ノート、Release作成のいずれかが失敗した場合、`Create Beta Release`を
  failureにして成功リアクションを付けない。タグpushで非同期に起動する
  `Deploy App` の成否は別runとGitHub Deployment Statusで判定し、PRコメントの
  リアクションをデプロイ成功の意味には使わない。
- ストア公開のいずれかが失敗した場合、対応するdeploy jobとGitHub Deployment
  Statusをfailureにする。
- Google Play `external` 公開失敗時に `internal` へフォールバックしない。
- サニタイズで行構造を識別できない場合、推測で作者メンションを書き換えない。
- 現在の `develop` pushおよび手動デプロイの配布先をbeta対応の副作用で変えない。

## テスト

リポジトリ内のfixtureとテストスクリプトで次を検証する。

1. `deploy-app.yaml` がbetaタグを監視する。
2. betaタグではiOS externalが有効になり、Android trackが `external` になる。
3. `develop` pushと手動実行ではAndroid trackが `internal` のままである。
4. `@Default(ja)`、`@foo`、複数の `@` を含む変更タイトルが `&#64;` へ変換される。
5. `by @YumNumm` とNew Contributorsの正式メンションは保持される。
6. サニタイズを2回適用しても結果が変わらない。
7. 既存Release修復モードでは新しいタグを作らない。

加えて `mise exec -- actionlint .github/workflows/*.yaml` と、追加したfocused testを
実行する。実際のストア公開はローカルテストでは行わず、修正後のbetaでActions
run、GitHub Deployments、TestFlight、Firebase、Google Play `external` の状態を
確認する。

## 運用知識

betaタグと外部配布の関係、GitHub Deploymentの確認方法、Release Notes内の
メンション安全化を `docs/knowledge/20260725_beta_release_deployment.md` に記録する。
