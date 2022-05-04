import 'appendix/maxIntChangeReason.dart';
import 'appendix/maxLpgmIntChange.dart';
import 'appendix/maxintchange.dart';

/// 予測震度及び予測長周期地震動階級の付加要素を記載します。
/// 震度予測及び長周期地震動階級予測をどちらも行っていないために、直前の緊急地震速報と今回の緊急地震速報の間で最大予測震度及び最大予測長周期地震動階級の比較ができない場合、本要素は出現しません。
class Appendix {
  Appendix({
    required this.maxIntChange,
    required this.maxLpgmIntChange,
    required this.maxIntChangeReason,
  });
  Appendix.fromJson(Map<String, dynamic> j)
      : maxIntChange = int.parse(j['maxIntChange'].toString()).toMaxIntChange,
        maxLpgmIntChange = (j['maxLpgmIntChange'].toString() == 'null')
            ? null
            : int.parse(j['maxLpgmIntChange'].toString()).toMaxLpgmIntChange,
        maxIntChangeReason =
            int.parse(j['maxIntChangeReason'].toString()).toMaxIntChangeReason;

  /// 最大予測震度変化 #8.3.1.maxIntChange
  final MaxIntChange maxIntChange;

  /// 最大予測長周期地震動階級変化 #8.3.2.maxLpgmIntChange
  final MaxLpgmIntChange? maxLpgmIntChange;

  /// 最大予測値変化の理由 #8.3.3.maxIntChangeReason
  final MaxIntChangeReason maxIntChangeReason;
}
