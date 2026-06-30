import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart' as app;
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_list_response.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/origin_time_precision.dart';
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
  test('build passes statuses to earthquake list repository call', () async {
    final repository = _FakeEarthquakeHistoryRepository();
    final statuses = [api.TelegramStatus.training, api.TelegramStatus.test];
    final provider = earthquakeHistoryProvider(
      EarthquakeHistoryParameter(statuses: statuses),
    );
    final container = ProviderContainer(
      overrides: [
        earthquakeHistoryRepositoryProvider.overrideWith(
          (ref) async => repository,
        ),
      ],
    );
    addTearDown(container.dispose);

    await container.read(provider.future);

    expect(repository.listStatuses, [statuses]);
  });
}

final class _FakeEarthquakeHistoryRepository
    extends EarthquakeHistoryRepository {
  _FakeEarthquakeHistoryRepository()
    : super(
        api: api.ApiClient(Dio()),
        earthquakeParameter: _parameter,
        shindoDbStations: const ShindoDbStationsParameter(
          metadata: ParameterMetadata(
            type: .shindoDbStations,
            schemaVersion: 1,
            sourceVersion: 'test',
            sourceUpdatedAt: null,
            sourceUrls: [],
            sha256: 'test',
          ),
          stations: [],
        ),
      );

  final listStatuses = <List<api.TelegramStatus>?>[];

  @override
  Future<EarthquakeListResponse> fetchEarthquakeList({
    int? limit,
    String? cursor,
    double? magnitudeGte,
    double? magnitudeLte,
    int? depthGte,
    int? depthLte,
    JmaIntensity? intensityGte,
    JmaIntensity? intensityLte,
    List<api.TelegramStatus>? statuses,
    List<int>? epicenterCodes,
    api.EarthquakeType? earthquakeType,
    api.EarthquakeDatasource? datasource,
    List<api.EarthquakeTelegramType>? telegramTypes,
    Date? originTimeGte,
    Date? originTimeLte,
    api.JmaLpgmIntensity? maxLpgmIntensityGte,
    api.JmaLpgmIntensity? maxLpgmIntensityLte,
    double? latitudeGte,
    double? latitudeLte,
    double? longitudeGte,
    double? longitudeLte,
    api.EarthquakeSortBy? sortBy,
    api.SortOrder? sortOrder,
  }) async {
    listStatuses.add(statuses);
    return EarthquakeListResponse(
      items: [_earthquake('event-1')],
      nextToken: null,
      nextPooling: null,
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

EarthquakePartial _earthquake(String eventId) => EarthquakePartial(
  eventId: eventId,
  status: app.TelegramStatus.normal,
  originTime: null,
  originTimePrecision: OriginTimePrecision.second,
  arrivalTime: null,
  dataSource: EarthquakeDataSource.jmaDisasterInformationXml,
  hypocenter: null,
  intensity: null,
  earthquakeType: EarthquakeType.normal,
  telegramTypes: const [],
  estimatedIntensityTileUrl: null,
);
