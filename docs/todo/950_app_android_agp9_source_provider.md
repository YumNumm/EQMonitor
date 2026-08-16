# app Android の generated assets を AGP 9 Sources API へ移行する

## 症状

`origin/develop` (`79c4a5e5a`) の `app/android` project evaluation が、
`app/android/app/build.gradle.kts:54` で失敗する。

```text
You cannot add Provider instances to the Android SourceSet API.
Use SourceDirectories.addGeneratedDirectory or addStaticDirectories.
```

`assets.srcDir(bundledAssetPackRoot)` が `Provider<Directory>` を旧 SourceSet API へ渡している。
参照された Deploy App run `31967550259` の SHA `705694791` より後に、
commit `682c6b929` で追加されたため、assets_util の4件とは別の blocker。

## やること

1. `stageBundledAssetPack` の出力を AGP 9 Variant `Sources` API の
   `addGeneratedDirectory` で登録する。
2. task dependency が自動配線されることを確認し、手動 `preBuild.dependsOn` を整理する。
3. 実 Android SDK で release AAB を build し、AAB 内の `assets/platform` を検査する。
4. app の旧 `android` accessor と `java.srcDirs` も公開 DSL へ移行する。
5. app と自前 plugin を Built-in Kotlin へ移行し、`android.builtInKotlin=false` と
   `android.newDsl=false` を削除する。どちらも AGP 10 で削除予定。

`android.sourceset.disallowProvider=false` は task dependency を失う暫定回避なので使用しない。
