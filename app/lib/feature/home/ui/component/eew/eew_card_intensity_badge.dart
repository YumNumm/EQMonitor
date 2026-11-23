import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/theme/model/intensity_colors.dart';
import 'package:eqmonitor/feature/home/ui/component/eew/eew_card_text_style.dart';
import 'package:material_ui/material_ui.dart';

class const EewCardIntensityBadge({
  required final JmaIntensity intensity,
  required final double size,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorEntry = context.designSystem.colorTheme.intensity
        .fromJmaIntensity(intensity);
    final foreground = colorEntry.resolvedForeground;
    final suffix = intensity.suffix;

    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: size, minHeight: size),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colorEntry.background,
          borderRadius: BorderRadius.circular(size * 0.2),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size * 0.08),
          child: Center(
            widthFactor: 1,
            heightFactor: 1,
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: intensity.mainText),
                  if (suffix.isNotEmpty)
                    TextSpan(
                      text: suffix,
                      style: EewCardFlexTextStyle(
                        size: size * 0.36,
                        weight: .w800,
                        color: foreground,
                      ),
                    ),
                ],
              ),
              style: EewCardCodeTextStyle(
                size: size * 0.76,
                weight: .w800,
                color: foreground,
              ),
              maxLines: 1,
              softWrap: false,
            ),
          ),
        ),
      ),
    );
  }
}
