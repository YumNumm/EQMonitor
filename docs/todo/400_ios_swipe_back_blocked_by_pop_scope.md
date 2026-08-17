# PopScope で戻る操作を再割り当てしている画面は iOS のスワイプバックが効かない

## 背景

go_router のページ遷移を `MaterialPage` へ修正し、iOS の左端スワイプバックが
機能するようになった（`docs/knowledge/20260815_go_router_material_ui_page_transition.md`）。

一方で Flutter の `ModalRoute.popGestureEnabled` は
`popDisposition == RoutePopDisposition.doNotPop` のときスワイプジェスチャを無効化する。
`PopScope(canPop: false)` で戻る操作を別の用途へ割り当てている画面では、
**ジェスチャ自体が開始されず `onPopInvokedWithResult` も呼ばれない**。
Android のシステムバックでは意図どおり動くが、iOS ではユーザーには
「スワイプしても何も起きない」画面として見える。

## 該当箇所

- `app/lib/feature/earthquake_history/ui/earthquake_history_page.dart`
  - `canPop: isDefaultSort` — 並び替え中はスワイプバック不可
- `app/lib/feature/intensity_history/ui/intensity_history_page.dart`
  - `canPop: !isFocused` — 市区町村フォーカス中はスワイプバック不可
- `app/lib/feature/live_monitor/ui/page/live_monitor_page.dart`
  - `canPop: allowExit.value` — 終了確認を通す前はスワイプバック不可（意図通りの可能性あり）

## 検討事項

- 「戻る操作でフィルタ／フォーカスを解除する」挙動は Android のシステムバック向けの設計。
  iOS では画面内の明示的な UI（クリアボタン等）で代替し、`canPop` を true に保つほうが
  プラットフォームの期待に沿う。
- LiveMonitor の終了確認は誤操作防止が目的なので、現状維持が妥当か UX として要判断。
- 現状は「以前はスワイプバックが全画面で効かなかった」ため機能後退ではないが、
  画面によって効く・効かないが混在するのは分かりにくい。
