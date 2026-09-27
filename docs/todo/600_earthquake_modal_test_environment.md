# 地震履歴モーダルの表示テストを再実行する

2026-09-27 の作業ツリーでは、既存の次の不整合で一部テストがコンパイルできない。

- `BuildConfig` のコンストラクタ引数・認証設定 getter と呼び出し側の不一致。
- `flutter_scene` の `waitForPendingGpuSubmissions`、`CullMode`、`FmatType` などとマップアダプターの不一致。

これらを解消後、`app` で次を実行し、実機でマップの観測点・地域タップも確認する。

```sh
mise exec -- flutter test test/feature/earthquake_history/ui/region_intensity_widget_test.dart test/feature/earthquake_history/data/shindo_db_intensity_tree_test.dart
```
