import 'package:eqmonitor/provider/setting/intensity_color_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../const/kmoni/jma_intensity.dart';
import '../../extension/relative_luminance.dart';

class IntensityWidget extends ConsumerWidget {
  const IntensityWidget({
    super.key,
    required this.intensity,
    required this.size,
    this.opacity = 0,
    this.isTextColorByBackground = true,
    this.color,
  });
  final JmaIntensity intensity;
  final double size;
  final double opacity;
  final Color? color;

  /// 文字色を背景に合わせるかどうか
  /// しない場合は指定しない。
  final bool isTextColorByBackground;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final intensityColor = color ??
        intensity
            .fromUser(ref.read(jmaIntensityColorProvider))
            .withOpacity(opacity);
    final textColor = isTextColorByBackground ? intensityColor.onPrimary : null;
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: size,
        height: size,
        color: intensityColor,
        child: Center(
          child: Text(
            intensity.name,
            style: TextStyle(
              fontSize: size * 0.8,
              color: textColor,
              fontFamily: 'CaskaydiaCove',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
