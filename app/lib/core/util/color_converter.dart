import 'dart:ui';

import 'package:eqmonitor/feature/map/data/provider/map_style_util.dart';
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
  String toJson(Color color) {
    final hex = color.hex;
    return "#${hex.toRadixString(16).padLeft(6, '0')}";
  }
}
