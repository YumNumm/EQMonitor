import 'package:flutter/material.dart';

/// 強震モニタのカラースケールを表示するWidget
class KyoshinMonitorScale extends StatelessWidget {
  const KyoshinMonitorScale({
    required this.type,
    required this.width,
    required this.height,
    super.key,
  });

  final KyoshinMonitorScaleType type;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width, height),
      painter: _KyoshinMonitorScalePainter(
        type: type,
      ),
    );
  }
}

/// カラースケールの種類
enum KyoshinMonitorScaleType {
  intensity,
  pga,
  pgv,
  pgd,
}

class _KyoshinMonitorScalePainter extends CustomPainter {
  _KyoshinMonitorScalePainter({
    required this.type,
  });

  final KyoshinMonitorScaleType type;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // スケールの値とRGB値のマッピング
    final List<({double value, Color color})> scaleData;
    switch (type) {
      case KyoshinMonitorScaleType.intensity:
        scaleData = [
          (value: -3.0, color: const Color.fromARGB(255, 0, 8, 255)),
          (value: -2.0, color: const Color.fromARGB(255, 0, 87, 255)),
          (value: -1.0, color: const Color.fromARGB(255, 0, 255, 179)),
          (value: 0.0, color: const Color.fromARGB(255, 5, 255, 0)),
          (value: 1.0, color: const Color.fromARGB(255, 178, 255, 0)),
          (value: 2.0, color: const Color.fromARGB(255, 250, 255, 0)),
          (value: 3.0, color: const Color.fromARGB(255, 255, 226, 0)),
          (value: 4.0, color: const Color.fromARGB(255, 255, 144, 0)),
          (value: 5.0, color: const Color.fromARGB(255, 255, 70, 0)),
          (value: 6.0, color: const Color.fromARGB(255, 255, 2, 0)),
          (value: 7.0, color: const Color.fromARGB(255, 172, 0, 0)),
        ];
      case KyoshinMonitorScaleType.pga:
        scaleData = [
          (value: 0.01, color: const Color.fromARGB(255, 0, 8, 255)),
          (value: 0.02, color: const Color.fromARGB(255, 0, 48, 255)),
          (value: 0.05, color: const Color.fromARGB(255, 0, 156, 255)),
          (value: 0.1, color: const Color.fromARGB(255, 0, 255, 179)),
          (value: 0.2, color: const Color.fromARGB(255, 0, 255, 65)),
          (value: 0.5, color: const Color.fromARGB(255, 82, 255, 0)),
          (value: 1.0, color: const Color.fromARGB(255, 178, 255, 0)),
          (value: 2.0, color: const Color.fromARGB(255, 228, 255, 0)),
          (value: 5.0, color: const Color.fromARGB(255, 255, 243, 0)),
          (value: 10.0, color: const Color.fromARGB(255, 255, 226, 0)),
          (value: 20.0, color: const Color.fromARGB(255, 255, 175, 0)),
          (value: 50.0, color: const Color.fromARGB(255, 255, 114, 0)),
          (value: 100.0, color: const Color.fromARGB(255, 255, 70, 0)),
          (value: 200.0, color: const Color.fromARGB(255, 255, 28, 0)),
          (value: 500.0, color: const Color.fromARGB(255, 218, 0, 0)),
          (value: 1000.0, color: const Color.fromARGB(255, 172, 0, 0)),
        ];
      case KyoshinMonitorScaleType.pgv:
        scaleData = [
          (value: 0.001, color: const Color.fromARGB(255, 0, 8, 255)),
          (value: 0.002, color: const Color.fromARGB(255, 0, 48, 255)),
          (value: 0.005, color: const Color.fromARGB(255, 0, 156, 255)),
          (value: 0.01, color: const Color.fromARGB(255, 0, 255, 179)),
          (value: 0.02, color: const Color.fromARGB(255, 0, 255, 65)),
          (value: 0.05, color: const Color.fromARGB(255, 82, 255, 0)),
          (value: 0.1, color: const Color.fromARGB(255, 178, 255, 0)),
          (value: 0.2, color: const Color.fromARGB(255, 228, 255, 0)),
          (value: 0.5, color: const Color.fromARGB(255, 255, 243, 0)),
          (value: 1.0, color: const Color.fromARGB(255, 255, 226, 0)),
          (value: 2.0, color: const Color.fromARGB(255, 255, 175, 0)),
          (value: 5.0, color: const Color.fromARGB(255, 255, 114, 0)),
          (value: 10.0, color: const Color.fromARGB(255, 255, 70, 0)),
          (value: 20.0, color: const Color.fromARGB(255, 255, 28, 0)),
          (value: 50.0, color: const Color.fromARGB(255, 218, 0, 0)),
          (value: 100.0, color: const Color.fromARGB(255, 172, 0, 0)),
        ];
      case KyoshinMonitorScaleType.pgd:
        scaleData = [
          (value: 0.0001, color: const Color.fromARGB(255, 0, 8, 255)),
          (value: 0.0002, color: const Color.fromARGB(255, 0, 48, 255)),
          (value: 0.0005, color: const Color.fromARGB(255, 0, 156, 255)),
          (value: 0.001, color: const Color.fromARGB(255, 0, 255, 179)),
          (value: 0.002, color: const Color.fromARGB(255, 0, 255, 65)),
          (value: 0.005, color: const Color.fromARGB(255, 82, 255, 0)),
          (value: 0.01, color: const Color.fromARGB(255, 178, 255, 0)),
          (value: 0.02, color: const Color.fromARGB(255, 228, 255, 0)),
          (value: 0.05, color: const Color.fromARGB(255, 255, 243, 0)),
          (value: 0.1, color: const Color.fromARGB(255, 255, 226, 0)),
          (value: 0.2, color: const Color.fromARGB(255, 255, 175, 0)),
          (value: 0.5, color: const Color.fromARGB(255, 255, 114, 0)),
          (value: 1.0, color: const Color.fromARGB(255, 255, 70, 0)),
          (value: 2.0, color: const Color.fromARGB(255, 255, 28, 0)),
          (value: 5.0, color: const Color.fromARGB(255, 218, 0, 0)),
          (value: 10.0, color: const Color.fromARGB(255, 172, 0, 0)),
        ];
    }

