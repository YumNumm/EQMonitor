import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';

class ColorConverter implements JsonConverter<Color, String> {
  const ColorConverter();

  @override
  Color fromJson(String value) {
    final hex = value.replaceFirst('#', '');
    final r = int.parse(hex.substring(0, 2), radix: 16);
    final g = int.parse(hex.substring(2, 4), radix: 16);
    final b = int.parse(hex.substring(4, 6), radix: 16);
    return Color.fromARGB(255, r, g, b);
  }

  @override
  String toJson(Color color) => color.toHexStringRGB();
}

extension ColorExtension on Color {
  /// Convert the color to a hex string in RGB format.
  String toHexStringRGB() {
    final r = ((this.r * 255.0).round() & 0xff).toRadixString(16).padLeft(2, '0');
    final g = ((this.g * 255.0).round() & 0xff).toRadixString(16).padLeft(2, '0');
    final b = ((this.b * 255.0).round() & 0xff).toRadixString(16).padLeft(2, '0');
    return '#$r$g$b';
  }
}
