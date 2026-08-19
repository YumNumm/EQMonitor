import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:material_ui/material_ui.dart';

class CustomChip extends StatelessWidget {
  const new({
    required this.child,
    this.backgroundColor,
    this.borderWidth = 0,
    super.key,
  });

  final Widget child;
  final Color? backgroundColor;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: backgroundColor ?? context.designSystem.colorTheme.surface,
          border: Border.all(
            color: context.designSystem.colorTheme.onSurface,
            width: borderWidth,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: child,
        ),
      ),
    );
  }
}
