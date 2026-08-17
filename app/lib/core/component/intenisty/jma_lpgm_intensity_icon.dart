import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/core/theme/model/intensity_colors.dart';
import 'package:eqmonitor/feature/map/features/icon/data/model/intensity_icon.dart';
import 'package:material_ui/material_ui.dart';

class JmaLpgmIntensityIcon extends StatelessWidget {
  const new({
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
  Widget build(BuildContext context) {
    final customText = this.customText;
    final colorEntry = context.designSystem.colorTheme.intensity
        .fromJmaLpgmIntensity(intensity);
    final (fg, bg) = (colorEntry.resolvedForeground, colorEntry.background);

    final borderColor = Color.lerp(bg, fg, 0.3) ?? bg;
    return switch (type) {
      .small => SizedBox(
        height: size,
        width: size,
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: .circle,
            color: bg,
            border: .all(color: borderColor, width: 5),
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
                      fontFamily: FontFamily.googleSansCode,
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
            // 角丸にする
            borderRadius: .circular(size / 5),
          ),
          child: Center(
            child: FittedBox(
              fit: .scaleDown,
              child: (customText != null)
                  ? Text(
                      customText,
                      style: TextStyle(
                        color: fg,
                        fontSize: 100,
                        fontWeight: .bold,
                        fontFamily: FontFamily.googleSansCode,
                      ),
                    )
                  : Text(
                      intensity.label,
                      style: TextStyle(
                        color: fg,
                        fontSize: 100,
                        fontWeight: .bold,
                        fontFamily: FontFamily.googleSansCode,
                      ),
                    ),
            ),
          ),
        ),
      ),
    };
  }
}
