# Flutter Scene と `--enable-dart-data-assets`

Flutter Sceneのshader bundleとmaterialは、pubspecの `flutter.assets` ではなく
build hookが生成するDart Data Assetとして配布される。Dart Data Assetsが無効な間、
`packages/flutter_scene/hook/build.dart` は `config.config.buildDataAssets` が
`false` のため何も生成せずに戻り、`packages/eqmonitor_map/example/hook/build.dart` の
`buildMaterials` も同様に出力を持たない。

その結果、`Scene.initializeStaticResources()` 内の `loadBaseShaderLibrary()` が
`packages/flutter_scene/flutter_gpu_shaders/shaderbundles/base.shaderbundle` を
解決できずにthrowし、`Scene._readyToRender` が `false` のままになる。SceneViewは
毎frame次を出力し続ける。

```text
Flutter Scene is not ready to render. Skipping frame.
You may wait on the Future returned by Scene.initializeStaticResources() before rendering.
```

## 有効化

machineごとに1度だけ実行する。global設定なので、clean checkoutや新しいCI runnerでは
再度必要になる。

```bash
MISE_EXEC_AUTO_INSTALL=0 mise exec -- flutter config --enable-dart-data-assets
```

設定後は既存のbuild artifactを再生成する（設定変更だけではhot restartもincremental
buildも反映されない）。

```bash
cd packages/eqmonitor_map/example
MISE_EXEC_AUTO_INSTALL=0 mise exec -- flutter build ios --debug --no-codesign
```

## 確認方法

`flutter config --list` の `enable-dart-data-assets` が `true` であることに加えて、
build後のflutter_assetsへ次が含まれることを確認する。含まれない場合はhookが動いて
いない。

```bash
cd packages/eqmonitor_map/example
find build/ios/iphoneos/Runner.app/Frameworks/App.framework/flutter_assets \
  -name '*.shaderbundle'
# packages/flutter_scene/flutter_gpu_shaders/shaderbundles/base.shaderbundle
# packages/eqmonitor_map_example/flutter_scene/fmat/materials/materials.shaderbundle
```

`NativeAssetsManifest.json` の `native-assets` は空のままで正常。Data Assetは
native assetではなくflutter_assets配下へ展開される。

## 生成物をversion管理しない

`.shaderbundle` / `.fsceneb` / `.fstex` はengineに結びついた中間生成物なので、
commitせず `flutter.assets` にも列挙しない。version管理するのはsourceの
`assets/map_spike.fmat` と `hook/build.dart` だけ。
