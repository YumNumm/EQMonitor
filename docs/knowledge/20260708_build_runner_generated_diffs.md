# build_runner 生成差分の扱い

## ルール

`build_runner` 実行で生成された差分は、直接の実装タスク対象ファイル外であってもコミットに含めてよい。

## 背景

Riverpod / Freezed / go_router_builder などの生成は、対象の変更に加えて既存の未生成差分や生成器バージョン差分をまとめて反映することがある。
このプロジェクトでは、生成ファイルを手編集せず `build_runner` の結果として出た差分であれば、関連する生成結果として扱う。

## 注意

- `.g.dart` / `.freezed.dart` は直接編集しない。
- 生成差分が出た場合は、ソースとの整合を確認したうえで残す。
- Flutter / Dart コマンドは `mise exec --` 経由で実行する。

```bash
cd app
mise exec -- dart run build_runner build --delete-conflicting-outputs
```
