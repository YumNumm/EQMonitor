import 'package:eqmonitor/core/component/chip/region_intensity_filter_chip.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_sort_by.dart';

/// [EarthquakeHistoryParameter] の地域選択関連ロジックを純粋関数として提供する extension。
extension EarthquakeHistoryParameterX on EarthquakeHistoryParameter {
  /// 地域選択結果を反映した新パラメータを返す。
  ///
  /// 共通フィルタ(magnitude/depth/originTime/lpgm/statuses/earthquakeType/
  /// epicenterCodes/datasource/telegramTypes/latlng)は現パラメータから引き継ぐ。
  /// [intensityGte]/[intensityLte] は [result] の値で上書き。
  /// [sortBy] は地域系 API が eventId ソートのみ対応するため [EarthquakeSortBy.eventId] に強制。
  /// [sortOrder] は現値を維持。
  EarthquakeHistoryParameter withRegion(RegionIntensityResult result) {
    switch (result.searchType) {
      case RegionSearchType.prefecture:
        return EarthquakeHistoryParameterPrefecture(
          sortBy: EarthquakeSortBy.eventId,
          sortOrder: sortOrder,
          prefectureCode: result.code,
          intensityGte: result.intensityGte,
          intensityLte: result.intensityLte,
          magnitudeGte: magnitudeGte,
          magnitudeLte: magnitudeLte,
          depthGte: depthGte,
          depthLte: depthLte,
          statuses: statuses,
          epicenterCodes: epicenterCodes,
          earthquakeType: earthquakeType,
          datasource: datasource,
          telegramTypes: telegramTypes,
          originTimeGte: originTimeGte,
          originTimeLte: originTimeLte,
          maxLpgmIntensityGte: maxLpgmIntensityGte,
          maxLpgmIntensityLte: maxLpgmIntensityLte,
          latitudeGte: latitudeGte,
          latitudeLte: latitudeLte,
          longitudeGte: longitudeGte,
          longitudeLte: longitudeLte,
        );
      case RegionSearchType.region:
        return EarthquakeHistoryParameterRegion(
          sortBy: EarthquakeSortBy.eventId,
          sortOrder: sortOrder,
          regionCode: result.code,
          intensityGte: result.intensityGte,
          intensityLte: result.intensityLte,
          magnitudeGte: magnitudeGte,
          magnitudeLte: magnitudeLte,
          depthGte: depthGte,
          depthLte: depthLte,
          statuses: statuses,
          epicenterCodes: epicenterCodes,
          earthquakeType: earthquakeType,
          datasource: datasource,
          telegramTypes: telegramTypes,
          originTimeGte: originTimeGte,
          originTimeLte: originTimeLte,
          maxLpgmIntensityGte: maxLpgmIntensityGte,
          maxLpgmIntensityLte: maxLpgmIntensityLte,
          latitudeGte: latitudeGte,
          latitudeLte: latitudeLte,
          longitudeGte: longitudeGte,
          longitudeLte: longitudeLte,
        );
      case RegionSearchType.city:
        return EarthquakeHistoryParameterCity(
          sortBy: EarthquakeSortBy.eventId,
          sortOrder: sortOrder,
          cityCode: result.code,
          intensityGte: result.intensityGte,
          intensityLte: result.intensityLte,
          magnitudeGte: magnitudeGte,
          magnitudeLte: magnitudeLte,
          depthGte: depthGte,
          depthLte: depthLte,
          statuses: statuses,
          epicenterCodes: epicenterCodes,
          earthquakeType: earthquakeType,
          datasource: datasource,
          telegramTypes: telegramTypes,
          originTimeGte: originTimeGte,
          originTimeLte: originTimeLte,
          maxLpgmIntensityGte: maxLpgmIntensityGte,
          maxLpgmIntensityLte: maxLpgmIntensityLte,
          latitudeGte: latitudeGte,
          latitudeLte: latitudeLte,
          longitudeGte: longitudeGte,
          longitudeLte: longitudeLte,
        );
      case RegionSearchType.station:
        return EarthquakeHistoryParameterStation(
          sortBy: EarthquakeSortBy.eventId,
          sortOrder: sortOrder,
          stationCode: result.code,
          intensityGte: result.intensityGte,
          intensityLte: result.intensityLte,
          magnitudeGte: magnitudeGte,
          magnitudeLte: magnitudeLte,
          depthGte: depthGte,
          depthLte: depthLte,
          statuses: statuses,
          epicenterCodes: epicenterCodes,
          earthquakeType: earthquakeType,
          datasource: datasource,
          telegramTypes: telegramTypes,
          originTimeGte: originTimeGte,
          originTimeLte: originTimeLte,
          maxLpgmIntensityGte: maxLpgmIntensityGte,
          maxLpgmIntensityLte: maxLpgmIntensityLte,
          latitudeGte: latitudeGte,
          latitudeLte: latitudeLte,
          longitudeGte: longitudeGte,
          longitudeLte: longitudeLte,
        );
    }
  }

  /// 地域指定を外して [EarthquakeHistoryParameterAll] に戻す。
  ///
  /// 共通フィルタはすべて引き継ぐ。[intensityGte]/[intensityLte] も引き継ぐ。
  EarthquakeHistoryParameterAll toAll() {
    return EarthquakeHistoryParameterAll(
      sortBy: sortBy,
      sortOrder: sortOrder,
      magnitudeGte: magnitudeGte,
      magnitudeLte: magnitudeLte,
      depthGte: depthGte,
      depthLte: depthLte,
      intensityGte: intensityGte,
      intensityLte: intensityLte,
      statuses: statuses,
      epicenterCodes: epicenterCodes,
      earthquakeType: earthquakeType,
      datasource: datasource,
      telegramTypes: telegramTypes,
      originTimeGte: originTimeGte,
      originTimeLte: originTimeLte,
      maxLpgmIntensityGte: maxLpgmIntensityGte,
      maxLpgmIntensityLte: maxLpgmIntensityLte,
      latitudeGte: latitudeGte,
      latitudeLte: latitudeLte,
      longitudeGte: longitudeGte,
      longitudeLte: longitudeLte,
    );
  }

  /// 現在の地域コード/種別。[EarthquakeHistoryParameterAll] の場合は null。
  (RegionSearchType, String)? get regionSelection => switch (this) {
    EarthquakeHistoryParameterPrefecture(:final prefectureCode) => (
      RegionSearchType.prefecture,
      prefectureCode,
    ),
    EarthquakeHistoryParameterRegion(:final regionCode) => (
      RegionSearchType.region,
      regionCode,
    ),
    EarthquakeHistoryParameterCity(:final cityCode) => (
      RegionSearchType.city,
      cityCode,
    ),
    EarthquakeHistoryParameterStation(:final stationCode) => (
      RegionSearchType.station,
      stationCode,
    ),
    EarthquakeHistoryParameterAll() => null,
  };
}
