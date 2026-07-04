import 'package:collection/collection.dart';
import 'package:core/core.dart' show Date;
import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/core/provider/jma_parameter/jma_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/current_location_intensity_display.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_search_response.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_sort_by.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/lpgm_intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/sort_order.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'earthquake_history_repository.g.dart';

@Riverpod(keepAlive: true)
Future<EarthquakeHistoryRepository> earthquakeHistoryRepository(Ref ref) async {
  final jmaParam = await ref.watch(jmaParameterProvider.future);
  final apiClient = await ref.watch(apiClientProvider.future);
  return EarthquakeHistoryRepository(
    earthquake: apiClient.earthquake,
    earthquakeParameter: jmaParam.earthquake,
    shindoDbStations: jmaParam.shindoDbStations,
  );
}

class EarthquakeHistoryRepository {
  EarthquakeHistoryRepository({
    required api.EarthquakeApiClient earthquake,
    required this.earthquakeParameter,
    required this.shindoDbStations,
  }) : _earthquake = earthquake;

  final api.EarthquakeApiClient _earthquake;
  final EarthquakeParameter earthquakeParameter;
  final ShindoDbStationsParameter shindoDbStations;

  Future<PaginatedResponse<EarthquakePartial>> fetchEarthquakeList({
    int? limit,
    String? cursor,
    double? magnitudeGte,
    double? magnitudeLte,
    int? depthGte,
    int? depthLte,
    JmaIntensity? intensityGte,
    JmaIntensity? intensityLte,
    List<TelegramStatus>? statuses,
    List<int>? epicenterCodes,
    EarthquakeType? earthquakeType,
    EarthquakeDataSource? datasource,
    List<EarthquakeTelegramType>? telegramTypes,
    Date? originTimeGte,
    Date? originTimeLte,
    JmaLpgmIntensity? maxLpgmIntensityGte,
    JmaLpgmIntensity? maxLpgmIntensityLte,
    double? latitudeGte,
    double? latitudeLte,
    double? longitudeGte,
    double? longitudeLte,
    EarthquakeSortBy? sortBy,
    SortOrder? sortOrder,
  }) async {
    final response = await _earthquake.getV2Earthquake(
      limit: limit?.toString(),
      cursor: cursor,
      statuses:
          statuses?.map((status) => status.toApiTelegramStatus).toList() ??
          const [.normal],
      magnitudeGte: magnitudeGte?.toString(),
      magnitudeLte: magnitudeLte?.toString(),
      depthGte: depthGte?.toString(),
      depthLte: depthLte?.toString(),
      intensityGte: intensityGte?.toApiJmaIntensity,
      intensityLte: intensityLte?.toApiJmaIntensity,
      epicenterCodes: epicenterCodes?.map((e) => e.toString()).toList(),
      earthquakeType: earthquakeType?.toApiEarthquakeType,
      datasource: datasource?.toApiEarthquakeDataSource,
      telegramTypes: telegramTypes
          ?.map((type) => type.toApiEarthquakeTelegramType)
          .toList(),
      originTimeGte: originTimeGte?.toString(),
      originTimeLte: originTimeLte?.toString(),
      maxLpgmIntensityGte: maxLpgmIntensityGte?.toApiJmaLpgmIntensity,
      maxLpgmIntensityLte: maxLpgmIntensityLte?.toApiJmaLpgmIntensity,
      latitudeGte: latitudeGte?.toString(),
      latitudeLte: latitudeLte?.toString(),
      longitudeGte: longitudeGte?.toString(),
      longitudeLte: longitudeLte?.toString(),
      sortBy: sortBy?.toApiEarthquakeSortBy,
      sortOrder: sortOrder?.toApiSortOrder,
    );
    return PaginatedResponse(
      items: response.data.items
          .map(
            (item) => item.toEarthquakePartial(parameter: earthquakeParameter),
          )
          .toList(),
      nextToken: response.data.nextToken,
    );
  }

