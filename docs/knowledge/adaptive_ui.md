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

## M3E の選択状態とアクセシビリティ

- 通常のボタンは `m3e_core` の部品を使い、既存の無効条件・処理中表示・色指定を維持する。
- アプリ状態と同期するドロップダウンは `ControlledDropdown` を使う。
  `m3e_core 1.1.4` は項目の再設定でも選択コールバックを呼ぶため、
  再描画によって設定保存が走らないよう、外部更新とユーザー操作を分離する。
- 選択肢としての `null` は未選択と区別する。M3E 内部へは非nullのrecordで渡し、
  呼び出し側には元の型で返す。選択必須の場合は選択中項目の再タップで空にしない。
- メニュー表示中に無効化された場合も、選択イベントから保存処理を起動しない。
- M3E のカスタム描画部品には標準 Slider / ProgressIndicator と同じ読み上げ情報がない。
  `AccessibleSlider` / `AccessibleRangeSlider` / `Accessible*ProgressIndicator` を使う。
  範囲入力は上下限を個別に操作でき、互いの値を越えないようにする。
- 時刻シークは時刻ラベルと増減操作を提供する。津波タイムラインは隣接する電文へ進み、
  動画は再生時間の範囲内に収める。最新電文の選択表現も維持する。
- M3E に直接 `SliderTheme` を渡しても反映されない設定がある。
  対応する native decoration / track / handle 引数へ移す。

```sh
# app/ から
mise exec -- flutter test test/core/component/selector \
  test/core/component/slider test/core/component/chip/m3e_filter_controls_test.dart \
  test/feature/knet_waveform/ui/media/knet_movie_seekbar_test.dart \
  test/feature/tsunami/tsunami_timeline_accessibility_test.dart --dart-define=CI=true
```

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

## M3E の一覧・シートの境界

- ページング履歴は既存のSliverとsticky headerを保持し、行をM3Eのsegmented itemで描画する。追加読み込み・エラー再試行を通常の全件リストへ置き換えない。
- `showM3EModalBottomSheet` は既定の `isScrollControlled` と `useSafeArea` が従来と異なるため明示する。既存の子Widgetが余白を持つ場合は `M3EBottomSheetStyle(padding: EdgeInsets.zero)` を指定する。
- `M3EPullToRefreshIndicator` は `onError` 省略時に例外を消費する。従来の失敗通知を保持する画面では `Error.throwWithStackTrace` を渡す。
- 展開見出しは `ExpandableSection` にまとめ、開閉状態・キーボード・読み上げの操作を維持する。
- m3e_core 1.1.4 のdismissible listはアニメーション破棄後に削除結果を待つ。遅延して `false` を返すと破棄済みcontrollerへアクセスするため、`ConfirmedDismissibleList` で保存結果と表示を仲介する。
- 通知設定の保存はAPIが返す確定済みslotを再取得の前に反映する。再取得が失敗しても、後続編集で削除済みの上書き条件を復活させない。
- 削除に成功したIDは取得済み一覧から消えるまで非表示を維持する。失敗時は行とスクロールを復元し、並び替え後もindexではなくIDで削除する。読み上げの削除操作も同じ保存経路を使う。