    // 各色のセグメントの幅を計算
    final segmentWidth = size.width / scaleData.length;

    // 各セグメントを描画
    for (var i = 0; i < scaleData.length; i++) {
      final rect = Rect.fromLTWH(
        i * segmentWidth,
        0,
        segmentWidth,
        size.height,
      );
      paint.color = scaleData[i].color;
      canvas.drawRect(rect, paint);
    }

    // 目盛りの描画
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    // 目盛りを描画する間隔を決定
    final tickInterval = type == KyoshinMonitorScaleType.intensity ? 1 : 4;
    for (var i = 0; i < scaleData.length; i += tickInterval) {
      final value = scaleData[i].value;
      final text = switch (type) {
        KyoshinMonitorScaleType.intensity => value.toStringAsFixed(0),
        KyoshinMonitorScaleType.pga =>
          value < 1 ? value.toStringAsFixed(2) : value.toStringAsFixed(0),
        KyoshinMonitorScaleType.pgv =>
          value < 1 ? value.toStringAsFixed(3) : value.toStringAsFixed(0),
        KyoshinMonitorScaleType.pgd =>
          value < 1 ? value.toStringAsFixed(4) : value.toStringAsFixed(0),
      };

      textPainter
        ..text = TextSpan(
          text: text,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 10,
          ),
        )
        ..layout();

      textPainter.paint(
        canvas,
        Offset(
          i * segmentWidth + (segmentWidth - textPainter.width) / 2,
          size.height + 2,
        ),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// カラースケールを表示するWidget（単位付き）
class KyoshinMonitorScaleWithUnit extends StatelessWidget {
  const KyoshinMonitorScaleWithUnit({
    required this.type,
    required this.width,
    required this.height,
    super.key,
  });

  final KyoshinMonitorScaleType type;
  final double width;
  final double height;

  String get _unit => switch (type) {
        KyoshinMonitorScaleType.intensity => '',
        KyoshinMonitorScaleType.pga => 'gal',
        KyoshinMonitorScaleType.pgv => 'kine',
        KyoshinMonitorScaleType.pgd => 'cm',
      };

  String get _title => switch (type) {
        KyoshinMonitorScaleType.intensity => '震度',
        KyoshinMonitorScaleType.pga => '最大加速度',
        KyoshinMonitorScaleType.pgv => '最大速度',
        KyoshinMonitorScaleType.pgd => '最大変位',
      };

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$_title${_unit.isNotEmpty ? ' ($_unit)' : ''}',
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        KyoshinMonitorScale(
          type: type,
          width: width,
          height: height,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
