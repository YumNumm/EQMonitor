import 'dart:async';

import 'package:cache/cache.dart';
import 'package:dio/dio.dart';
import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/core/api/cache_only_api_client_provider.dart';
import 'package:eqmonitor/core/provider/dio_provider.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/highest_intensity_entry.dart';
import 'package:eqmonitor/feature/intensity_history/data/notifier/city_highest_provider.dart';
import 'package:eqmonitor/feature/intensity_history/data/repository/intensity_highest_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';

late ApiClient _cacheOnlyClient;
late ApiClient _networkClient;

EarthquakePartial _partial(String eventId) => EarthquakePartial(
  eventId: eventId,
  status: TelegramStatus.normal,
  originTimePrecision: OriginTimePrecision.second,
  datasource: EarthquakeDatasource.jmaDisasterInformationXml,
  telegramTypes: const [],
  earthquakeType: EarthquakeType.normal,
);

HighestIntensityItem _item(String code, JmaIntensity intensity) =>
    HighestIntensityItem(
      code: code,
      name: 'エリア$code',
      intensity: intensity,
      count: 1,
      earthquake: _partial('evt-$code'),
    );

class _SwrFakeRepository extends IntensityHighestRepository {
  _SwrFakeRepository() : super(earthquake: ApiClient(Dio()).earthquake);

  bool cacheHit = false;
  List<HighestIntensityItem> cachedItems = const [];
  List<HighestIntensityItem> freshItems = const [];
  Object? networkError;

  @override
  Future<List<HighestIntensityEntry>> fetchCityHighest(
    String prefectureCode, {
    ApiClient? client,
  }) async {
    if (identical(client, _cacheOnlyClient)) {
      if (cacheHit) {
        return cachedItems.map(HighestIntensityEntry.fromApi).toList();
      }
      throw DioException(
        requestOptions: RequestOptions(),
        error: const CacheMissException(),
      );
    }
    if (networkError != null) {
      throw networkError!;
    }
    return freshItems.map(HighestIntensityEntry.fromApi).toList();
  }
}

Future<void> _pumpMicrotasks() async {
  await Future<void>.delayed(Duration.zero);
  await Future<void>.delayed(Duration.zero);
  await Future<void>.delayed(Duration.zero);
}

void main() {
  late ProviderContainer container;
  late _SwrFakeRepository repository;

  setUp(() {
    _cacheOnlyClient = ApiClient(Dio());
    _networkClient = ApiClient(Dio());
    repository = _SwrFakeRepository();
    container = ProviderContainer(
      overrides: [
        intensityHighestRepositoryProvider.overrideWith(
          (ref) async => repository,
        ),
        cacheOnlyApiClientProvider.overrideWith(
          (ref) async => _cacheOnlyClient,
        ),
        apiClientProvider.overrideWith((ref) async => _networkClient),
        dioProvider.overrideWith((ref) async => Dio()),
      ],
    );
  });

  tearDown(() => container.dispose());

  test('キャッシュヒット時は stale を即返し、裏で fresh に差し替える', () async {
    repository
      ..cacheHit = true
      ..cachedItems = [_item('0101', JmaIntensity.value3)]
      ..freshItems = [_item('0101', JmaIntensity.value5plus)];

    container.listen(cityHighestProvider('01'), (_, _) {});
    final stale = await container.read(cityHighestProvider('01').future);
    expect(stale.single.intensity, JmaIntensity.value3);
    expect(container.read(cityHighestProvider('01')).isFromCache, isTrue);

    await _pumpMicrotasks();

    final state = container.read(cityHighestProvider('01'));
    expect(state.requireValue.single.intensity, JmaIntensity.value5plus);
    expect(state.isLoading, isFalse);
  });

  test('キャッシュミス時は通常ロードで fresh を返す', () async {
    repository.freshItems = [_item('0102', JmaIntensity.value4)];

    final result = await container.read(cityHighestProvider('01').future);

    expect(result.single.intensity, JmaIntensity.value4);
  });

  test('再検証失敗時は stale を維持しエラーを併記する', () async {
    repository
      ..cacheHit = true
      ..cachedItems = [_item('0103', JmaIntensity.value2)]
      ..networkError = Exception('offline');

    container.listen(cityHighestProvider('01'), (_, _) {});
    await container.read(cityHighestProvider('01').future);
    await _pumpMicrotasks();

    final state = container.read(cityHighestProvider('01'));
    expect(state.hasValue, isTrue);
    expect(state.requireValue.single.intensity, JmaIntensity.value2);
    expect(state.hasError, isTrue);
  });
}
