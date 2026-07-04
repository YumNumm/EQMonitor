import 'package:eqmonitor/core/util/converter/color_converter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const converter = ColorJsonConverter();

  group('ColorJsonConverter.toJson', () {
    test('不透明な色は #RRGGBB 形式で出力する', () {
      const color = Color(0xFF03B5FF);
      expect(converter.toJson(color), '#03B5FF');
    });

    test('半透明な色は #AARRGGBB 形式で出力する', () {
      const color = Color(0x8003B5FF);
      expect(converter.toJson(color), '#8003B5FF');
    });

    test('透明 (alpha=0) な色は #AARRGGBB 形式で出力する', () {
      const color = Color(0x0003B5FF);
      expect(converter.toJson(color), '#0003B5FF');
    });
  });

  group('ColorJsonConverter.fromJson', () {
    test('#RRGGBB 形式を不透明な色として解釈する', () {
      final color = converter.fromJson('#03B5FF');
      expect(color.toARGB32(), 0xFF03B5FF);
    });

    test('#AARRGGBB 形式をそのまま解釈する', () {
      final color = converter.fromJson('#8003B5FF');
      expect(color.toARGB32(), 0x8003B5FF);
    });

    test('0xAARRGGBB 形式を解釈する', () {
      final color = converter.fromJson('0xFF03B5FF');
      expect(color.toARGB32(), 0xFF03B5FF);
    });

    test('不正な形式は FormatException を投げる', () {
      expect(() => converter.fromJson('not-a-color'), throwsFormatException);
    });
  });

  group('ColorJsonConverter ラウンドトリップ', () {
    test('不透明な色は toJson → fromJson で同じ色に戻る', () {
      const color = Color(0xFF123456);
      final json = converter.toJson(color);
      expect(json, '#123456');
      final decoded = converter.fromJson(json);
      expect(decoded.toARGB32(), color.toARGB32());
    });

    test('半透明な色は toJson → fromJson で同じ色に戻る', () {
      const color = Color(0x80ABCDEF);
      final json = converter.toJson(color);
      expect(json, '#80ABCDEF');
      final decoded = converter.fromJson(json);
      expect(decoded.toARGB32(), color.toARGB32());
    });
  });
}
