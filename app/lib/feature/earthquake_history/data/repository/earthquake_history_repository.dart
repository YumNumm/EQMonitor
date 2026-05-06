import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/core/provider/jma_parameter/jma_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/current_location_intensity_display.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_list_response.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_search_response.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/lpgm_intensity_tree.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'earthquake_history_repository.g.dart';

@Riverpod(keepAlive: true)
Future<EarthquakeHistoryRepository> earthquakeHistoryRepository(
  Ref ref,
) async {
  final jmaParam = await ref.watch(jmaParameterProvider.future);
  return EarthquakeHistoryRepository(
    api: await ref.watch(apiClientProvider.future),
    earthquakeParameter: jmaParam.earthquake,
  );
}

class EarthquakeHistoryRepository {
  EarthquakeHistoryRepository({
    required api.ApiClient api,
    required this.earthquakeParameter,
  }) : _api = api;

  final api.ApiClient _api;
  final EarthquakeParameter earthquakeParameter;

  Iterable<EarthquakeParameterRegionItem> get _allRegions =>
      earthquakeParameter.prefectures.expand((p) => p.regions);

  String? _resolveAreaDisplayName(String areaCode) {
    for (final region in _allRegions) {
      if (region.code == areaCode) {
        return region.name.ja;
      }
      for (final city in region.cities) {
        if (city.code == areaCode) {
          return city.name.ja;
        }
      }
    }
    return null;
  }

  String? _regionCodeForCity(String cityCode) {
    for (final region in _allRegions) {
      for (final city in region.cities) {
        if (city.code == cityCode) {
          return region.code;
        }
      }
    }
    return null;
  }

  String? _resolveStationDisplayName(String stationCode) {
    for (final region in _allRegions) {
      for (final city in region.cities) {
        for (final station in city.stations) {
          if (station.code == stationCode) {
            return station.name.ja;
          }
        }
      }
    }
    return null;
  }

  Future<EarthquakeListResponse> fetchEarthquakeList({
    int? limit,
    String? cursor,
    double? magnitudeGte,
    double? magnitudeLte,
    int? depthGte,
    int? depthLte,
    JmaIntensity? intensityGte,
    JmaIntensity? intensityLte,
  }) async {
    final response = await _api.earthquake.getV2Earthquake(
      limit: limit?.toString(),
      cursor: cursor,
      magnitudeGte: magnitudeGte?.toString(),
      magnitudeLte: magnitudeLte?.toString(),
      depthGte: depthGte?.toString(),
      depthLte: depthLte?.toString(),
      intensityGte: intensityGte?.toApiJmaIntensity,
      intensityLte: intensityLte?.toApiJmaIntensity,
    );
    return response.data.toEarthquakeListResponse(
      parameter: earthquakeParameter,
    );
  }

  Future<Earthquake> fetchEarthquakeDetail({
    required String eventId,
  }) async {
    final response = await _api.earthquake.getV2EarthquakeEventId(
      eventId: eventId,
    );
    return response.data.earthquake.toEarthquake(
      parameter: earthquakeParameter,
    );
  }

  Future<PaginatedSearchResponse<IntensityAreaSearchItem>> searchByRegion({
    required String code,
    int? limit,
    String? cursor,
  }) async {
    final response = await _api.earthquake.getV2EarthquakeIntensityRegionCode(
      code: code,
      limit: limit?.toString(),
      cursor: cursor,
    );
    return response.data.toAppResponse(
      parameter: earthquakeParameter,
      areaCode: code,
      areaName: _resolveAreaDisplayName(code) ?? code,
    );
  }

  Future<PaginatedSearchResponse<IntensityAreaSearchItem>> searchByPrefecture({
    required String code,
    int? limit,
    String? cursor,
  }) async {
    final response = await _api.earthquake
        .getV2EarthquakeIntensityPrefectureCode(
          code: code,
          limit: limit?.toString(),
          cursor: cursor,
        );
    return response.data.toAppResponse(
      parameter: earthquakeParameter,
      areaCode: code,
      areaName: _resolveAreaDisplayName(code) ?? code,
    );
  }

  Future<PaginatedSearchResponse<IntensityAreaSearchItem>> searchByCity({
    required String code,
    int? limit,
    String? cursor,
  }) async {
    final response = await _api.earthquake.getV2EarthquakeIntensityCityCode(
      code: code,
      limit: limit?.toString(),
      cursor: cursor,
    );
    return response.data.toAppResponse(
      parameter: earthquakeParameter,
      areaCode: code,
      areaName: _resolveAreaDisplayName(code) ?? code,
    );
  }

