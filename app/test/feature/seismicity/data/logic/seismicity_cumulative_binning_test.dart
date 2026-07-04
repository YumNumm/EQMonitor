import 'package:eqmonitor/feature/seismicity/data/logic/seismicity_cumulative_binning.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_event.dart';
import 'package:flutter_test/flutter_test.dart';

SeismicityEvent _event(DateTime originTime) => SeismicityEvent(
  eventId: originTime.toIso8601String(),
  originTime: originTime,
  magnitude: 3,
  depth: 10,
  latitude: 35,
  longitude: 139,
  maxIntensity: null,
);

void main() {
  test('日別件数と積算件数を計算する(欠測日も0件で補完)', () {
    const binning = SeismicityCumulativeBinning();
    final events = [
      _event(DateTime.utc(2026, 1, 1, 1)),
      _event(DateTime.utc(2026, 1, 1, 23)),
      _event(DateTime.utc(2026, 1, 3, 0)),
    ];

    final bins = binning.bin(events);

    expect(bins.length, 3);
    expect(bins[0].date, DateTime.utc(2026, 1, 1));
    expect(bins[0].count, 2);
    expect(bins[0].cumulativeCount, 2);
    expect(bins[1].date, DateTime.utc(2026, 1, 2));
    expect(bins[1].count, 0);
    expect(bins[1].cumulativeCount, 2);
    expect(bins[2].date, DateTime.utc(2026, 1, 3));
    expect(bins[2].count, 1);
    expect(bins[2].cumulativeCount, 3);
  });

  test('空リストは空を返す', () {
    const binning = SeismicityCumulativeBinning();
    expect(binning.bin(const []), isEmpty);
  });
}
