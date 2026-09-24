# テスト実行・環境切り分け・表示確認

## 実行する場所とコマンド

修正依頼時のテスト追加・TDD の扱いは [テスト方針](test_strategy.md)、
SDK・submodule の準備は [development_environment.md](development_environment.md) を参照。

- Flutter テストは必ず対象 package 内で実行する。app なら `app/` が working directory。
  root から `flutter test app/test/...` や `flutter test packages/<name>` を実行すると、
  asset / fixture の基準や `flutter.config` が変わり、偽の失敗を作る。
- 特に app の Native Assets 設定が外れると sqlite3 v3 の `sqlite3_initialize` を解決できない。
  `dart:ui` を使う package は `dart test` ではなく `flutter test`。
- `packages/eqmonitor_api` は同ディレクトリで `mise exec -- dart test`。backend の起動は不要。
- 成功メッセージと終了コード0を確認する。途中の package の成功だけで workspace 全体を合格にしない。

```sh
# app/ または対象 Flutter package 内
mise exec -- flutter test test/path_test.dart --dart-define=CI=true
# 純 Dart package 内
mise exec -- dart test test/path_test.dart
```

root からの CI 同等実行:

```sh
mise exec -- dart run melos exec --dir-exists=test --concurrency=4 \
  -- 'mise exec -- flutter test --dart-define=CI=true --file-reporter="json:test_report.log"'
```

Melos は workspace の固定版を `dart run melos` で使う。
`--` の後ろは1つの引用符付き文字列にする。分割すると内側の mise が Flutter flags を誤解釈する。
`melos run test` は現行では steps 形式だが、`test:dart` の `dependsOn: test` だけでは
Flutter 依存 package も選ばれる。明示的に分離する場合は root で次を使う。

```sh
mise exec -- dart run melos exec --depends-on=flutter_test --dir-exists=test --concurrency=1 \
  -- 'mise exec -- flutter test --dart-define=CI=true'
mise exec -- dart run melos exec --no-flutter --depends-on=test --dir-exists=test --concurrency=1 \
  -- 'mise exec -- dart test'
```

## 環境失敗を切り分ける

- `SourcePackages` の rsync 失敗は対象 package の `build/ios/SourcePackages` と
  `build/macos/SourcePackages` を作る。Linux の Native Assets コンパイル失敗は Clang を確認する。
- `impellerc failure: Could not write file` で古い `build/unit_test_assets` が残っている場合は、
  対象 package 内で `mise exec -- flutter clean` 後に同じテストを再実行する。
- `Disk quota exceeded` は空き領域と quota を確認する。他作業の一時ファイルを削除せず、
  空きのある領域へそのコマンドだけ `TMPDIR` を切り替える。例は対象 package 内で:

```sh
mkdir -p .dart_tool/test-temp
TMPDIR="$PWD/.dart_tool/test-temp" mise exec -- flutter test test/path_test.dart --dart-define=CI=true
```

- 複数 worktree は同一 Flutter SDK の startup lock を共有する。待機が長い場合は
  他の実行を破壊せず、単独実行と `--concurrency=1` で競合を切り分ける。
- 過去の「develop でも赤かった」という記録だけで失敗を免除しない。
  現在の base と同じ SDK・cwd・コマンドで再現し、対象差分と package ごとの結果を確認する。
  解析 server/plugin の異常終了も検証未完了として扱う。

## Widget テストの import と Provider

- app と同じ `package:material_ui/material_ui.dart` の `MaterialApp` / `ThemeData` を使う。
  Flutter 標準 Material と混ぜると `MaterialLocalizations` の型が別物になり、
  `showDialog` などが失敗する。pump の追加では直らない。
  既存の `DesignSystemThemeExtension` を設定する test helper を参考にする。
- UI 操作で引数が変わる family Provider は family 全体を override する。
  特定引数だけの override は検索条件変更で外れ、実 API を呼ぶことがある。
  現行 Riverpod の例: `earthquakeHistoryProvider.overrideWith2((_) => FakeNotifier())`。
  `build(parameter)` の引数を記録すると UI 操作による条件変更も検証できる。

## 一時 golden によるレイアウト確認

日本語フォントは `testWidgets` の fake async 内で実 I/O を await せず、
`TestWidgetsFlutterBinding.ensureInitialized()` 後の `setUpAll` で読み込む。
`FontLoader` は `package:flutter/services.dart`、`File` は `dart:io` を import する。

```dart
setUpAll(() async {
  final loader = FontLoader('NotoSansJP')
    ..addFont(Future.value(
      File('assets/fonts/NotoSansJP/NotoSansJP-Bold.ttf')
          .readAsBytesSync().buffer.asByteData(),
    ));
  await loader.load();
});
```

- テーマにも本番と同じ `fontFamilyFallback` を設定する。欧文フォントだけの日本語の □ は
  実機不具合とは限らない。MaterialIcons も読み込まなければ形状確認には使えない。
- app 内で `mise exec -- flutter test --update-goldens test/tmp_visual_test.dart` を実行する。
  `debugShowCheckedModeBanner: false` にし、確認専用のテストと PNG は作業後に削除する。

## Swift 共通ロジックの軽量確認

Widget の Foundation ベースの共有実装は `xcrun swiftc` に実装と検証用 Swift を渡して
コンパイル・実行できる（例: `app/ios/Shared/WidgetLayoutPolicy.swift`、`EarthquakeDetailURL.swift`）。
Runner 全体の Swift Package 解決を伴う `WidgetModelsTests` より軽量だが、
SwiftUI・entitlements・ターゲット統合の確認は対象 scheme の test/build で別途行う。
