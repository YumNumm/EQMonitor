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
