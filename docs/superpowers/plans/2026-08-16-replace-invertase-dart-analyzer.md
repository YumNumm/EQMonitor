# Invertase Dart Analyzer Action Replacement Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** archived Invertase Action を、注釈対応の直接的な Dart analyzer 実行へ置換する。
**Architecture:** リポジトリ管理の GitHub problem matcher が analyzer の標準出力をファイル注釈へ変換する。解析自体は mise で固定した Flutter 同梱 Dart SDK を使用し、既存の `app` スコープと blocking 条件を維持する。

**Tech Stack:** GitHub Actions、Dart analyzer、mise、GitHub problem matcher、actionlint

## Global Constraints

- Flutter / Dart コマンドは必ず `mise exec --` 経由で実行する。
- `app` の解析範囲、`--fatal-infos`、両 custom analyzer plugins を維持する。
- Node 20 許可、成功扱いへのフォールバック、新しい analyzer Action を追加しない。

### Task 1: Problem matcher と直接解析

**Files:**
- Create: `.github/problem-matchers/dart-analyzer.json`
- Modify: `.github/workflows/wc-check-dart-analyze.yaml`

**Interfaces:**
- Consumes: `dart analyze --format machine` の絶対パス付き diagnostics
- Produces: GitHub の error、warning、info ファイル注釈と analyzer の終了コード

- [ ] **Step 1: 置換前の検査が失敗することを確認する**

```shell
! test -f .github/problem-matchers/dart-analyzer.json
rg -n "invertase/github-action-dart-analyzer|checks: write" .github/workflows/wc-check-dart-analyze.yaml
```

Expected: matcher は未作成で、workflow から Invertase Action と `checks: write` が検出される。

- [ ] **Step 2: Dart analyzer problem matcher を追加する**

`problemMatcher` 配列に severity、位置、メッセージ、診断コードを抽出する
`dart-analyzer-machine` を定義する。

- [ ] **Step 3: workflow を直接解析へ置換する**

`checks: write` を workflow と job から削除し、`Report analyze` を次の2ステップへ置換する。

```yaml
      - name: Register Dart analyzer problem matcher
        run: echo "::add-matcher::.github/problem-matchers/dart-analyzer.json"

      - name: Analyze app
        run: mise exec -- dart analyze app --fatal-infos --format machine
```

- [ ] **Step 4: matcher と workflow を検証する**

```shell
jq -e '.problemMatcher | length == 1' .github/problem-matchers/dart-analyzer.json
mise exec -- actionlint .github/workflows/wc-check-dart-analyze.yaml
mise exec -- dart analyze app --fatal-infos --format machine
! rg -n "invertase/github-action-dart-analyzer|ACTIONS_ALLOW_USE_UNSECURE_NODE_VERSION|checks: write" .github/workflows/wc-check-dart-analyze.yaml
```

Expected: JSON と workflow は有効で、archived Action、Node 20 許可、不要権限は存在しない。既存 diagnostics がある場合、analyzer はそれを報告して非ゼロ終了する。

- [ ] **Step 5: 実装をコミットする**

```shell
git add .github/problem-matchers/dart-analyzer.json .github/workflows/wc-check-dart-analyze.yaml
git commit -m "CI: Dart解析をproblem matcherへ移行"
```

### Task 2: CI 運用知見と最終検証

**Files:**
- Create: `docs/knowledge/20260816_github_actions_dart_analyzer_annotations.md`

**Interfaces:**
- Consumes: Task 1 の matcher 登録方式と解析コマンド
- Produces: 今後の Flutter/Dart CI 更新時に参照する運用ルール

- [ ] **Step 1: 運用知見を記録する**

matcher 登録、mise SDK、root からの解析、fatal 条件、権限、検証コマンドを記録する。

- [ ] **Step 2: 全差分を検証する**

```shell
mise exec -- actionlint .github/workflows/wc-check-dart-analyze.yaml
jq empty .github/problem-matchers/dart-analyzer.json
git --no-pager diff --check origin/ci/replace-invertase-dart-analyzer...HEAD
git --no-pager status --short
```

Expected: 構文エラーと whitespace error がなく、意図した3ファイルと文書だけが変更されている。

- [ ] **Step 3: 知見をコミットして push する**

```shell
git add docs/knowledge/20260816_github_actions_dart_analyzer_annotations.md
git commit -m "Docs: Dart解析注釈のCI運用を記録"
git push
```
