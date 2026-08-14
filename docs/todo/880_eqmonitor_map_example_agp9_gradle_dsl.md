# eqmonitor_map example の Android build を AGP 9.0 の新 DSL へ追随させる

## 症状

必須チェック `eqmonitor-map-scene-spike / Android Profile and Release Build` が
develop baseline で赤。`assembleProfile` が Gradle script のコンパイル段階で失敗する。

対象: `packages/eqmonitor_map/example/android/app/build.gradle.kts`

```text
Line 07: android {
         ^ 'fun Project.android(configure: Action<BaseAppModuleExtension>): Unit' is deprecated.
           Replaced by com.android.build.api.dsl.ApplicationExtension.
           This class is not used for the public extensions in AGP when android.newDsl=true,
           which is the default in AGP 9.0, and will be removed in AGP 10.0.

Line 33:         profile {
                 ^ Unresolved reference. None of the following candidates is applicable
                   because of a receiver type mismatch:
                       val NamedDomainObjectContainer<KotlinSourceSet>.profile: ...

Line 35:             signingConfig = signingConfigs.getByName("debug")
                     ^ Unresolved reference 'signingConfig'.

3 errors
```

## 原因

AGP 9.0 で `android.newDsl=true` が既定になり、旧 `BaseAppModuleExtension` 経由の
Kotlin DSL 拡張が公開 extension として使われなくなった。その結果、
`buildTypes` 内の `profile { ... }` が `KotlinSourceSet` の `profile` へ誤解決され、
`signingConfig` も解決できなくなっている。

## 影響

- Dart 側の変更とは無関係に、`packages/eqmonitor_map/**` を触る PR すべてで
  この必須チェックが赤になる（merged PR #1628 / #1617 でも同様）。
- iOS 側（`iOS Profile and Release Build`）は成功しているため Android 固有。

## やること

1. `build.gradle.kts` を `com.android.build.api.dsl.ApplicationExtension` ベースの
   新 DSL へ書き換える。
2. `profile` build type の宣言を `buildTypes` の正しい receiver 下で行い、
   `signingConfig` を新 DSL の型で設定する。
3. 暫定回避が必要なら `android.newDsl=false` を `gradle.properties` に置く案もあるが、
   AGP 10.0 で削除されるため恒久対応にはしない。
4. `app/android` 側が同じ旧 DSL を使っていないか併せて確認する。

## 参照

- PR #1627 の CI（run 31791372614, job 94738949419）
- `docs/knowledge/20260814_stacked_pr_flutter_gate_baseline.md`
