import 'package:knet_waveform_parser/knet_waveform_parser.dart';

/// 1観測点の波形解析結果
class KnetStationAnalysis {
  const new({
    required this.pga,
    required this.pgv,
    required this.pgd,
    required this.velocity,
    required this.displacement,
    required this.responseSpectrum5pct,
    required this.fourierSpectrum,
    required this.siValue,
  });

  /// 最大加速度 PGA (gal) — チャンネル別
  final List<double> pga;

  /// 最大速度 PGV (cm/s) — チャンネル別
  final List<double> pgv;

  /// 最大変位 PGD (cm) — チャンネル別
  final List<double> pgd;

  /// 速度波形 (cm/s) — [チャンネル][サンプル]
  final List<List<double>> velocity;

  /// 変位波形 (cm) — [チャンネル][サンプル]
  final List<List<double>> displacement;

  /// 応答スペクトル h=5%
  final ResponseSpectrumResult responseSpectrum5pct;

  /// フーリエ振幅スペクトル（最大 PGA チャンネル）
  final FourierSpectrumResult fourierSpectrum;

  /// SI 値 (cm/s)
  final double siValue;
}
