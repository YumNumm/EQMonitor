# freezed 4.0.0-dev.3 と build_runner 互換性

## 症状

`app` で `dart run build_runner build` が AOT コンパイル段階で失敗する。

- `NamedArgument` / `NamedExpression` など analyzer AST 型が見つからない
- `Bad state: Generating AOT kernel dill failed!`

## 原因

コード生成系パッケージと `dependency_overrides` の analyzer 系バージョンが食い違う。

| パッケージ | 必要な analyzer |
|---|---|
| freezed 3.2.6-dev.1 | `>=12.0.0 <13.0.0` |
| freezed 4.0.0-dev.3 | `^13.0.0` |
| riverpod_generator 4.0.8 / riverpod_analyzer_utils | `^13.0.0` |
| dart_style 3.1.8 | `^12.0.0` |
| dart_style 3.1.12 | `>=13.1.0 <15.0.0` |
| mockito 5.6.4 | `>=8.1.1 <13.0.0` |
| mockito 5.8.1 | `>=13.3.0 <15.0.0` |

freezed を 4 系に上げる場合、analyzer / dart_style / mockito もセットで上げる必要がある。

## 解決策（2026-08-13 時点）

`app/pubspec.yaml` の override を次に揃える。

```yaml
dependency_overrides:
  analyzer: ^13.0.0
  dart_style: 3.1.12
  freezed: 4.0.0-dev.3
  mockito: 5.8.1
```

その後:

```bash
mise exec -- dart pub get
cd app && mise exec -- dart run build_runner build --delete-conflicting-outputs
```

## 注意

- workspace 内で `freezed: ^3.2.6-dev.1` を残している package があると、override 無しでは再び衝突する
- `--delete-conflicting-outputs` は新しい build_runner では無視される警告が出る（動作自体は成功する）
