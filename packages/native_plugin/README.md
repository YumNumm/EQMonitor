# native_plugin

MethodChannel を使わず、FFIgen（Objective-C）と JNIgen（Java / Kotlin）のバインディングで OS の API を Dart から直接呼び出すパッケージ。

- 公開する型は Freezed で定義する。OS ごとに値が異なるものは sealed class にする。
- OS ごとの実装は `abstract interface class` の裏に置き、利用側は `platform()` で得た実装を使う。

## バインディングの生成

```sh
mise exec -- dart run tool/ffigen.dart
mise exec -- dart run tool/jnigen.dart "$ANDROID_HOME/platforms/android-36/android.jar"
mise exec -- dart run build_runner build --delete-conflicting-outputs
```

JNIgen は初回に Gradle で ApiSummarizer をビルドするため、JDK が必要。

JNIgen 1.1.0 は `package:jni` 1.2.1 に無い `JType.className` を override するコードを生成し、解析が警告になる。
対応する `package:jni` が公開されるまで 1.0.1 に固定する。
