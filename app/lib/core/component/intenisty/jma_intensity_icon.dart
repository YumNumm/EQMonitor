import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/feature/map/features/icon/data/model/intensity_icon.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class JmaIntensityIcon extends ConsumerWidget {
  const JmaIntensityIcon({
    required this.intensity,
    required this.type,
    this.customText,
    super.key,
    this.size = 50,
    this.showSuffix = true,
  });

  final JmaIntensity intensity;
  final IntensityIconType type;
  final double size;
  final String? customText;
  final bool showSuffix;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final intensityColorModel = ref.watch(intensityColorProvider);
    final colorScheme = intensityColorModel.fromJmaIntensity(intensity);
    final (fg, bg) = (colorScheme.foreground, colorScheme.background);
    final intensityMainText = intensity.mainText;
    final suffix = intensity.label.contains('-')
        ? '-'
        : intensity.label.contains('+')
        ? '+'
        : '';
    final intensitySubText = intensity.suffix;
    final borderColor = Color.lerp(bg, fg, 0.3)!;
    return switch (type) {
      .small => SizedBox(
        height: size,
        width: size,
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: .circle,
            color: bg,
            border: Border.all(color: borderColor, width: 5),
          ),
          child: (intensity == .fiveUnknown)
              ? const SizedBox.shrink()
              : Center(
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: FittedBox(
                      fit: .scaleDown,
                      child: Row(
                        crossAxisAlignment: .start,
                        children: [
                          Text(
                            intensityMainText,
                            style: TextStyle(
                              color: fg,
                              fontSize: 100,
                              fontWeight: .bold,
                              fontFamily: FontFamily.googleSansCode,
                            ),
                          ),
                          Text(
                            suffix,
                            style: TextStyle(
                              color: fg,
                              fontSize: 80,
                              fontFamily: FontFamily.googleSansCode,
                              fontFamilyFallback: const [
                                FontFamily.notoSansJP,
                              ],
                            ),
                          ),
                        ],
                      ),
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
            shape: BoxShape.circle,
            color: bg,
            border: Border.all(color: borderColor, width: 5),
          ),
        ),
      ),
      .filled => SizedBox(
        height: size,
        width: size,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(size / 5),
          ),
          child: Center(
            child: FittedBox(
              fit: .scaleDown,
              child: Row(
                crossAxisAlignment: .baseline,
                textBaseline: .alphabetic,
                children: [
                  if (customText != null)
                    Text(
                      customText!,
                      style: TextStyle(
                        color: fg,
                        fontSize: 100,
                        fontWeight: .bold,
                        fontFamily: FontFamily.googleSansCode,
                      ),
                    )
                  else ...[
                    Text(
                      intensityMainText,
                      style: TextStyle(
                        color: fg,
                        fontSize: 100,
                        fontWeight: .bold,
                        fontFamily: FontFamily.googleSansCode,
                      ),
                    ),
                    if (showSuffix)
                      Text(
                        intensitySubText,
                        style: TextStyle(
                          color: fg,
                          fontSize: 50,
                          fontWeight: .bold,
                          fontFamily: FontFamily.googleSansCode,
                          fontFamilyFallback: const [FontFamily.notoSansJP],
                        ),
                      ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    };
  }
}
