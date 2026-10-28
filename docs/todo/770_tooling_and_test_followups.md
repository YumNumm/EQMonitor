# 開発コマンド・解析・テスト

数値は元の優先度。過去の失敗件数を現在のbaselineとはみなさず、対象packageで再現して未達だけを直す。

## 770: workspace 全体での gcloud 導入

- workspace全体の導入で `vfox:gcloud` の `module 'metadata' not found` が再現するか確認し、gcloudのplugin設定を見直す。
- 完了条件: clean環境でworkspace全体のツールを再現可能に導入できる。

## 770: Codemagic CLI の macOS 検証

- Codemagic CLI 0.70.0 の locked install と CLI 起動は Linux / Python 3.14.7 で確認済み。
  macOS のインストールと XcResult 変換は未検証。既存 CI に該当する Codemagic 呼び出しはない。
- 完了条件: macOS で `mise install --locked pipx:codemagic-cli-tools` を実行し、
  Xcode 16 以上の実 XcResult を `xcode-project junit-test-results` で変換できることを確認する。

## 700 / 100: Melos・起動設定

- 700: root `pubspec.yaml` の `test:dart` / `report:test:dart` の `dependsOn: test` にFlutter依存packageが混入しないfilterを設定する。
- 完了条件: global Melos無しでlocal/CIのDart-only集合が一致し、`cache` 等はFlutter suiteからpackage cwdで実行される。選択契約を回帰テストする。
- 100: `generate` の未定義 `generate:dart` / `generate:flutter` 参照を `rebuild` に統合または定義する。`.vscode/launch.json` の `cwd: app` に対する環境fileパスを `../environment/` に直す。

## 600: region panel の pending timer

- 2026-09-25: 同梱Asset Packのないworktreeでは「市区町村選択状態でタップすると市区町村詳細モーダルが開く」が `AssetPackNotReadyException` と `pumpAndSettle` timeout で失敗する。`develop` の `3f659ea79` でも再現。必要なproviderをoverrideし、テストをローカルpack配置に依存させない。

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

## 750: Flutter Material 互換delegateの整理

- Flutter Materialを使う依存の移行完了後に、互換用の `flutter_localizations.GlobalMaterialLocalizations.delegate` と局所的な非推奨抑制を削除する。現在は `material_ui` と両方のdelegateが必要。
- 完了条件: 依存の移行後に互換delegateを整理し、関連UIテストが成功する。
