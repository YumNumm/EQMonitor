import 'package:eqmonitor/feature/seismicity/ui/layer/seismicity_epicenter_layer.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SeismicityEpicenterLayer.elapsedHours', () {
    test('originTime から now までの経過時間を時間単位で返す', () {
      final now = DateTime.utc(2026, 7, 4, 12);
      final originTime = DateTime.utc(2026, 7, 1, 12);

      final result = SeismicityEpicenterLayer.elapsedHours(
        originTime: originTime,
        now: now,
      );

      expect(result, 72.0);
    });

    test('ローカルタイムの originTime/now も UTC 換算で計算する', () {
      final now = DateTime.utc(2026, 7, 4).toLocal();
      final originTime = DateTime.utc(2026, 7, 3).toLocal();

      final result = SeismicityEpicenterLayer.elapsedHours(
        originTime: originTime,
        now: now,
      );

      expect(result, 24.0);
    });

    test('now が更新されると経過時間も増加する(定期更新の前提)', () {
      final originTime = DateTime.utc(2026, 7, 1);

      final earlier = SeismicityEpicenterLayer.elapsedHours(
        originTime: originTime,
        now: DateTime.utc(2026, 7, 2),
      );
      final later = SeismicityEpicenterLayer.elapsedHours(
        originTime: originTime,
        now: DateTime.utc(2026, 7, 3),
      );

      expect(later, greaterThan(earlier));
    });
  });
}
