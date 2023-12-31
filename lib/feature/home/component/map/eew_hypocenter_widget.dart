import 'package:eqapi_types/extension/telegram_v3.dart';
import 'package:eqapi_types/model/telegram_v3.dart';
import 'package:eqmonitor/core/component/map/model/map_state.dart';
import 'package:eqmonitor/core/component/map/utils/web_mercator_projection.dart';
import 'package:eqmonitor/core/component/map/view_model/map_viewmodel.dart';
import 'package:eqmonitor/feature/home/features/eew/provider/eew_telegram.dart';
import 'package:eqmonitor/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EewHypocenterWidget extends HookConsumerWidget {
  const EewHypocenterWidget({required this.mapKey, super.key});

  final Key mapKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eewTelegramState = ref.watch(eewTelegramProvider);
    final eewTelegrams = eewTelegramState.value;

    if (eewTelegrams == null || eewTelegrams.isEmpty) {
      return const SizedBox.shrink();
    }

    final opacityController = useAnimationController(
      duration: const Duration(milliseconds: 500),
    );
    final opacityAnimation = useAnimation(
      Tween<double>(
        begin: 1,
        end: 0.4,
      ).animate(opacityController),
    );

    useEffect(
      () {
        opacityController
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              opacityController.reverse();
            } else if (status == AnimationStatus.dismissed) {
              opacityController.forward();
            }
          })
          ..forward();
        return null;
      },
      [],
    );

    final state = ref.watch(MapViewModelProvider(mapKey));

    final isDark = Theme.of(context).brightness == Brightness.dark;

    final hypoWidget = CustomPaint(
      painter: _HypocenterPainter(
        state: state,
        hypocenters: eewTelegrams
            .where(
              (e) => e.latestEew != null && e.latestEew is TelegramVxse45Body,
            )
            .map((e) => e.latestEew! as TelegramVxse45Body)
            .map(
              (e) => _HypoModel(
                type: (e.isPlum || e.isIpfOnePoint || e.isLevelEew)
                    ? _HypocenterType.lowPrecise
                    : _HypocenterType.normal,
                globalPoint: e.hypocenter?.coordinate != null
                    ? WebMercatorProjection().project(e.hypocenter!.coordinate!)
                    : null,
                magnitude: e.magnitude,
                depth: e.depth,
              ),
            )
            .toList(),
        textColor: isDark ? Colors.white : Colors.black,
      ),
      size: Size.infinite,
    );
    return Opacity(
      opacity: opacityAnimation,
      child: hypoWidget,
    );
  }
}

class _HypocenterPainter extends CustomPainter {
  _HypocenterPainter({
    required this.state,
    required this.hypocenters,
    required this.textColor,
  });

  final MapState state;
  final List<_HypoModel> hypocenters;
  final Color textColor;

