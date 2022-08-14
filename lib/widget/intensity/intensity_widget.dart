import 'package:eqmonitor/const/kmoni/jma_intensity.dart';
import 'package:flutter/material.dart';

import '../../extension/relative_luminance.dart';

class IntensityWidget extends StatelessWidget {
  const IntensityWidget({
    super.key,
    required this.intensity,
    required this.size,
    this.opacity = 0,
    this.isTextColorByBackground = false,
  });
  final JmaIntensity intensity;
  final double size;
  final double opacity;

  /// 文字色を背景に合わせるかどうか
  /// しない場合は指定しない。
  final bool isTextColorByBackground;

  @override
  Widget build(BuildContext context) {
    final intensityColor = intensity.color.withOpacity(opacity);
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
