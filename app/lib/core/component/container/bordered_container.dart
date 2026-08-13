import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:material_ui/material_ui.dart';

class BorderedContainer extends StatelessWidget {
  const BorderedContainer({
    required this.child,
    this.accentColor,
    this.padding = const EdgeInsets.all(12),
    this.margin = const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    this.elevation = 0,
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
    this.onPressed,
    super.key,
  });

  final Widget child;
  final Color? accentColor;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final double elevation;
  final BorderRadiusGeometry borderRadius;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;

    final card = Card(
      clipBehavior: Clip.antiAlias,
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
