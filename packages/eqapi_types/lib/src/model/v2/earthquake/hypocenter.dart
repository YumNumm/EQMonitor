import 'package:eqapi_types/src/model/v2/common/code_name.dart';
import 'package:eqapi_types/src/model/v2/common/coordinate.dart';
import 'package:eqapi_types/src/model/v2/common/depth.dart';
import 'package:eqapi_types/src/model/v2/common/magnitude.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'hypocenter.freezed.dart';
part 'hypocenter.g.dart';

/// 震源に関する情報
@freezed
abstract class Hypocenter with _$Hypocenter {
  const factory Hypocenter({
    required CodeName value,
    CodeName? detailed,
    required Coordinate coordinates,
    required Magnitude magnitude,
    required Depth depth,
  }) = _Hypocenter;

  factory Hypocenter.fromJson(Map<String, dynamic> json) =>
      _$HypocenterFromJson(json);
}
