# 履歴の分割表示と戻るボタン

- 地震履歴の詳細は `HistoryDetailScope.showBackButtonOf(context)` で戻るボタンの表示可否を判断する。
- 分割状態は `HistoryAdaptiveView` の実際の配置から渡す。詳細内の `MediaQuery.size` はペインの幅なので、端末全体の分割判定には使わない。
- `onClose` は狭い画面で選択を解除するためにも必要であり、その有無だけでは分割表示か判定できない。
- 分割表示では、読み込み中・エラー時のAppBarも `automaticallyImplyLeading: false` にする。明示したボタンを除くだけでは親Navigatorから戻るボタンが補完される。
- 詳細ルートから直接開いた場合は、従来どおりNavigatorの戻る操作を利用する。

## 検証

```sh
cd app
mise exec -- flutter test --no-pub \
  test/feature/earthquake_history/ui/earthquake_history_details_navigation_test.dart \
  test/feature/earthquake_history/ui/earthquake_history_details_nearby_card_test.dart
mise exec -- dart analyze --fatal-infos lib/core/component/layout \
  lib/feature/earthquake_history/ui/earthquake_history_details_page.dart
```
