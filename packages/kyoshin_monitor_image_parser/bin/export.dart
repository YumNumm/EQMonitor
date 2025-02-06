import 'dart:convert';
import 'dart:math' as math;

/// シンプルなカラークラス
class Color {
  const Color(this.red, this.green, this.blue);

  final int red;
  final int green;
  final int blue;

  static Color fromRGB(int r, int g, int b) {
    return Color(
      r.clamp(0, 255),
      g.clamp(0, 255),
      b.clamp(0, 255),
    );
  }
}

/// ***************************************************************************
/// *** 1) p -> (h, s, v) : 区分多項式を二分法で逆解 ***
/// ***************************************************************************

/// 6次式 fA(h)
double _fA(double h) {
  return 280.31 * math.pow(h, 6) -
      916.05 * math.pow(h, 5) +
      1142.60 * math.pow(h, 4) -
      709.95 * math.pow(h, 3) +
      234.65 * math.pow(h, 2) -
      40.27 * h +
      3.2217;
}

/// 4次式 fB(h)
double _fB(double h) {
  return 151.4 * math.pow(h, 4) -
      49.32 * math.pow(h, 3) +
      6.753 * math.pow(h, 2) -
      2.481 * h +
      0.9033;
}

/// 2次式 fC(v)
double _fC(double v) {
  return -0.005171 * math.pow(v, 2) - 0.3282 * v + 1.2236;
}

/// 「p -> (h, s, v)」
List<double> scaleToHsv(double p) {
  assert(p >= 0.0 && p <= 1.0, 'p must be in [0.0..1.0]');

  var h = 0.0;
  const s = 1.0; // 常に高彩度と仮定
  var v = 1.0;

  if (p <= 0.60) {
    // 区間A: fA(h) = p  (h in [0.1476..1.0])
    h = _solveMonotonicallyDecreasing(
      target: p,
      lower: 0.1476,
      upper: 1,
      func: _fA,
    );
  } else if (p <= 0.90) {
    // 区間B: fB(h) = p  (h in [0.001..0.1476])
    h = _solveMonotonicallyDecreasing(
      target: p,
      lower: 0.001,
      upper: 0.1476,
      func: _fB,
    );
  } else {
    // 区間C: fC(v) = p  (v in [0..1]) + h=0固定
    h = 0.0;
    v = _solveMonotonicallyDecreasing(
      target: p,
      lower: 0,
      upper: 1,
      func: _fC,
    );
  }
  return [h, s, v];
}

/// 二分法で「単調減少」f(x)=target を解く
double _solveMonotonicallyDecreasing({
  required double target,
  required double lower,
  required double upper,
  required double Function(double) func,
}) {
  final fL = func(lower);
  final fU = func(upper);
  if (target >= fL) {
    return lower;
  }
  if (target <= fU) {
    return upper;
  }

  for (var i = 0; i < 30; i++) {
    final mid = 0.5 * (lower + upper);
    final fM = func(mid);
    if ((fM - target).abs() < 1e-7) {
      return mid;
    }
    // 単調減少なので、f(mid)>target -> xを大きく
    if (fM > target) {
      lower = mid;
    } else {
      upper = mid;
    }
  }
  return 0.5 * (lower + upper);
}

/// ***************************************************************************
/// *** 2) (h, s, v) -> (r, g, b) の自前実装
///     Hue,Sat,Val は [0..1]、  RGBは [0..255]
/// ***************************************************************************

