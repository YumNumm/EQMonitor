import 'package:eqmonitor/core/theme/model/intensity_text_color.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('IntensityTextColor', () {
    test('auto のJSON往復', () {
      const original = IntensityTextColor.auto();
      final json = original.toJson();
      expect(json, {'type': 'auto'});
      final restored = IntensityTextColor.fromJson(json);
      expect(restored, original);
    });

    test('manual のJSON往復', () {
      const original = IntensityTextColor.manual(color: Color(0xFF333333));
      final json = original.toJson();
      expect(json['type'], 'manual');
      final restored = IntensityTextColor.fromJson(json);
      expect(restored, isA<IntensityTextColorManual>());
    });
  });
}
