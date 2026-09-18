import 'package:cache/cache.dart';
import 'package:dio/dio.dart';
import 'package:eqmonitor/core/api/cache_only_api_client_provider.dart';
import 'package:eqmonitor/core/api/http_cached_api_client_provider.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart' as app;
import 'package:eqmonitor/core/provider/http_cached_dio_provider.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/city_max_intensity.dart';
import 'package:eqmonitor/feature/intensity_history/data/notifier/city_max_intensity_provider.dart';
import 'package:eqmonitor/feature/intensity_history/data/repository/city_max_intensity_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';

late ApiClient _cacheOnlyClient;
late ApiClient _networkClient;

CityMaxIntensityResponse _response(String cityId, JmaIntensity intensity) =>
    CityMaxIntensityResponse(
      aggregatedAt: DateTime.utc(2026, 8, 19, 12),
      items: [CityMaxIntensityItem(cityId: cityId, maxIntensity: intensity)],
    );

class _SwrFakeRepository extends CityMaxIntensityRepository {
  new() : super(earthquake: ApiClient(Dio()).earthquake);

  bool cacheHit = false;
  CityMaxIntensityResponse? cached;
  CityMaxIntensityResponse? fresh;
  Object? networkError;

  @override
  Future<CityMaxIntensity> fetch({ApiClient? client}) async {
    if (identical(client, _cacheOnlyClient)) {
      if (cacheHit) {
        return cached!.toAppModel();
      }
      throw DioException(
        requestOptions: RequestOptions(),
        error: const CacheMissException(),
      );
    }
    if (networkError != null) {
      throw networkError!;
    }
    return fresh!.toAppModel();
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
        cityMaxIntensityRepositoryProvider.overrideWith(
          (ref) async => repository,
        ),
        cacheOnlyApiClientProvider.overrideWith(
          (ref) async => _cacheOnlyClient,
        ),
        httpCachedApiClientProvider.overrideWith((ref) async => _networkClient),
        httpCachedDioProvider.overrideWith((ref) async => Dio()),
      ],
    );
  });

  tearDown(() => container.dispose());

  test('キャッシュヒット時は stale を即返し、裏で fresh に差し替える', () async {
    repository
      ..cacheHit = true
      ..cached = _response('0110000', JmaIntensity.value3)
      ..fresh = _response('0110000', JmaIntensity.value5plus);

    container.listen(cityMaxIntensityProvider, (_, _) {});
    final stale = await container.read(cityMaxIntensityProvider.future);
    expect(stale.items.single.intensity, app.JmaIntensity.three);
    expect(container.read(cityMaxIntensityProvider).isFromCache, isTrue);

    await _pumpMicrotasks();

    final state = container.read(cityMaxIntensityProvider);
    expect(
      state.requireValue.items.single.intensity,
      app.JmaIntensity.fiveUpper,
    );
    expect(state.isLoading, isFalse);
  });

  test('キャッシュミス時は通常ロードで fresh を返す', () async {
    repository.fresh = _response('0110000', JmaIntensity.value4);

    final result = await container.read(cityMaxIntensityProvider.future);

    expect(result.items.single.intensity, app.JmaIntensity.four);
  });

  test('再検証失敗時は stale を維持しエラーを併記する', () async {
    repository
      ..cacheHit = true
      ..cached = _response('0110000', JmaIntensity.value2)
      ..networkError = Exception('offline');

    container.listen(cityMaxIntensityProvider, (_, _) {});
    await container.read(cityMaxIntensityProvider.future);
    await _pumpMicrotasks();

    final state = container.read(cityMaxIntensityProvider);
    expect(state.hasValue, isTrue);
    expect(state.requireValue.items.single.intensity, app.JmaIntensity.two);
    expect(state.hasError, isTrue);
  });
}
