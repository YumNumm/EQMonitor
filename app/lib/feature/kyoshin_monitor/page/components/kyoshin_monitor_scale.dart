import 'dart:math';

import 'package:flutter/material.dart';

/// 強震モニタのカラースケールを表示するWidget
class KyoshinMonitorScale extends StatelessWidget {
  const KyoshinMonitorScale({
    required this.type,
    required this.width,
    required this.height,
    this.tickInterval = 4,
    super.key,
  });

  final KyoshinMonitorScaleType type;
  final double width;
  final double height;

  /// 目盛りの刻み数（震度の場合は1固定）
  final int tickInterval;

  /// 対数スケールでの正規化を行う
  double _mapToRange(double x, double minX, double maxX) {
    return (log(x) / ln10 - log(minX) / ln10) /
        (log(maxX) / ln10 - log(minX) / ln10);
  }

  List<({double position, double value, Color color})> get colorStops {
    final values = switch (type) {
      KyoshinMonitorScaleType.intensity => _intensityValues,
      KyoshinMonitorScaleType.pga => _pgaValues,
      KyoshinMonitorScaleType.pgv => _pgvValues,
      KyoshinMonitorScaleType.pgd => _pgdValues,
    };

    // 最小値と最大値を取得
    final (minValue, maxValue) = switch (type) {
      KyoshinMonitorScaleType.intensity => (-3.0, 7.0),
      KyoshinMonitorScaleType.pga => (0.01, 1000.0),
      KyoshinMonitorScaleType.pgv => (0.001, 100.0),
      KyoshinMonitorScaleType.pgd => (0.0001, 10.0),
    };

    return List.generate(
      values.length,
      (i) {
        final value = values[i].toDouble();
        // 対数スケールでの正規化
        final position = type == KyoshinMonitorScaleType.intensity
            ? (value - minValue) / (maxValue - minValue)
            : _mapToRange(value, minValue, maxValue);
        // positionに最も近い色を選択
        final colorIndex = (position * (_colors.length - 1)).round();
        return (
          position: position,
          value: value,
          color: _colors[colorIndex].$2,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width, height),
      painter: _KyoshinMonitorScalePainter(
        type: type,
        colorStops: colorStops,
        tickInterval: tickInterval,
      ),
    );
  }

  static const _colors = [
    (0.0, Color(0xFF0008FF)),
    (0.02, Color(0xFF0014FF)),
    (0.04, Color(0xFF0021FF)),
    (0.06, Color(0xFF002FFF)),
    (0.08, Color(0xFF0041FF)),
    (0.1, Color(0xFF0057FF)),
    (0.12, Color(0xFF0073FF)),
    (0.14, Color(0xFF009DFF)),
    (0.16, Color(0xFF00DAFF)),
    (0.18, Color(0xFF00FFE5)),
    (0.2, Color(0xFF00FFB3)),
    (0.22, Color(0xFF00FF8A)),
    (0.24, Color(0xFF00FF65)),
    (0.26, Color(0xFF00FF41)),
    (0.28, Color(0xFF00FF1F)),
    (0.3, Color(0xFF05FF00)),
    (0.32, Color(0xFF2BFF00)),
    (0.34, Color(0xFF53FF00)),
    (0.36, Color(0xFF79FF00)),
    (0.38, Color(0xFF99FF00)),
    (0.4, Color(0xFFB2FF00)),
    (0.42, Color(0xFFC6FF00)),
    (0.44, Color(0xFFD6FF00)),
    (0.46, Color(0xFFE4FF00)),
    (0.48, Color(0xFFF0FF00)),
    (0.5, Color(0xFFFAFF00)),
    (0.52, Color(0xFFFFFB00)),
    (0.54, Color(0xFFFFF300)),
    (0.56, Color(0xFFFFEB00)),
    (0.58, Color(0xFFFFE400)),
    (0.6, Color(0xFFFFE200)),
    (0.62, Color(0xFFFFCF00)),
    (0.64, Color(0xFFFFBF00)),
    (0.66, Color(0xFFFFAF00)),
    (0.68, Color(0xFFFFA000)),
    (0.7, Color(0xFFFF9000)),
    (0.72, Color(0xFFFF8100)),
    (0.74, Color(0xFFFF7200)),
    (0.76, Color(0xFFFF6300)),
    (0.78, Color(0xFFFF5400)),
    (0.8, Color(0xFFFF4600)),
    (0.82, Color(0xFFFF3800)),
    (0.84, Color(0xFFFF2A00)),
    (0.86, Color(0xFFFF1C00)),
    (0.88, Color(0xFFFF0F00)),
    (0.9, Color(0xFFFF0200)),
    (0.92, Color(0xFFE90000)),
    (0.94, Color(0xFFD90000)),
    (0.96, Color(0xFFCA0000)),
    (0.98, Color(0xFFBB0000)),
    (1.0, Color(0xFFAC0000)),
  ];

  // 震度の値 (-3~7)
  static const _intensityValues = [
    -3,
    -2,
    -1,
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
  ];

  // PGAの値
  static const _pgaValues = [
    0.01,
    0.02,
    0.05,
    0.1,
    0.2,
    0.5,
    1.0,
    2.0,
    5.0,
    10.0,
    20.0,
    50.0,
    100.0,
    200.0,
    500.0,
    1000.0,
  ];

  // PGVの値
  static const _pgvValues = [
    0.001,
    0.002,
    0.005,
    0.01,
    0.02,
    0.05,
    0.1,
    0.2,
    0.5,
    1.0,
    2.0,
    5.0,
    10.0,
    20.0,
    50.0,
    100.0,
  ];

  // PGDの値
  static const _pgdValues = [
    0.0001,
    0.0002,
    0.0005,
    0.001,
    0.002,
    0.005,
    0.01,
    0.02,
    0.05,
    0.1,
    0.2,
    0.5,
    1.0,
    2.0,
    5.0,
    10.0,
  ];
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
    required this.colorStops,
    required this.tickInterval,
  });

  final KyoshinMonitorScaleType type;
  final List<({double position, double value, Color color})> colorStops;
  final int tickInterval;

  @override
  void paint(Canvas canvas, Size size) {
    // グラデーションの描画
    final rect = Offset.zero & size;
    final gradient = LinearGradient(
      colors: colorStops.map((e) => e.color).toList(),
      stops: colorStops.map((e) => e.position).toList(),
    );
    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.fill;

    canvas.drawRect(rect, paint);

    // 目盛りの描画
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    // 目盛り線の描画用のペイント
    final tickPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    // 目盛りを描画する間隔を決定
    final interval =
        type == KyoshinMonitorScaleType.intensity ? 1 : tickInterval;

    // 文字の重なりを検出するために、前の文字の範囲を保持
    double? previousTextRight;
    var isOverlapping = false;

    // まず全ての目盛りをチェックして重なりがあるか確認
    for (var i = 0; i < colorStops.length; i += interval) {
      final stop = colorStops[i];
      final x = stop.position * size.width;
      final text = switch (type) {
        KyoshinMonitorScaleType.intensity => stop.value.toStringAsFixed(0),
        KyoshinMonitorScaleType.pga => _formatValue(stop.value),
        KyoshinMonitorScaleType.pgv => _formatValue(stop.value),
        KyoshinMonitorScaleType.pgd => _formatValue(stop.value),
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

      final textLeft = x - textPainter.width / 2;
      final textRight = x + textPainter.width / 2;

      if (previousTextRight != null && textLeft < previousTextRight) {
        isOverlapping = true;
        break;
      }
      previousTextRight = textRight;
    }

    // 重なりがある場合は右上に向かって斜めに表示
    for (var i = 0; i < colorStops.length; i += interval) {
      final stop = colorStops[i];
      final x = stop.position * size.width;

      // 目盛り線を描画
      canvas.drawLine(
        Offset(x, size.height),
        Offset(x, size.height + 4),
        tickPaint,
      );

      // 値のテキストを描画
      final text = switch (type) {
        KyoshinMonitorScaleType.intensity => stop.value.toStringAsFixed(0),
        KyoshinMonitorScaleType.pga => _formatValue(stop.value),
        KyoshinMonitorScaleType.pgv => _formatValue(stop.value),
        KyoshinMonitorScaleType.pgd => _formatValue(stop.value),
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

      if (isOverlapping) {
        // 文字が重なる場合は右上に向かって斜めに表示
        canvas.save();
        // 位置を少し上に調整
        canvas.translate(x - textPainter.width / 2, size.height + 8);
        canvas.rotate(-0.8); // より大きな角度で回転（約-45度）
        textPainter.paint(
          canvas,
          Offset.zero, // 回転の基準点を変更したので、オフセットは0に
        );
        canvas.restore();
      } else {
        // 重ならない場合は通常通り表示
        textPainter.paint(
          canvas,
          Offset(
            x - textPainter.width / 2,
            size.height + 6,
          ),
        );
      }
    }
  }

  /// 値のフォーマット
  String _formatValue(double value) {
    if (value >= 1) {
      return value.toStringAsFixed(0);
    } else if (value >= 0.1) {
      return value.toStringAsFixed(1);
    } else if (value >= 0.01) {
      return value.toStringAsFixed(2);
    } else if (value >= 0.001) {
      return value.toStringAsFixed(3);
    } else {
      return value.toStringAsFixed(4);
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
    this.tickInterval = 4,
    super.key,
  });

  final KyoshinMonitorScaleType type;
  final double width;
  final double height;

  /// 目盛りの刻み数（震度の場合は1固定）
  final int tickInterval;

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
          tickInterval: tickInterval,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
