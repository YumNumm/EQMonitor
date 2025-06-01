import 'package:collection/collection.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_color_map_model.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kyoshin_color_map.g.dart';

@Riverpod(keepAlive: true)
List<KyoshinColorMapModel> kyoshinColorMap(Ref ref) =>
    throw UnimplementedError();

extension IntensityToKyoshinColor on List<KyoshinColorMapModel> {
  Color intensityToColor(double intensity) {
    // intensity
    final lower = firstWhereOrNull((e) => e.intensity <= intensity);
    final upper = firstWhereOrNull((e) => e.intensity > intensity);
    if (lower == null || upper == null) {
      return Colors.transparent;
    }

    // color
    return Color.lerp(
      Color.fromRGBO(lower.r, lower.g, lower.b, 255),
      Color.fromRGBO(upper.r, upper.g, upper.b, 255),
      (intensity - lower.intensity) / (upper.intensity - lower.intensity),
    )!;
  }
}
