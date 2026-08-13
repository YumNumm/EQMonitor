import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sheet/sheet.dart';

class BasicModalSheet extends HookWidget {
  const BasicModalSheet({
    required this.child,
    super.key,
    this.hasAppBar = true,
  });

  final Widget child;
  final bool hasAppBar;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final colorTheme = designSystem.colorTheme;
    final shape = designSystem.shape;
    final spacing = designSystem.spacing;

    return SafeArea(
      bottom: false,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final size = (
            width: constraints.maxWidth,
            height: constraints.maxHeight,
          );
          final isLandscape = size.width > size.height;
          final sheet = Sheet(
            backgroundColor: colorTheme.surface,
            shape: RoundedSuperellipseBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(shape.sheet),
              ),
              side: BorderSide(color: colorTheme.outlineVariant),
            ),
            initialExtent: size.height * 0.2,
            physics: const SnapSheetPhysics(
              stops: [
                0.1,
                0.2,
                0.3,
                0.5,
                0.7,
                0.8,
                1,
              ],
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: spacing.sm,
                    bottom: spacing.xs,
                  ),
                  width: 36,
                  height: 4,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(shape.pill),
                    color: colorTheme.outline.withValues(alpha: 0.48),
                  ),
                ),
                Expanded(child: child),
              ],
            ),
          );

          if (isLandscape) {
            return Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: size.width * 0.5,
                height: size.height,
                child: sheet,
              ),
            );
          }
          return sheet;
        },
      ),
    );
  }
}
