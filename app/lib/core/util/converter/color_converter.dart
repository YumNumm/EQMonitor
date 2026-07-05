import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class ColorJsonConverter implements JsonConverter<Color, String> {
  const ColorJsonConverter();

  @override
  Color fromJson(String json) {
    // 16進数カラーコード（例: #FF0000FF または 0xFF0000FF）をColorに変換
    if (json.startsWith('#')) {
      // #AARRGGBB または #RRGGBBAA の場合
      final hex = json.substring(1);
      if (hex.length == 8) {
        // #AARRGGBB
        return Color(int.parse(hex, radix: 16));
      } else if (hex.length == 6) {
        // #RRGGBB → #FFRRGGBB
        return Color(int.parse('FF$hex', radix: 16));
      }
    } else if (json.startsWith('0x')) {
      // 0xAARRGGBB
      return Color(int.parse(json));
    }
    throw FormatException('Invalid color format: $json');
  }

  @override
  String toJson(Color color) {
    final argb = color.toARGB32();
    final alpha = (argb >> 24) & 0xFF;
    if (alpha == 0xFF) {
      // 不透明な場合は #RRGGBB 形式で出力
      final rgb = argb & 0xFFFFFF;
      return '#${rgb.toRadixString(16).padLeft(6, '0').toUpperCase()}';
    }
    // 半透明な場合は #AARRGGBB 形式で出力
    return '#${argb.toRadixString(16).padLeft(8, '0').toUpperCase()}';
  }
}

extension ColorExtension on Color {
  /// RGB値を16進数文字列（#RRGGBB）として返します
  String toHexStringRGB() {
    final r = (this.r * 255.0).round() & 0xff;
    final g = (this.g * 255.0).round() & 0xff;
    final b = (this.b * 255.0).round() & 0xff;
    return '#${(r << 16 | g << 8 | b).toRadixString(16).padLeft(6, '0').toUpperCase()}';
  }
}
