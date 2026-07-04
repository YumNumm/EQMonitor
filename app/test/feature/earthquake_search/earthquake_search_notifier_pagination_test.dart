import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart' as app;
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_search_response.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_sort_by.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/origin_time_precision.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/sort_order.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/repository/earthquake_history_repository.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_metadata.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_type.dart';
import 'package:eqmonitor/feature/parameter/data/model/earthquake/earthquake_parameter.dart';
import 'package:eqmonitor/feature/parameter/data/model/shindo_db/shindo_db_stations_parameter.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  test('fetchNextData passes current nextToken as cursor', () async {
    final repository = _FakeEarthquakeHistoryRepository();
    const parameter = EarthquakeHistoryParameter.region(
      sortBy: EarthquakeSortBy.eventId,
      sortOrder: SortOrder.desc,
      regionCode: '100',
    );
    final provider = earthquakeHistoryProvider(parameter);
    final container = ProviderContainer(
      overrides: [
        earthquakeHistoryRepositoryProvider.overrideWith(
          (ref) async => repository,
        ),
      ],
    );
    addTearDown(container.dispose);
    final subscription = container.listen(provider, (_, _) {});
    addTearDown(subscription.close);

    await container.read(provider.future);
    await container.read(provider.notifier).fetchNextData();

    expect(repository.regionCursors, [null, 'next-1']);
  });
}

final class _FakeEarthquakeHistoryRepository
    extends EarthquakeHistoryRepository {
  _FakeEarthquakeHistoryRepository()
    : super(
        earthquake: api.ApiClient(Dio()).earthquake,
        earthquakeParameter: _parameter,
        shindoDbStations: const ShindoDbStationsParameter(
          metadata: ParameterMetadata(
            type: ParameterType.shindoDbStations,
            schemaVersion: 1,
            sourceVersion: 'test',
            sourceUpdatedAt: null,
            sourceUrls: [],
            sha256: 'test',
          ),
          stations: [],
        ),
      );

  final regionCursors = <String?>[];

  @override
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
    List<app.TelegramStatus>? statuses,
    List<int>? epicenterCodes,
    EarthquakeType? earthquakeType,
    Date? originTimeGte,
    Date? originTimeLte,
    JmaLpgmIntensity? maxLpgmIntensityGte,
    JmaLpgmIntensity? maxLpgmIntensityLte,
    EarthquakeSortBy? sortBy,
    SortOrder? sortOrder,
  }) async {
    regionCursors.add(cursor);
    return PaginatedResponse(
      items: [
        EarthquakePartialRegion(
          regionIntensity: JmaIntensity.three,
          earthquake: _earthquake('event-${regionCursors.length}'),
        ),
      ],
      nextToken: regionCursors.length == 1 ? 'next-1' : null,
    );
  }
}

const _parameter = EarthquakeParameter(
  metadata: ParameterMetadata(
    type: ParameterType.jmaCodeTable,
    schemaVersion: 1,
    sourceVersion: 'test',
    sourceUpdatedAt: null,
    sourceUrls: [],
    sha256: 'test',
  ),
  prefectures: [],
);

EarthquakePartialNormal _earthquake(String eventId) => EarthquakePartialNormal(
  eventId: eventId,
  status: app.TelegramStatus.normal,
  originTime: null,
  originTimePrecision: OriginTimePrecision.second,
  arrivalTime: null,
  dataSources: [EarthquakeDataSource.jmaDisasterInformationXml],
  hypocenter: null,
  intensity: null,
  earthquakeType: EarthquakeType.normal,
  telegramTypes: const [],
  estimatedIntensityTileUrl: null,
);
