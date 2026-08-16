# assets_util AGP 9 DSL 移行設計

## 目的

Deploy App run 31967550259 の Android AAB build を停止させた
`packages/assets_util/android/build.gradle.kts` の AGP 9 非互換を解消する。
iOS build・配布経路や Dart/native 実装の挙動は変更しない。

## 根因

CI は AGP 9.1.1、Gradle 9.3.1、Kotlin 2.4.0 と
`warningsAsErrors=true` を使用する。対象 script の旧 `android` accessor、
`android.kotlinOptions`、文字列 `jvmTarget`、`java.srcDirs` が deprecated diagnostic
を4件生成し、Kotlin script compilation error になっている。

## 設計

- Android library extension は `extensions.configure<LibraryExtension>("android")`
  で新しい公開 DSL interface を明示する。
- Kotlin JVM target は extension-level `kotlin.compilerOptions` と型付き
  `JvmTarget.JVM_17` で指定する。
- `src/main/kotlin` は Kotlin Android plugin の既定 source directory なので、
  deprecated な SourceSet 上書きを削除する。
- `android.newDsl=false` の延命や AGP downgrade は AGP 10 で行き止まりになるため
  採用しない。

## 検証

AGP 9.1.1 で example project graph を評価し、対象4 diagnostic が消えることを確認する。
加えて `assets_util` の Flutter tests、Dart analyze、diff check を実行する。
