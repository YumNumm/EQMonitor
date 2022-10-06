import 'appendix/max_int_change.dart';
import 'appendix/max_int_change_reason.dart';
import 'appendix/max_lpgm_int_change.dart';

/// 予測震度及び予測長周期地震動階級の付加要素を記載します。
/// 震度予測及び長周期地震動階級予測をどちらも行っていないために、直前の緊急地震速報と今回の緊急地震速報の間で最大予測震度及び最大予測長周期地震動階級の比較ができない場合、本要素は出現しません。
class Appendix {
  Appendix({
    required this.maxIntChange,
    required this.maxLpgmIntChange,
    required this.maxIntChangeReason,
  });

  Appendix.fromJson(Map<String, dynamic> j)
      : maxIntChange = MaxIntChange.values.firstWhere(
          (e) => e.code == int.tryParse(j['maxIntChange'].toString()),
          orElse: () => MaxIntChange.unknown,
        ),
        maxLpgmIntChange = (j['maxLpgmIntChange'] != null)
            ? MaxLpgmIntChange.values.firstWhere(
                (e) => e.code == int.tryParse(j['maxLpgmIntChange'].toString()),
                orElse: () => MaxLpgmIntChange.unknown,
              )
            : null,
        maxIntChangeReason = MaxIntChangeReason.values.firstWhere(
          (e) => e.code == int.tryParse(j['maxIntChangeReason'].toString()),
          orElse: () => MaxIntChangeReason.unknown,
        );

  Map<String, dynamic> toJson() => <String, dynamic>{
        if (maxIntChange != MaxIntChange.unknown)
          'maxIntChange': maxIntChange.code,
        'maxLpgmIntChange': maxLpgmIntChange?.code,
        if (maxIntChangeReason != MaxIntChangeReason.unknown)
          'maxIntChangeReason': maxIntChangeReason.code,
      };

  /// 最大予測震度変化 #8.3.1.maxIntChange
  final MaxIntChange maxIntChange;

  /// 最大予測長周期地震動階級変化 #8.3.2.maxLpgmIntChange
  final MaxLpgmIntChange? maxLpgmIntChange;

  /// 最大予測値変化の理由 #8.3.3.maxIntChangeReason
  final MaxIntChangeReason maxIntChangeReason;
}
