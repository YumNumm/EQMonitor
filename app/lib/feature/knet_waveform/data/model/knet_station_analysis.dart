import 'package:knet_waveform_parser/knet_waveform_parser.dart';

/// 1観測点の波形解析結果
class const KnetStationAnalysis({
  /// 最大加速度 PGA (gal) — チャンネル別
  required final List<double> pga,

  /// 最大速度 PGV (cm/s) — チャンネル別
  required final List<double> pgv,

  /// 最大変位 PGD (cm) — チャンネル別
  required final List<double> pgd,

  /// 速度波形 (cm/s) — [チャンネル][サンプル]
  required final List<List<double>> velocity,

  /// 変位波形 (cm) — [チャンネル][サンプル]
  required final List<List<double>> displacement,

  /// 応答スペクトル h=5%
  required final ResponseSpectrumResult responseSpectrum5pct,

  /// フーリエ振幅スペクトル（最大 PGA チャンネル）
  required final FourierSpectrumResult fourierSpectrum,

  /// SI 値 (cm/s)
  required final double siValue,
});
