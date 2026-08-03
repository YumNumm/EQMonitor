import 'package:eqmonitor/feature/shake_detection/data/logic/shake_detection_debug_preset_factory.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('東京プリセットへ観測点の地域コードを設定する', () {
    const factory = ShakeDetectionDebugPresetFactory();

    final event = factory.create(
      id: ShakeDetectionDebugPresetId.tokyoMultiLevelGrid,
      now: DateTime.utc(2026),
    );

    expect(event.points, isNotEmpty);
    expect(
      event.points.map((point) => point.prefectureCode),
      everyElement('13'),
    );
    expect(event.points.map((point) => point.regionCode), everyElement('350'));
    expect(event.points.map((point) => point.cityCode), everyElement(isNull));
  });
}
