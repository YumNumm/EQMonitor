# iOS archive: Flutter Run Script / actool 失敗の追跡

## 現状 (2026-07-28)

`jma_code_table.json` 欠落は解消済み（stage `ios-native`）。
一方 Deploy App の Build iOS はまだ赤で、失敗フェーズは次のとおり。

### CI (Xcode 26.3)

- `Create XCArchive` 内で `PhaseScriptExecution Run Script`
  （`xcode_backend.sh build`）が失敗
- xcbeautify がスクリプト出力を吸収し、真のエラーメッセージが見えない
- 対策として `set -o pipefail` + raw log `tee` を入れた（次の CI で原因が表に出るはず）

### ローカル (Xcode 26.6)

- `Exception while running actool: attempt to insert nil object from objects[0]`
- Widget に `AccentColor` / `WidgetBackground` colorset を追加しても再現
- CI 26.3 では同色は warning のみで、症状が一致しない

## 次のアクション

1. pipefail 入りの CI ログで Run Script の実エラーを読む
2. 必要なら raw log 全文を artifact 化する
3. ローカル actool crash が CI と無関係なら、Xcode 26.6 固有として別途切り分け

## 検証済み

- `stage_from_release.sh --target ios-native` は成功
- 部分ビルド成果物に
  `WidgetExtension.appex/jma_code_table.json` /
  `AppIntentExtension.appex/jma_code_table.json` が含まれる
