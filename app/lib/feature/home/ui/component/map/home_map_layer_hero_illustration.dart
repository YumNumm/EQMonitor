import 'dart:async';
import 'dart:math' as math;

import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HomeMapLayerHeroIllustration extends HookWidget {
  const HomeMapLayerHeroIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final colorTheme = designSystem.colorTheme;
    final shape = designSystem.shape;
    final primary = context.designSystem.colorTheme.primary;
    final primarySoft = Color.lerp(
      colorTheme.surfaceContainerHighest,
      primary,
      0.35,
    )!;
    final controller = useAnimationController(
      duration: const Duration(seconds: 12),
    );
    useEffect(() {
      unawaited(controller.repeat());
      return null;
    }, [controller]);
    final progress = useAnimation(controller);

    return Container(
      height: 208,
      decoration: BoxDecoration(
        color: colorTheme.surfaceContainer,
        borderRadius: BorderRadius.circular(shape.xl),
        border: Border.all(color: colorTheme.outlineVariant),
      ),
      clipBehavior: Clip.antiAlias,
      child: RepaintBoundary(
        child: CustomPaint(
          painter: _HomeMapLayerHeroPainter(
            progress: progress,
            baseColor: colorTheme.surfaceContainerHigh,
            layerColor: colorTheme.surfaceContainerHighest,
            accentColor: primarySoft,
            outlineColor: colorTheme.outline,
            glowColor: primary.withValues(alpha: 0.25),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 18,
                left: 18,
                child: _LayerLabelChip(
                  label: 'Layered',
                  backgroundColor: colorTheme.surfaceContainerHighest
                      .withValues(alpha: 0.92),
                ),
              ),
              Positioned(
                right: 18,
                bottom: 18,
                child: _LayerLabelChip(
                  label: 'Realtime',
                  backgroundColor: colorTheme.surfaceContainerHigh.withValues(
                    alpha: 0.92,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LayerLabelChip extends StatelessWidget {
  const _LayerLabelChip({required this.label, required this.backgroundColor});

  final String label;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    final typography = context.designSystem.typography;
    final shape = context.designSystem.shape;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(shape.pill),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        child: Text(
          label,
          style: typography.labelMedium.copyWith(
            color: context.designSystem.colorTheme.onSurface,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _HomeMapLayerHeroPainter extends CustomPainter {
  const _HomeMapLayerHeroPainter({
    required this.progress,
    required this.baseColor,
    required this.layerColor,
    required this.accentColor,
    required this.outlineColor,
    required this.glowColor,
  });

  final double progress;
  final Color baseColor;
  final Color layerColor;
  final Color accentColor;
  final Color outlineColor;
  final Color glowColor;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width * 0.54, size.height * 0.48);
    final phase = progress * math.pi * 2;
    final drift = math.sin(phase) * 6;
    final pulse = (math.sin(phase * 1.6) + 1) / 2;

    final shadowPaint = Paint()
      ..color = glowColor
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 18);
    canvas.drawCircle(
      center.translate(0, 6),
      size.shortestSide * 0.22,
      shadowPaint,
    );

    final baseLayer = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: center.translate(0, 20),
        width: size.width * 0.70,
        height: size.height * 0.30,
      ),
      const Radius.circular(28),
    );
    final middleLayer = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: center.translate(10 + drift * 0.2, -4),
        width: size.width * 0.58,
        height: size.height * 0.24,
      ),
      const Radius.circular(24),
    );
    final topLayer = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: center.translate(-16 + drift * 0.55, -34),
        width: size.width * 0.46,
        height: size.height * 0.19,
      ),
      const Radius.circular(22),
    );

    final fillPaint = Paint()..style = PaintingStyle.fill;
    final strokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    fillPaint.color = baseColor.withValues(alpha: 0.95);
    canvas.drawRRect(baseLayer, fillPaint);
    strokePaint.color = outlineColor.withValues(alpha: 0.60);
    canvas.drawRRect(baseLayer, strokePaint);

    fillPaint.color = layerColor.withValues(alpha: 0.96);
    canvas.drawRRect(middleLayer, fillPaint);
    strokePaint.color = outlineColor.withValues(alpha: 0.75);
    canvas.drawRRect(middleLayer, strokePaint);

    fillPaint.color = accentColor.withValues(alpha: 0.92);
    canvas.drawRRect(topLayer, fillPaint);
    strokePaint.color = Colors.white.withValues(alpha: 0.20);
    canvas.drawRRect(topLayer, strokePaint);

    final pathPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = Colors.white.withValues(alpha: 0.26)
      ..strokeCap = StrokeCap.round;

    final path = Path()
      ..moveTo(size.width * 0.20, size.height * 0.68)
      ..quadraticBezierTo(
        size.width * 0.36,
        size.height * 0.52 + drift * 0.3,
        size.width * 0.48,
        size.height * 0.58,
      )
      ..quadraticBezierTo(
        size.width * 0.66,
        size.height * 0.66 - drift * 0.35,
        size.width * 0.80,
        size.height * 0.48,
      );
    canvas.drawPath(path, pathPaint);

    final nodePaint = Paint()..style = PaintingStyle.fill;
    final nodes = <Offset>[
      Offset(size.width * 0.25, size.height * 0.63),
      Offset(size.width * 0.43, size.height * 0.56),
      Offset(size.width * 0.59, size.height * 0.62),
      Offset(size.width * 0.76, size.height * 0.51),
    ];

    for (var index = 0; index < nodes.length; index++) {
      final node = nodes[index];
      final localPulse = (math.sin(phase * 1.3 + index) + 1) / 2;
      final radius = 4 + localPulse * 1.5;
      nodePaint.color = Colors.white.withValues(alpha: 0.85 - index * 0.12);
      canvas.drawCircle(node, radius, nodePaint);
      nodePaint.color = glowColor.withValues(alpha: 0.26 + localPulse * 0.18);
      canvas.drawCircle(
        node,
        10 + localPulse * 10,
        nodePaint..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10),
      );
      nodePaint.maskFilter = null;
    }

    final radarCenter = Offset(size.width * 0.22, size.height * 0.30);
    final radarPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..color = Colors.white.withValues(alpha: 0.18);
    canvas.drawCircle(radarCenter, 18, radarPaint);
    canvas.drawCircle(
      radarCenter,
      34 + pulse * 10,
      radarPaint..color = glowColor.withValues(alpha: 0.35 - pulse * 0.12),
    );
    canvas.drawCircle(
      radarCenter,
      52 + pulse * 16,
      radarPaint..color = glowColor.withValues(alpha: 0.20 - pulse * 0.06),
    );

    final accentPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = accentColor.withValues(alpha: 0.85);
    canvas.drawCircle(
      Offset(size.width * 0.68 + drift * 0.55, size.height * 0.23),
      6,
      accentPaint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.60 - drift * 0.35, size.height * 0.36),
      5,
      accentPaint..color = Colors.white.withValues(alpha: 0.70),
    );
  }

  @override
  bool shouldRepaint(covariant _HomeMapLayerHeroPainter oldDelegate) =>
      oldDelegate.progress != progress ||
      oldDelegate.baseColor != baseColor ||
      oldDelegate.layerColor != layerColor ||
      oldDelegate.accentColor != accentColor ||
      oldDelegate.outlineColor != outlineColor ||
      oldDelegate.glowColor != glowColor;
}
