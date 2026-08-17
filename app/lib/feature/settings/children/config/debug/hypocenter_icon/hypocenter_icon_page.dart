import 'dart:io';

import 'package:eqmonitor/core/component/intenisty/jma_intensity_icon.dart';
import 'package:eqmonitor/core/component/intenisty/jma_lpgm_intensity_icon.dart';
import 'package:eqmonitor/core/gen/assets.gen.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/feature/map/features/icon/data/model/intensity_icon.dart';
import 'package:material_ui/material_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class HypocenterIconPage extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('地震履歴詳細アイコン一覧')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _SectionHeader(title: '震源アイコン'),
          SizedBox(height: 8),
          _HypocenterIconsSection(),
          SizedBox(height: 24),
          _SectionHeader(title: 'JMA震度アイコン'),
          SizedBox(height: 8),
          _JmaIntensityShowcase(),
          SizedBox(height: 24),
          _SectionHeader(title: '長周期地震動階級アイコン'),
          SizedBox(height: 8),
          _JmaLpgmIntensityShowcase(),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const new({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}

class _SubSectionHeader extends StatelessWidget {
  const new({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 4),
      child: Text(
        title,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _HypocenterIconsSection extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    final normalController = ScreenshotController();
    final lowPreciseController = ScreenshotController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SubSectionHeader(title: '通常の震源アイコン'),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                const Text('Rendered'),
                Screenshot(
                  controller: normalController,
                  child: Container(
                    color: Colors.transparent,
                    height: 100,
                    width: 100,
                    child: const CustomPaint(
                      painter: _HypocenterPainter(type: HypocenterType.normal),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),
            Column(
              children: [
                const Text('Assets'),
                Assets.images.map.normalHypocenter.image(
                  width: 100,
                  height: 100,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 4),
        FilledButton.icon(
          onPressed: () async => _captureAndShare(
            controller: normalController,
            fileName: 'normal_hypocenter.png',
          ),
          icon: const Icon(Icons.share),
          label: const Text('Rendered を共有'),
        ),
        const SizedBox(height: 16),
        const _SubSectionHeader(title: '精度の低い震源アイコン'),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                const Text('Rendered'),
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
              ],
            ),
            const SizedBox(width: 16),
            Column(
              children: [
                const Text('Assets'),
                Assets.images.map.lowPreciseHypocenter.image(
                  width: 100,
                  height: 100,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 4),
        FilledButton.icon(
          onPressed: () async => _captureAndShare(
            controller: lowPreciseController,
            fileName: 'low_precise_hypocenter.png',
          ),
          icon: const Icon(Icons.share),
          label: const Text('Rendered を共有'),
        ),
      ],
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

    await SharePlus.instance.share(
      ShareParams(
        subject: '震源アイコン',
        files: [XFile(file.path)],
      ),
    );
  }
}

class _JmaIntensityShowcase extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final type in IntensityIconType.values) ...[
          _SubSectionHeader(title: type.name),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final intensity in JmaIntensity.values)
                _IconLabel(
                  label: intensity.label,
                  child: JmaIntensityIcon(
                    intensity: intensity,
                    type: type,
                    size: 56,
                  ),
                ),
            ],
          ),
        ],
      ],
    );
  }
}

class _JmaLpgmIntensityShowcase extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final type in IntensityIconType.values) ...[
          _SubSectionHeader(title: type.name),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final intensity in JmaLpgmIntensity.values)
                _IconLabel(
                  label: intensity.label,
                  child: JmaLpgmIntensityIcon(
                    intensity: intensity,
                    type: type,
                    size: 56,
                  ),
                ),
            ],
          ),
        ],
      ],
    );
  }
}

class _IconLabel extends StatelessWidget {
  const new({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        child,
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 11)),
      ],
    );
  }
}

class _HypocenterPainter extends CustomPainter {
  const new({required this.type});

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

enum HypocenterType { normal, lowPrecise }
