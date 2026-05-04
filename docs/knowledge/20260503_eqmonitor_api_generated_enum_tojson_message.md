# eqmonitor_api 生成 enum の toJson エラーメッセージと `\$unknown`

## 事象

`packages/eqmonitor_api` の `@JsonEnum` 付き enum で、`toJson()` 内に次のような文言が含まれることがある。

```dart
'This usually happens for \\$unknown or @JsonValue(null) entries.'
```

Dart の文字列では `\$` はエスケープされ **`$unknown` が識別子として解釈** される。当該 enum に `unknown` ゲッターが無いと **コンパイルエラー** になる。

## 対処

生成物を直す場合は、メッセージを **リテラルの `$` を含む形** にする。

- 望ましい: `'...\$unknown...'`（ソース上は `\$unknown` 1 バックスラッシュ — Dart が `$` をエスケープ）

コードジェネレータ側では、エラーメッセージ内の `$` は `\$` で出力するよう注意する。

## 参照

修正例: `packages/eqmonitor_api/lib/src/models/environment.dart` ほか多数の enum ファイル。
