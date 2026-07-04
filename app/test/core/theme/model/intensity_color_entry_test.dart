import 'package:eqmonitor/core/theme/model/intensity_color_entry.dart';
import 'package:eqmonitor/core/theme/model/intensity_text_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('IntensityColorEntry.resolvedForeground', () {
    test('auto + 明るい背景 → 黒', () {
      const entry = IntensityColorEntry(
        background: Color(0xFFFFFFFF),
        foreground: IntensityTextColor.auto(),
      );
      expect(entry.resolvedForeground, Colors.black);
    });

    test('auto + 暗い背景 → 白', () {
      const entry = IntensityColorEntry(
        background: Color(0xFF000000),
        foreground: IntensityTextColor.auto(),
      );
      expect(entry.resolvedForeground, Colors.white);
    });

    test('manual → 指定色', () {
      const entry = IntensityColorEntry(
        background: Color(0xFFFFFFFF),
        foreground: IntensityTextColor.manual(color: Color(0xFF333333)),
      );
      expect(entry.resolvedForeground, const Color(0xFF333333));
    });
  });
}
