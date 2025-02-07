import 'dart:math';

import 'package:flutter/material.dart';

/// 強震モニタのカラースケールを表示するWidget
///
/// [type] スケールの種類（震度、PGA、PGV、PGD）
/// [width] スケールの幅
/// [height] スケールの高さ
/// [tickInterval] 目盛りの間隔（震度の場合は1固定）
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
  final int tickInterval;

  /// カラーストップの計算
  ///
  /// 各値に対応する位置と色を計算します
  List<({double position, double value, Color color})> get colorStops {
    final values = type.scaleValues;
    return List.generate(
      values.length,
      (i) {
        final value = values[i];
        final position = type.convertToPosition(value);
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

  /// カラーテーブル
  ///
  /// 強震モニタの色テーブル
  /// (position, Color)のタプルのリスト
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
}

/// カラースケールの種類
enum KyoshinMonitorScaleType {
  /// 震度
  intensity,

  /// 最大加速度（PGA: Peak Ground Acceleration）
  pga,

  /// 最大速度（PGV: Peak Ground Velocity）
  pgv,

  /// 最大変位（PGD: Peak Ground Displacement）
  pgd,
  ;

  /// 値を0-1の範囲に正規化する
  ///
  /// [value] 正規化する値
  /// returns 0-1の範囲に正規化された値
  double convertToPosition(double value) {
    if (this == KyoshinMonitorScaleType.intensity) {
      return (value - minValue) / (maxValue - minValue);
    }
    return (log(value) / ln10 - log(minValue) / ln10) /
        (log(maxValue) / ln10 - log(minValue) / ln10);
  }

  /// 単位を取得
  String get unit => switch (this) {
        KyoshinMonitorScaleType.intensity => '',
        KyoshinMonitorScaleType.pga => 'gal',
        KyoshinMonitorScaleType.pgv => 'kine',
        KyoshinMonitorScaleType.pgd => 'cm',
      };

  /// タイトルを取得
  String get title => switch (this) {
        KyoshinMonitorScaleType.intensity => '震度',
        KyoshinMonitorScaleType.pga => '最大加速度',
        KyoshinMonitorScaleType.pgv => '最大速度',
        KyoshinMonitorScaleType.pgd => '最大変位',
      };

  /// 最小値を取得
  double get minValue => switch (this) {
        KyoshinMonitorScaleType.intensity => -3.0,
        KyoshinMonitorScaleType.pga => 0.01,
        KyoshinMonitorScaleType.pgv => 0.001,
        KyoshinMonitorScaleType.pgd => 0.0001,
      };

  /// 最大値を取得
  double get maxValue => switch (this) {
        KyoshinMonitorScaleType.intensity => 7.0,
        KyoshinMonitorScaleType.pga => 1000.0,
        KyoshinMonitorScaleType.pgv => 100.0,
        KyoshinMonitorScaleType.pgd => 10.0,
      };

  /// スケール値のリストを取得
  List<double> get scaleValues => switch (this) {
        KyoshinMonitorScaleType.intensity =>
          List.generate(11, (i) => i - 3).map((e) => e.toDouble()).toList(),
        KyoshinMonitorScaleType.pga => _generateLogValues(0.01, 1000),
        KyoshinMonitorScaleType.pgv => _generateLogValues(0.001, 100),
        KyoshinMonitorScaleType.pgd => _generateLogValues(0.0001, 10),
      };

  /// 対数スケールの値を生成
  List<double> _generateLogValues(double min, double max) {
    return [
      min,
      min * 2,
      min * 5,
      min * 10,
      min * 20,
      min * 50,
      min * 100,
      min * 200,
      min * 500,
      min * 1000,
      min * 2000,
      min * 5000,
      min * 10000,
      min * 20000,
      min * 50000,
      max,
    ];
  }
}

/// カラースケールの描画を行うCustomPainter
class _KyoshinMonitorScalePainter extends CustomPainter {
  const _KyoshinMonitorScalePainter({
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

    // 目盛りを描画する間隔を決定（震度は1固定）
    final interval =
        type == KyoshinMonitorScaleType.intensity ? 1 : tickInterval;

    // 文字の重なりを検出するために、前の文字の範囲を保持
    double? previousTextRight;
    var isOverlapping = false;

    // まず全ての目盛りをチェックして重なりがあるか確認
    for (var i = 0; i < colorStops.length; i += interval) {
      final stop = colorStops[i];
      final x = stop.position * size.width;
      final text = _formatValue(stop.value);

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

    // 目盛りの描画
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
      final text = _formatValue(stop.value);

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
        canvas.translate(x - textPainter.width / 2, size.height + 8);
        canvas.rotate(-0.8);
        textPainter.paint(canvas, Offset.zero);
        canvas.restore();
      } else {
        // 重ならない場合は通常通り表示
        textPainter.paint(
          canvas,
          Offset(x - textPainter.width / 2, size.height + 6),
        );
      }
    }
  }

  /// 値のフォーマット
  ///
  /// 値の大きさに応じて小数点以下の桁数を調整します
  /// - 1以上: 整数
  /// - 0.1以上: 小数点1桁
  /// - 0.01以上: 小数点2桁
  /// - 0.001以上: 小数点3桁
  /// - それ以下: 小数点4桁
  String _formatValue(double value) {
    if (value >= 1 || value <= 0) {
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
  bool shouldRepaint(covariant _KyoshinMonitorScalePainter oldDelegate) =>
      false;
}
