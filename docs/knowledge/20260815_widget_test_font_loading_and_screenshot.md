---
globs: app/test/**/*.dart
---

# Widget テストでのフォント読み込みとレイアウト目視確認

## `FontLoader` を `testWidgets` の中で await するとハングする

`testWidgets` のボディは FakeAsync ゾーンで動くため、`File.readAsBytes()` のような
**実 I/O の Future が完了せず、`FontLoader.load()` の await で永久に止まる**
（タイムアウトまでテストが返らない）。

```dart
// ❌ testWidgets の中で実 I/O を await → ハングする
testWidgets('...', (tester) async {
  final loader = FontLoader('NotoSansJP')
    ..addFont(File(path).readAsBytes().then((b) => b.buffer.asByteData()));
  await loader.load();
});

// ✅ setUpAll（FakeAsync 外）で読み込む。バイト列は同期読みにしておく
void main() {
  setUpAll(() async {
    final loader = FontLoader('NotoSansJP')
      ..addFont(
        Future.value(File(path).readAsBytesSync().buffer.asByteData()),
      );
    await loader.load();
  });
}
```

`FontLoader` は `package:flutter/services.dart` にある。このリポジトリの UI は
`package:material_ui/material_ui.dart` を import しているため、テストでは
`package:flutter/services.dart` を明示的に import する必要がある。

## レイアウトを画像で確認する（golden をコミットせずに使う）

余白やデザインの調整では、一時的な golden テストで PNG を書き出して目視確認できる。

```bash
cd app
mise exec flutter -- flutter test --update-goldens test/tmp_visual_test.dart
# → test/tmp_visual_test.png が生成される。確認後、テストと PNG は削除する
```

注意点:

- `flutter test` は `--use-test-fonts --disable-asset-fonts` で動くため、
  上記のフォント読み込みをしないと日本語は □ になる。
- MaterialIcons もアセットフォント扱いのため、アイコンは □ のまま描画される。
  アイコン形状の確認には向かず、余白・整列の確認用途に限る。
- `MaterialApp(debugShowCheckedModeBanner: false)` にしないと右上に DEBUG リボンが写る。
- リポジトリに golden 運用は無いので、確認用のテストと PNG は**必ず削除する**。

## `mise exec` はツールを絞って使う

`mise exec -- <cmd>` は `mise.toml` の全ツールを解決しようとし、Linux 環境では
`swift` のインストールに失敗してコマンド自体が実行できない。Flutter / Dart を使うときは
ツールを明示する。

```bash
mise exec flutter -- flutter test
mise exec flutter -- dart analyze lib
```
