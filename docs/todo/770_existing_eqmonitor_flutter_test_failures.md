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