  @override
  void paint(Canvas canvas, Size size) {
    for (final hypo in hypocenters) {
      if (hypo.globalPoint == null) {
        continue;
      }
      final offset = state.globalPointToOffset(hypo.globalPoint!);
      // 画面外だったら描画しない
      if (offset.dx < -10 ||
          offset.dx > size.width + 10 ||
          offset.dy < -10 ||
          offset.dy > size.height + 10) {
        continue;
      }
      if (hypo.type == _HypocenterType.lowPrecise) {
        // 円を描く
        canvas
          ..drawCircle(
            offset,
            10,
            Paint()
              ..color = Colors.black
              ..isAntiAlias = true
              ..style = PaintingStyle.stroke
              ..strokeWidth = 10,
          )
          ..drawCircle(
            offset,
            10,
            Paint()
              ..color = Colors.white
              ..isAntiAlias = true
              ..style = PaintingStyle.stroke
              ..strokeWidth = 8,
          )
          ..drawCircle(
            offset,
            10,
            Paint()
              ..color = Colors.red
              ..isAntiAlias = true
              ..style = PaintingStyle.stroke
              ..strokeWidth = 4,
          );
        // 「仮定震源」
        final textPainter = TextPainter(
          text: const TextSpan(
            text: '仮定震源',
            style: TextStyle(
              color: Colors.red,
              fontSize: 12,
              fontWeight: FontWeight.w900,
              fontFamily: FontFamily.notoSansJP,
            ),
          ),
          textDirection: TextDirection.ltr,
        )..layout();
        textPainter.paint(
          canvas,
          Offset(
            offset.dx - textPainter.width / 2,
            offset.dy + 15,
          ),
        );
      }
      if (hypo.type == _HypocenterType.normal) {
        // ×印を描く
        canvas
          ..drawLine(
            Offset(offset.dx - 10, offset.dy - 10),
            Offset(offset.dx + 10, offset.dy + 10),
            Paint()
              ..color = const Color.fromARGB(255, 0, 0, 0)
              ..isAntiAlias = true
              ..strokeCap = StrokeCap.square
              ..style = PaintingStyle.stroke
              ..strokeWidth = 12,
          )
          ..drawLine(
            Offset(offset.dx + 10, offset.dy - 10),
            Offset(offset.dx - 10, offset.dy + 10),
            Paint()
              ..color = const Color.fromARGB(255, 0, 0, 0)
              ..isAntiAlias = true
              ..strokeCap = StrokeCap.square
              ..style = PaintingStyle.stroke
              ..strokeWidth = 12,
          )
          ..drawLine(
            Offset(offset.dx - 10, offset.dy - 10),
            Offset(offset.dx + 10, offset.dy + 10),
            Paint()
              ..color = const Color.fromARGB(255, 255, 255, 255)
              ..isAntiAlias = true
              ..strokeCap = StrokeCap.square
              ..style = PaintingStyle.stroke
              ..strokeWidth = 10,
          )
          ..drawLine(
            Offset(offset.dx + 10, offset.dy - 10),
            Offset(offset.dx - 10, offset.dy + 10),
            Paint()
              ..color = const Color.fromARGB(255, 255, 255, 255)
              ..isAntiAlias = true
              ..strokeCap = StrokeCap.square
              ..style = PaintingStyle.stroke
              ..strokeWidth = 10,
          )
          ..drawLine(
            Offset(offset.dx - 10, offset.dy - 10),
            Offset(offset.dx + 10, offset.dy + 10),
            Paint()
              ..color = const Color.fromARGB(255, 255, 0, 0)
              ..isAntiAlias = true
              ..strokeCap = StrokeCap.square
              ..style = PaintingStyle.stroke
              ..strokeWidth = 7,
          )
          ..drawLine(
            Offset(offset.dx + 10, offset.dy - 10),
            Offset(offset.dx - 10, offset.dy + 10),
            Paint()
              ..color = const Color.fromARGB(255, 255, 0, 0)
              ..isAntiAlias = true
              ..strokeCap = StrokeCap.square
              ..style = PaintingStyle.stroke
              ..strokeWidth = 7,
          );
        // マグニチュードを描く
        final textPainter = TextPainter(
          text: TextSpan(
            text: 'M${hypo.magnitude}',
            style: TextStyle(
              fontSize: 15,
              fontFamily: FontFamily.jetBrainsMono,
              fontWeight: FontWeight.w900,
              color: textColor,
            ),
          ),
          textDirection: TextDirection.ltr,
        )..layout();
        textPainter.paint(
          canvas,
          Offset(
            offset.dx - textPainter.width / 2,
            offset.dy - textPainter.height / 2 + 30,
          ),
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _HypocenterPainter oldDelegate) => true;
}

enum _HypocenterType {
  normal,
  lowPrecise,
  ;
}

class _HypoModel {
  _HypoModel({
    required this.type,
    required this.globalPoint,
    required this.magnitude,
    required this.depth,
  });

  final _HypocenterType type;
  final GlobalPoint? globalPoint;
  final double? magnitude;
  final int? depth;
}
