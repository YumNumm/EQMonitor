# beta / 本番の二重 Release Please

日付: 2026-08-19

## 概要

本番と beta で Release Please を分ける。

| | 本番 | beta |
|---|---|---|
| config | `release-please-config.json` | `release-please-config.beta.json` |
| manifest | `.release-please-manifest.json` | `.release-please-manifest.beta.json` |
| CHANGELOG | `CHANGELOG.md` | `CHANGELOG.beta.md` |
| component | `eqmonitor_workspace`（dart package 名） | `eqmonitor-beta`（明示） |
| バージョン | `X.Y.Z` | `X.Y.Z-beta.N` |
| タグ | `vX.Y.Z` | `vX.Y.Z-beta.N` |

`develop` push で両方の job が走る（`.github/workflows/release-please.yaml`）。

## beta 配布の手順

1. 変更を `develop` に入れる
2. **beta Release PR**（タイトル例: `chore: beta release 3.0.0-beta.11`）を merge する
3. Release Please が `vX.Y.Z-beta.N` タグと GitHub prerelease を作成する
4. 既存の `Deploy App`（`v*-beta.*`）が外部配布する
5. merge 後の `app/pubspec.yaml` は `X.Y.Z-beta.N` になる

本番 Release PR への `/beta` コメントは使わない。

## なぜ component を分けるか

同じ target branch（`develop`）で複数 config を動かすと、component 名が同じだと
Release PR ブランチ（`release-please--branches--develop--components--...`）が上書きされる。
beta は `component: eqmonitor-beta` を明示し、本番（`eqmonitor_workspace`）と分岐させる。
タグに component を付けないため `include-component-in-tag: false` は両方で維持する。

## 同時オープン時の注意

- 本番 PR と beta PR は両方 `app/pubspec.yaml` を更新提案する（ブランチが別なので共存可）
- Release PR ブランチを手編集しない（develop push で force push される）
- merge 順は原則 **beta を繰り返し → 本番は最後に一度**
- CHANGELOG はファイルを分けているので衝突しにくい

## 手動救済（Create Beta Release）

通常の beta は Release Please merge で十分。壊れた Release 本文の修復や緊急タグ作成だけ
`create-beta-release.yaml` の `workflow_dispatch` を使う。`version` は必須。

```bash
gh workflow run create-beta-release.yaml \
  --ref develop \
  -f version=v3.0.0-beta.11 \
  -f repair_existing_release=true
```

issue_comment の `/beta` トリガーは廃止済み。

## manifest 初期化・ズレ修正

beta manifest は直近の beta タグに合わせる（例: `3.0.0-beta.10`）。
ズレたら `.release-please-manifest.beta.json` を直近タグの版に直して develop へ入れる。

本番リリース（`vX.Y.Z`）後は、次の beta は Release Please が
`v(next)-beta.1` 系へ進める。意図と違う場合は beta manifest を手で合わせる。

## 確認

```bash
python3 -c "import json; json.load(open('release-please-config.json')); json.load(open('release-please-config.beta.json'))"
bash scripts/ci/test_release_please_dual_track.sh
bash scripts/ci/test_create_beta_release_workflow.sh
mise exec -- actionlint .github/workflows/release-please.yaml .github/workflows/create-beta-release.yaml
```
