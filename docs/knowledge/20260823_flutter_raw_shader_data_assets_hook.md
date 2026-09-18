# Flutter raw shaderのDataAssets build hook

## ルール

`buildTargetShaderBundleJson`を`TargetShaderBundleAssetMode.dataAssetsRequired`で
呼ぶ場合、hookはDataAssets buildが有効な時だけ実行する。

```dart
if (config.config.buildDataAssets) {
  await buildTargetShaderBundleJson(
    buildInput: config,
    buildOutput: output,
    manifestFileName: 'shaders/example.shaderbundle.json',
    assetMode: TargetShaderBundleAssetMode.dataAssetsRequired,
    glesLanguageVersion: 300,
  );
}
```

このgateがないと、通常の`flutter test`などDataAssetsを要求しないbuildでもrequired
assetの出力を試みてhookが失敗する。`flutter_scene`自身のhookも同じgateを使う。

## 検証

通常のpackage testに加え、DataAssets pathを明示的に有効化してshader compileを通す。

```sh
cd packages/eqmonitor_map
FLUTTER_DART_DATA_ASSETS=true mise exec -- flutter test --no-pub \
  test/renderer/observation_point_batch_builder_test.dart
```

manifest symbol、shader source、target GLSLの不整合はこの経路でbuild failureになる。
