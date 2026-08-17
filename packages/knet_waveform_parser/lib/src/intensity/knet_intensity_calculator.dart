import 'dart:math';

import 'package:knet_waveform_parser/src/csv/knet_csv_parser.dart';
import 'package:knet_waveform_parser/src/model/knet_channel_direction.dart';
import 'package:meta/meta.dart';

/// JMA計測震度算出クラス（特許第5946067号の実装）
///
/// 警告: このコードを使用して利益を得る場合、防災科研とのライセンス契約が必要です。
/// https://plidb.inpit.go.jp/pldb/html/HTML.L/2016/001/L2016001200.html
///
/// 参考実装: https://github.com/ingen084/seismometer
class KnetIntensityCalculator {
  new({double samplingFrequencyHz = 100.0})
    : _fs = samplingFrequencyHz {
    _initCoefficients();
  }

  static const _gainG = 1.262;

  final double _fs;

  // [stage 0..6][coef 0..2]  (stage0=HPF, stage1-6=補正フィルタ)
  late final List<List<double>> _coefA;
  late final List<List<double>> _coefB;

  void _initCoefficients() {
    _coefA = List.generate(7, (_) => List.filled(3, 0));
    _coefB = List.generate(7, (_) => List.filled(3, 0));

    _initHpf(_coefA[0], _coefB[0]);
    _initA11(_coefA[1], _coefB[1]);
    _initA12(_coefA[2], _coefB[2]);
    _initA13(_coefA[3], _coefB[3]);
    _initA14(_coefA[4], _coefB[4], h: 0.9, fc: 12);
    _initA14(_coefA[5], _coefB[5], h: 0.6, fc: 20);
    _initA14(_coefA[6], _coefB[6], h: 0.6, fc: 30);
  }

  void _initHpf(List<double> a, List<double> b) {
    // 2次バターワースHPF (fc=0.05 Hz)
    // 作者: François LN (特許対象外)
    final k = tan(pi * 0.05 / _fs);
    final norm = 1.0 + sqrt2 * k + k * k;
    b[0] = 1.0 / norm;
    b[1] = -2.0 / norm;
    b[2] = 1.0 / norm;
    a[0] = 1.0;
    a[1] = 2.0 * (k * k - 1.0) / norm;
    a[2] = (1.0 - sqrt2 * k + k * k) / norm;
  }

  void _initA11(List<double> a, List<double> b) {
    const f0 = 0.45;
    const f1 = 7.0;
    const omA1 = 2.0 * pi * f0;
    const omA2 = 2.0 * pi * f1;
    final fs2 = _fs * _fs;
    a[0] = 8 * fs2 + (4 * omA1 + 2 * omA2) * _fs + omA1 * omA2;
    a[1] = 2 * omA1 * omA2 - 16 * fs2;
    a[2] = 8 * fs2 - (4 * omA1 + 2 * omA2) * _fs + omA1 * omA2;
    b[0] = 4 * fs2 + 2 * omA2 * _fs;
    b[1] = -8 * fs2;
    b[2] = 4 * fs2 - 2 * omA2 * _fs;
  }

  void _initA12(List<double> a, List<double> b) {
    const f1 = 7.0;
    const omA3 = 2.0 * pi * f1;
    const omA3sq = omA3 * omA3;
    final fs2 = _fs * _fs;
    a[0] = 16 * fs2 + 17 * omA3 * _fs + omA3sq;
    a[1] = 2 * omA3sq - 32 * fs2;
    a[2] = 16 * fs2 - 17 * omA3 * _fs + omA3sq;
    b[0] = 4 * fs2 + 8.5 * omA3 * _fs + omA3sq;
    b[1] = 2 * omA3sq - 8 * fs2;
    b[2] = 4 * fs2 - 8.5 * omA3 * _fs + omA3sq;
  }

  void _initA13(List<double> a, List<double> b) {
    const hb1 = 1.0;
    const hb2 = 0.75;
    const fb = 0.5;
    const omB = 2.0 * pi * fb;
    const omBsq = omB * omB;
    final fs2 = _fs * _fs;
    a[0] = 12 * fs2 + 12 * hb2 * omB * _fs + omBsq;
    a[1] = 10 * omBsq - 24 * fs2;
    a[2] = 12 * fs2 - 12 * hb2 * omB * _fs + omBsq;
    b[0] = 12 * fs2 + 12 * hb1 * omB * _fs + omBsq;
    b[1] = 10 * omBsq - 24 * fs2;
    b[2] = 12 * fs2 - 12 * hb1 * omB * _fs + omBsq;
  }

