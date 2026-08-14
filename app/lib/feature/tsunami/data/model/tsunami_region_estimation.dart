import 'package:eqmonitor/feature/tsunami/data/model/tsunami_estimation_first_height.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tsunami_estimation_max_height.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tsunami_region_estimation.freezed.dart';

/// 津波予報区単位の観測に基づく推定値のドメインモデル
@freezed
abstract class TsunamiRegionEstimation with _$TsunamiRegionEstimation {
  const factory TsunamiRegionEstimation({
    required TsunamiEstimationFirstHeight firstHeight,
    required TsunamiEstimationMaxHeight maxHeight,
  }) = _TsunamiRegionEstimation;
}

extension TsunamiRegionEstimationApiExt on api.TsunamiRegionEstimation {
  TsunamiRegionEstimation toDomain() => TsunamiRegionEstimation(
    firstHeight: firstHeight.toDomain(),
    maxHeight: maxHeight.toDomain(),
  );
}
