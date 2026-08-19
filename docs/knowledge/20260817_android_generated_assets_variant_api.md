# AGP 9 で生成 assets を登録する

## 背景

AGP 9.1 では、Android SourceSet API に `Provider<Directory>` を渡すと
設定フェーズでビルドが失敗する。

```text
You cannot add Provider instances to the Android SourceSet API.
```

生成物か静的ファイルかを Android Studio が判定できず、生成タスクへの
依存関係も旧 API では正しく引き継げないためである。

## ルール

- `sourceSets.main.assets.srcDir(provider)` は使用しない。
- 生成タスクは `DirectoryProperty` の出力を公開する。
- `androidComponents.onVariants` から
  `variant.sources.assets.addGeneratedSourceDirectory` へ登録する。
- `android.sourceset.disallowProvider=false` で旧挙動へ戻さない。
- Variant API が生成タスク依存を引き継ぐため、`preBuild.dependsOn` を
  重ねて追加しない。

## 実装例

```kotlin
abstract class GenerateAssetsTask : Sync() {
    @get:OutputDirectory
    abstract val outputDirectory: DirectoryProperty

    init {
        into(outputDirectory)
    }
}

androidComponents {
    onVariants(selector().all()) { variant ->
        variant.sources.assets?.addGeneratedSourceDirectory(
            generateAssets,
            GenerateAssetsTask::outputDirectory,
        )
    }
}
```

## 確認

Flutter / Gradle コマンドはプロジェクトルートから `mise exec --` 経由で
実行する。

```bash
mise exec -- flutter build appbundle --debug
```