  void _initA14(
    List<double> a,
    List<double> b, {
    required double h,
    required double fc,
  }) {
    final omC = 2.0 * pi * fc;
    final omCsq = omC * omC;
    final fs2 = _fs * _fs;
    a[0] = 12 * fs2 + 12 * h * omC * _fs + omCsq;
    a[1] = 10 * omCsq - 24 * fs2;
    a[2] = 12 * fs2 - 12 * h * omC * _fs + omCsq;
    b[0] = omCsq;
    b[1] = 10 * omCsq;
    b[2] = omCsq;
  }

  /// 直接形IIR双二次フィルタ（1サンプル）
  double _biquad(
    double input,
    List<double> b,
    List<double> a,
    List<double> xd,
    List<double> yd,
  ) {
    xd[0] = input;
    var acc = b[0] * xd[0] + b[1] * xd[1] + b[2] * xd[2];
    xd[2] = xd[1];
    xd[1] = xd[0];
    acc -= a[1] * yd[1] + a[2] * yd[2];
    yd[0] = acc / a[0];
    yd[2] = yd[1];
    yd[1] = yd[0];
    return yd[0];
  }

  /// 0.3秒に相当するサンプル数を算出する。
  ///
  /// 気象庁の計測震度算出方法に従い `floor(seconds × サンプリング周波数)`
  /// を返す。100Hz では 30、200Hz（KiK-net 等）では 60 となる。
  @visibleForTesting
  static int durationSampleCount(
    double samplingFrequencyHz, [
    double seconds = 0.3,
  ]) => (samplingFrequencyHz * seconds).floor();

  /// CSVレコードからJMA計測震度（小数値）を算出する
  ///
  /// 戻り値は小数第1位まで (0.1 刻み)。
  /// NS/EW/UD チャンネルが揃っていない、またはサンプル数が不足している場合は 0.0 を返す。
  double calculate(KnetCsvRecord record) {
    final dirs = record.channelDirections;
    final nsIdx = dirs.indexWhere((d) => d == KnetChannelDirection.ns);
    final ewIdx = dirs.indexWhere((d) => d == KnetChannelDirection.ew);
    final udIdx = dirs.indexWhere((d) => d == KnetChannelDirection.ud);
    if (nsIdx < 0 || ewIdx < 0 || udIdx < 0) {
      return 0;
    }

    final needLen = [nsIdx, ewIdx, udIdx].reduce((a, b) => a > b ? a : b) + 1;

    // 遅延バッファ [軸][ステージ][遅延インデックス]
    final xd = List.generate(
      3,
      (_) => List.generate(7, (_) => List<double>.filled(3, 0)),
    );
    final yd = List.generate(
      3,
      (_) => List.generate(7, (_) => List<double>.filled(3, 0)),
    );

    final composites = <double>[];

    for (final point in record.dataPoints) {
      final accs = point.accelerationsGal;
      if (accs.length < needLen) {
        continue;
      }

      final axes = [accs[nsIdx], accs[ewIdx], accs[udIdx]];

      for (var ax = 0; ax < 3; ax++) {
        var v = axes[ax];
        for (var st = 0; st < 7; st++) {
          v = _biquad(v, _coefB[st], _coefA[st], xd[ax][st], yd[ax][st]);
        }
        axes[ax] = v * _gainG;
      }

      composites.add(
        sqrt(axes[0] * axes[0] + axes[1] * axes[1] + axes[2] * axes[2]),
      );
    }

    // 気象庁仕様: 3成分合成波形を降順ソートし、大きい方から
    // floor(0.3 × サンプリング周波数) 番目の加速度値を a0 とする。
    // サンプリング周波数を固定せず _fs から窓サンプル数を算出する。
    final n = durationSampleCount(_fs);
    if (composites.length < n) {
      return 0;
    }

    // 降順ソートして floor(0.3×fs) 番目の値を取得（0.3秒相当の値）
    composites.sort((x, y) => y.compareTo(x));
    final v = composites[n - 1];
    if (v <= 0) {
      return 0;
    }

    // rawInt = floor(round((2*log10(v)+0.94)*100)/10)/10
    final rawInt =
        ((2.0 * log(v) / ln10 + 0.94) * 100.0).roundToDouble() / 10.0;
    return rawInt.floorToDouble() / 10.0;
  }

  /// JMA計測震度の小数値をJMAの震度等級文字列に変換する
  static String toJmaLabel(double rawInt) {
    if (rawInt < 0.5) {
      return '0';
    }
    if (rawInt < 1.5) {
      return '1';
    }
    if (rawInt < 2.5) {
      return '2';
    }
    if (rawInt < 3.5) {
      return '3';
    }
    if (rawInt < 4.5) {
      return '4';
    }
    if (rawInt < 5.0) {
      return '5弱';
    }
    if (rawInt < 5.5) {
      return '5強';
    }
    if (rawInt < 6.0) {
      return '6弱';
    }
    if (rawInt < 6.5) {
      return '6強';
    }
    return '7';
  }
}
