import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/component/intenisty/intensity_icon_type.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class JmaIntensityIcon extends ConsumerWidget {
  const JmaIntensityIcon({
    required this.intensity,
    required this.type,
    this.customText,
    super.key,
    this.size = 50,
  });
  final JmaIntensity intensity;
  final IntensityIconType type;
  final double size;
  final String? customText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final intensityColorModel = ref.watch(intensityColorProvider);
    final colorScheme = intensityColorModel.fromJmaIntensity(intensity);
    final (fg, bg) = (colorScheme.foreground, colorScheme.background);
    // 震度の整数部分
    final intensityMainText = switch (intensity) {
      JmaIntensity.fiveUpperNoInput => '5',
      _ => intensity.type.replaceAll('-', '').replaceAll('+', ''),
    };
    // 震度の弱・強の表記
    final suffix = intensity.type.contains('-')
        ? '-'
        : intensity.type.contains('+')
            ? '+'
            : '';
    final intensitySubText = switch (intensity) {
      JmaIntensity.fiveUpperNoInput => '弱以上',
      _ => intensity.type.contains('-')
          ? '弱'
          : intensity.type.contains('+')
              ? '強'
              : '',
    };
    final borderColor = Color.lerp(
      bg,
      fg,
      0.3,
    )!;
    return switch (type) {
      IntensityIconType.small => SizedBox(
          height: size,
          width: size,
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: bg,
              border: Border.all(
                color: borderColor,
                width: 5,
              ),
            ),
            child: (intensity == JmaIntensity.fiveUpperNoInput)
                ? const SizedBox.shrink()
                : Center(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            intensityMainText,
                            style: TextStyle(
                              color: fg,
                              fontSize: 100,
                              fontWeight: FontWeight.w900,
                              fontFamily: FontFamily.jetBrainsMono,
                            ),
                          ),
                          Text(
                            suffix,
                            style: TextStyle(
                              color: fg,
                              fontSize: 80,
                              fontWeight: FontWeight.w900,
                              fontFamily: FontFamily.jetBrainsMono,
                              fontFamilyFallback: const [FontFamily.notoSansJP],
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
              border: Border.all(
                color: borderColor,
                width: 5,
              ),
            ),
          ),
        ),
      IntensityIconType.filled => SizedBox(
          height: 50,
          width: 50,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: bg,
              // 角丸にする
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    if (customText != null)
                      Text(
                        customText!,
                        style: TextStyle(
                          color: fg,
                          fontSize: 100,
                          fontWeight: FontWeight.w900,
                          fontFamily: FontFamily.jetBrainsMono,
                        ),
                      )
                    else ...[
                      Text(
                        intensityMainText,
                        style: TextStyle(
                          color: fg,
                          fontSize: 100,
                          fontWeight: FontWeight.w900,
                          fontFamily: FontFamily.jetBrainsMono,
                        ),
                      ),
                      Text(
                        intensitySubText,
                        style: TextStyle(
                          color: fg,
                          fontSize: 50,
                          fontWeight: FontWeight.w900,
                          fontFamily: FontFamily.jetBrainsMono,
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
