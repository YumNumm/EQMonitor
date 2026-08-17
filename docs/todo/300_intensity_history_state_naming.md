# `IntensityHistoryState` の命名が実態と逆で誤読を招く

## 現状

`app/lib/feature/intensity_history/data/model/intensity_history_state.dart`

| コンストラクタ | 実際の意味 |
|---|---|
| `IntensityHistoryState.prefecture()` | 全国表示（都道府県ごとに色分け） |
| `IntensityHistoryState.city(prefectureCode: ...)` | 特定の**都道府県**にフォーカス（市区町村ごとに色分け） |
| `IntensityHistoryController.backToPrefecture()` | 全国表示に戻す |

「塗り分けの粒度」を名前にしているが、状態としては「何にフォーカスしているか」を
表しているため、読み手はほぼ確実に逆の意味に取る。

## 実害

この命名により、タップ処理に

```dart
} else if (hitRegion && state is IntensityHistoryStatePrefecture) {
```

という条件が書かれ、「都道府県フォーカス中に別の都道府県をタップしても無反応」という
不具合が生まれていた（#1614 で修正）。

## 対応方針

- `IntensityHistoryState.prefecture()` → `.nationwide()`
- `IntensityHistoryState.city(...)` → `.prefectureFocused(...)`
- `backToPrefecture()` → `backToNationwide()`

参照箇所は以下。Freezed の再生成とテスト更新が必要。

- `data/notifier/intensity_history_controller.dart`
- `ui/action/intensity_history_map_action.dart`
- `ui/intensity_history_page.dart`
- `ui/layer/intensity_fill_layer.dart` / `intensity_fill_layer_builder.dart`
- `ui/components/region_floating_panel.dart`
- `test/feature/intensity_history/` 配下

#1614 の変更と競合しやすいため、マージ後に単独の PR で行う。
