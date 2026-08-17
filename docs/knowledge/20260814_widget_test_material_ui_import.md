# Widget テストは `package:flutter/material.dart` ではなく `material_ui` を import する

## 事象

`app/lib` 配下は `package:material_ui/material_ui.dart`（独自 fork の Material 実装）へ
移行済み（`docs/todo/800_material_ui_migration_residuals.md` 参照）。

この状態で Widget テスト側だけ誤って `package:flutter/material.dart` の `MaterialApp` を
使うと、本番コードの Widget（`material_ui` の `showDialog` 等を使うもの）を
その `MaterialApp` 配下に置いても

```text
No MaterialLocalizations found.
XxxWidget widgets require MaterialLocalizations to be provided by a Localizations widget ancestor.
```

が発生する。`material_ui` 独自の `MaterialLocalizations` 型と Flutter 標準の
`MaterialLocalizations` 型は別物であり、`flutter/material.dart` の `MaterialApp` が
提供する `Localizations` には `material_ui` 側の型が登録されないため。

`initState` の `addPostFrameCallback` から `showDialog` を呼ぶような Widget
（例: `ForcedUpdateWrapper`）でこの不整合があると、何度 `pump()` してもエラーが
再現し続ける（一過性のレースではない）。

## 対処

Widget テストで `MaterialApp` / `Scaffold` / `Text` 等の Material Widget を使う場合は、
必ず `package:material_ui/material_ui.dart` から import する。

```dart
// ❌ 悪い例
import 'package:flutter/material.dart';

// ✅ 良い例
import 'package:material_ui/material_ui.dart';
```

既存の `_TestApp` ヘルパー（`ThemeData` + `DesignSystemThemeExtension` を設定するもの）を
持つテストファイルはすでにこのパターンに従っているため、それらをコピーして使うと安全。

## 調査方法のヒント

`showDialog` 系のアサーション失敗で表示される ancestor 一覧は、実際の Element Tree の
一部（直近 5 件程度）だけを表示するデバッグ用の簡略表示であり、`MaterialApp` が
本当にツリーに存在するかどうかの判定材料にはならない。import の取り違えを最初に疑うこと。
