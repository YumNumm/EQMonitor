import 'package:eqapi_types/src/model/v2/common/code_name.dart';
import 'package:eqapi_types/src/model/v2/common/coordinate.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'eew_hypocenter.freezed.dart';
part 'eew_hypocenter.g.dart';

/// EEWの震源に関する情報
@freezed
abstract class EewHypocenter with _$EewHypocenter {
  const factory EewHypocenter({
    required CodeName value,
    CodeName? detailed,
    required Coordinate coordinates,
    double? magnitude,

    /// 震源の深さ: 0 = ごく浅い, 700 = 700km以上, null = 不明
    int? depth,
  }) = _EewHypocenter;

  factory EewHypocenter.fromJson(Map<String, dynamic> json) =>
      _$EewHypocenterFromJson(json);
}
