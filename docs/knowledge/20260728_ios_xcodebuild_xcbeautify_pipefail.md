# iOS CD: xcodebuild | xcbeautify は pipefail 必須

## 症状

`deploy-app` の Build iOS が `Embed entitlements and ad-hoc sign` で
`Runner.app: No such file or directory` と落ちる一方、`Create XCArchive` は
success に見えることがある。

## 原因

```yaml
xcodebuild archive ... | xcbeautify ...
```

GitHub Actions のデフォルト bash は `pipefail` 無し。`xcodebuild` が非ゼロでも
パイプ右側の `xcbeautify` が 0 ならステップ全体が成功扱いになる。
真の失敗（例: Flutter `Run Script` / `PhaseScriptExecution`）はログを掘らないと分からない。

## 対策

```yaml
set -o pipefail
xcodebuild archive ... 2>&1 | tee /tmp/xcodebuild-archive.log | xcbeautify --renderer github-actions
archive_status=${PIPESTATUS[0]}
if [ "$archive_status" -ne 0 ]; then
  echo "::error::xcodebuild archive failed (exit $archive_status). Tail of raw log:"
  tail -n 120 /tmp/xcodebuild-archive.log
  exit "$archive_status"
fi
```

`Create IPA` / `Create Ad-Hoc IPA` も同様に `set -o pipefail` を付ける。

## 関連

- jma_code_table 欠落は別件で解消済み（`stage_from_r2.sh --target all`）
- ローカル Xcode 26.6 では別途 `actool` の nil crash が出ることがある（CI 26.3 とは症状が異なる）
