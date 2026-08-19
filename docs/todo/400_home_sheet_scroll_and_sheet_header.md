# ホームシートの残課題（スクロール実装・`SheetHeader` の置き場所）

ホームシートの余白・デザイン調整（`HomeSheetCard` / `AppBanner` の導入）の際に
残した課題。

## 1. `SingleChildScrollView` のまま残っている

`app/lib/page/home_page.dart` の `_SheetBody` は `SingleChildScrollView` を使っている。
コーディング規約では `ListView.builder` / `SliverList` を推奨している。

- 現状の子は「EEW カード・バナー数件・カード 3 枚」で件数が少なく、
  すべて常時レイアウトされても実害が小さいため据え置いた。
- ただし `sheet` パッケージのドラッグと `BottomBouncingScrollPhysics` の
  組み合わせに依存しているため、`CustomScrollView` へ置き換える場合は
  シートの追従・バウンス挙動の回帰確認が必要。

## 2. `SheetHeader` の置き場所

`app/lib/feature/home/ui/component/sheet/sheet_header.dart` の `SheetHeader` は
home feature 配下にありながら、実際の利用箇所は

- `app/lib/feature/earthquake_history/ui/components/earthquake_intensity_card.dart`
- `app/lib/feature/kyoshin_monitor/page/components/kyoshin_monitor_maintenance_card.dart`

で、home からは使われていない（home のカード見出しは `HomeSheetCardHeader`）。
規約どおり feature をまたぐ Widget は `lib/core/component/` へ移すのが望ましい。
また余白が `EdgeInsets.all(8)` 固定・スタイルが `titleMedium` 固定で、
デザイントークン（`spacing` / `typography`）に寄せる余地がある。