  Future<Earthquake> fetchEarthquakeDetail({required String eventId}) async {
    final response = await _earthquake.getV2EarthquakeEventId(eventId: eventId);
    return response.data.earthquake.toEarthquake(
      parameter: earthquakeParameter,
      shindoDbStations: shindoDbStations,
    );
  }

  Future<PaginatedResponse<EarthquakePartialRegion>> searchByRegion({
    required String code,
    int? limit,
    String? cursor,
    double? magnitudeGte,
    double? magnitudeLte,
    int? depthGte,
    int? depthLte,
    JmaIntensity? intensityGte,
    JmaIntensity? intensityLte,
    List<TelegramStatus>? statuses,
    List<int>? epicenterCodes,
    EarthquakeType? earthquakeType,
    Date? originTimeGte,
    Date? originTimeLte,
    JmaLpgmIntensity? maxLpgmIntensityGte,
    JmaLpgmIntensity? maxLpgmIntensityLte,
    EarthquakeSortBy? sortBy,
    SortOrder? sortOrder,
  }) async {
    final region = earthquakeParameter.prefectures
        .expand((prefecture) => prefecture.regions)
        .firstWhereOrNull((region) => region.code == code);
    if (region == null) {
      throw Exception('Region not found: $code');
    }

    final response = await _earthquake.getV2EarthquakeIntensityRegionCode(
      code: code,
      limit: limit?.toString(),
      cursor: cursor,
      statuses:
          statuses?.map((status) => status.toApiTelegramStatus).toList() ??
          const [.normal],
      magnitudeGte: magnitudeGte?.toString(),
      magnitudeLte: magnitudeLte?.toString(),
      depthGte: depthGte?.toString(),
      depthLte: depthLte?.toString(),
      intensityGte: intensityGte?.toApiJmaIntensity,
      intensityLte: intensityLte?.toApiJmaIntensity,
      epicenterCodes: epicenterCodes?.map((e) => e.toString()).toList(),
      earthquakeType: earthquakeType?.toApiEarthquakeType,
      originTimeGte: originTimeGte?.toString(),
      originTimeLte: originTimeLte?.toString(),
      maxLpgmIntensityGte: maxLpgmIntensityGte?.toApiJmaLpgmIntensity,
      maxLpgmIntensityLte: maxLpgmIntensityLte?.toApiJmaLpgmIntensity,
      sortBy: sortBy?.toApiEarthquakeSortBy,
      sortOrder: sortOrder?.toApiSortOrder,
    );
    return response.data.toAppResponse(
      parameter: earthquakeParameter,
      areaCode: code,
      areaName: region.name,
    );
  }

  Future<PaginatedResponse<EarthquakePartialPrefecture>> searchByPrefecture({
    required String code,
    int? limit,
    String? cursor,
    double? magnitudeGte,
    double? magnitudeLte,
    int? depthGte,
    int? depthLte,
    JmaIntensity? intensityGte,
    JmaIntensity? intensityLte,
    List<TelegramStatus>? statuses,
    List<int>? epicenterCodes,
    EarthquakeType? earthquakeType,
    Date? originTimeGte,
    Date? originTimeLte,
    JmaLpgmIntensity? maxLpgmIntensityGte,
    JmaLpgmIntensity? maxLpgmIntensityLte,
    EarthquakeSortBy? sortBy,
    SortOrder? sortOrder,
  }) async {
    final prefecture = earthquakeParameter.prefectures.firstWhereOrNull(
      (prefecture) => prefecture.code == code,
    );
    if (prefecture == null) {
      throw Exception('Prefecture not found: $code');
    }
    final response = await _earthquake.getV2EarthquakeIntensityPrefectureCode(
      code: code,
      limit: limit?.toString(),
      cursor: cursor,
      statuses:
          statuses?.map((status) => status.toApiTelegramStatus).toList() ??
          const [.normal],
      magnitudeGte: magnitudeGte?.toString(),
      magnitudeLte: magnitudeLte?.toString(),
      depthGte: depthGte?.toString(),
      depthLte: depthLte?.toString(),
      intensityGte: intensityGte?.toApiJmaIntensity,
      intensityLte: intensityLte?.toApiJmaIntensity,
      epicenterCodes: epicenterCodes?.map((e) => e.toString()).toList(),
      earthquakeType: earthquakeType?.toApiEarthquakeType,
      originTimeGte: originTimeGte?.toString(),
      originTimeLte: originTimeLte?.toString(),
      maxLpgmIntensityGte: maxLpgmIntensityGte?.toApiJmaLpgmIntensity,
      maxLpgmIntensityLte: maxLpgmIntensityLte?.toApiJmaLpgmIntensity,
      sortBy: sortBy?.toApiEarthquakeSortBy,
      sortOrder: sortOrder?.toApiSortOrder,
    );
    return response.data.toAppResponse(
      parameter: earthquakeParameter,
      areaCode: code,
      areaName: prefecture.name,
    );
  }

