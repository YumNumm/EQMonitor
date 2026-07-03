# analyzer と codegen パッケージのバージョン整合（2026-07）

## 背景

workspace 全体に `dependency_overrides: analyzer: ^13.x` を置くと `dart pub get` は通るが、`build_runner` の AOT コンパイルで `riverpod_generator` / `riverpod_analyzer_utils` が落ちる。

典型エラー:

- `NamedExpression` not found
- `ClassDeclaration.members` / `.name` not found
- `DefaultFormalParameter` isn't a type

## 原因

codegen 系パッケージが要求する analyzer の範囲が一致しない。

| パッケージ | analyzer 制約 (pub.dev 時点) |
|---|---|
| `riverpod_generator` 4.0.4 | `^12.0.0` |
| `freezed` 4.0.0-dev.x | `^13.0.0` |
| `freezed` 3.2.6-dev.1 | `>=12.0.0 <13.0.0` |
| `dart_style` 3.1.9 | `^13.0.0` |
| `dart_style` 3.1.8 | `^12.0.0` |
| `mockito` 5.7.0 | `^13.0.0` |
| `mockito` 5.6.4 | `>=8.1.1 <13.0.0` |
| `theme_tailor` 3.1.3 | `>=9.0.0 <11.0.0` (override で 12 でも動作確認済み) |

`eqmonitor_lints_plugin` は workspace 外 (`tools/eqmonitor_lints_plugin`) で analyzer 13 を使う。workspace 本体に analyzer 13 override は不要。

## 推奨 override（app/pubspec.yaml）

```yaml
dependency_overrides:
  analyzer: ^12.0.0
  dart_style: 3.1.8      # ^3.1.8 だと 3.1.9 が選ばれるのでピン留め
  freezed: 3.2.6-dev.1   # analyzer 12 対応の bridge。4.0.0-dev.x は analyzer 13 必須
  mockito: 5.6.4         # riverpod_generator 経由。5.7.0 は analyzer 13 必須
```

## freezed 4 を使いたい場合

現状 pub.dev 上では **freezed 4 dev (analyzer 13) と riverpod_generator 4 (analyzer 12) は共存不可**。

- riverpod 側の analyzer 13 対応を待つ
- または freezed を 3.2.6-dev.1 に留める

## 確認コマンド

```bash
mise exec -- dart pub get
cd packages/dart_azarashi && mise exec -- dart run build_runner build -d
cd app && mise exec -- dart run build_runner build -d
```
