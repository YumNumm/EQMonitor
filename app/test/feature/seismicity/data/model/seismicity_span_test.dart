import 'package:eqmonitor/feature/seismicity/data/model/seismicity_span.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('SeismicitySpan は API 文字列と対応する', () {
    expect(seismicitySpanFromApiValue('P1M'), SeismicitySpan.p1m);
    expect(seismicitySpanFromApiValue('P3M'), SeismicitySpan.p3m);
    expect(seismicitySpanFromApiValue('P12M'), SeismicitySpan.p12m);
  });

  test('未知の span 文字列は FormatException', () {
    expect(() => seismicitySpanFromApiValue('P6M'), throwsFormatException);
  });
}
