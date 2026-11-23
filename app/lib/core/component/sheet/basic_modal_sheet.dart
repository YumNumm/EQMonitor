import 'dart:async';

import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sheet/sheet.dart';

class const BasicModalSheet({
  required final Widget child,
  super.key,
  final bool hasAppBar = true,
  final bool expandToPane = false,
  final Widget? initialPositionOverlay,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final colorTheme = designSystem.colorTheme;
    final shape = designSystem.shape;
    final spacing = designSystem.spacing;
    final controller = useMemoized(SheetController.new);
    useEffect(() => controller.dispose, [controller]);
    final sheetKey = useMemoized(GlobalKey.new);
    final fitExtent = useState<double?>(null);
    final isUserDragged = useRef(false);
    final initialExtentRef = useRef(0.0);

    void moveTo(double? extent) {
      final current = fitExtent.value;
      if (current == extent ||
          (current != null && extent != null && (current - extent).abs() < 1)) {
        return;
      }
      // 停止位置に無い高さへ動かすと SnapSheetPhysics が最寄りの停止位置へ戻すため、先に停止位置へ加える。
      fitExtent.value = extent;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!context.mounted || !controller.hasClients) {
          return;
        }
        unawaited(
          controller.animateTo(
            extent ?? initialExtentRef.value,
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOutCubic,
          ),
        );
      });
    }

    final scope = useMemoized(
      () => (
        fit: (target) {
          final sheetBox = sheetKey.currentContext?.findRenderObject();
          if (isUserDragged.value ||
              !controller.hasClients ||
              sheetBox is! RenderBox ||
              !target.attached) {
            return;
          }
          final targetBottom = target
              .localToGlobal(Offset(0, target.size.height))
              .dy;
          final sheetBottom = sheetBox
              .localToGlobal(Offset(0, sheetBox.size.height))
              .dy;
          final extent =
              controller.offset + targetBottom + spacing.md - sheetBottom;
          moveTo(
            extent.clamp(initialExtentRef.value, sheetBox.size.height),
          );
        },
        release: () => WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!context.mounted) {
            return;
          }
          final wasUserDragged = isUserDragged.value;
          isUserDragged.value = false;
          if (wasUserDragged) {
            fitExtent.value = null;
          } else {
            moveTo(null);
          }
        }),
      ),
    );
    final lastHeight = useRef<double?>(null);

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
          initialExtentRef.value = initialExtent;
          final fitStop = switch (fitExtent.value) {
            final extent? when size.height > 0 => extent / size.height,
            _ => null,
          };
          final previousHeight = lastHeight.value;
          lastHeight.value = size.height;
          if (previousHeight != null &&
              previousHeight > 0 &&
              previousHeight != size.height &&
              controller.hasClients) {
            // Sheet は位置を px で保持するため、高さが変わったら同じ割合へ合わせ直す。
            final relativeExtent = controller.offset / previousHeight;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (controller.hasClients) {
                controller.jumpTo(relativeExtent * size.height);
              }
            });
          }
          final sheet = Sheet(
            key: sheetKey,
            controller: controller,
            backgroundColor: colorTheme.surface,
            shape: RoundedSuperellipseBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(shape.sheet),
              ),
              side: BorderSide(color: colorTheme.outlineVariant),
            ),
            initialExtent: initialExtent,
            physics: SnapSheetPhysics(
              stops: [
                ...{0.1, 0.2, 0.3, 0.5, 0.7, 0.8, 1.0, ?fitStop},
              ]..sort(),
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
          final scopedSheet = BasicModalSheetScope(
            fit: scope.fit,
            release: scope.release,
            child: NotificationListener<ScrollStartNotification>(
              onNotification: (notification) {
                if (notification.dragDetails != null) {
                  isUserDragged.value = true;
                }
                return false;
              },
              child: sheet,
            ),
          );
          final content = overlay == null
              ? scopedSheet
              : Stack(
                  children: [
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
                    scopedSheet,
                  ],
                );

          return Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              width: isLandscape && !expandToPane
                  ? size.width * 0.5
                  : size.width,
              height: size.height,
              child: content,
            ),
          );
        },
      ),
    );
  }
}

class const BasicModalSheetScope({
  required final void Function(RenderBox target) fit,
  required final VoidCallback release,
  required super.child,
  super.key,
}) extends InheritedWidget {
  static BasicModalSheetScope? maybeOf(BuildContext context) =>
      context.getInheritedWidgetOfExactType<BasicModalSheetScope>();

  @override
  bool updateShouldNotify(BasicModalSheetScope oldWidget) => false;
}

/// 利用者がシートを動かしていない間、この Widget の下端までが見える高さへ [BasicModalSheet] を合わせる。
class const SheetFitTarget({
  required final Widget child,
  super.key,
}) extends StatefulWidget {
  @override
  State<SheetFitTarget> createState() => _SheetFitTargetState();
}

class _SheetFitTargetState extends State<SheetFitTarget> {
  BasicModalSheetScope? _scope;

  @override
  void initState() {
    super.initState();
    _scheduleFit();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scope = BasicModalSheetScope.maybeOf(context);
  }

  @override
  void dispose() {
    _scope?.release();
    super.dispose();
  }

  void _scheduleFit() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      final box = context.findRenderObject();
      if (box is RenderBox && box.hasSize) {
        _scope?.fit(box);
      }
    });
  }

  @override
  Widget build(BuildContext context) =>
      NotificationListener<SizeChangedLayoutNotification>(
        onNotification: (_) {
          _scheduleFit();
          return true;
        },
        child: SizeChangedLayoutNotifier(child: widget.child),
      );
}
