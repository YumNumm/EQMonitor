# OpenAPI の inline enum 名衝突を防ぐ

## 背景

`swagger_parser` は inline enum のプロパティ名から Dart の型名を生成する。
共有 component と inline enum が同じプロパティ名を持つと、後から生成された型が
同名ファイルを上書きし、別 API の enum 値が欠落する場合がある。

今回、地震 API の共有 `OriginTimePrecision` と震源カタログ API の inline
`origin_time_precision` が衝突し、地震 API の `MILLISECOND` などが失われた。

## 対応

`packages/eqmonitor_api/bin/generate.dart` で swagger_parser 実行前に inline enum を
専用 component `HypocenterOriginTimePrecision` へ抽出し、`$ref` に置き換える。
異なる契約を同じ Dart enum に統合しないこと。

再生成と検証は次のコマンドで行う。

```shell
mise exec -- dart run packages/eqmonitor_api/bin/generate.dart
cd packages/eqmonitor_api
mise exec -- dart analyze
mise exec -- dart test test/origin_time_precision_collision_test.dart
```

新しい inline enum を追加した際は、生成後の enum ファイル名だけでなく、既存 API の
fixture も同時にパースする回帰テストで衝突を検出する。
