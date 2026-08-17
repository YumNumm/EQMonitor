import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/theme/model/intensity_colors.dart';
import 'package:eqmonitor/feature/map/features/icon/data/model/intensity_icon.dart';
import 'package:material_ui/material_ui.dart';

class JmaIntensityIcon extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final colorEntry = context.designSystem.colorTheme.intensity
        .fromJmaIntensity(intensity);
    final (fg, bg) = (colorEntry.resolvedForeground, colorEntry.background);
    final intensityMainText = intensity.mainText;
    final suffix = intensity.label.contains('-')
        ? '-'
        : intensity.label.contains('+')
        ? '+'
        : '';
    final intensitySubText = intensity.suffix;
    final borderColor = Color.lerp(bg, fg, 0.3) ?? bg;
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
          child: (intensity == .fiveUnknown || intensity == .sixUnknown)
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
                              fontFamilyFallback: const [FontFamily.notoSansJP],
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
            borderRadius: BorderRadius.circular(size / 4),
          ),
          child: Center(
            child: FittedBox(
              fit: .scaleDown,
              child: Row(
                crossAxisAlignment: .baseline,
                textBaseline: .alphabetic,
                children: [
                  if (customText case final ct?)
                    Text(
                      ct,
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
