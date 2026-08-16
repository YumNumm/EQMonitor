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

## 追記 (2026-08-15): AGP 8 系へ戻す回避策は行き止まり

「やること」4 の確認結果として、`app/android` は AGP 8.13.1 / Kotlin 2.2.21 /
Gradle 8.14.3 で、example だけが AGP 9.1.0 / Kotlin 2.4.0 / Gradle 9.3.1 だった。
example を app と同じ組み合わせへ揃える回避策を PR #1648 で試して計測した
（方針 1 に沿わないため revert 済み）。

- `gradle.properties` には既に `android.newDsl=false` が入っている。それでも
  AGP 9.1.0 は legacy DSL の `android { }` accessor を deprecation **error** に
  するため、「やること」3 の回避策は AGP 9 では成立しない。
- AGP 8.13.1 へ揃えると script compilation は通る（症状の 3 errors は解消）。
  `profile` は Flutter Gradle Plugin が登録する build type で KTS の生成 accessor が
  無いため、AGP のバージョンに関わらず `named("profile")` で参照する必要がある。
- ただしその先で `:app:validateSigningProfile` が失敗する（run 31859310385）。
  `$HOME/.android/debug.keystore` を事前生成しても解消しなかった
  （run 31859725902。例外メッセージが空なので `--stacktrace` での切り分けが必要）。
- 加えて、pin している Flutter は Gradle 8.14.3 / AGP 8.13.1 / Kotlin 2.2.21 の
  いずれについても「support will soon be dropped」と警告する。

したがって**「やること」1 の新 DSL 移行が本筋**で、ダウングレードでの回避は
signing 検証の壁に当たるうえ Flutter の対応バージョンからも外れる。
移行時は `validateSigningProfile` を先に切り分けること。

## 参照

- PR #1627 の CI（run 31791372614, job 94738949419）
- PR #1648 の CI（run 31859310385 / 31859725902）
- `docs/knowledge/20260814_stacked_pr_flutter_gate_baseline.md`
