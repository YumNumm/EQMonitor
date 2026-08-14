# eqmonitor の既存 Flutter test 18件を修復する

## 背景

Flutter master toolchain移行時に`eqmonitor` suiteで1,477件が成功し、18件が失敗した。
同じ6 files・同じ18 test・同じ原因がrepositoryのstable Flutter baselineでも再現した
ため、固定Flutter masterへの移行が原因ではない。`cache` 52件と
`telemetry_store` 46件は固定masterで成功した。

## 再現コマンド

package asset rootを保つため`app/`をworking directoryにする。

```bash
cd app
mise exec -- flutter test --no-pub test \
  --file-reporter=json:/tmp/eqmonitor-flutter-tests.json
```

repository rootから`flutter test app/test`を呼ぶと`assets/tjma2001.csv`の解決条件が
変わり、比較対象外のasset failureが発生するため使用しない。

## 内訳

- `theme_settings_page_test.dart`: 6件
  - `appThemeProvider`が`AsyncLoading`中に`requireValue`
- `theme_editor_page_test.dart`: 4件
  - 同じtheme初期化race
- `home_earthquake_history_parameter_provider_test.dart`: 2件
  - testは`SortOrder.asc`、productionは明示的に`SortOrder.desc`
- `feed_item_list_tile_test.dart`: 1件
  - testは日時だけ、productionは`頃発表` suffix付き
- `background_location_update_notifier_test.dart`: 5件
  - fake Dio adapterがserialize前のenum instanceを`fromJson`へ渡す

## 最小修正と回帰確認

- theme testは`appThemeProvider.future`のreadyを待ってからdependent surfaceを操作する
- home testは全国/currentLocation双方のproduction sort contractを確認する
- feed testはlocal日時と表示suffixを確認する
- location fake adapterはwire JSON round-trip後にdecodeし、
  `min_level: "Medium"`を明示検証する

生命に関わるapp behaviorをtest都合で変更せず、production contractを確認してから
test fixtureを修正する。

## 追記 (2026-08-14): 通知設定リデザインに伴う既存不良

Analyzer 診断ゼロ化 (PR #1639) の develop マージ時点で、以下が既に破損していた。

- `override_edit_page_test.dart`: 1件
  - develop 上でこのテストは `OverrideType.earthquake` を参照していたが、
    `OverrideType` はリポジトリ内のどこにも定義されておらず**コンパイルエラー**だった
    （通知設定リデザイン系 PR のマージ順序によるもの）。
  - Analyzer の ERROR 解消のため `overrideType` 引数の実際の型である
    `NotificationKind.earthquake` に修正した。これでコンパイルは通るようになったが、
    リデザイン後の UI が最小震度を `震度0以上` 形式で一覧表示しなくなったため、
    `expect(find.text('震度0以上'), findsOneWidget)`（テスト名:
    「追加ダイアログで通知音と割り込みレベルを選んで追加すると一覧に反映される」）が
    runtime で失敗する。
  - **これは Analyzer 修正が壊したものではなく、リデザイン PR がテストを更新し忘れた
    既存不良である。** 一覧表示の正しい仕様（リデザイン後に最小震度をどう表示するか）を
    リデザイン担当と確認してから test fixture を更新すること。
    ダイアログ操作・保存結果の assertion（sound / interruptionLevel）は成功しており、
    壊れているのは一覧表示テキストの assertion のみ。

現時点の `flutter test` 失敗は 6 件で、内訳は次のとおり（いずれも本 Analyzer 作業の前から
非成功。develop 直系の baseline と一致し、新規の回帰はない）。

- `live_monitor_detected_event_notifier_test.dart`: 2件
- `theme_editor_page_test.dart`: 3件
- `override_edit_page_test.dart`: 1件（上記）
