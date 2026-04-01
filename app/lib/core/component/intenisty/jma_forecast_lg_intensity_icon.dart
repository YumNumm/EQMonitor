import 'package:eqmonitor/core/component/intenisty/intensity_icon_type.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class JmaForecastLgIntensityWidget extends ConsumerWidget {
  const JmaForecastLgIntensityWidget({
    required this.intensity,
    this.type = IntensityIconType.filled,
    this.customText,
    this.colorModel,
    super.key,
    this.size = 50,
  });

  final JmaLpgmIntensity intensity;
  final IntensityIconType type;
  final double size;
  final String? customText;
  final IntensityColorModel? colorModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ignore: omit_local_variable_types
    final IntensityColorModel intensityColorModel =
        colorModel ?? ref.watch(intensityColorProvider);
    final colorScheme = intensityColorModel.fromJmaLpgmIntensity(intensity);
    final (fg, bg) = (colorScheme.foreground, colorScheme.background);
    final intensityMainText = intensity.label;
    const intensitySubText = '';

    return SizedBox(
      height: size,
      width: size,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: type == IntensityIconType.filled ? bg : null,
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
                      fontWeight: FontWeight.bold,
                      fontFamily: FontFamily.notoSansMono,
                    ),
                  )
                else if (intensity == JmaLpgmIntensity.unknown)
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      intensityMainText,
                      style: TextStyle(
                        color: fg,
                        fontSize: 100,
                        fontWeight: FontWeight.bold,
                        fontFamily: FontFamily.notoSansJP,
                      ),
                    ),
                  )
                else ...[
                  Text(
                    intensityMainText,
                    style: TextStyle(
                      color: fg,
                      fontSize: 100,
                      fontWeight: FontWeight.bold,
                      fontFamily: FontFamily.notoSansMono,
                    ),
                  ),
                  Text(
                    intensitySubText,
                    style: TextStyle(
                      color: fg,
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      fontFamily: FontFamily.notoSansMono,
                      fontFamilyFallback: const [FontFamily.notoSansJP],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
