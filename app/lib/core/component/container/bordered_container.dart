import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:material_ui/material_ui.dart';

class const BorderedContainer({
  required final Widget child,
  final Color? accentColor,
  final EdgeInsetsGeometry padding = const EdgeInsets.all(12),
  final EdgeInsetsGeometry margin = const EdgeInsets.symmetric(
    vertical: 4,
    horizontal: 8,
  ),
  final double elevation = 0,
  final BorderRadiusGeometry borderRadius = const BorderRadius.all(
    Radius.circular(16),
  ),
  final void Function()? onPressed,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;

    final card = Card(
      clipBehavior: .antiAlias,
      elevation: elevation,
      color: accentColor ?? designSystem.colorTheme.surfaceContainer,
      shape: RoundedSuperellipseBorder(
        side: BorderSide(
          color: designSystem.colorTheme.onSurfaceVariant.withValues(
            alpha: 0.3,
          ),
        ),
        borderRadius: borderRadius,
      ),
      margin: margin,
      child: InkWell(
        onTap: onPressed,
        child: Padding(padding: padding, child: child),
      ),
    );
    if (onPressed != null) {
      return Ink(child: card);
    }
    return card;
  }
}
