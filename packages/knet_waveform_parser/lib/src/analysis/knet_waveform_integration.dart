/// 加速度波形の積分・ベースライン補正ユーティリティ
class KnetWaveformIntegration {
  const KnetWaveformIntegration._();

  /// トラペゾイド積分: 加速度(gal) → 速度(cm/s)、速度 → 変位(cm)
  static List<double> integrate(List<double> data, double dt) {
    if (data.isEmpty) {
      return [];
    }
    final out = List<double>.filled(data.length, 0);
    for (var i = 1; i < data.length; i++) {
      out[i] = out[i - 1] + (data[i - 1] + data[i]) * dt * 0.5;
    }
    return out;
  }

  /// 線形トレンド除去（積分ドリフト補正）
  static List<double> detrend(List<double> data) {
    if (data.length < 2) {
      return List.of(data);
    }
    final n = data.length;
    final slope = (data.last - data.first) / (n - 1);
    return List.generate(n, (i) => data[i] - slope * i);
  }

  /// 最大絶対値を返す
  static double peakAbsolute(List<double> data) {
    if (data.isEmpty) {
      return 0;
    }
    var peak = 0.0;
    for (final v in data) {
      final a = v.abs();
      if (a > peak) {
        peak = a;
      }
    }
    return peak;
  }

  /// 加速度チャンネル1本から速度・変位を計算する
  ///
  /// [accelBiasCorrected] バイアス除去済み加速度 (gal)
  /// [dt] サンプリング間隔 (s)
  ///
  /// Returns ([velocity cm/s], [displacement cm])
  static (List<double>, List<double>) computeVelDisp(
    List<double> accelBiasCorrected,
    double dt,
  ) {
    final vel = detrend(integrate(accelBiasCorrected, dt));
    final disp = detrend(integrate(vel, dt));
    return (vel, disp);
  }
}
