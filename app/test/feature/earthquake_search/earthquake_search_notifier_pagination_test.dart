import 'package:dio/dio.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart' as app;
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_search_response.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_area_info.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/origin_time_precision.dart';
import 'package:eqmonitor/feature/earthquake_history/data/repository/earthquake_history_repository.dart';
import 'package:eqmonitor/feature/earthquake_search/data/model/earthquake_search_parameter.dart';
import 'package:eqmonitor/feature/earthquake_search/data/notifier/earthquake_search_notifier.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_metadata.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_type.dart';
import 'package:eqmonitor/feature/parameter/data/model/earthquake/earthquake_parameter.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  test('fetchNextData passes current nextToken as cursor', () async {
    final repository = _FakeEarthquakeHistoryRepository();
    const parameter = EarthquakeSearchParameter(
      type: EarthquakeSearchType.region,
      code: '100',
      name: '地域',
    );
    final provider = earthquakeSearchProvider(parameter);
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
    : super(api: api.ApiClient(Dio()), earthquakeParameter: _parameter);

  final regionCursors = <String?>[];

  @override
  Future<PaginatedSearchResponse<IntensityAreaSearchItem>> searchByRegion({
    required String code,
    int? limit,
    String? cursor,
    List<api.TelegramStatus>? statuses,
  }) async {
    regionCursors.add(cursor);
    return PaginatedSearchResponse(
      items: [
        IntensityAreaSearchItem(
          eventId: 'event-${regionCursors.length}',
          area: const IntensityAreaInfo(
            code: '100',
            name: '地域',
            intensity: null,
            lpgmIntensity: null,
          ),
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
    generatedAt: '2026-06-04T00:00:00Z',
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
  estimatedIntensityTileUrl: null,
);
