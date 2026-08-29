# Asia/Tokyo Time Display Design

## Goal

EQMonitor の通常画面、デバッグ画面、診断情報に表示される絶対時刻を、
端末のタイムゾーンに依存せず `Asia/Tokyo` で表示する。

## Scope

- Flutter app 内で `DateTime` または `TZDateTime` が表す絶対時刻の表示
- 日時から導出する現在年などの表示
- デバッグ用の編集フィールドと診断情報に表示する ISO 8601 文字列
- 既に `Asia/Tokyo` へ変換している NIED 画面を含む表示経路の共通化

期間フィルターでユーザーが選択した日付など、絶対時刻ではなく暦日を表す値は
タイムゾーン変換しない。経過時間、所要時間、時刻を含まない識別子や API パスの
フォーマットも対象外とする。

## Architecture

表示境界に共通 API を置き、Domain/Data 層のモデル型は変更しない。
既存の `DateTime` を保存、比較、API 送受信する処理は維持し、文字列へ変換する直前に
`timezone` package の `TZDateTime.from` で `Asia/Tokyo` へ変換する。

共通 API は `app/lib/core/util/date_time_format.dart` に配置する。

```dart
enum DateTimeFormat(final String pattern) {
  hourMinute('HH:mm'),
  hourMinuteSecond('HH:mm:ss'),
  monthDayHourMinute('MM/dd HH:mm'),
  yearMonthDayHourMinute('yyyy/MM/dd HH:mm'),
  yearMonthDayHourMinuteSecond('yyyy/MM/dd HH:mm:ss'),
  ;
}

extension DateTimeFormatting on DateTime {
  String formatWithTz(DateTimeFormat format);

  tz.TZDateTime get tokyoDateTime;
}
```

`DateTimeFormat` は Primary Constructor でパターンを保持する。
enum のコンストラクターは暗黙に const であり、非 const の `DateFormat` を enum 値へ
直接渡せないため、enum 内の静的リストで全 `DateFormat` を一度だけ生成し、enum の
`index` で参照する。null assertion は使用しない。

## Format Catalogue

現在の表示を維持するため、実際に使われている以下の形式を enum に集約する。

- `yyyy/MM/dd`
- `yyyy年MM月dd日`
- `MM/dd`
- `HH:mm`
- `HH:mm:ss`
- `MM/dd HH:mm`
- `MM/dd HH:mm:ss`
- `yyyy/MM/dd HH:mm`
- `yyyy年MM月dd日 HH:mm`
- `yyyy/MM/dd HH:mm:ss`
- `yyyy-MM-dd HH:mm:ss`
- `yyyy/MM/dd HH:mm:ss.SSS`

「頃」「発表」「JST」などの画面固有文言はパターンへ含めず、呼び出し側で付加する。

## Data Flow

1. Repository や Notifier から既存の `DateTime` / `TZDateTime` を受け取る。
2. UI または表示文字列 builder が `formatWithTz` を呼ぶ。
3. extension が値と同じ瞬間を表す Tokyo の `TZDateTime` を生成する。
4. enum が保持する `DateFormat` で既存の表示形式へ変換する。

ISO 8601 を表示する箇所は `tokyoDateTime.toIso8601String()` を使い、Tokyo の
UTC オフセットを含む文字列を表示する。編集後のパースでも同じ瞬間が保たれることを
確認する。

## Error Handling

`Asia/Tokyo` の timezone database はアプリ起動時に既存の
`initializeTimeZones()` で初期化される。初期化されていない場合に固定値や端末 local
へフォールバックせず、既存と同様にプログラミングエラーとして検出可能な状態を保つ。

## Migration

- UI の `DateFormat(...).format(dateTime)` を `dateTime.formatWithTz(...)` へ変更する。
- UI の `.toLocal()` を Tokyo 変換 API に置き換える。
- 既に NIED 画面で直接行っている `TZDateTime.from(..., Asia/Tokyo)` を共通 API へ寄せる。
- デバッグ編集画面と診断情報の `toIso8601String()` を Tokyo の値から生成する。
- 暦日、期間、日時の比較、API リクエスト値、JSON シリアライズは変更しない。

## Testing

共通 API の単体テストで以下を確認する。

- UTC 15:00 が Tokyo の翌日 00:00 になる日付境界
- UTC と端末 local が同じ瞬間なら同じ文字列になること
- Tokyo 以外の `TZDateTime` が Tokyo 表示へ変換されること
- 秒、ミリ秒、日本語年月日を含む enum の代表的な形式
- enum の全値が対応するキャッシュ済み `DateFormat` を持つこと
- Tokyo の ISO 8601 表示が UTC オフセットを含むこと

日時文字列を組み立てる既存ロジックの関連単体テストを更新する。表示文言だけを変更する
Widget には一律で Widget Test を追加せず、関連既存テストと静的解析で回帰確認する。

Flutter app 全体の基準テストには、変更前から SQLite native asset 解決失敗と WebView
Widget Test の期待不一致がある。今回追加・更新する対象テストは個別に実行し、全体テストの
既存失敗とは分けて結果を報告する。
