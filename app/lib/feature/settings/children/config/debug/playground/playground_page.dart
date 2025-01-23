// ignore_for_file: avoid_classes_with_only_static_members

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PlaygroundRoute extends GoRouteData {
  const PlaygroundRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return Scaffold(
      appBar: AppBar(title: const Text('Playground')),
      body: const ScaleCheckList(),
    );
  }
}

/// ***************************************************************************
/// *** 元記事で使われた「色→p」「p→色」をまとめて定義 ***
/// ***************************************************************************

/// （1）「色→p」
///  - Hue大きい/中間/赤付近(Value利用) で区間分けされた多項式をそのまま使う。
///  - colorToScalePosition は前回のサンプルを簡略化して記載。
class ColorToScale {
  /// RGB→HSV変換 (Flutter標準の HSVColor.fromColor(color) を利用)
  static double colorToScalePosition(Color color) {
    // HSVに変換 (hue=0..360, s=0..1, v=0..1)
    final hsv = HSVColor.fromColor(color);

    final hDeg = hsv.hue; // 0..360
    final s = hsv.saturation; // 0..1
    final v = hsv.value; // 0..1

    // 色がスケール外(彩度や明度が低すぎるなど)なら0扱い
    if (v <= 0.1 || s <= 0.75) {
      return 0;
    }

    // Hueを0..1に正規化
    final h = hDeg / 360.0;
    double p;

    // 区間分け
    if (h > 0.1476) {
      // 6次多項式
      p = 280.31 * math.pow(h, 6) -
          916.05 * math.pow(h, 5) +
          1142.60 * math.pow(h, 4) -
          709.95 * math.pow(h, 3) +
          234.65 * math.pow(h, 2) -
          40.27 * h +
          3.2217;
    } else if (h > 0.001) {
      // 4次
      p = 151.4 * math.pow(h, 4) -
          49.32 * math.pow(h, 3) +
          6.753 * math.pow(h, 2) -
          2.481 * h +
          0.9033;
    } else {
      // Hue≒0 (赤付近) => Value(明度)で2次多項式
      p = -0.005171 * math.pow(v, 2) - 0.3282 * v + 1.2236;
    }

    // 0..1にクランプ
    if (p < 0.0) {
      p = 0.0;
    }
    if (p > 1.0) {
      p = 1.0;
    }
    return p;
  }
}

/// （2）「p→色」（逆変換）
///  - 「p=0..1」を区間で分けて、それぞれの多項式を二分法で逆解。
///  - scaleToColor は前回サンプルのコードを流用
class ScaleToColor {
  static double _fA(double h) {
    return 280.31 * math.pow(h, 6) -
        916.05 * math.pow(h, 5) +
        1142.60 * math.pow(h, 4) -
        709.95 * math.pow(h, 3) +
        234.65 * math.pow(h, 2) -
        40.27 * h +
        3.2217;
  }

  static double _fB(double h) {
    return 151.4 * math.pow(h, 4) -
        49.32 * math.pow(h, 3) +
        6.753 * math.pow(h, 2) -
        2.481 * h +
        0.9033;
  }

  static double _fC(double v) {
    return -0.005171 * math.pow(v, 2) - 0.3282 * v + 1.2236;
  }

  /// p→色を求める
  static Color scaleToColor(double p) {
    assert(p >= 0.0 && p <= 1.0, 'p must be in [0.0..1.0]');

    var h = 0.0;
    const s = 1.0;
    var v = 1.0;

    if (p <= 0.60) {
      // 区間A: fA(h)=p, h in [0.1476..1.0], 単調減少
      h = _solveMonotonicallyDecreasing(p, 0.1476, 1, _fA);
    } else if (p <= 0.90) {
      // 区間B: fB(h)=p, h in [0.001..0.1476], 単調減少
      h = _solveMonotonicallyDecreasing(p, 0.001, 0.1476, _fB);
    } else {
      // 区間C: fC(v)=p, v in [0.0..1.0], 単調減少, h=0
      h = 0.0;
      v = _solveMonotonicallyDecreasing(p, 0, 1, _fC);
    }

    // hue 0..1 を 0..360 度へ
    final hueDeg = h * 360.0;
    final hsvColor = HSVColor.fromAHSV(1, hueDeg, s, v);
    return hsvColor.toColor();
  }

  /// 二分法で「f(x)=target」を単調減少として逆解
  static double _solveMonotonicallyDecreasing(
    double target,
    double lower,
    double upper,
    double Function(double) f,
  ) {
    final fL = f(lower);
    final fU = f(upper);

    if (target >= fL) {
      return lower;
    }
    if (target <= fU) {
      return upper;
    }

    for (var i = 0; i < 30; i++) {
      final mid = 0.5 * (lower + upper);
      final fM = f(mid);
      if ((fM - target).abs() < 1e-7) {
        return mid;
      }
      if (fM > target) {
        // f(mid)がまだ大きい => x上げる
        lower = mid;
      } else {
        upper = mid;
      }
    }
    return 0.5 * (lower + upper);
  }
}

/// ***************************************************************************
/// *** 画面: 複数の p で「p→色→p'」を確認し、差分を表示 ***
/// ***************************************************************************

class ScaleCheckList extends StatelessWidget {
  const ScaleCheckList({super.key});

  @override
  Widget build(BuildContext context) {
    // 0.00, 0.05, 0.10, ..., 1.00 の101ステップ
    final pValues = List.generate(101, (index) => index * 0.01);

    return ListView.builder(
      itemCount: pValues.length,
      itemBuilder: (context, index) {
        final p = pValues[index];
        // p→Color
        final color = ScaleToColor.scaleToColor(p);
        // さらにColor→p'
        final p2 = ColorToScale.colorToScalePosition(color);

        // 差分
        final diff = p2 - p;

        // 差分の絶対値が大きいと、文字の色を赤系にする等の例
        final absDiff = diff.abs();
        final textColor = absDiff < 0.002
            ? Colors.green
            : (absDiff < 0.01 ? Colors.orange : Colors.red);

        return Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black12),
          ),
          child: Row(
            children: [
              // 1) p の表示
              SizedBox(
                width: 50,
                child: Text('p=${p.toStringAsFixed(2)}'),
              ),
              // 2) p->Color の見た目を 50x50 で表示
              Container(
                width: 50,
                height: 50,
                color: color,
                margin: const EdgeInsets.symmetric(horizontal: 8),
              ),
              // 3) 再度 求めた p'
              SizedBox(
                width: 60,
                child: Text("p'=${p2.toStringAsFixed(2)}"),
              ),
              // 4) 差分
              Expanded(
                child: Row(
                  children: [
                    const Text('差分: '),
                    Text(
                      diff.toStringAsFixed(4),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
