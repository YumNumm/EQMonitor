# バグ修正・クリーンアップ

## 背景

コードベース調査で見つかった小規模なバグ・不要コードをまとめた。

---

## 1. QZSS ストリーム購読のリーク修正

**ファイル:** `app/lib/feature/qzss_dcr/data/provider/qzss_serial_port_provider.dart:92`

**問題:**  
`LatestQzssDcReport.build()` 内で `stream.listen()` を呼び出しているが、返された `StreamSubscription` を保持していない。`qzssSerialPortConnectionProvider` が変化するたびに `build()` が再実行され、前の購読がキャンセルされないまま新しい購読が積み重なるメモリ・イベントリーク。

**修正方針:**  
`ref.onDispose` で購読をキャンセルする。

```dart
final subscription = stream.listen((report) {
  state = report;
});
ref.onDispose(subscription.cancel);
```

---

## 2. 無意味な try-catch-rethrow の削除

**ファイル:** `packages/nied_api_client/lib/src/hinet/aqua/parser/aqua_html_parser.dart:37-44`

**問題:**  
```dart
try {
  final event = _parseTableRow(row);
  if (event != null) {
    events.add(event);
  }
} catch (e) {
  rethrow;
}
```
`catch { rethrow }` は例外を一切加工せず再スローするだけで、`try` を書かないのと等価。不要なボイラープレート。

**修正方針:**  
`try-catch` ブロックを取り除き、直接 `final event = _parseTableRow(row);` を呼ぶ。

---

## 3. デバッグ用 `print` の除去

**ファイル:** `app/lib/feature/settings/children/config/debug/jma_map/debug_jma_map_page.dart:92-94`

**問題:**  
```dart
print(
  '${selectedMapType.value} time: ${stopWatch.elapsedMicroseconds / 1000}ms',
);
```
デバッグ設定ページとはいえ `print` はリリースビルドでも出力されるため `talker.debug()` または `debugPrint()` に差し替えるべき。

**修正方針:**  
`print(...)` → `talker.debug(...)` に置き換える（`talker` インスタンスは同ファイル内で既に利用可）。

---

## 参照

- `app/lib/feature/qzss_dcr/data/provider/qzss_serial_port_provider.dart`
- `packages/nied_api_client/lib/src/hinet/aqua/parser/aqua_html_parser.dart`
- `app/lib/feature/settings/children/config/debug/jma_map/debug_jma_map_page.dart`
