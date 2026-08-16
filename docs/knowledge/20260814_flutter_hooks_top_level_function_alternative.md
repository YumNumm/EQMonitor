---
alwaysApply: true
---

# flutter_hooks のカスタム Hook はトップレベル関数でなくても動く

## 背景

`avoid_top_level_functions` を解消する際、既存コード
（`app/lib/core/hook/use_sheet_controller.dart` など）は
`// ignore: eqmonitor_lints_plugin/avoid_top_level_functions` で抑制し、
コメントで「Hook はトップレベル関数として定義する規約であり、クラスの
メソッドにすると Hook の登録順序が壊れて動作しない」と説明していた。

しかしタスクによっては ignore コメントの使用自体が禁止される場合がある
（Task 16 の `feature/tsunami` / `feature/eew` など）。この場合に備え、
flutter_hooks の実装を調査した。

## 調査結果

`flutter_hooks-<version>/lib/src/framework.dart` の実装:

```dart
R use<R>(Hook<R> hook) => Hook.use(hook);
...
static R use<R>(Hook<R> hook) {
  assert(HookElement._currentHookElement != null, '...');
  return HookElement._currentHookElement!._use(hook);
}
```

`use()`（`useState` / `useRef` / `useMemoized` などの内部実装）は
`HookElement._currentHookElement` という **static field** を参照するだけで、
呼び出し元の関数がトップレベル関数か、クラスの static メソッド/インスタンス
メソッドかを一切区別しない。Hook の登録順序は「build メソッド内で毎回同じ
順序で呼ばれるか」だけに依存する。

## 結論

- カスタム Hook を `avoid_top_level_functions` 対応でクラス化する場合、
  **static メソッドに変更しても動作は変わらない**
  （例: `EewEstimatedRegionsStaleCacheHook.use(...)` のような形）。
- ignore コメントでの抑制と static メソッド化はどちらも有効な手段。
  タスクの指示で ignore コメントが禁止されている場合は static メソッド化を
  優先する。
- ただし、Hook 内部で呼んでいる `useRef` 等の**呼び出し順序・呼び出し回数**
  自体は変更しないこと（条件分岐の中で hook を呼ぶなど、既存の
  flutter_hooks の制約は変わらない）。
