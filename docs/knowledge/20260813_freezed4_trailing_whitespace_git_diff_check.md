# Freezed 4 生成物の trailing whitespace と `git diff --check`

## 症状

`mise exec -- dart run build_runner build`（Freezed 4.0.0-dev.3）後、生成された `.freezed.dart` が `// dart format off` ブロック内に末尾空白を含み、`git diff --check` が FAIL する。

## 確認例（eqmonitor_map / Task 52）

1. build_runner 実行 → `wrote N outputs`
2. 直後の `git diff --check` → trailing whitespace で失敗
3. 手編集で空白を削ると `git diff --check` は通るが、再実行で同じ空白が戻る

## 方針

- `.freezed.dart` を意味のある手編集で「通す」ことは禁止（生成ファイル編集禁止ルール）
- seismicity 計画と同様、**末尾空白のみ**の正規化が必要な場合は、正規化前後を `git diff --no-index --ignore-space-at-eol` で証明し、空白以外の差分が無いことだけを許容する
- final verification タスクでは、再現不能な手編集を隠さず、tooling 境界の blocker として docs に残す

## 関連

- `docs/knowledge/20260813_freezed4_build_runner.md`
- `docs/knowledge/20260708_build_runner_generated_diffs.md`
- Map foundation contracts: `docs/knowledge/20260809_eqmonitor_map_foundation_contracts.md`