  Future<PaginatedResponse<EarthquakePartialRegion>> searchByCity({
    required String code,
    int? limit,
    String? cursor,
    double? magnitudeGte,
    double? magnitudeLte,
    int? depthGte,
    int? depthLte,
    JmaIntensity? intensityGte,
    JmaIntensity? intensityLte,
    List<TelegramStatus>? statuses,
    List<int>? epicenterCodes,
    EarthquakeType? earthquakeType,
    Date? originTimeGte,
    Date? originTimeLte,
    JmaLpgmIntensity? maxLpgmIntensityGte,
    JmaLpgmIntensity? maxLpgmIntensityLte,
    EarthquakeSortBy? sortBy,
    SortOrder? sortOrder,
  }) async {
    final city = earthquakeParameter.prefectures
        .expand((prefecture) => prefecture.regions)
        .expand((region) => region.cities)
        .firstWhereOrNull((city) => city.code == code);
    if (city == null) {
      throw Exception('City not found: $code');
    }
    final response = await _earthquake.getV2EarthquakeIntensityCityCode(
      code: code,
      limit: limit?.toString(),
      cursor: cursor,
      statuses:
          statuses?.map((status) => status.toApiTelegramStatus).toList() ??
          const [.normal],
      magnitudeGte: magnitudeGte?.toString(),
      magnitudeLte: magnitudeLte?.toString(),
      depthGte: depthGte?.toString(),
      depthLte: depthLte?.toString(),
      intensityGte: intensityGte?.toApiJmaIntensity,
      intensityLte: intensityLte?.toApiJmaIntensity,
      epicenterCodes: epicenterCodes?.map((e) => e.toString()).toList(),
      earthquakeType: earthquakeType?.toApiEarthquakeType,
      originTimeGte: originTimeGte?.toString(),
      originTimeLte: originTimeLte?.toString(),
      maxLpgmIntensityGte: maxLpgmIntensityGte?.toApiJmaLpgmIntensity,
      maxLpgmIntensityLte: maxLpgmIntensityLte?.toApiJmaLpgmIntensity,
      sortBy: sortBy?.toApiEarthquakeSortBy,
      sortOrder: sortOrder?.toApiSortOrder,
    );
    return response.data.toAppResponse(
      cityItem: city,
      parameter: earthquakeParameter,
    );
  }

