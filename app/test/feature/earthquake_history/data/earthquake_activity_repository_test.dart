import 'package:core/core.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_activity_query.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_search_response.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_sort_by.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/sort_order.dart';
import 'package:eqmonitor/feature/earthquake_history/data/repository/earthquake_activity_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';

import '../earthquake_activity_test_data.dart';

void main() {
  final baseTime = DateTime.utc(2026, 7, 1, 12);
  final now = DateTime.utc(2026, 7, 8, 12);
  final query = EarthquakeActivityQuery(
    baseEventId: 'base',
    baseOriginTime: baseTime,
    latitude: 35,
    longitude: 139,
    depth: 40,
    beforeDays: 1,
    afterDays: 7,
    radiusKm: 25,
    depthOffsetKm: 20,
  );

  test('全ページを取得してから完全なデータセットを返す', () async {
    final repository = _SpyEarthquakeHistoryRepository(
      pages: {
        null: PaginatedResponse(
          items: [
            testActivityEarthquake(
              eventId: 'older',
              originTime: baseTime.subtract(const Duration(hours: 1)),
            ),
            testActivityEarthquake(eventId: 'base', originTime: baseTime),
          ],
          nextToken: 'page-2',
        ),
        'page-2': PaginatedResponse(
          items: [
            testActivityEarthquake(
              eventId: 'newer',
              originTime: baseTime.add(const Duration(hours: 1)),
            ),
          ],
          nextToken: null,
        ),
      },
    );
    final progress = <int>[];

    final dataset = await EarthquakeActivityRepository(
      earthquakeHistoryRepository: repository,
    ).fetch(query: query, now: now, onProgress: progress.add);

    expect(repository.cursors, [null, 'page-2']);
    expect(repository.limit, 100);
    expect(repository.earthquakeType, EarthquakeType.normal);
    expect(repository.originTimeGte, Date(year: 2026, month: 6, day: 30));
    expect(repository.originTimeLte, Date(year: 2026, month: 7, day: 8));
    expect(repository.depthGte, 20);
    expect(repository.depthLte, 60);
    expect(repository.sortBy, EarthquakeSortBy.eventId);
    expect(repository.sortOrder, SortOrder.asc);
    expect(repository.latitudeGte, closeTo(34.7752, 0.001));
    expect(repository.latitudeLte, closeTo(35.2248, 0.001));
    expect(repository.longitudeGte, closeTo(138.7255, 0.002));
    expect(repository.longitudeLte, closeTo(139.2745, 0.002));
    expect(progress, [2, 3]);
    expect(dataset.items.map((item) => item.eventId), ['newer', 'older']);
    expect(dataset.fetchedAt, now);
  });

  test('同じcursorが再登場したら取得を中止する', () async {
    final repository = _SpyEarthquakeHistoryRepository(
      pages: {
        null: const PaginatedResponse(items: [], nextToken: 'repeat'),
        'repeat': const PaginatedResponse(items: [], nextToken: 'repeat'),
      },
    );

    final future = EarthquakeActivityRepository(
      earthquakeHistoryRepository: repository,
    ).fetch(query: query, now: now, onProgress: (_) {});

    await expectLater(future, throwsStateError);
    expect(repository.cursors, [null, 'repeat']);
  });
}

final class _SpyEarthquakeHistoryRepository
    extends TestEarthquakeHistoryRepository {
  _SpyEarthquakeHistoryRepository({required this.pages});

  final Map<String?, PaginatedResponse<EarthquakePartial>> pages;
  final List<String?> cursors = [];
  int? limit;
  int? depthGte;
  int? depthLte;
  EarthquakeType? earthquakeType;
  Date? originTimeGte;
  Date? originTimeLte;
  double? latitudeGte;
  double? latitudeLte;
  double? longitudeGte;
  double? longitudeLte;
  EarthquakeSortBy? sortBy;
  SortOrder? sortOrder;

  @override
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
    api.ApiClient? client,
  }) async {
    cursors.add(cursor);
    this.limit = limit;
    this.depthGte = depthGte;
    this.depthLte = depthLte;
    this.earthquakeType = earthquakeType;
    this.originTimeGte = originTimeGte;
    this.originTimeLte = originTimeLte;
    this.latitudeGte = latitudeGte;
    this.latitudeLte = latitudeLte;
    this.longitudeGte = longitudeGte;
    this.longitudeLte = longitudeLte;
    this.sortBy = sortBy;
    this.sortOrder = sortOrder;
    final page = pages[cursor];
    if (page == null) {
      throw StateError('Unexpected cursor: $cursor');
    }
    return page;
  }
}
