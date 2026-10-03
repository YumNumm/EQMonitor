import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sheet/sheet.dart';

class BasicModalSheet extends HookWidget {
  const new({
    required this.child,
    super.key,
    this.hasAppBar = true,
    this.expandToPane = false,
    this.initialPositionOverlay,
  });

  final Widget child;
  final bool hasAppBar;
  final bool expandToPane;
  final Widget? initialPositionOverlay;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final colorTheme = designSystem.colorTheme;
    final shape = designSystem.shape;
    final spacing = designSystem.spacing;
    final controller = useMemoized(SheetController.new);
    useEffect(() => controller.dispose, [controller]);

    return SafeArea(
      bottom: false,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final size = (
            width: constraints.maxWidth,
            height: constraints.maxHeight,
          );
          final isLandscape = size.width > size.height;
          final initialExtent = size.height * 0.2;
          final sheet = Sheet(
            controller: initialPositionOverlay == null ? null : controller,
            backgroundColor: colorTheme.surface,
            shape: RoundedSuperellipseBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(shape.sheet),
              ),
              side: BorderSide(color: colorTheme.outlineVariant),
            ),
            initialExtent: initialExtent,
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
                  margin: EdgeInsets.symmetric(vertical: spacing.sm),
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
          final overlay = initialPositionOverlay;
          final content = overlay == null
              ? sheet
              : Stack(
                  children: [
                    sheet,
                    Positioned(
                      left: spacing.sm,
                      right: spacing.sm,
                      bottom: initialExtent + spacing.sm,
                      child: AnimatedBuilder(
                        animation: controller.animation,
                        child: Align(alignment: .centerLeft, child: overlay),
                        builder: (context, child) {
                          final extent = controller.hasClients
                              ? controller.offset
                              : initialExtent;
                          final opacity =
                              (1 -
                                      (extent - initialExtent).abs() /
                                          (spacing.xxxxl * 2))
                                  .clamp(0.0, 1.0);
                          return ExcludeFocus(
                            excluding: opacity == 0,
                            child: IgnorePointer(
                              ignoring: opacity == 0,
                              child: ExcludeSemantics(
                                excluding: opacity == 0,
                                child: Opacity(opacity: opacity, child: child),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );

          if (isLandscape && !expandToPane) {
            return Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: size.width * 0.5,
                height: size.height,
                child: content,
              ),
            );
          }
          return content;
        },
      ),
    );
  }
}
