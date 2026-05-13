import 'package:knet_dsp/src/filter/butterworth_iir.dart';
import 'package:knet_dsp/src/filter/knet_filter.dart';

/// 2次 Butterworth ハイパスフィルタ（ゼロ位相）
///
/// 双線形変換で設計した 2 次 IIR フィルタを前後向き適用します。
class ButterworthHpf implements KnetFilter {
  const ButterworthHpf({required this.cutoffHz});

  /// カットオフ周波数 (Hz)
  final double cutoffHz;

  @override
  List<double> apply(List<double> x, double dt) {
    final sampleRate = 1.0 / dt;
    final coeff = ButterworthDesigner.hpf(cutoffHz, sampleRate);
    return const ZeroPhaseIirFilter().apply(x, coeff);
  }
}
