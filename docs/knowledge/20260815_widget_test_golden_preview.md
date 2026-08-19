# Widget の見た目を golden で目視確認する（日本語フォント読み込み）

UI 変更のレビュー時、`flutter test --update-goldens` で PNG を書き出すと
実機を起動せずにレイアウトを目視確認できる。日本語を含む Widget では
フォント読み込みの手順を誤ると必ずハマるため、以下を守る。

## フォント読み込みは `setUpAll` で行う

`testWidgets` のボディは fake async ゾーンで実行されるため、
`File.readAsBytes()` のような実 I/O の `Future` は完了せず、
`await FontLoader.load()` がテストタイムアウト（既定 10 分）まで停止する。

```dart
Future<void> loadFonts() async {
  final loader = FontLoader('NotoSansJP')
    ..addFont(
      File('assets/fonts/NotoSansJP/NotoSansJP-Bold.ttf')
          .readAsBytes()
          .then((b) => b.buffer.asByteData()),
    );
  await loader.load();
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(loadFonts); // ✅ testWidgets の中で await しない
  ...
}
```

パスは package ルート（`app/`）からの相対パスで解決される。

## テーマの fontFamilyFallback も再現する

アプリ本体は `NotoSansJP` を fallback に持つテーマを使っている。
テストで `ThemeData.dark()` を素で使うと、`GoogleSansCode` / `GoogleSansFlex`
（いずれも欧文フォント）が当たった日本語が豆腐（□）で描画される。
豆腐が出ても実機の不具合とは限らないため、確認したい文字列に対して
適切な fontFamilyFallback を設定したテーマを組むこと。

## 確認コマンド

```bash
cd app
flutter test --update-goldens test/tmp_visual_preview_test.dart
```

確認用のプレビューテストと生成された PNG はコミットしない。
