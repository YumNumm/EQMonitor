import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_level_parser.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('5段階のcanonical levelを厳密に変換すること', () {
    expect('Weaker'.toShakeDetectionLevel(), ShakeDetectionLevel.weaker);
    expect('Weak'.toShakeDetectionLevel(), ShakeDetectionLevel.weak);
    expect('Medium'.toShakeDetectionLevel(), ShakeDetectionLevel.medium);
    expect('Strong'.toShakeDetectionLevel(), ShakeDetectionLevel.strong);
    expect('Stronger'.toShakeDetectionLevel(), ShakeDetectionLevel.stronger);
  });

  test('未知levelを固定値へフォールバックしないこと', () {
    expect(
      () => 'Unknown'.toShakeDetectionLevel(),
      throwsA(isA<FormatException>()),
    );
  });
}
