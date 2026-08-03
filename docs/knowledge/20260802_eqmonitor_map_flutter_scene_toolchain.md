# EQMonitor Map Flutter Scene toolchain

## 固定 revisionと導入

2026-08-03以降、root workspaceのFlutter/Dart commandはYumNumm版
`mise-flutter`で導入する。固定値の正本は次とする。

- Flutter plugin/revision: `mise.toml`
- Flutter Scene revision: `packages/eqmonitor_map/pubspec.yaml`
- 解決済みFlutter Scene revision: root `pubspec.lock`

2026-08-03の固定revisionは次のとおり。

- Flutter: `4dacd3fc91d96262a33e5c598e17d816f0b35641`
- Flutter Scene: `7f71993b7e2a0ab1d2f59726a406098709be7291`

project rootで導入とrevision確認を行う。既存の別Flutterやsystem `PATH`を
直接使わず、Flutter/Dart commandは常に`mise exec --`経由で実行する。

```bash
mise install flutter
mise exec -- flutter --version --machine
mise exec -- dart --version
```

custom pluginが未登録の環境では次を実行できるが、通常はprojectの
`mise.toml`から`mise install flutter`で自動解決させる。

```bash
mise plugin install flutter https://github.com/YumNumm/mise-flutter.git
```

platform artifactが未取得なら、対象だけを事前取得する。

```bash
mise exec -- flutter precache --linux
mise exec -- flutter precache --android
mise exec -- flutter precache --ios
```

## Shared lint preflight

共有 lint は二層の互換契約を持つ。root/app がincludeする
`package:eqmonitor_lints/analysis_options.yaml` はincludeなし・rulesなしの既存code
向けbaselineを維持する。新規packageが明示採用する
`package:eqmonitor_lints/recommended.yaml`だけがstrict Flutter 3.41設定を使う。
root entry pointをstrict設定へ委譲すると3,081件、Dart 3.11 recommendedでも
1,807件のdiagnosticが既存app・生成物を含むworkspace全体で有効化されたため、
Task 1ではlint全面移行を行わず、この二層を統合しない。

`package:eqmonitor_lints/recommended.yaml` は package root ではなく
`packages/eqmonitor_lints/lib/recommended.yaml` へ解決される。共有 lint のentry
pointは必ず`lib/`配下へ置く。`flutter pub add -C`に渡すpathはcommandを
起動したrepository root基準で解決されるため、exampleへの追加は次を使う。

```bash
mise exec -- flutter pub add -C packages/assets_util/example \
  "dev:eqmonitor_lints@{path: packages/eqmonitor_lints}"
```

この command は既存 `analysis_options.yaml` へ platform directory の exclude を
自動追記する場合がある。依存追加後は差分を確認し、Task scope 外の自動変更を残さない。

## Workspace test preflight

root の `test:dart` script は内部で bare `melos exec` を呼ぶため、local dependency
として `dart run melos` だけが使える環境では `melos: not found` になる。また
`--depends-on=test` だけでは Flutter SDK に依存する `cache` package も選ばれ、
`dart test` が `dart:ui` を読み込めず失敗する。Dart-only suite の診断には明示的に
Flutter packageを除外する。

```bash
mise exec -- dart run melos exec \
  --no-flutter \
  --depends-on=test \
  --dir-exists=test \
  --concurrency=1 \
  -- "dart test"
```

Flutter suite は package ごとの asset root を保つため、repository root から
`flutter test app/test` を直接呼ばない。Melos で各 package directory を cwd にするか、
対象 package を working directory にして実行する。

```bash
mise exec -- dart run melos exec \
  --depends-on=flutter_test \
  --dir-exists=test \
  --concurrency=1 \
  -- "flutter test"

cd app
mise exec -- flutter test --no-pub test
```

repository root起点のapp testでは`assets/tjma2001.csv`の解決条件が変わり、実際の
package/CI実行にはないasset failureを作るため、failure比較に使用しない。

固定masterのroot full scanでは`eqmonitor`だけが既存custom lint 1,381件で失敗し、
Flutter suiteはappの既存18 testsが失敗した。同じsource treeをstable Flutterで
比較しても同じ件数・同じ原因だったため、master migrationの回帰ではない。root full
scanはtoolchain互換性のdiagnostic evidenceとして残し、既存CIの合否契約を変更しない。
詳細と解消作業は次へ分離する。

- `docs/todo/760_existing_eqmonitor_custom_lint_debt.md`
- `docs/todo/770_existing_eqmonitor_flutter_test_failures.md`

## CI

Flutter を使う analyze、test、integration、iOS build、Android build job は
`mise-action`がproject configのcustom pluginと固定Flutterを導入する。
各jobは導入後にrevisionを確認する。

```bash
mise exec -- flutter --version --machine
```

`eqmonitor_map` exampleのPR workflowは
package単体の`flutter analyze --fatal-infos`とAndroid/iOSのprofile/release buildを
blockingにする。署名、配布、deploy secretは扱わない。既存root/appのdiagnosticを
この新規package gateへ混ぜない。

iOS/Android実機のprofile/releaseはpackage READMEのmanual smoke checklistで確認する。
実機確認の未実施をfoundation実装のblockerにせず、実施状況は
`docs/todo/800_eqmonitor_map_deferred_verification.md`で追跡する。
