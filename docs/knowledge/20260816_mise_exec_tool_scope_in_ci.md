# CI で `mise exec` を使うときはツールを必ず絞る

`mise exec -- <cmd>` は `mise.toml` の**全ツール**を解決・インストールしようとする。
CI ではこれが次の 2 つの問題を起こす。

- `ubuntu-slim` ランナーには `libncurses.so.6` 等が無く、`core:swift` のインストールが
  `exit code 127` で失敗する → コマンド本体に到達せずステップが落ちる
- 不要な Flutter（約 1GB / 数分）まで clone してしまう

`mise exec <tool> -- <cmd>` のようにツールを明示すれば、そのツールだけが解決される。

```yaml
# ❌ 悪い例: mise.toml の全ツール（swift 含む）を入れようとする
- run: mise exec -- python3 scripts/release/sanitize_release_notes.py

# ✅ 良い例
- run: mise exec python -- python3 scripts/release/sanitize_release_notes.py
```

`ubuntu-24.04` などのフルイメージでは swift のインストールが成功するため、
この問題は `ubuntu-slim` を使うジョブでのみ顕在化する。ランナーを絞ったジョブを
追加するときは特に注意する。

参考: [Create Beta Release #60](https://github.com/YumNumm/EQMonitor/actions/runs/31946789655/job/95163970760)
