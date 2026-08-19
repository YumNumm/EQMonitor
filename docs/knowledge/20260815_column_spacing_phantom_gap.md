---
globs: app/lib/**/*.dart
---

# 条件付き表示の Widget を `Column(spacing:)` で並べると余白だけが残る

## 事象

`Column` / `Row` の `spacing` は、子が `SizedBox.shrink()` を返して 0px でも
子の個数から間隔を計算する（`spacing * (childCount - 1)`）。

そのため「条件を満たさないときは `SizedBox.shrink()` を返す」タイプの Widget を
`spacing` 付きの `Column` に並べると、**非表示のときも間隔だけが残る**。

ホームシートでは、非表示が既定状態の What's New バナー・デバイス初期設定バナーの
ぶんだけ、常に余分な余白が入っていた。

```dart
// ❌ 非表示のバナーのぶんも余白が残る
Column(
  spacing: spacing.md,
  children: [
    WhatsNewBanner(), // 未更新時は SizedBox.shrink()
    DeviceProvisioningBanner(), // 正常時は SizedBox.shrink()
    const HomeFeedSheet(),
  ],
)
```

## 対処方針

- 表示条件を親側で判定できるものは、`if (condition) Banner()` として
  **children に載せないようにする**（`spacing` はそのまま使える）。
- 親が判定できない（Widget 内部で provider を見て決める）場合は、
  **間隔を Widget 自身の下余白として持たせる**。
  ホームシートのバナーは `AppBanner`（`app/lib/core/component/banner/app_banner.dart`）が
  `EdgeInsets.only(bottom: spacing.md)` を持つことで統一している。
- 常に表示されるカード群だけを内側の `Column(spacing:)` にまとめるのは問題ない。

## 確認方法

Widget テストで、間に `SizedBox.shrink()` を挟んだ状態の実効間隔を検証できる。

```dart
Rect surfaceOf(int index) => tester.getRect(
  find.descendant(
    of: find.byType(AppBanner).at(index),
    matching: find.byType(Material),
  ),
);
expect(surfaceOf(1).top - surfaceOf(0).bottom, spacing.md);
```
