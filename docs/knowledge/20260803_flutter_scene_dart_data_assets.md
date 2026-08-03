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

## 有効化直後は `AssetManifest.bin` が古いまま残る

`flutter config` を変えた直後のincremental buildでは、hookが生成したData Assetの
**ファイルはflutter_assetsへコピーされるのに、`AssetManifest.bin` が前回の内容の
まま更新されない**ことがある。

`flutter_scene` はData Assetのキーを `AssetManifest` の登録有無で判定し、未登録なら
legacy pathへfallbackする（`resolveBaseShaderBundleKey`）。そのためこの中途半端な
状態では、ファイルが実在しているのに次のエラーになる。

```text
Exception: Failed to initialize ShaderLibrary:
Asset 'packages/flutter_scene/build/shaderbundles/base.shaderbundle' not found.
```

パスが `flutter_gpu_shaders/shaderbundles/` ではなく `build/shaderbundles/` に
なっていたら、必ずこのmanifest staleを疑う。build artifactを作り直せば解消する。

```bash
cd packages/eqmonitor_map/example
MISE_EXEC_AUTO_INSTALL=0 mise exec -- flutter build ios --debug --no-codesign
# 解消しない場合
MISE_EXEC_AUTO_INSTALL=0 mise exec -- flutter clean
```

hot restartでは反映されないため、必ずアプリを再起動する。

## 確認方法

ファイルの存在確認だけでは不十分で、`AssetManifest.bin` に登録されているかまで
確認する。

```bash
cd packages/eqmonitor_map/example
manifest=build/ios/iphoneos/Runner.app/Frameworks/App.framework/flutter_assets/AssetManifest.bin
python3 -c "
d = open('$manifest', 'rb').read().decode('utf-8', 'ignore')
print('base.shaderbundle' in d, 'materials.shaderbundle' in d)
"
# True True なら正常
```

`NativeAssetsManifest.json` の `native-assets` は空のままで正常。Data Assetは
native assetではなくflutter_assets配下へ展開される。

## 生成物をversion管理しない

`.shaderbundle` / `.fsceneb` / `.fstex` はengineに結びついた中間生成物なので、
commitせず `flutter.assets` にも列挙しない。version管理するのはsourceの
`assets/map_spike.fmat` と `hook/build.dart` だけ。
