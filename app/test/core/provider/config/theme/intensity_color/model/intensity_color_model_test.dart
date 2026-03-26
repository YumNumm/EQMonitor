import 'dart:ui';

import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('IntensityColorModelExt', () {
    test('copyWithTargetBackgroundは対象震度の色のみ更新する', () {
      final model = IntensityColorModel.eqmonitor();
      const nextColor = Color(0xFF112233);

      final updated = model.copyWithTargetBackground(
        IntensityColorTarget.fiveUpper,
        nextColor,
      );

      expect(updated.fiveUpper.background, nextColor);
      expect(updated.four, model.four);
      expect(updated.sixLower, model.sixLower);
    });

    test('colorToJson/colorFromJsonでround-tripできる', () {
      const color = Color(0xFFABCDEF);
      final serialized = colorToJson(color);
      final deserialized = colorFromJson(serialized);

      expect(deserialized, color);
    });
  });
}