List<int> hsvToRgb(double h, double s, double v) {
  // hは0..1を想定 → 0..360度へ
  final hueDeg = (h * 360.0) % 360.0;
  final c = v * s;
  final hh = hueDeg / 60.0; // 0..6
  final x = c * (1.0 - ((hh % 2) - 1.0).abs());

  double r1;
  double g1;
  double b1;
  if (hh < 1) {
    r1 = c;
    g1 = x;
    b1 = 0;
  } else if (hh < 2) {
    r1 = x;
    g1 = c;
    b1 = 0;
  } else if (hh < 3) {
    r1 = 0;
    g1 = c;
    b1 = x;
  } else if (hh < 4) {
    r1 = 0;
    g1 = x;
    b1 = c;
  } else if (hh < 5) {
    r1 = x;
    g1 = 0;
    b1 = c;
  } else {
    r1 = c;
    g1 = 0;
    b1 = x;
  }

  final m = v - c;
  final r = r1 + m;
  final g = g1 + m;
  final b = b1 + m;

  var rr = (r * 255).round();
  var gg = (g * 255).round();
  var bb = (b * 255).round();
  rr = rr.clamp(0, 255);
  gg = gg.clamp(0, 255);
  bb = bb.clamp(0, 255);

  return [rr, gg, bb];
}

/// ***************************************************************************
/// *** 3) (r, g, b) -> (h, s, v) の自前実装
///     RGBは [0..255]、  Hue,Sat,Val は [0..1]
/// ***************************************************************************

List<double> rgbToHsv(int r, int g, int b) {
  final rr = r / 255.0;
  final gg = g / 255.0;
  final bb = b / 255.0;

  final cMax = math.max(rr, math.max(gg, bb));
  final cMin = math.min(rr, math.min(gg, bb));
  final delta = cMax - cMin;

  var h = 0.0;
  var s = 0.0;
  final v = cMax;

  // Hue計算 (0..1)
  if (delta == 0) {
    h = 0.0; // グレイ
  } else if (cMax == rr) {
    // (gg - bb)/delta in [-1..1]  → /6で [ -1/6..1/6 ]
    h = ((gg - bb) / delta) % 6;
    h = h / 6.0; // 0..1
  } else if (cMax == gg) {
    h = ((bb - rr) / delta + 2) / 6.0;
  } else {
    h = ((rr - gg) / delta + 4) / 6.0;
  }
  if (h < 0) {
    h += 1.0;
  }

  // Sat計算
  if (cMax == 0) {
    s = 0.0;
  } else {
    s = delta / cMax;
  }

  return [h, s, v];
}

/// ***************************************************************************
/// *** 4) (h, s, v) -> p : 元記事の順方向(色→p)
/// ***************************************************************************

double hsvToScale(double h, double s, double v) {
  // 記事どおり: s<=0.75, v<=0.1 はスケール外→0
  if (v <= 0.1 || s <= 0.75) {
    return 0;
  }

  double p;
  // Hueは 0..1 前提
  if (h > 0.1476) {
    // A区間
    p = _fA(h);
  } else if (h > 0.001) {
    // B区間
    p = _fB(h);
  } else {
    // C区間 (Hue≒0 → Valueで計算)
    p = _fC(v);
  }

  // clamp
  if (p < 0) {
    p = 0;
  }
  if (p > 1) {
    p = 1;
  }
  return p;
}

/// ***************************************************************************
/// *** 5) 2点間の色を補間する ***
/// ***************************************************************************
Color _interpolateColor(Color a, Color b, double t) {
  return Color(
    (a.red + (b.red - a.red) * t).round(),
    (a.green + (b.green - a.green) * t).round(),
    (a.blue + (b.blue - a.blue) * t).round(),
  );
}

/// ***************************************************************************
/// *** 6) position値から色を計算する ***
/// ***************************************************************************
Color _calculateColorForPosition(
    double position, List<({double value, Color color})> scaleData) {
  if (position <= 0) {
    return scaleData.first.color;
  }
  if (position >= 1) {
    return scaleData.last.color;
  }

  // positionに最も近い2つの色を見つける
  for (var i = 0; i < scaleData.length - 1; i++) {
    final currentP = scaleData[i].value;
    final nextP = scaleData[i + 1].value;

    if (position >= currentP && position <= nextP) {
      // 2点間の比率を計算
      final t = (position - currentP) / (nextP - currentP);
      return _interpolateColor(scaleData[i].color, scaleData[i + 1].color, t);
    }
  }

  return scaleData.last.color;
}

/// ***************************************************************************
/// *** メイン: テーブルを作成し JSON出力 ***
/// ***************************************************************************

