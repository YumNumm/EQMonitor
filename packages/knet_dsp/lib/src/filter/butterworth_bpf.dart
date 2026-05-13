import 'package:knet_dsp/src/filter/butterworth_iir.dart';
import 'package:knet_dsp/src/filter/knet_filter.dart';

/// 2次 Butterworth バンドパスフィルタ（ゼロ位相）
///
/// HPF → LPF の直列適用でバンドパスフィルタを実現します。
/// 各フィルタは前後向き適用のゼロ位相フィルタです。
class ButterworthBpf implements KnetFilter {
  const ButterworthBpf({required this.lowHz, required this.highHz});

  /// 通過帯域の低域カットオフ周波数 (Hz)
  final double lowHz;

  /// 通過帯域の高域カットオフ周波数 (Hz)
  final double highHz;

  @override
  List<double> apply(List<double> x, double dt) {
    final sampleRate = 1.0 / dt;
    const zeroPhase = ZeroPhaseIirFilter();

    // ハイパスフィルタ（低域除去）
    final hpfCoeff = ButterworthDesigner.hpf(lowHz, sampleRate);
    final hpFiltered = zeroPhase.apply(x, hpfCoeff);

    // ローパスフィルタ（高域除去）
    final lpfCoeff = ButterworthDesigner.lpf(highHz, sampleRate);
    return zeroPhase.apply(hpFiltered, lpfCoeff);
  }
}
