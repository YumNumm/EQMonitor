import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/feature/map/features/icon/data/model/intensity_icon.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class JmaLpgmIntensityIcon extends ConsumerWidget {
  const JmaLpgmIntensityIcon({
    required this.intensity,
    required this.type,
    this.customText,
    super.key,
    this.size = 50,
  });

  final JmaLpgmIntensity intensity;
  final IntensityIconType type;
  final double size;
  final String? customText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final intensityColorModel = ref.watch(intensityColorProvider);
    final colorScheme = intensityColorModel.fromJmaLpgmIntensity(intensity);
    final (fg, bg) = (colorScheme.foreground, colorScheme.background);

    final borderColor = Color.lerp(bg, fg, 0.3) ?? bg;
    return switch (type) {
      .small => SizedBox(
        height: size,
        width: size,
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: .circle,
            color: bg,
            border: .all(
              color: borderColor,
              width: 5,
            ),
          ),
          child: Center(
            child: FittedBox(
              fit: .scaleDown,
              child: Row(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    intensity.label,
                    style: TextStyle(
                      color: fg,
                      fontSize: 100,
                      fontWeight: .bold,
                      fontFamily: FontFamily.notoSansMono,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      .smallWithoutText => SizedBox(
        height: size,
        width: size,
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: .circle,
            color: bg,
            border: Border.all(
              color: borderColor,
              width: 5,
            ),
          ),
        ),
      ),
      .filled => SizedBox(
        height: size,
        width: size,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: bg,
            // 角丸にする
            borderRadius: .circular(
              size / 5,
            ),
          ),
          child: Center(
            child: FittedBox(
              fit: .scaleDown,
              child: (customText != null)
                  ? Text(
                      customText!,
                      style: TextStyle(
                        color: fg,
                        fontSize: 100,
                        fontWeight: .bold,
                        fontFamily: FontFamily.notoSansMono,
                      ),
                    )
                  : Text(
                      intensity.label,
                      style: TextStyle(
                        color: fg,
                        fontSize: 100,
                        fontWeight: .bold,
                        fontFamily: FontFamily.notoSansMono,
                      ),
                    ),
            ),
          ),
        ),
      ),
    };
  }
}
