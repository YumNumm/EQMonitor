# material_ui / cupertino_ui 移行の残課題

`add packages` / `add: cupertino_ui` で Flutter 本体の material から
`package:material_ui` / `package:cupertino_ui` へ移行したが、
Flutter 本体の material 型を要求する外部パッケージとの境界が未整理。

## 1. flutter_markdown が Flutter 本体の ThemeData を要求する

`flutter_markdown` の `MarkdownStyleSheet.fromTheme` / 内部の
`Theme.of(context)` は Flutter 本体の `ThemeData` を参照する。
material_ui の `MaterialApp` 配下には Flutter 本体の `Theme` が
存在しないため、`MarkdownStyleSheet` を渡さない場合は
**既定の light ベース ThemeData** が使われる。

- 対応済み: `app/lib/feature/changelog/ui/page/changelog_page.dart`
  （`MarkdownStyleSheet` へ TextStyle を明示的に受け渡す）
- 未対応（dark mode で本文が読めない可能性がある）:
  - `app/lib/feature/settings/children/application_info/about_this_app.dart`
  - `app/lib/feature/settings/children/application_info/term_of_service_page.dart`
  - `app/lib/feature/settings/children/application_info/privacy_policy_page.dart`

対応方針: material_ui 対応の markdown レンダラへ移行するか、
`MarkdownStyleSheet` を組み立てる共通コンポーネントを
`app/lib/core/component/` に切り出して 4 箇所で共有する。

## 2. flutter_hooks の material 依存フック

`useTabController` は Flutter 本体の `TabController` を返すため
material_ui の `TabBar` / `TabBarView` に渡せない。
`knet_station_waveform_page.dart` は `DefaultTabController` へ置き換えたが、
他に material 型を返すフック（`useTabController` 以外）を使い始める場合は
同じ問題が起きる。

## 3. go_router の app 種別判定が material_ui を検出できない

go_router は `findAncestorWidgetOfExactType<MaterialApp>()`（Flutter 本体の型）で
app 種別を判定するため、material_ui の `MaterialApp` 配下では常に
「`WidgetsApp` 構成」と判定される。

- 対応済み: 既定 `Page` が `NoTransitionPage` になり遷移アニメーションと iOS の
  スワイプバックが失われる問題。全ルートに `MaterialPageMixin` を適用して解消した
  （`docs/knowledge/20260815_go_router_material_ui_page_transition.md`）。
- 未対応: `HeroController` が `createMaterialHeroController()` ではなく素の
  `HeroController()` になるため、Hero 飛行の軌跡が `MaterialRectArcTween` の
  弧ではなく直線になる。影響箇所は `onboarding_hero.dart` / `welcome_step_page.dart` /
  `complete_step_page.dart` / `paywall_page.dart`。
  go_router は `HeroController` の差し替え口を公開していないため、
  material_ui 対応が go_router 本体に入るのを待つか、
  `MaterialApp.router` の `builder` で `HeroControllerScope` を挟めないか検討する。
- 未対応（影響なし）: 既定エラー画面が go_router の素の `ErrorScreen` になる。
  `goRouterProvider` が `errorBuilder` を渡しているため実際には使われない。

## 4. Localizations delegate の重複

`flutter_localizations` と `material_ui` / `cupertino_ui` が
同名の `GlobalMaterialLocalizations` / `GlobalCupertinoLocalizations` を公開する。
`app/lib/app.dart` は `show` で material_ui / cupertino_ui 側を選択しているが、
他ファイルで両方を import すると同じ衝突が再発する。
