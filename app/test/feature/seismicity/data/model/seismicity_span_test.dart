import 'package:eqmonitor/feature/seismicity/data/model/seismicity_span.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('SeismicitySpan は API 文字列と対応する', () {
    expect(SeismicitySpanApiValue.fromApiValue('P1M'), SeismicitySpan.p1m);
    expect(SeismicitySpanApiValue.fromApiValue('P3M'), SeismicitySpan.p3m);
    expect(SeismicitySpanApiValue.fromApiValue('P12M'), SeismicitySpan.p12m);
  });

  test('未知の span 文字列は FormatException', () {
    expect(
      () => SeismicitySpanApiValue.fromApiValue('P6M'),
      throwsFormatException,
    );
  });
}
