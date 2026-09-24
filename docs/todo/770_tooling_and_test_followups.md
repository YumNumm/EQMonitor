# 開発コマンド・解析・テスト

数値は元の優先度。過去の失敗件数を現在のbaselineとはみなさず、対象packageで再現して未達だけを直す。

## 770: PR の Flutter 検証での mise 全ツール解決

- `wc-check-dart-{analyze,test}.yaml` はjobの `MISE_ENABLE_TOOLS=flutter,node,python` で対象を制限する。clean runnerで全ツール導入が再発せず、Asset Pack配置後に解析・テストが起動することはCI検証待ち。
- workspace全体の導入では `vfox:gcloud` の `module 'metadata' not found` が残る。gcloudのplugin設定を確認する。
- `pipx:codemagic-cli-tools` の lockfile が参照する `.mise/locks/pipx-codemagic-cli-tools/0.69.0` も未配置。Android CD からは未使用依存として除去したが、workspace 全体の導入では修復が必要。
- 完了条件: clean runner で PR の解析とテストが起動・完走し、必要なツールだけを再現可能に導入できる。

## 770: 既存テスト失敗の再確認

- 通知の `slot_detail_page_test.dart` の警報設定2件と `notification_preset_selector_test.dart` の通知許可ダイアログ1件は、地域選択共通化時に変更前の `4e5708b38` でも失敗を再現した。期待する文言と現行UIを照合し、正しい仕様にテストを合わせる。通知・課金の本番挙動をテスト都合で変更しない。

- `app/` で `mise exec -- flutter test test --dart-define=CI=true --file-reporter=json:test_report.log` を実行する。repository rootから `app/test` を指定するとasset rootが変わるため比較しない。
- 旧失敗対象: `theme_settings_page_test.dart` / `theme_editor_page_test.dart`（theme ready待ち）、`home_earthquake_history_parameter_provider_test.dart`（asc/desc）、`feed_item_list_tile_test.dart`（「頃発表」）、`background_location_update_notifier_test.dart`（fake adapterのenum→wire JSON）、`live_monitor_detected_event_notifier_test.dart`、`override_edit_page_test.dart`（通知UIの「震度0以上」表現）。`app/test/` で該当名を検索し、現行仕様とassertionを照合する。
- 完了条件: 対象テストとpackage suiteが成功し、緊急情報の本番挙動をfixture都合で変更していない。

## 700: CI の10分 timeout

- `.github/workflows/wc-check-dart-test.yaml` の timeout は10分。旧実測は完走9m37s〜9m50s/時間切れ10m18sでrunner差に敏感だった。
- JSON reporterで遅いpackage/testを計測し、必要ならpackage matrixへ分割してから予算を決める。reporter の対象に workspace 内の `tools/*/test_report.log` も含める。
- 完了条件: 通常CIで余裕を持って完走し、テスト失敗とtimeoutを区別して把握できる。

## 700 / 100: Melos・起動設定

- 700: root `pubspec.yaml` の `test:dart` / `report:test:dart` の `dependsOn: test` にFlutter依存packageが混入しないfilterを設定する。
- 完了条件: global Melos無しでlocal/CIのDart-only集合が一致し、`cache` 等はFlutter suiteからpackage cwdで実行される。選択契約を回帰テストする。
- 100: `generate` の未定義 `generate:dart` / `generate:flutter` 参照を `rebuild` に統合または定義する。`.vscode/launch.json` の `cwd: app` に対する環境fileパスを `../environment/` に直す。

## 600: region panel の pending timer

- 対象: `app/test/feature/intensity_history/` の `region_floating_panel_test.dart`。「都道府県フォーカス状態でタップすると都道府県詳細モーダルが開く」のRiverpod retry 800ms timerを再確認する。
- 完了条件: 必要なprovider override/teardownでWidget破棄後のtimerを残さず、単独と全体並列で `!timersPending` が出ない。

## 600: 文書の参照切れ防止

- Markdown lint では `docs/knowledge/`・`docs/todo/` が除外され、ローカルリンクの存在も検査されない。分野別ガイド・TODO・エージェントガイドを対象に相対リンクと文書パスを検査する CI を追加する。
- 完了条件: 文書の削除・改名で参照切れを検出し、submodule 未初期化や過去の計画内の実装予定パスを誤って必須ファイル扱いしない。

## 500: formatter 差分

