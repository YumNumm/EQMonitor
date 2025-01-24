import 'dart:convert';
import 'dart:math' as math;

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
/// *** メイン: テーブルを作成し JSON出力 (p, r, g, b, pBack, diff) ***
/// ***************************************************************************

void main() {
  // pを 0.00..1.00 の範囲で 0.01 刻み
  const step = 1/16;
  final table = <Map<String, dynamic>>[];

  for (var p = 0.0; p < 1.0 + 1e-9; p += step) {
    // 1) p -> (h, s, v)
    final hsv = scaleToHsv(p);
    // 2) HSV -> (r, g, b)
    final rgb = hsvToRgb(hsv[0], hsv[1], hsv[2]);
    final r = rgb[0];
    final g = rgb[1];
    final b = rgb[2];

    // 3) 再度 (r, g, b) -> (h2, s2, v2)
    final hsv2 = rgbToHsv(r, g, b);
    // 4) (h2, s2, v2) -> pBack
    final pBack = hsvToScale(hsv2[0], hsv2[1], hsv2[2]);
    // 5) diff
    final diff = pBack - p;

    table.add({
      'p': double.parse(p.toStringAsFixed(2)),
      'r': r,
      'g': g,
      'b': b,
      'p_back': pBack,
      'diff': diff,
      'intensity': 10 * p - 3,
      'pga': math.pow(10, 5 * p - 2).toDouble(),
      'pgv': math.pow(10, 5 * p - 3).toDouble(),
      'pgd': math.pow(10, 5 * p - 4).toDouble(),
    });
  }

  // JSON文字列化して出力
  final jsonStr = jsonEncode(table);
  print(jsonStr);

  // 実行例:
  //   dart run main.dart
  // 出力（先頭例）:
  // [
  //   {"p":0,"r":0,"g":0,"b":255,"p_back":0,"diff":0},
  //   {"p":0.01,"r":0,"g":4,"b":255,"p_back":0.01,"diff":0},
  //   ...
  // ]
}
