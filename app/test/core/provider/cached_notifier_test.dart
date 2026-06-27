import 'package:cache/cache.dart';
import 'package:dio/dio.dart';
import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/core/api/cache_only_api_client_provider.dart';
import 'package:eqmonitor/core/provider/cached_notifier.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';

// Test control variables
late ApiClient _cacheOnlyClient;
late ApiClient _normalClient;
var _shouldCacheHit = false;
var _cachedValue = 'cached';
var _freshValue = 'fresh';
Exception? _cacheError;
Exception? _networkError;

class _TestNotifier extends AsyncNotifier<String> with CachedNotifier<String> {
  @override
  Future<String> fetch(ApiClient client) async {
    if (identical(client, _cacheOnlyClient)) {
      if (_cacheError != null) {
        throw _cacheError!;
      }
      if (_shouldCacheHit) {
        return _cachedValue;
      }
      throw DioException(
        requestOptions: RequestOptions(),
        error: const CacheMissException(),
      );
    }
    if (_networkError != null) {
      throw _networkError!;
    }
    return _freshValue;
  }

  @override
  Future<String> build() => cachedBuild();
}

final _testProvider = AsyncNotifierProvider<_TestNotifier, String>(
  _TestNotifier.new,
);

void main() {
  late ProviderContainer container;

  setUp(() {
    _cacheOnlyClient = ApiClient(Dio());
    _normalClient = ApiClient(Dio());
    _shouldCacheHit = false;
    _cachedValue = 'cached';
    _freshValue = 'fresh';
    _cacheError = null;
    _networkError = null;

    container = ProviderContainer(
      overrides: [
        cacheOnlyApiClientProvider.overrideWith(
          (ref) async => _cacheOnlyClient,
        ),
        apiClientProvider.overrideWith((ref) async => _normalClient),
      ],
    );
  });

  tearDown(() => container.dispose());

  test('cache miss: loads from network directly', () async {
    _shouldCacheHit = false;
    _freshValue = 'network-data';

    final result = await container.read(_testProvider.future);

    expect(result, 'network-data');
  });

  test('cache hit: returns stale then updates with fresh', () async {
    _shouldCacheHit = true;
    _cachedValue = 'stale-data';
    _freshValue = 'fresh-data';

    final states = <AsyncValue<String>>[];
    container.listen(_testProvider, (_, next) => states.add(next));

    // Wait for build to return cached value
    await container.read(_testProvider.future);
    expect(container.read(_testProvider).value, 'stale-data');

    // Wait for background revalidation microtask
    await Future<void>.delayed(Duration.zero);
    await Future<void>.delayed(Duration.zero);

    expect(container.read(_testProvider).value, 'fresh-data');
  });

  test('cache hit + network failure: maintains stale with error', () async {
    _shouldCacheHit = true;
    _cachedValue = 'stale-data';
    _networkError = Exception('offline');

    await container.read(_testProvider.future);
    expect(container.read(_testProvider).value, 'stale-data');

    // Wait for background revalidation to fail
    await Future<void>.delayed(Duration.zero);
    await Future<void>.delayed(Duration.zero);

    final state = container.read(_testProvider);
    expect(state.hasValue, isTrue);
    expect(state.value, 'stale-data');
    expect(state.hasError, isTrue);
  });

  test(
    'generation counter prevents stale microtask from updating state',
    () async {
      _shouldCacheHit = true;
      _cachedValue = 'stale-v1';
      _freshValue = 'fresh-v1';

      await container.read(_testProvider.future);

      // Invalidate before background revalidation completes
      _cachedValue = 'stale-v2';
      _freshValue = 'fresh-v2';
      container.invalidate(_testProvider);

      // Wait for everything to settle
      await container.read(_testProvider.future);
      await Future<void>.delayed(Duration.zero);
      await Future<void>.delayed(Duration.zero);

      // Should see v2, not v1
      expect(container.read(_testProvider).value, 'fresh-v2');
    },
  );
}
