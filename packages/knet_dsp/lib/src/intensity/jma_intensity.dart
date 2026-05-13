import 'dart:math' as math;

import 'package:knet_dsp/src/complex.dart';
import 'package:knet_dsp/src/spectrum/fft.dart';

/// JMA 計測震度の計算結果
class JmaIntensityResult {
  const JmaIntensityResult({
    required this.instrumentalIntensity,
    required this.a03,
    required this.jmaScale,
  });

  /// 計測震度 I（連続値）
  final double instrumentalIntensity;

  /// 0.3 秒継続最大加速度 a0.3 [同入力単位]
  final double a03;

  /// JMA 震度スケール（0〜7、0.5刻みで丸め）
  final String jmaScale;

  /// 連続値から JMA 震度スケール文字列へ変換します。
  static String toJmaScale(double i) {
    if (i < 0.5) {
      return '0';
    }
    if (i < 1.5) {
      return '1';
    }
    if (i < 2.5) {
      return '2';
    }
    if (i < 3.5) {
      return '3';
    }
    if (i < 4.5) {
      return '4';
    }
    if (i < 5.0) {
      return '5-';
    }
    if (i < 5.5) {
      return '5+';
    }
    if (i < 6.0) {
      return '6-';
    }
    if (i < 6.5) {
      return '6+';
    }
    return '7';
  }
}

/// JMA 計測震度計算クラス
///
/// 気象庁の計測震度算出方法（2003年改訂版）に基づき実装しています。
/// 参考: https://www.jma.go.jp/jma/press/0303/27a/kaisetsu.pdf
///
/// ## 計算手順
/// 1. 3 成分（NS/EW/UD）の加速度波形を受け取る
/// 2. JMA 指定フィルタを周波数領域で適用
///    伝達関数: H(f) = 1 / (f * sqrt(1+(f/10)²) * sqrt(1+(0.5/f)²))
/// 3. 3 成分のベクトル合成: a(t) = sqrt(aNS² + aEW² + aUD²)
/// 4. 0.3 秒以上継続する最大加速度 a0.3 を求める
/// 5. 計測震度: I = 2 * log10(a0.3) + 0.94
class JmaIntensityCalculator {
  const JmaIntensityCalculator({this.fft = const Fft()});

  final Fft fft;

  /// 3 成分の加速度時系列から JMA 計測震度を計算します。
  ///
  /// ns/ew/ud は各成分の加速度 (gal = cm/s²)、dt はサンプリング間隔 (s) です。
  JmaIntensityResult compute({
    required List<double> ns,
    required List<double> ew,
    required List<double> ud,
    required double dt,
  }) {
    // 1. JMA フィルタを各成分に適用
    final fNs = _applyJmaFilter(ns, dt);
    final fEw = _applyJmaFilter(ew, dt);
    final fUd = _applyJmaFilter(ud, dt);

    // 2. ベクトル合成振幅
    final n = math.min(math.min(fNs.length, fEw.length), fUd.length);
    final composite = List<double>.generate(n, (i) {
      return math.sqrt(fNs[i] * fNs[i] + fEw[i] * fEw[i] + fUd[i] * fUd[i]);
    });

    // 3. 0.3 秒継続最大加速度を求める
    final a03 = _computeA03(composite, dt);

    // 4. 計測震度（a03=0 の場合は -infinity になるが、例外は投げない）
    final intensity = 2.0 * math.log(a03) / math.ln10 + 0.94;

    return JmaIntensityResult(
      instrumentalIntensity: intensity,
      a03: a03,
      jmaScale: JmaIntensityResult.toJmaScale(intensity),
    );
  }

  /// JMA 指定フィルタを周波数領域で適用します。
  ///
  /// 伝達関数: H(f) = 1 / (f * sqrt(1+(f/10)²) * sqrt(1+(0.5/f)²))
  /// DC 成分（f=0）は 0 として処理します。
  List<double> _applyJmaFilter(List<double> x, double dt) {
    final spectrum = fft.forward(x);
    final n = spectrum.length;
    final df = 1.0 / (n * dt);

    final filtered = List<Complex>.generate(n, (i) {
      // 周波数インデックスを実周波数に変換（負周波数は折り返し）
      final fi = i <= n ~/ 2 ? i : n - i;
      final f = fi * df;

      if (f == 0.0) {
        // DC 成分は 0 にする（H(0) は特異点）
        return const Complex(0, 0);
      } else {
        final hf = _jmaH(f);
        return spectrum[i] * hf;
      }
    });

    return fft.inverseReal(filtered).sublist(0, x.length);
  }

  /// JMA フィルタの伝達関数振幅 H(f)
  double _jmaH(double f) {
    return 1.0 /
        (f *
            math.sqrt(1.0 + (f / 10.0) * (f / 10.0)) *
            math.sqrt(1.0 + (0.5 / f) * (0.5 / f)));
  }

  /// 0.3 秒以上継続する最大加速度を求めます。
  ///
  /// アルゴリズム: 振幅の降順ソートで、k*dt >= 0.3 となる最初の値を返します。
  /// これは「閾値 a を超えるサンプル数 × dt >= 0.3 となる最大 a」に相当します。
  double _computeA03(List<double> composite, double dt) {
    if (composite.isEmpty) {
      return 0;
    }

    // 降順にソート
    final sorted = List<double>.from(composite)..sort((a, b) => b.compareTo(a));

    // 0.3 秒分のサンプル数（繰り上げ）
    final kThreshold = (0.3 / dt).ceil();

    if (kThreshold >= sorted.length) {
      return sorted.last;
    }

    // k 番目（0-indexed）の値が a0.3
    return sorted[kThreshold];
  }
}
