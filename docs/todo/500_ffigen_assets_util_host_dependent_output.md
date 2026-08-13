# ffigen 生成物 (assets_util) がホストの Xcode SDK に依存する

`packages/assets_util/lib/src/ios/eqm_assets_util.dart` は ffigen 生成物で、
`dart run build_runner build` を実行したマシンの macOS / Xcode SDK に応じて
出力が変わる。

ローカル（Xcode の SDK バージョンが CI と異なる環境）で再生成すると、
`NSDeprecatedMethods` などの非推奨 Objective-C API バインディングが
600 行規模で追加され、CI（macos-26 / Xcode 26.6）の出力と乖離する。

そのため freezed 再生成 PR ではこのファイルの差分を意図的に含めていない。

## 対応方針

- 生成に使う SDK を固定するか、CI で再生成して差分を検知する仕組みを入れる
- ffigen の `exclude` で非推奨カテゴリを除外し、出力をホスト非依存にする

## 注意

このファイルはローカルで build_runner を回すたびに差分が出る。
コミットする場合は CI と同じ Xcode バージョンで生成すること。