void main() {
  // position値の分割数
  const positionSteps = 20;

  final result = {
    'intensity': <Map<String, dynamic>>[],
    'pga': <Map<String, dynamic>>[],
    'pgv': <Map<String, dynamic>>[],
    'pgd': <Map<String, dynamic>>[],
  };

  // 震度のリスト (-3 ~ 7)
  final intensityList = List.generate(11, (i) => -3.0 + i.toDouble());

  // PGAの値のリスト (gal)
  final pgaList = [
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

  // PGVの値のリスト (kine)
  final pgvList = [
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

  // PGDの値のリスト (cm)
  final pgdList = [
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

  // 震度のカラーマップを作成
  final intensityColorMap = intensityList.map((value) {
    final p = (value + 3) / 10;
    final hsv = scaleToHsv(p);
    final rgb = hsvToRgb(hsv[0], hsv[1], hsv[2]);
    return (
      value: p,
      color: Color.fromRGB(rgb[0], rgb[1], rgb[2]),
    );
  }).toList();

  // PGAのカラーマップを作成
  final pgaColorMap = pgaList.map((value) {
    final p = (math.log(value) / math.ln10 + 2) / 5;
    final hsv = scaleToHsv(p);
    final rgb = hsvToRgb(hsv[0], hsv[1], hsv[2]);
    return (
      value: p,
      color: Color.fromRGB(rgb[0], rgb[1], rgb[2]),
    );
  }).toList();

  // PGVのカラーマップを作成
  final pgvColorMap = pgvList.map((value) {
    final p = (math.log(value) / math.ln10 + 3) / 5;
    final hsv = scaleToHsv(p);
    final rgb = hsvToRgb(hsv[0], hsv[1], hsv[2]);
    return (
      value: p,
      color: Color.fromRGB(rgb[0], rgb[1], rgb[2]),
    );
  }).toList();

  // PGDのカラーマップを作成
  final pgdColorMap = pgdList.map((value) {
    final p = (math.log(value) / math.ln10 + 4) / 5;
    final hsv = scaleToHsv(p);
    final rgb = hsvToRgb(hsv[0], hsv[1], hsv[2]);
    return (
      value: p,
      color: Color.fromRGB(rgb[0], rgb[1], rgb[2]),
    );
  }).toList();

  // 震度の補間値を計算
  for (var i = 0; i < positionSteps; i++) {
    final p = i / (positionSteps - 1);
    final value = p * 10 - 3; // -3から7の範囲に変換
    final color = _calculateColorForPosition(p, intensityColorMap);
    result['intensity']!.add({
      'position': p,
      'value': value,
      'r': color.red,
      'g': color.green,
      'b': color.blue,
    });
  }

  // PGAの補間値を計算
  for (var i = 0; i < positionSteps; i++) {
    final p = i / (positionSteps - 1);
    final value = math.pow(10, 5 * p - 2).toDouble();
    final color = _calculateColorForPosition(p, pgaColorMap);
    result['pga']!.add({
      'position': p,
      'value': value,
      'r': color.red,
      'g': color.green,
      'b': color.blue,
    });
  }

  // PGVの補間値を計算
  for (var i = 0; i < positionSteps; i++) {
    final p = i / (positionSteps - 1);
    final value = math.pow(10, 5 * p - 3).toDouble();
    final color = _calculateColorForPosition(p, pgvColorMap);
    result['pgv']!.add({
      'position': p,
      'value': value,
      'r': color.red,
      'g': color.green,
      'b': color.blue,
    });
  }

  // PGDの補間値を計算
  for (var i = 0; i < positionSteps; i++) {
    final p = i / (positionSteps - 1);
    final value = math.pow(10, 5 * p - 4).toDouble();
    final color = _calculateColorForPosition(p, pgdColorMap);
    result['pgd']!.add({
      'position': p,
      'value': value,
      'r': color.red,
      'g': color.green,
      'b': color.blue,
    });
  }

  // JSON文字列化して出力
  const encoder = JsonEncoder.withIndent('  ');
  final jsonStr = encoder.convert(result);
  print(jsonStr);
}
