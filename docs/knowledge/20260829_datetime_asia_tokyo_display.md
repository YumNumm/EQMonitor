# 日時表示をAsia/Tokyoへ統一する際のルール

- 画面や診断テキストへ日時を出す場合は、`DateTime.formatWithTz(DateTimeFormat)` を使う。
- ISO 8601形式を維持する必要がある編集画面では、`DateTime.tokyoDateTime` へ変換してから出力する。
- `DateTimeFormat` enumが`DateFormat`をキャッシュするため、表示側で`DateFormat`を生成しない。
- アプリ起動時は`core.initializeTimeZones()`を完了してから日時表示を構築する。
- Flutterテストでは`app/test/flutter_test_config.dart`でtimezone DBを共通初期化する。
- API送信、永続化、識別子、検索条件の日付は表示処理ではないため、用途に応じた既存形式を維持する。

```bash
mise exec -- flutter test app/test/core/util/date_time_format_test.dart
mise exec -- flutter analyze app
```
