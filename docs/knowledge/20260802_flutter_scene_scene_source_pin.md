# Flutter Scene 固定revisionの `scene` source pin

Flutter Scene `695c954f237fabef65d49fa7199002851d2dcd88` は、同じ
monorepo内の未公開 `scene` API（`TextureResource.content` を含む）を使う。一方、
そのrevisionの `packages/flutter_scene/pubspec.yaml` は `scene: ^0.1.0` のままなので、
外部packageから解決すると同APIを持たないhosted `scene 0.1.0` が選ばれ、compileに
失敗する。

固定Flutter Scene revisionを使う間は、`packages/eqmonitor_map/pubspec.yaml` で
`scene` を同一repo・同一revision・`packages/scene` へoverrideする。

```bash
MISE_EXEC_AUTO_INSTALL=0 mise exec -- flutter pub add --no-example \
  'override:scene@{git:{url: https://github.com/bdero/flutter_scene.git, ref: 695c954f237fabef65d49fa7199002851d2dcd88, path: packages/scene}}'
```

hosted `scene` に必要APIが公開され、Flutter Scene側がそのversion/sourceを正しく
宣言したrevisionへ更新できた時点で、このoverrideを除去して `flutter pub get` を
実行する。hosted版へのfallbackや異なるrevisionの組み合わせは使わない。

## Scene spike metadata writerの信頼境界

`packages/eqmonitor_map/tool/write_scene_spike_defines.dart` は実行時CWDをrepo判定に
使わない。`Platform.script` の位置が `packages/eqmonitor_map/tool/` 配下であることを
確認し、そこから導出したrootと `git rev-parse --show-toplevel` が一致した場合だけ
manifestを生成する。

dirty判定はtracked diffだけでは不十分なため、untracked fileを含む次のstatusを使う。

```bash
git status --porcelain=v1 --untracked-files=all
```

Flutterのmachine JSONに含まれるSDK version文字列とは別に、Dart source revision
`d402ff7c9c8442d64aa8148609480aa0e04a24fd` をcompile-time manifestへ書き、
evidence validatorでも固定値と一致することを検証する。writerの実行はexampleから
次の形に固定する。

```bash
cd packages/eqmonitor_map/example
MISE_EXEC_AUTO_INSTALL=0 mise exec -- \
  dart run ../tool/write_scene_spike_defines.dart
```
