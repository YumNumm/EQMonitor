import 'package:eqmonitor/feature/home/data/model/home_map_label_parameter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('disables both home map labels by default', () {
    const parameter = HomeMapLabelParameter();

    expect(parameter.showRegionLabel, isFalse);
    expect(parameter.showCityLabel, isFalse);
    expect(parameter.regionLabelMinZoom, 5.0);
    expect(parameter.cityLabelMinZoom, 9.0);
  });
}
