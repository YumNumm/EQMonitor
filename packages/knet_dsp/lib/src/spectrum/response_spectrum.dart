import 'dart:math' as math;

/// 応答スペクトル解析結果
class ResponseSpectrum {
  const ResponseSpectrum({
    required this.periods,
    required this.sa,
    required this.sv,
    required this.sd,
    required this.dampingRatio,
  });

  /// 固有周期 (s)
  final List<double> periods;

  /// 加速度応答スペクトル（入力単位に応じた値）
  final List<double> sa;

  /// 速度応答スペクトル
  final List<double> sv;

  /// 変位応答スペクトル
  final List<double> sd;

  /// 減衰定数 h
  final double dampingRatio;
}

/// 応答スペクトルを計算するクラス
///
/// Nigam-Jennings 法（1969）による一自由度（SDOF）振動系の応答を計算します。
/// この方法は線形加速度仮定に基づく厳密解を各時間ステップで計算します。
class ResponseSpectrumAnalyzer {
  const ResponseSpectrumAnalyzer({
    this.dampingRatio = 0.05,
    this.periods = _defaultPeriods,
  });

  /// 減衰定数（デフォルト 5%）
  final double dampingRatio;

  /// 計算する固有周期のリスト (s)
  final List<double> periods;

  static const _defaultPeriods = [
    0.01, 0.02, 0.03, 0.04, 0.05,
    0.06, 0.07, 0.08, 0.09, 0.10,
    0.12, 0.15, 0.17, 0.20, 0.25,
    0.30, 0.40, 0.50, 0.60, 0.70,
    0.80, 0.90, 1.00, 1.20, 1.50,
    1.70, 2.00, 2.50, 3.00, 4.00,
    5.00, 6.00, 7.00, 8.00, 9.00,
    10.0,
  ];

  /// 加速度時刻歴から応答スペクトルを計算します。
  ///
  /// accel は加速度時刻歴（任意単位）、dt はサンプリング間隔 (s) です。
  ResponseSpectrum compute(List<double> accel, double dt) {
    final h = dampingRatio;
    final nTime = accel.length;

    final saList = <double>[];
    final svList = <double>[];
    final sdList = <double>[];

    for (final period in periods) {
      final omega = 2.0 * math.pi / period;
      final omegaD = omega * math.sqrt(1.0 - h * h);

      // Nigam-Jennings 係数
      final e = math.exp(-h * omega * dt);
      final sinD = math.sin(omegaD * dt);
      final cosD = math.cos(omegaD * dt);

      final a11 = e * (cosD + h * omega / omegaD * sinD);
      final a12 = e * sinD / omegaD;
      final a21 = -e * omega * omega / omegaD * sinD;
      final a22 = e * (cosD - h * omega / omegaD * sinD);

      final b11 = e *
              ((2.0 * h * h - 1.0) / (omega * omega * dt) +
                  2.0 * h / (omega * omega * omega * dt)) *
              sinD /
              omegaD +
          e * (2.0 * h / (omega * omega) + dt / omega) * cosD -
          2.0 * h / (omega * omega * omega * dt);
      final b12 = -e *
              ((2.0 * h * h - 1.0) / (omega * omega * dt) +
                  2.0 * h / (omega * omega * omega * dt)) *
              sinD /
              omegaD -
          e * (2.0 * h / (omega * omega)) * cosD +
          1.0 / (omega * omega) -
          2.0 * h / (omega * omega * omega * dt);

      final b21 = e *
              ((2.0 * h * h - 1.0) / (omega * omega * dt) +
                  2.0 * h / (omega * omega * omega * dt)) *
              (cosD - h * omega / omegaD * sinD) -
          e *
              (2.0 * h / (omega * omega) + dt / omega) *
              (omegaD * sinD + h * omega * cosD) +
          1.0 / (omega * omega * dt) +
          h / omega;
      final b22 = -e *
              ((2.0 * h * h - 1.0) / (omega * omega * dt) +
                  2.0 * h / (omega * omega * omega * dt)) *
              (cosD - h * omega / omegaD * sinD) +
          e *
              (2.0 * h / (omega * omega)) *
              (omegaD * sinD + h * omega * cosD) -
          1.0 / (omega * omega * dt) +
          (1.0 - 2.0 * h * h / (omega * omega * dt));

      var disp = 0.0;
      var vel = 0.0;
      var maxAbsSa = 0.0;
      var maxAbsSv = 0.0;
      var maxAbsSd = 0.0;

      for (var i = 0; i < nTime - 1; i++) {
        final ag0 = accel[i];
        final ag1 = accel[i + 1];

        final newDisp = a11 * disp + a12 * vel + b11 * ag0 + b12 * ag1;
        final newVel = a21 * disp + a22 * vel + b21 * ag0 + b22 * ag1;

        disp = newDisp;
        vel = newVel;

        // 絶対加速度応答 ag + ü = -(2hω·u̇ + ω²·u)
        final absAccel = (2.0 * h * omega * vel + omega * omega * disp).abs();
        if (absAccel > maxAbsSa) {
          maxAbsSa = absAccel;
        }
        final absVel = vel.abs();
        if (absVel > maxAbsSv) {
          maxAbsSv = absVel;
        }
        final absDisp = disp.abs();
        if (absDisp > maxAbsSd) {
          maxAbsSd = absDisp;
        }
      }

      saList.add(maxAbsSa);
      svList.add(maxAbsSv);
      sdList.add(maxAbsSd);
    }

    return ResponseSpectrum(
      periods: List<double>.from(periods),
      sa: saList,
      sv: svList,
      sd: sdList,
      dampingRatio: h,
    );
  }
}
