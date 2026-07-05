import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/lpgm_intensity_tree.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'current_location_intensity_display.freezed.dart';

/// 現在地に対応する震度表示（震度速報ベース）。
@freezed
sealed class CurrentLocationIntensityDisplay
    with _$CurrentLocationIntensityDisplay {
  /// 市区町村別の通常結果がなく、細分区域などの速報値として表示する。
  const factory CurrentLocationIntensityDisplay.quick({
    required JmaIntensity intensity,
  }) = CurrentLocationIntensityDisplayQuick;

  /// 市区町村別の通常結果として表示する。
  const factory CurrentLocationIntensityDisplay.result({
    required JmaIntensity intensity,
    required JmaLpgmIntensity? lpgmIntensity,

    /// 市区町村のすべての観測点を含むことに注意
    required List<StationIntensityNode> stations,

    /// 市区町村のすべての観測点を含むことに注意
    required List<StationLpgmIntensityNode> lpgmStations,
  }) = CurrentLocationIntensityDisplayResult;

  /// 現在地に対応する震度がない。
  const factory CurrentLocationIntensityDisplay.none() =
      CurrentLocationIntensityDisplayNone;
}
