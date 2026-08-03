# region_floating_panel_test の pending timer を解消する

`mise exec -- flutter test --fail-fast --reporter expanded` の全体並列実行で、
`region_floating_panel_test.dart` の
「都道府県フォーカス状態でタップすると都道府県詳細モーダルが開く」が失敗する。

Riverpod の retry が作る 800ms timer が Widget 破棄後も残り、Flutter test の
`!timersPending` assertion に抵触している。Asset Pack の対象テスト 39 件と
`assets_util` の全 15 件は通るため今回の変更とは独立しているが、全体テストを
安定させるため provider override または teardown で retry timer を確実に
終了させること。
