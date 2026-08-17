# go_router は material_ui の MaterialApp を検出できない（遷移アニメーション消失）

## 事象

iOS で go_router のページ遷移アニメーションが一切再生されず、左端からのスワイプバック
（back gesture）も効かない。Android でも遷移アニメーションがない。

`Navigator.push(MaterialPageRoute(...))` を直接呼んでいる画面（通知設定の子画面や
地図ピッカーなど）だけは正常にアニメーションする、という切り分けになる。

## 原因

go_router は `GoRouteData.build()`（= `GoRoute.builder`）だけを実装したルートに対して、
**祖先ウィジェットの型を見て** 既定の `Page` 実装を決めている。

```dart
// go_router/lib/src/pages/material.dart
bool isMaterialApp(BuildContext context) =>
    context.findAncestorWidgetOfExactType<MaterialApp>() != null;
```

ここで参照される `MaterialApp` は `package:flutter/material.dart`（Flutter SDK 本体）の
クラスである。本アプリは `package:material_ui/material_ui.dart` へ移行済みで、
`material_ui` は SDK とは**別の `MaterialApp` クラス**を定義している
（`docs/todo/800_material_ui_migration_residuals.md` 参照）。

そのため `findAncestorWidgetOfExactType<MaterialApp>()` は必ず null になり、
go_router は「`WidgetsApp` 構成」と判定して全ルートを `NoTransitionPage` で包む。
`NoTransitionPage` は `transitionDuration` が `Duration.zero` で、
iOS のスワイプバックを提供する `CupertinoPageTransition` も挿入されない。

go_router 17.5.0（現時点の最新）に material_ui 対応はない。

## 対処

`app/lib/core/router/material_page_mixin.dart` の `MaterialPageMixin` を全ルートへ適用し、
`material_ui` の `MaterialPage` を明示的に生成する。

```dart
class SplashRoute extends GoRouteData with $SplashRoute, MaterialPageMixin {
  const SplashRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const SplashPage();
}
```

`buildPage()` を自前で実装するルート（`HomeRoute` は `sheet` パッケージ連携のため
`MaterialExtendedPage` を使う）は mixin の対象外。その場合も
`key` / `name` / `restorationId` を `GoRouterState` から渡すこと。渡さないと
Navigator のページ同一性判定・状態復元・`FirebaseAnalytics` の画面名が壊れる。

## 注意点

- **ルート追加時に mixin を付け忘れてもコンパイルエラーにならず、遷移アニメーションだけが
  静かに失われる。** `app/test/core/router/material_page_mixin_test.dart` が
  `router.dart` の宣言を静的に検査して取りこぼしを検知する。
- 同じ検出ロジックは go_router の `HeroController` 選択（`createMaterialHeroController`）と
  既定エラー画面にも使われている。前者は残課題として
  `docs/todo/800_material_ui_migration_residuals.md` に記載済み。
- 外部パッケージが `package:flutter/material.dart` の型で分岐している箇所は同種の
  不具合を起こす。`Theme.of` / `findAncestorWidgetOfExactType` を使うパッケージは疑う。

## 再現・検証コマンド

```bash
cd app
mise exec --no-deps flutter -- flutter test test/core/router/material_page_mixin_test.dart
```
