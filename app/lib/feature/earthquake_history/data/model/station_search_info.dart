import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_station.dart';
import 'package:eqmonitor_api/export.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'station_search_info.freezed.dart';
part 'station_search_info.g.dart';

/// 観測点震度情報（観測点検索結果用）
@freezed
abstract class StationSearchInfo with _$StationSearchInfo {
  const factory StationSearchInfo({
    required String code,
    required String name,
    required JmaIntensity? intensity,
    required JmaLpgmIntensity? lpgmIntensity,
    required double? sva,
    required List<PrePeriod>? prePeriods,
  }) = _StationSearchInfo;

  factory StationSearchInfo.fromJson(Map<String, dynamic> json) =>
      _$StationSearchInfoFromJson(json);
}

extension IntensityStationInfoToApp on api.IntensityStationInfo {
  StationSearchInfo get toStationSearchInfo => StationSearchInfo(
    code: code,
    name: name,
    intensity: intensity?.toJmaIntensity,
    lpgmIntensity: lpgmIntensity?.toJmaLpgmIntensity,
    sva: sva?.toDouble(),
    prePeriods: prePeriods
        ?.map(
          (e) => PrePeriod(
            band: e.band.toDouble(),
            lpgmIntensity: switch (e.lpgmIntensity) {
              '0' => JmaLpgmIntensity.zero,
              '1' => JmaLpgmIntensity.one,
              '2' => JmaLpgmIntensity.two,
              '3' => JmaLpgmIntensity.three,
              '4' => JmaLpgmIntensity.four,
              _ => JmaLpgmIntensity.unknown,
            },
            sva: e.sva.toDouble(),
          ),
        )
        .toList(),
  );
}
