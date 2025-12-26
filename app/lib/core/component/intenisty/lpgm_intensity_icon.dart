import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/component/intenisty/intensity_icon_type.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LpgmIntensityIcon extends ConsumerWidget {
  const LpgmIntensityIcon({
    required this.intensity,
    required this.type,
    this.customText,
    super.key,
    this.size = 50,
  });

  final LpgmIntensityValue intensity;
  final IntensityIconType type;
  final double size;
  final String? customText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final intensityColorModel = ref.watch(intensityColorProvider);
    final colorScheme = intensityColorModel.fromLpgmIntensityValue(intensity);
    final (fg, bg) = (colorScheme.foreground, colorScheme.background);

    final borderColor = Color.lerp(bg, fg, 0.3)!;
    return switch (type) {
      IntensityIconType.small => SizedBox(
          height: size,
          width: size,
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: bg,
              border: Border.all(color: borderColor, width: 5),
            ),
            child: Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      intensity.value,
                      style: TextStyle(
                        color: fg,
                        fontSize: 100,
                        fontWeight: FontWeight.w900,
                        fontFamily: FontFamily.jetBrainsMono,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      IntensityIconType.smallWithoutText => SizedBox(
          height: size,
          width: size,
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: bg,
              border: Border.all(color: borderColor, width: 5),
            ),
          ),
        ),
      IntensityIconType.filled => SizedBox(
          height: size,
          width: size,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(size / 5),
            ),
            child: Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: (customText != null)
                    ? Text(
                        customText!,
                        style: TextStyle(
                          color: fg,
                          fontSize: 100,
                          fontWeight: FontWeight.w900,
                          fontFamily: FontFamily.jetBrainsMono,
                        ),
                      )
                    : Text(
                        intensity.value,
                        style: TextStyle(
                          color: fg,
                          fontSize: 100,
                          fontWeight: FontWeight.w900,
                          fontFamily: FontFamily.jetBrainsMono,
                        ),
                      ),
              ),
            ),
          ),
        ),
    };
  }
}