  Future<PaginatedResponse<EarthquakePartialStation>> searchByStation({
    required String code,
    int? limit,
    String? cursor,
    double? magnitudeGte,
    double? magnitudeLte,
    int? depthGte,
    int? depthLte,
    JmaIntensity? intensityGte,
    JmaIntensity? intensityLte,
    List<TelegramStatus>? statuses,
    List<int>? epicenterCodes,
    EarthquakeType? earthquakeType,
    Date? originTimeGte,
    Date? originTimeLte,
    JmaLpgmIntensity? maxLpgmIntensityGte,
    JmaLpgmIntensity? maxLpgmIntensityLte,
    EarthquakeSortBy? sortBy,
    SortOrder? sortOrder,
  }) async {
    final station = earthquakeParameter.prefectures
        .expand((prefecture) => prefecture.regions)
        .expand((region) => region.cities)
        .expand((city) => city.stations)
        .firstWhereOrNull((station) => station.code == code);
    if (station == null) {
      throw Exception('Station not found: $code');
    }
    final response = await _earthquake.getV2EarthquakeIntensityStationCode(
      code: code,
      limit: limit?.toString(),
      cursor: cursor,
      statuses:
          statuses?.map((status) => status.toApiTelegramStatus).toList() ??
          [.normal],
      magnitudeGte: magnitudeGte?.toString(),
      magnitudeLte: magnitudeLte?.toString(),
      depthGte: depthGte?.toString(),
      depthLte: depthLte?.toString(),
      intensityGte: intensityGte?.toApiJmaIntensity,
      intensityLte: intensityLte?.toApiJmaIntensity,
      epicenterCodes: epicenterCodes?.map((e) => e.toString()).toList(),
      earthquakeType: earthquakeType?.toApiEarthquakeType,
      originTimeGte: originTimeGte?.toString(),
      originTimeLte: originTimeLte?.toString(),
      maxLpgmIntensityGte: maxLpgmIntensityGte?.toApiJmaLpgmIntensity,
      maxLpgmIntensityLte: maxLpgmIntensityLte?.toApiJmaLpgmIntensity,
      sortBy: sortBy?.toApiEarthquakeSortBy,
      sortOrder: sortOrder?.toApiSortOrder,
    );
    return response.data.toAppResponse(
      parameter: earthquakeParameter,
      stationCode: code,
      stationName: station.name,
    );
  }

  EarthquakePartial toEarthquakePartial({
    required api.EarthquakePartial item,
  }) => item.toEarthquakePartial(parameter: earthquakeParameter);

  CurrentLocationIntensityDisplay resolveCurrentLocationIntensity({
    required Map<JmaIntensity, List<IntensityRegion>> regions,
    required Map<JmaIntensity, List<PrefectureIntensityNode>> intensityTree,
    required Map<JmaLpgmIntensity, List<PrefectureLpgmIntensityNode>>
    lpgmIntensityTree,
    required String? cityAreaCode,
    required String? regionAreaCode,
  }) {
    final hasCityIntensityTree = intensityTree.values.any(
      (prefectures) =>
          prefectures.any((prefecture) => prefecture.cities.isNotEmpty),
    );
    if (cityAreaCode != null && hasCityIntensityTree) {
      final targetCities = intensityTree.values
          .expand(
            (prefectures) =>
                prefectures.expand((prefecture) => prefecture.cities),
          )
          .where((city) => city.city.code == cityAreaCode);
      final maxIntensity = targetCities
          .map((city) => city.maxIntensity)
          .nonNulls
          .sortedBy((e) => e.orderIndex)
          .lastOrNull;
      if (maxIntensity == null) {
        return const CurrentLocationIntensityDisplay.none();
      }

      final targetLpgmCities = lpgmIntensityTree.values
          .expand(
            (prefectures) =>
                prefectures.expand((prefecture) => prefecture.cities),
          )
          .where((city) => city.city.code == cityAreaCode);
      final maxLpgmIntensity = targetLpgmCities
          .map((city) => city.maxLpgmIntensity)
          .nonNulls
          .sortedBy((e) => e.orderIndex)
          .lastOrNull;

      return CurrentLocationIntensityDisplay.result(
        intensity: maxIntensity,
        lpgmIntensity: maxLpgmIntensity,
        stations: targetCities.expand((city) => city.stations).toList(),
        lpgmStations: targetLpgmCities.expand((city) => city.stations).toList(),
      );
    }
    if (regionAreaCode != null) {
      final targetRegions = regions.values
          .expand((regionGroups) => regionGroups)
          .where((region) => region.region.code == regionAreaCode);
      final maxIntensity = targetRegions
          .map((region) => region.maxIntensity)
          .nonNulls
          .sortedBy((e) => e.orderIndex)
          .lastOrNull;
      if (maxIntensity != null) {
        return CurrentLocationIntensityDisplay.quick(intensity: maxIntensity);
      }
    }
    return const CurrentLocationIntensityDisplay.none();
  }
}
