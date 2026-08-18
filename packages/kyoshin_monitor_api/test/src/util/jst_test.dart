import 'package:kyoshin_monitor_api/kyoshin_monitor_api.dart';
import 'package:test/test.dart';

void main() {
  // 強震モニタ / 長周期地震動モニタの画像URLは JST の壁時計を要求する。
  // 端末のタイムゾーンに依存しないことを保証するため、絶対時刻 (UTC) を
  // 入力にして期待値を固定する。
  //
  // 以前は `latest_time` を端末ローカル時刻として誤って解釈し、URL生成側も
  // 端末ローカルで整形していたため、2つの誤差が偶然打ち消し合って動いていた。
  // NTP の絶対時刻から対象時刻を導出するとその相殺が消えるため、ここを
  // 明示的に JST 固定にしている。
  group('JstDateTimeX.toJst', () {
    test('UTCの絶対時刻をJSTの壁時計に変換する', () {
      final jst = DateTime.utc(2026, 8, 18, 15, 17, 30).toJst();
      expect(jst.year, 2026);
      expect(jst.month, 8);
      expect(jst.day, 19);
      expect(jst.hour, 0);
      expect(jst.minute, 17);
      expect(jst.second, 30);
    });

    test('オフセットは9時間', () {
      expect(Jst.offset, const Duration(hours: 9));
    });
  });

  group('KyoshinMonitorWebApiDataSource.formatDateTime', () {
    test('JSTのyyyyMMddHHmmssになる', () {
      expect(
        KyoshinMonitorWebApiDataSource.formatDateTime(
          DateTime.utc(2026, 8, 18, 15, 17, 30),
        ),
        '20260819001730',
      );
    });

    test('日付境界: UTC 15:00 は翌日のJST 00:00 として扱われる', () {
      final boundary = DateTime.utc(2026, 8, 18, 15);
      expect(
        KyoshinMonitorWebApiDataSource.formatDate(boundary),
        '20260819',
      );
      expect(
        KyoshinMonitorWebApiDataSource.formatDateTime(boundary),
        '20260819000000',
      );
    });

    test('ローカルタイムゾーンの DateTime でも同じ絶対時刻なら同じ文字列になる', () {
      final utc = DateTime.utc(2026, 8, 18, 15, 17, 30);
      expect(
        KyoshinMonitorWebApiDataSource.formatDateTime(utc.toLocal()),
        KyoshinMonitorWebApiDataSource.formatDateTime(utc),
      );
    });
  });
}