  Future<PaginatedSearchResponse<StationSearchItem>> searchByStation({
    required String code,
    int? limit,
    String? cursor,
  }) async {
    final response = await _api.earthquake.getV2EarthquakeIntensityStationCode(
      code: code,
      limit: limit?.toString(),
      cursor: cursor,
    );
    return response.data.toAppResponse(
      parameter: earthquakeParameter,
      stationCode: code,
      stationName: _resolveStationDisplayName(code) ?? code,
    );
  }

  Future<PaginatedSearchResponse<EpicenterSearchItem>> searchByEpicenter({
    required int code,
    int? limit,
    String? cursor,
  }) async {
    final response = await _api.earthquake.getV2EarthquakeEpicenterCode(
      code: code.toString(),
      limit: limit?.toString(),
      cursor: cursor,
    );
    return response.data.toAppResponse(parameter: earthquakeParameter);
  }

  /// [cityAreaCode] … areaInformationCity のコード、[regionAreaCode] … areaForecastLocalE のコード。
  CurrentLocationIntensityDisplay resolveCurrentLocationIntensity({
    required Map<JmaIntensity, List<IntensityRegion>> regions,
    required Map<JmaIntensity, List<PrefectureIntensityNode>> intensityTree,
    required Map<JmaLpgmIntensity, List<PrefectureLpgmIntensityNode>>
    lpgmIntensityTree,
    required String? cityAreaCode,
    required String? regionAreaCode,
  }) {
    if (cityAreaCode != null) {
      final cityNode = _findCityNodeByCode(intensityTree, cityAreaCode);
      final j = cityNode?.maxIntensity;
      if (j != null) {
        return CurrentLocationIntensityDisplay.result(
          intensity: j,
          lpgmIntensity: _cityLpgmIntensity(lpgmIntensityTree, cityAreaCode),
        );
      }
      // 市区町村が震度ツリーにない場合、親地域コードで速報震度を探す
      // （cityAreaCode は7桁、regionCode は2〜3桁で別体系のため直接比較不可）
      final regionCode = _regionCodeForCity(cityAreaCode);
      final prefJ = regionCode != null
          ? _regionIntensity(regions, regionCode)
          : _regionIntensity(regions, cityAreaCode);
      if (prefJ != null) {
        return CurrentLocationIntensityDisplay.quick(
          intensity: prefJ,
        );
      }
    }
    if (regionAreaCode != null) {
      final cityNode = _findCityNodeByCode(intensityTree, regionAreaCode);
      final j = cityNode?.maxIntensity;
      if (j != null) {
        return CurrentLocationIntensityDisplay.quick(
          intensity: j,
        );
      }
      final prefJ = _regionIntensity(regions, regionAreaCode);
      if (prefJ != null) {
        return CurrentLocationIntensityDisplay.quick(
          intensity: prefJ,
        );
      }
    }
    return const CurrentLocationIntensityDisplay.none();
  }

  CityIntensityNode? _findCityNodeByCode(
    Map<JmaIntensity, List<PrefectureIntensityNode>> intensityTree,
    String areaCode,
  ) {
    for (final regions in intensityTree.values) {
      for (final regionNode in regions) {
        for (final city in regionNode.cities) {
          if (city.city.code == areaCode) {
            return city;
          }
        }
      }
    }
    return null;
  }

  JmaLpgmIntensity? _cityLpgmIntensity(
    Map<JmaLpgmIntensity, List<PrefectureLpgmIntensityNode>> lpgmIntensityTree,
    String cityAreaCode,
  ) {
    for (final regions in lpgmIntensityTree.values) {
      for (final regionNode in regions) {
        for (final city in regionNode.cities) {
          if (city.city.code == cityAreaCode) {
            return city.maxLpgmIntensity;
          }
        }
      }
    }
    return null;
  }

  JmaIntensity? _regionIntensity(
    Map<JmaIntensity, List<IntensityRegion>> regions,
    String areaCode,
  ) {
    for (final entry in regions.entries) {
      for (final region in entry.value) {
        if (region.region.code == areaCode) {
          return region.maxIntensity ?? entry.key;
        }
      }
    }
    return null;
  }
}
