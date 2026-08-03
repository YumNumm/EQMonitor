# scene spike の compile-time defines は clean checkout からしか作れない

`packages/eqmonitor_map/example` を起動すると、ハーネスパネルに次の赤字が出て
`Start updates`（頂点更新と evidence 採取）がブロックされることがある。

```
Bad state: EQMONITOR_SCENE_SPIKE_RENDERER_CHECKOUT_DIRTY must be explicitly set to true or false.
```

## 原因

`SceneSpikeEnvironmentBuildManifestSource.read()` は compile-time define
`EQMONITOR_SCENE_SPIKE_RENDERER_CHECKOUT_DIRTY` を `true` / `false` のいずれかで
要求し、未設定なら例外を投げる（fail-closed）。evidence は「どの commit で
ビルドされたバイナリの観測か」を保証する必要があるため、既定値へのフォールバックを
持たない設計になっている。

つまり defines を渡さずに起動した場合は必ずこのエラーになる。

## 起動手順

defines は `write_scene_spike_defines.dart` が
`packages/eqmonitor_map/example/.dart_tool/scene_spike_defines.json` に生成する。

```bash
cd packages/eqmonitor_map/example
MISE_EXEC_AUTO_INSTALL=0 mise exec -- dart run ../tool/write_scene_spike_defines.dart
MISE_EXEC_AUTO_INSTALL=0 mise exec -- flutter run --profile \
  -d "$physical_device_id" \
  --dart-define-from-file=.dart_tool/scene_spike_defines.json
```

VSCode から起動する場合は `.vscode/launch.json` の `[EQMonitor Map] Debug` /
`[EQMonitor Map] Profile` が同じ `--dart-define-from-file` を渡す。
それでも defines ファイル自体は事前に生成しておく必要がある。

## clean checkout が必須

`write_scene_spike_defines.dart` は**リポジトリルートで**
`git status --porcelain=v1 --untracked-files=all` を取り、1 エントリでもあれば
生成を拒否する。

```
FormatException: Renderer checkout must be clean.
```

判定対象はサブモジュール（`backend`）や `.vscode/` も含む repository 全体で、
`packages/eqmonitor_map` 配下だけではない。実行前に以下を片付けること。

- サブモジュールのずれ: `git submodule update --init --recursive`
- Xcode がプロジェクトを開いたときに書き換える `*.xcscheme` /
  `AppFrameworkInfo.plist` の差分
- `mise` 実行で再生成される `mise.lock`

## 落とし穴

- `flutter clean` は `example/.dart_tool` ごと defines ファイルを消す。
  clean 後は必ず再生成する。
- 実行時 validator は defines の revision を HEAD と突き合わせない。
  古い defines のまま起動できてしまうので、**run のたびに再生成する**こと。
  再生成を怠ると `dirty=false` の evidence が実際には dirty な checkout の
  観測を指すことになる。
- defines が無くても Scene の静的描画自体は動く。赤字表示と `startUpdates()`
  のブロックだけが症状になるため、描画確認だけなら生成は必須ではない。
