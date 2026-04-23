import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/provider/jma_parameter/jma_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/current_location_intensity_display.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_list_response.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_search_response.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_tree.dart';
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
    return response.data.toEarthquakeListResponse(parameter: earthquakeParameter);
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
    return response.data.toAppResponse(parameter: earthquakeParameter);
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
    return response.data.toAppResponse(parameter: earthquakeParameter);
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
    return response.data.toAppResponse(parameter: earthquakeParameter);
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
    return response.data.toAppResponse(parameter: earthquakeParameter);
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
  CurrentLocationIntensityDisplay? resolveCurrentLocationIntensity({
    required Map<JmaIntensity, List<RegionIntensityNode>> intensityTree,
    required String? cityAreaCode,
    required String? regionAreaCode,
  }) {
    if (cityAreaCode != null) {
      final cityNode = _findCityNodeByCode(intensityTree, cityAreaCode);
      final j = cityNode?.maxIntensity;
      if (j != null) {
        return CurrentLocationIntensityDisplay(
          intensity: j,
          usedCityLevelData: true,
        );
      }
      final prefJ = _prefectureOnlyIntensity(intensityTree, cityAreaCode);
      if (prefJ != null) {
        return CurrentLocationIntensityDisplay(
          intensity: prefJ,
          usedCityLevelData: false,
        );
      }
    }
    if (regionAreaCode != null) {
      final cityNode = _findCityNodeByCode(intensityTree, regionAreaCode);
      final j = cityNode?.maxIntensity;
      if (j != null) {
        return CurrentLocationIntensityDisplay(
          intensity: j,
          usedCityLevelData: false,
        );
      }
      final prefJ = _prefectureOnlyIntensity(intensityTree, regionAreaCode);
      if (prefJ != null) {
        return CurrentLocationIntensityDisplay(
          intensity: prefJ,
          usedCityLevelData: false,
        );
      }
    }
    return null;
  }

  CityIntensityNode? _findCityNodeByCode(
    Map<JmaIntensity, List<RegionIntensityNode>> intensityTree,
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

  JmaIntensity? _prefectureOnlyIntensity(
    Map<JmaIntensity, List<RegionIntensityNode>> intensityTree,
    String areaCode,
  ) {
    for (final entry in intensityTree.entries) {
      for (final regionNode in entry.value) {
        if (regionNode.region.region.code == areaCode &&
            regionNode.cities.isEmpty) {
          return regionNode.region.maxIntensity ?? entry.key;
        }
      }
    }
    return null;
  }
}
