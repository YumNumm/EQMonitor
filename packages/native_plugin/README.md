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
