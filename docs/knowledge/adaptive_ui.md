# 履歴ペイン・画面遷移・表示lifecycle

2026-09-21統合。レイアウト契約と非同期pluginの所有境界をまとめる。
コード確認と実機の視覚確認を区別し、過去の個別作業の「テスト不要」を恒久ルールにしない。

## 履歴一覧と詳細

- 地震/EEW履歴はHistoryAdaptiveViewを使う。通常840dp以上で左右分割し、一覧は30%・320〜440dp。
  狭い場合は一覧か選択中詳細だけを表示する。
- 一覧の要素を破棄せず選択・scroll・filterを保持する。詳細はeventIdでkeyを付け、
  同一eventの幅変更では保持、別eventでは再作成する。詳細ルート直接表示も維持する。
- 戻るボタンはHistoryDetailScope.showBackButtonOf(context)で判断する。
  詳細内MediaQueryはペイン幅なので端末全体の分割判定へ使わない。
- onCloseは狭い画面の選択解除にも必要で、存在だけで分割状態を判断しない。
- 分割中のloading/error AppBarもautomaticallyImplyLeading:falseとする。
  明示ボタンを消すだけでは親Navigatorが戻るボタンを補完する。
- 直接開いた詳細ルートはNavigatorの戻る操作を使う。

## 折りたたみとペイン内制約

- DisplayFeatureSubScreen.avoidBoundsとPaneViewportObserverの実表示領域を使い、
  screen座標をglobal originからlocalへ変換する。計測が古い間は描画・入力・semanticsを抑止する。
- 縦ヒンジは左右、横ヒンジは上下。端末orientationで分割方向を決めない。
- 左右は一覧320dp/詳細360dp以上、上下は幅600dp・一覧高280dp・詳細高360dp以上を条件とする。
  両側に収まらなければ広い片側を使い、その幅で表示を決める。
- 幅0の折り目も対象なのでRect.overlapsだけで交差判定しない。
  Live Monitorとは計測部品を共有し、独自の分割方向まで同一化しない。
- HistoryPaneは一覧/詳細に別PrimaryScrollControllerを与える。loading ListViewも対象。
  MediaQueryサイズ/余白は各ペイン、keyboard縮小は外側Scaffoldが担当する。
- 地図上詳細シートはBasicModalSheet(expandToPane:true)で、横長ペインをさらに半幅にしない。
- EEW各報シートは最新報から表示し、event選択変更/詳細closeで履歴再生を止める。
  選択は震度色を塗り替えず輪郭とSemanticsで伝える。

## material_uiとgo_router

- go_routerのSDK MaterialApp型検出はmaterial_uiの同名型を検出できない。
  暗黙Pageへ依存するとNoTransitionPageとなり、遷移/スワイプバックが失われる。
- `app/lib/core/router/material_page_mixin.dart`のMaterialPageMixinでmaterial_ui MaterialPageを明示する。
- 独自buildPageのHomeRoute等はmixin対象外だが、key/name/restorationIdをGoRouterStateから渡す。
  欠落はpage同一性・復元・analytics画面名へ影響する。
- mixin忘れはcompile errorにならないため既存material_page_mixin_testで検出する。
  HeroController等の残件は[UI・画面遷移](../todo/800_ui_and_navigation.md)。
- 外部packageのTheme.ofやexact SDK型検出でも同種の不整合が起こり得る。

## 条件付き表示と更新時刻

- Row/Column spacingはSizedBox.shrinkも子として数える。非表示バナーをchildrenへ載せないか、
  AppBanner自身の下余白に任せる。常時表示カードだけをspacing付きColumnへまとめる。
- 市区町村最大震度の集計時刻は`aggregated_at`/CityMaxIntensity.aggregatedAt。
  別用途responseAtを混ぜない。時刻nullでもitemsは表示する。
- API更新は現在の元スキーマから生成し、古い調査時タグへsubmoduleを戻す手順を常用しない。

## Live Monitorの画面点灯

- wakelock_plusを呼ぶcontrollerはsession・keepScreenAwake・lifecycleを監視する。
  active sessionかつ設定有効かつresumedの場合だけenableする。
- background、exit、設定無効はdisableへ収束する。plugin処理は直列化し、generationで古い未実行状態を捨てる。
  enable完了後にpause/exitが残れば続けてdisableする。同じdesired stateを重複実行しない。
- adapter/queue/generation/適用状態はRef非依存ownerが保持し、await区間でRefを読まない。
  controller依存変更のたびにownerを破棄せず、owner寿命終了時に実行中処理後の強制disableをqueueする。
- plugin例外はログに記録し、地震情報UIのerrorへ置き換えない。
- 実機で自動ロック時間超過、background/foreground、exit、設定変更、高速な状態切替を確認する。

## 検証

コード確認済み: `app/lib/core/component/layout/history_adaptive_view.dart`の実測判定と要素保持。
実機レイアウトの残件は[UI・画面遷移](../todo/800_ui_and_navigation.md)。本統合では試験を再実行していない。

```sh
# app/から
mise exec -- flutter test test/core/router/material_page_mixin_test.dart \
  test/feature/earthquake_history/ui/earthquake_history_details_navigation_test.dart \
  test/feature/earthquake_history/ui/earthquake_history_details_nearby_card_test.dart \
  test/feature/live_monitor/data/live_monitor_wake_lock_controller_test.dart --dart-define=CI=true
mise exec -- dart analyze lib/core/component/layout lib/feature/eew_history/ui
# packages/eqmonitor_api/から
mise exec -- dart test test/city_max_intensity_response_test.dart
```
