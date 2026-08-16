# assets_util AGP 9 DSL Migration Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Deploy App の Android AAB build を止める assets_util の AGP 9 script compilation error 4件を解消する。

**Architecture:** Android library 設定を AGP の公開 `LibraryExtension` で構成し、Kotlin compiler 設定を Kotlin extension へ分離する。既定の Kotlin source directory は上書きしない。

**Tech Stack:** Gradle 9.3.1、AGP 9.1.1、Kotlin 2.4.0、Flutter、mise

## Global Constraints

- Flutter / Dart コマンドは必ず `mise exec --` 経由で実行する。
- 固定値 fallback や互換フラグによる旧 DSL 延命を追加しない。
- Android Gradle 設定以外の assets_util 挙動を変更しない。

---

### Task 1: assets_util Android build script

**Files:**
- Modify: `packages/assets_util/android/build.gradle.kts`
- Create: `docs/knowledge/20260816_assets_util_agp9_gradle_dsl.md`

**Interfaces:**
- Consumes: AGP `com.android.build.api.dsl.LibraryExtension`、Kotlin `JvmTarget`
- Produces: AGP 9.1.1 で deprecated diagnostic を出さず評価できる Android library configuration

- [x] **Step 1: AGP 9.1.1 で失敗を再現する**

`assets_util/example/android` の project graph を AGP 9.1.1 で評価する。

Expected: `android`、`kotlinOptions`、文字列 `jvmTarget`、`srcDirs` の4件で script compilation error。

- [x] **Step 2: 公開 DSL と compilerOptions へ移行する**

```kotlin
import com.android.build.api.dsl.LibraryExtension
import org.jetbrains.kotlin.gradle.dsl.JvmTarget

extensions.configure<LibraryExtension>("android") {
    // Existing Android library settings stay unchanged.
}

kotlin {
    compilerOptions {
        jvmTarget = JvmTarget.JVM_17
    }
}
```

既定値と重複する `sourceSets` 上書きは削除する。

- [x] **Step 3: Gradle と package gate を実行する**

```shell
mise exec -- flutter test packages/assets_util
mise exec -- dart analyze packages/assets_util
git --no-pager diff --check origin/develop...HEAD
```

Expected: tests/analyze/diff check が成功し、AGP 9 project graph から対象4 diagnostic が消える。

- [x] **Step 4: 実装と知見を分けてコミットする**

```shell
git add packages/assets_util/android/build.gradle.kts
git commit -m "Fix: assets_utilをAGP 9 DSLへ移行"
git add docs/knowledge/20260816_assets_util_agp9_gradle_dsl.md docs/superpowers
git commit -m "Docs: assets_utilのAGP 9移行手順を記録"
```
