# assets_util の AGP 9 Gradle DSL 移行

## 症状

Deploy App run `31967550259` の Android AAB build は、
`packages/assets_util/android/build.gradle.kts` の script compilation error 4件で失敗した。

- 旧 `android {}` accessor
- `android.kotlinOptions`
- 文字列 `jvmTarget`
- `java.srcDirs(...)`

CI の `warningsAsErrors=true` により、deprecated diagnostic も build failure になる。

## 恒久対応

Android library は AGP の公開 DSL interface を型付きで構成する。

```kotlin
import com.android.build.api.dsl.LibraryExtension
import org.jetbrains.kotlin.gradle.dsl.JvmTarget

extensions.configure<LibraryExtension>("android") {
    // Android library settings
}

kotlin {
    compilerOptions {
        jvmTarget = JvmTarget.JVM_17
    }
}
```

`src/main/kotlin` は Kotlin Android plugin の既定値なので、SourceSet への再登録は不要。
`android.newDsl=false` は AGP 10 で削除予定のため、恒久回避策に使わない。

## 検証

Android SDK がある環境では example build と package gate を実行する。

```shell
cd packages/assets_util/example
mise exec -- flutter build apk --release

cd ../
mise exec -- flutter test

cd ../../
mise exec -- dart analyze packages/assets_util
```

AGP 9 の移行では、Dart tests だけでなく Gradle project evaluation または Android build を
必ず含める。Kotlin/AGP の deprecated diagnostic は Dart analyzer では検出できない。

参考:
- https://developer.android.com/build/releases/agp-9-0-0-release-notes
- https://kotlinlang.org/docs/gradle-compiler-options.html
