# Dart 3.14 primary constructors と `final` 引数の破壊的変更

Flutter 3.47.0-1.0.pre-97 / Dart 3.14.0-29.0.dev で primary constructors が
言語機能として有効になった。これに伴い **通常の引数リストに `final` 修飾子を
書けなくなった**（`extraneous_modifier` / `Can't have modifier 'final' here.`）。

analyzer と CFE の双方でエラーになるため、`dart analyze` でも `flutter build` でも失敗する。

```dart
// ❌ Dart 3.14 以降はエラー
void m({final String? x}) {}
class A { A({final String? x}); }

// ✅ primary constructor の引数リストでのみ `final` が使える（フィールド宣言になる）
class C({required final int x});
```

## 事故事例 1: freezed の生成コード

`freezed` 4.0.0-dev.1 / dev.2 は union の `$type` 引数を
`const X({required this.data, final String? $type})` の形で出力していた。
dev.3 では出力されないが、**生成済みファイルをコミットしている**ため
生成器を上げても再生成しない限りコンパイルエラーが残る。

deploy-app の Android/iOS ビルドが 400 ファイル規模の
`Can't have modifier 'final' here.` で落ちた実例がある。

対処は再生成のみ。手編集・sed での修正はしない。

```bash
# パッケージごとに build_runner を回す
for d in packages/cache packages/core packages/dart_azarashi packages/earthquake_replay \
         packages/eqmonitor_api packages/eqmonitor_map packages/eqmonitor_websocket \
         packages/knet_api_client packages/knet_waveform_parser packages/kyoshin_monitor_api \
         packages/kyoshin_monitor_image_parser packages/nied_api_client packages/pmtiles_v3 \
         packages/seismicity_pmtiles packages/telemetry_store app; do
  (cd "$d" && mise exec -- dart run build_runner build)
done
```

> `melos run generate` は `generate:dart` / `generate:flutter` が pubspec.yaml に
> 未定義のため動かない。`melos run rebuild` も melos の依存解決に失敗することがある。
> 上記のループが確実。

## 事故事例 2: 手書きコードの自動 primary constructor 化

`RetryController` が primary constructor へ機械的に書き換えられ、
以下が同時に壊れた。

- `class RetryController({required Future<void> Function(Duration) _delay})`
  → 名前付き引数は `_` 始まりにできないためエラー
- `final class RetryRunning({required int attempt}) extends ...`
  → `final` が無いのでフィールドが生成されず `attempt` が未定義
- `RateLimitedException.retryAfter` が `Duration?` なのに
  `case RateLimitedException(:final int retryAfter)` へ書き換えられ、
  パターンが一致せず Rate Limit の `Retry-After` が無視される状態

**primary constructor へは機械的に変換しない。** 変換する場合は
フィールド化したい引数に `final` を付け、名前付き引数を private 名にしない。

## 検証方法

`flutter analyze` だけでなく CFE を通す確認をする。
Android/iOS の toolchain 無しで全 Dart コードを CFE でコンパイルできる。

```bash
cd app
mise exec -- flutter build bundle --debug --no-pub
ls -la build/flutter_assets/kernel_blob.bin   # 生成されれば CFE 通過
```

## CI の穴

`Deploy App` は `develop` への push でのみ走り、`Dart Analyze` /
`Flutter Test` は PR でしか走らない。`develop` へ直 push した変更は
どのゲートも通らずに deploy-app を壊せる。
