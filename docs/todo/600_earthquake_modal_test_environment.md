# 地震履歴モーダルの実機確認

2026-09-28: 最新 develop を取り込んだ分離 worktree では、以前の BuildConfig・flutter_scene のコンパイル不整合は再現せず、以下の関連テスト16件が成功した。

```sh
cd app
mise exec -- flutter test test/feature/earthquake_history/data/earthquake_intensity_area_filter_test.dart test/feature/earthquake_history/ui/shindo_db_intensity_content_widget_test.dart test/feature/earthquake_history/ui/region_intensity_widget_test.dart test/feature/earthquake_history/data/shindo_db_intensity_tree_test.dart
```

残件: 実機でマップの観測点・市区町村・都道府県タップと、詳細・一覧のスクロールを確認する。