- `mise.toml` / lockfile のSDKでlocal/CI/agentを統一し、touched file外へformatter差分が広がる範囲を計測する。必要な一括formatは専用変更にする。
- 完了条件: pinned SDKで再formatが冪等になり、CIのformat確認とlocalが一致する。生成物や他人の差分を無断で差し戻さない。
- Freezedの再生成で末尾空白が復活する。`dart format off` のためformatterでは除去されない。生成後処理の適用範囲と冪等性を確認する。

## 450: primary constructor 残件

- 対象: `packages/{lat_lng,kyoshin_monitor_image_parser,eqmonitor_map}/lib/`、`app/lib/`、`tools/eqmonitor_lints_plugin/` の `prefer_primary_constructor`。
- initializer/body/super/assert、複数生成constructor、非finalフィールドの残件はlintの機械変換対象外。Widget/State subclassは方針どおり `const new()` を維持する。
- private DI引数のpositional化、assertのbody化、named constructorのredirect可否を必要なクラスごとに判断する。完了条件: 公開API/情報を失わず変換できるものだけ変換し、残る言語制約をルール側で説明できる。

## 400: analyzer plugin の package 適用範囲

- `mise exec -- dart run melos run analyze --no-select` で、app以外の13パッケージに計145件のカスタムlint警告が出る。対象は `cache`、`core`、`dart_azarashi`、`earthquake_replay`、`jma_map`、`knet_api_client`、`knet_waveform_parser`、`kyoshin_monitor_api`、`kyoshin_monitor_image_parser`、`live_activity_util`、`msgpack_dart`、`nied_api_client`、`telemetry_store`。
- 診断には生成ファイルのトップレベル関数やnullアサーションも含まれる。生成ファイルを直接修正せず、ルールの対象範囲と生成設定を確認する。
- `analysis_options.yaml`、`app/analysis_options.yaml`、`packages/*/analysis_options.yaml` のinclude chainと `tools/eqmonitor_lints_plugin/` の対象scopeを調べる。
- pure Dart/Flutterごとに有効ルールを決め、必要なpackageへ適用する。診断0件だけをplugin無効/有効の証拠にしない。
- 完了条件: 意図したpackageの違反fixtureに診断が出て、generated/test scopeは `LintTargetScope` の回帰テストと一致する。

## 092: TODO監査の実課題だけを解消

- `packages/eqmonitor_api/lib/src/models/get_v2_subscription_me_response_union.dart` は現在も `fromJson` が `UnimplementedError`。OpenAPI discriminatorまたは `packages/eqmonitor_api/bin/generate.dart` の後処理で直し、active/grace/inactiveと不正値をtestして再生成する。
- `app/ios/scripts/patch_purchases_paywall_color.sh` は依存pinが `purchases-ios-spm >= 5.78.0` を満たしたら不要性を検証して削除する。
- `app/lib/feature/fnet_catalog/ui/components/fnet_catalog_list_tile.dart` は詳細modal/pageのUXを決めて古いコメントを整理する。`packages/extensions/README.md` / `packages/lat_lng/README.md` のtemplate TODOを実態に合わせる。
- map utility/asset generator のgeometry guardは入力shape契約をfixtureで確認する。問い合わせ画面の非mobile対応を採用するなら `app/lib/feature/settings/data/contact/contact_action.dart` の案内を設計する。

## 750: Flutter main 更新時点で再現する既存の検証失敗

- Flutter `19946f91c8d9de18a4674460d015229cc0b2534f` のUI移行前でも、関連テスト12件が失敗する。
- `theme_editor_page_test.dart` の3件はColorPicker内部のFlutter Materialと `material_ui` の境界で `No Material widget found` となる。依存の境界をそろえて色選択を検証する。
- `notification_delivery_log_detail_builder_test.dart` の3件は時刻・表示文言、`notification_preset_selector_test.dart` の1件と `slot_detail_page_test.dart` の2件は通知文言の全角・半角差を現行仕様と照合する。
- `earthquake_vxse_debug_editor_test.dart` のJSON手動編集2件はコメント欠損・未知の型の期待値を確認する。データ保持の要件を弱めず修正する。
- `earthquake_history_debug_sheet_test.dart` の1件は `earthquake_summary_header.dart` のWrap直下のExpandedで `ParentDataWidget` エラーになる。地震情報の時刻表示を保ってレイアウトを修正する。
- Flutter Materialを使う依存の移行完了後に、互換用の `flutter_localizations.GlobalMaterialLocalizations.delegate` と局所的な非推奨抑制を削除する。現在は `material_ui` と両方のdelegateが必要。
- 完了条件: 上記テストと全体解析が成功し、通知内容・時刻・地震データの意味を維持する。
