import 'dart:io';

import 'package:eqmonitor/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class HypocenterIconPage extends ConsumerWidget {
  const HypocenterIconPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final normalController = ScreenshotController();
    final lowPreciseController = ScreenshotController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('震源アイコン生成'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            '通常の震源アイコン',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Rendered, Assets'),
              Screenshot(
                controller: normalController,
                child: Container(
                  color: Colors.transparent,
                  height: 100,
                  width: 100,
                  child: const CustomPaint(
                    painter: _HypocenterPainter(
                      type: HypocenterType.normal,
                    ),
                  ),
                ),
              ),
              Assets.images.map.normalHypocenter.image(
                width: 100,
                height: 100,
              ),
              FilledButton.icon(
                onPressed: () async => _captureAndShare(
                  controller: normalController,
                  fileName: 'normal_hypocenter.png',
                ),
                icon: const Icon(Icons.share),
                label: const Text('共有'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            '精度の低い震源アイコン',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Rendered, Assets'),
              Column(
                children: [
                  Screenshot(
                    controller: lowPreciseController,
                    child: Container(
                      color: Colors.transparent,
                      height: 100,
                      width: 100,
                      child: const CustomPaint(
                        painter: _HypocenterPainter(
                          type: HypocenterType.lowPrecise,
                        ),
                      ),
                    ),
                  ),
                  Assets.images.map.lowPreciseHypocenter.image(
                    width: 100,
                    height: 100,
                  ),
                  FilledButton.icon(
                    onPressed: () async => _captureAndShare(
                      controller: lowPreciseController,
                      fileName: 'low_precise_hypocenter.png',
                    ),
                    icon: const Icon(Icons.share),
                    label: const Text('共有'),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _captureAndShare({
    required ScreenshotController controller,
    required String fileName,
  }) async {
    final image = await controller.capture();
    if (image == null) {
      return;
    }

    final tempDir = await getTemporaryDirectory();
    final file = await File('${tempDir.path}/$fileName').create();
    await file.writeAsBytes(image);

    await Share.shareXFiles(
      [XFile(file.path)],
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
