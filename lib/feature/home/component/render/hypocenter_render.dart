import 'dart:typed_data';
import 'dart:ui';

import 'package:eqmonitor/core/provider/capture/intensity_icon_render.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HypocenterRenderWidget extends ConsumerWidget {
  const HypocenterRenderWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        _HypocenterRender(
          type: HypocenterType.normal,
          onRendered: (data) =>
              ref.read(hypocenterIconRenderProvider.notifier).onRendered(data),
        ),
        _HypocenterRender(
          type: HypocenterType.lowPrecise,
          onRendered: (data) => ref
              .read(hypocenterLowPreciseIconRenderProvider.notifier)
              .onRendered(data),
        ),
      ],
    );
  }
}

class _HypocenterRender extends HookConsumerWidget {
  const _HypocenterRender({
    required this.onRendered,
    required this.type,
  });
  final void Function(Uint8List data) onRendered;
  final HypocenterType type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final key = GlobalObjectKey('hypocenter$type');

    useEffect(
      () {
        WidgetsBinding.instance.endOfFrame.then((_) async {
          final currentContext = key.currentContext;
          do {
            await Future<void>.delayed(const Duration(milliseconds: 250));
          } while (currentContext == null);
          
          if (context.mounted) {
            final boundary =
                currentContext.findRenderObject()! as RenderRepaintBoundary;
            final image = await boundary.toImage();
            final byte = await image.toByteData(format: ImageByteFormat.png);
            onRendered.call(byte!.buffer.asUint8List());
          }
        });
        return null;
      },
      [],
    );
    return RepaintBoundary(
      key: key,
      child: SizedBox(
        height: 80,
        width: 80,
        child: CustomPaint(
          painter: _HypocenterPainter(type: type),
        ),
      ),
    );
  }
}

class _HypocenterPainter extends CustomPainter {
  const _HypocenterPainter({
    required this.type,
  });
  final HypocenterType type;

  @override
  void paint(Canvas canvas, Size size) {
    final offset = Offset(size.width / 2, size.height / 2);
    if (type == HypocenterType.lowPrecise) {
      // 円を描く
      canvas
        ..drawCircle(
          offset,
          25,
          Paint()
            ..color = Colors.black
            ..isAntiAlias = true
            ..style = PaintingStyle.stroke
            ..strokeWidth = 25,
        )
        ..drawCircle(
          offset,
          25,
          Paint()
            ..color = Colors.white
            ..isAntiAlias = true
            ..style = PaintingStyle.stroke
            ..strokeWidth = 18,
        )
        ..drawCircle(
          offset,
          25,
          Paint()
            ..color = const Color.fromARGB(255, 255, 0, 0)
            ..isAntiAlias = true
            ..style = PaintingStyle.stroke
            ..strokeWidth = 10,
        );
    } else if (type == HypocenterType.normal) {
      // ×印を描く
      canvas
        ..drawLine(
          Offset(offset.dx - 20, offset.dy - 20),
          Offset(offset.dx + 20, offset.dy + 20),
          Paint()
            ..color = const Color.fromARGB(255, 0, 0, 0)
            ..isAntiAlias = true
            ..strokeCap = StrokeCap.square
            ..style = PaintingStyle.stroke
            ..strokeWidth = 25,
        )
        ..drawLine(
          Offset(offset.dx + 20, offset.dy - 20),
          Offset(offset.dx - 20, offset.dy + 20),
          Paint()
            ..color = const Color.fromARGB(255, 0, 0, 0)
            ..isAntiAlias = true
            ..strokeCap = StrokeCap.square
            ..style = PaintingStyle.stroke
            ..strokeWidth = 25,
        )
        ..drawLine(
          Offset(offset.dx - 20, offset.dy - 20),
          Offset(offset.dx + 20, offset.dy + 20),
          Paint()
            ..color = const Color.fromARGB(255, 255, 255, 255)
            ..isAntiAlias = true
            ..strokeCap = StrokeCap.square
            ..style = PaintingStyle.stroke
            ..strokeWidth = 18,
        )
        ..drawLine(
          Offset(offset.dx + 20, offset.dy - 20),
          Offset(offset.dx - 20, offset.dy + 20),
          Paint()
            ..color = const Color.fromARGB(255, 255, 255, 255)
            ..isAntiAlias = true
            ..strokeCap = StrokeCap.square
            ..style = PaintingStyle.stroke
            ..strokeWidth = 18,
        )
        ..drawLine(
          Offset(offset.dx - 20, offset.dy - 20),
          Offset(offset.dx + 20, offset.dy + 20),
          Paint()
            ..color = const Color.fromARGB(255, 255, 0, 0)
            ..isAntiAlias = true
            ..strokeCap = StrokeCap.square
            ..style = PaintingStyle.stroke
            ..strokeWidth = 12,
        )
        ..drawLine(
          Offset(offset.dx + 20, offset.dy - 20),
          Offset(offset.dx - 20, offset.dy + 20),
          Paint()
            ..color = const Color.fromARGB(255, 255, 0, 0)
            ..isAntiAlias = true
            ..strokeCap = StrokeCap.square
            ..style = PaintingStyle.stroke
            ..strokeWidth = 12,
        );
    }
  }

  @override
  bool shouldRepaint(covariant _) => false;
}

enum HypocenterType {
  normal,
  lowPrecise,
  ;
}
