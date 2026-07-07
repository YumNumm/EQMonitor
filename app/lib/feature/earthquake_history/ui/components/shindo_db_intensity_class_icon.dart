import 'package:eqmonitor/core/component/intenisty/jma_intensity_icon.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/core/theme/model/intensity_colors.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/shindo_db_intensity_class.dart';
import 'package:eqmonitor/feature/map/features/icon/data/model/intensity_icon.dart';
import 'package:flutter/material.dart';

class ShindoDbIntensityClassIcon extends StatelessWidget {
  const ShindoDbIntensityClassIcon({
    required this.intensityClass,
    this.size = 40,
    super.key,
  });

  final ShindoDbIntensityClass intensityClass;
  final double size;

  @override
  Widget build(BuildContext context) {
    final exact = intensityClass.exactJmaIntensity;
    if (exact != null) {
      return JmaIntensityIcon(
        intensity: exact,
        type: IntensityIconType.filled,
        size: size,
      );
    }

    final colorJma = intensityClass.colorJmaIntensity;
    if (colorJma != null) {
      final entry = context.designSystem.colorTheme.intensity.fromJmaIntensity(
        colorJma,
      );
      return SizedBox(
        width: size,
        height: size,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: entry.background,
            borderRadius: BorderRadius.circular(size * 0.25),
          ),
          child: Center(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                intensityClass.label,
                style: TextStyle(
                  color: entry.resolvedForeground,
                  fontSize: size,
                  fontWeight: FontWeight.bold,
                  fontFamily: FontFamily.googleSansCode,
                  fontFamilyFallback: const [FontFamily.notoSansJP],
                ),
              ),
            ),
          ),
        ),
      );
    }

    // Historical grades — gray
    return SizedBox(
      width: size,
      height: size,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.designSystem.colorTheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(size * 0.25),
        ),
        child: Center(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              intensityClass.label,
              style: TextStyle(
                color: context.designSystem.colorTheme.onSurface,
                fontSize: size,
                fontWeight: FontWeight.bold,
                fontFamily: FontFamily.googleSansCode,
                fontFamilyFallback: const [FontFamily.notoSansJP],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
