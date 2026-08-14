import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/feature/tsunami/data/model/value/tsunami_warning_kind.dart';
import 'package:eqmonitor/feature/tsunami/ui/utils/tsunami_warning_color.dart';
import 'package:material_ui/material_ui.dart';

class TsunamiWarningLegend extends StatelessWidget {
  const TsunamiWarningLegend({super.key});

  static const List<TsunamiWarningKind> _kinds = [
    TsunamiWarningKind.majorWarning,
    TsunamiWarningKind.warning,
    TsunamiWarningKind.advisory,
    TsunamiWarningKind.forecast,
  ];

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final colorTheme = designSystem.colorTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: colorTheme.surfaceContainerHigh.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colorTheme.outlineVariant),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '津波警報',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: designSystem.colorTheme.onSurface,
            ),
          ),
          const SizedBox(height: 4),
          for (final kind in _kinds)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 1),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 4,
                    height: 14,
                    color: TsunamiWarningColor.headerColor(kind),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    TsunamiWarningColor.displayName(kind),
                    style: TextStyle(
                      fontSize: 10,
                      color: designSystem.colorTheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
