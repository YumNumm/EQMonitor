import 'dart:math';

/// 応答スペクトル計算結果
class ResponseSpectrumResult {
  const ResponseSpectrumResult({
    required this.periods,
    required this.sa,
    required this.sv,
    required this.sd,
  });

  /// 周期 T (s)
  final List<double> periods;

  /// 擬似加速度応答スペクトル Sa (gal)
  final List<double> sa;

  /// 擬似速度応答スペクトル Sv (cm/s)
  final List<double> sv;

  /// 変位応答スペクトル Sd (cm)
  final List<double> sd;

  /// SI値 (cm/s) — Housner スペクトル強度
  ///
  /// SI = (1/2.4) * ∫[0.1, 2.5] Sv(T, h=0.2) dT
  /// (h=0.2 の場合のみ意味がある)
  double get siValue {
    var integral = 0.0;
    for (var i = 1; i < periods.length; i++) {
      final t0 = periods[i - 1];
      final t1 = periods[i];
      if (t0 >= 2.5 || t1 <= 0.1) {
        continue;
      }
      final tLo = t0 < 0.1 ? 0.1 : t0;
      final tHi = t1 > 2.5 ? 2.5 : t1;
      // 台形積分（インデックス境界をクランプ）
      final svLo = sv[i - 1];
      final svHi = sv[i];
      integral += (svLo + svHi) * (tHi - tLo) * 0.5;
    }
    return integral / 2.4;
  }
}

/// 1自由度系の応答スペクトルを Nigam-Jennings 法で計算する
///
/// 参考: Nigam & Jennings (1969), BSSA vol. 59
class KnetResponseSpectrum {
  const KnetResponseSpectrum._();

  /// 応答スペクトルを計算する
  ///
  /// [accelGal] バイアス除去済み加速度 (gal)
  /// [dt] サンプリング間隔 (s)
  /// [dampingRatio] 減衰定数 h (無次元, 例: 0.05)
  /// [periods] 評価する周期リスト (s)
  static ResponseSpectrumResult compute(
    List<double> accelGal,
    double dt,
    double dampingRatio, {
    List<double>? periods,
  }) {
    final T = periods ?? _defaultPeriods();
    final sa = List<double>.filled(T.length, 0);
    final sv = List<double>.filled(T.length, 0);
    final sd = List<double>.filled(T.length, 0);

    for (var pi = 0; pi < T.length; pi++) {
      final t = T[pi];
      final wn = 2 * pi / t;
      final wd = wn * sqrt(1 - dampingRatio * dampingRatio);
      final e = exp(-dampingRatio * wn * dt);
      final sinD = sin(wd * dt);
      final cosD = cos(wd * dt);
      final xi = dampingRatio;
      final sqrtTerm = sqrt(1 - xi * xi);

      // Nigam-Jennings 遷移行列
      final a11 = e * (cosD + xi / sqrtTerm * sinD);
      final a12 = e * sinD / wd;
      final a21 = -wn / sqrtTerm * e * sinD;
      final a22 = e * (cosD - xi / sqrtTerm * sinD);

      // 定加速度を仮定した particular solution 係数
      final b1 = (a11 - 1.0) / (wn * wn);
      final b2 = a21 / (wn * wn);

      var u = 0.0;
      var v = 0.0;
      var sdMax = 0.0;

      for (final ag in accelGal) {
        final u2 = a11 * u + a12 * v + b1 * ag;
        final v2 = a21 * u + a22 * v + b2 * ag;
        u = u2;
        v = v2;
        final absU = u.abs();
        if (absU > sdMax) {
          sdMax = absU;
        }
      }

      sd[pi] = sdMax;
      // PSv = ωn * Sd (cm/s)
      sv[pi] = wn * sdMax;
      // PSa = ωn² * Sd (gal) = ωn * PSv
      sa[pi] = wn * wn * sdMax;
    }

    return ResponseSpectrumResult(periods: T, sa: sa, sv: sv, sd: sd);
  }

  /// 対数等間隔の周期リスト (0.05〜5 s, 100点)
  static List<double> _defaultPeriods() {
    const n = 100;
    const logMin = -1.301; // log10(0.05)
    const logMax = 0.699;  // log10(5.0)
    return List.generate(
      n,
      (i) => pow(10.0, logMin + (logMax - logMin) * i / (n - 1)).toDouble(),
    );
  }

  /// SI値計算用の周期リスト (0.1〜2.5 s, 49点)
  static List<double> siPeriods() => List.generate(
    49,
    (i) => 0.1 + 2.4 * i / 48,
  );
}
