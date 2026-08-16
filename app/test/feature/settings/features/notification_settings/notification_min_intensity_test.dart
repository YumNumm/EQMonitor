import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_min_intensity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('minIntensityLabel', () {
    test('震度0 は「すべて」', () {
      expect(JmaIntensity.zero.minIntensityLabel, 'すべて');
      expect(JmaIntensity.zero.minIntensityThresholdLabel, 'すべて');
    });

    test('震度1以上は数値ラベル', () {
      expect(JmaIntensity.four.minIntensityLabel, '震度4');
      expect(JmaIntensity.one.minIntensityThresholdLabel, '震度1以上');
    });
  });

  group('current location defaults', () {
    test('予報は震度4、地震情報は震度1', () {
      expect(currentLocationEewMinIntensity, JmaIntensity.four);
      expect(currentLocationEarthquakeMinIntensity, JmaIntensity.one);
    });
  });
}
