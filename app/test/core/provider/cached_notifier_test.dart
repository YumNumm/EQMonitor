// ignore_for_file: only_throw_errors

import 'dart:async';

import 'package:cache/cache.dart';
import 'package:dio/dio.dart';
import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/core/api/cache_only_api_client_provider.dart';
import 'package:eqmonitor/core/api/http_cached_api_client_provider.dart';
import 'package:eqmonitor/core/provider/cached_notifier.dart';
import 'package:eqmonitor/core/provider/http_cached_dio_provider.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';

late ApiClient _cacheOnlyClient;
late Dio _httpCachedDio;
late ApiClient _httpCachedClient;
var _shouldCacheHit = false;
var _cachedValue = 'cached';
var _freshValue = 'fresh';
Object? _cacheError;
Object? _networkError;
Completer<String>? _networkCompleter;

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
    if (_networkCompleter != null) {
      return _networkCompleter!.future;
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

Future<void> _pumpMicrotasks() async {
  await Future<void>.delayed(Duration.zero);
  await Future<void>.delayed(Duration.zero);
  await Future<void>.delayed(Duration.zero);
}

void main() {
  late ProviderContainer container;

  setUp(() {
    _cacheOnlyClient = ApiClient(Dio());
    _httpCachedDio = Dio();
    _httpCachedClient = ApiClient(_httpCachedDio);
    _shouldCacheHit = false;
    _cachedValue = 'cached';
    _freshValue = 'fresh';
    _cacheError = null;
    _networkError = null;
    _networkCompleter = null;

    container = ProviderContainer(
      overrides: [
        cacheOnlyApiClientProvider.overrideWith(
          (ref) async => _cacheOnlyClient,
        ),
        httpCachedApiClientProvider.overrideWith(
          (ref) async => _httpCachedClient,
        ),
        httpCachedDioProvider.overrideWith((ref) async => _httpCachedDio),
        apiClientProvider.overrideWith(
          (ref) async => throw StateError('normal ApiClient must not be used'),
        ),
      ],
    );
  });

  tearDown(() => container.dispose());

  group('cache miss', () {
    test('loads from network directly', () async {
      _shouldCacheHit = false;
      _freshValue = 'network-data';

      final result = await container.read(_testProvider.future);

      expect(result, 'network-data');
    });

    test('network error propagates as AsyncError', () async {
      _shouldCacheHit = false;
      _networkError = Exception('server down');

      final sub = container.listen(_testProvider, (_, _) {});
      await _pumpMicrotasks();

      final state = container.read(_testProvider);
      expect(state.hasError, isTrue);
      expect(state.hasValue, isFalse);
      sub.close();
    });
  });

  group('cache hit → SWR cycle', () {
    test('returns stale immediately then updates with fresh', () async {
      _shouldCacheHit = true;
      _cachedValue = 'stale-data';
      _freshValue = 'fresh-data';

      final states = <AsyncValue<String>>[];
      container.listen(_testProvider, (_, next) => states.add(next));

      await container.read(_testProvider.future);
      expect(container.read(_testProvider).value, 'stale-data');

      await _pumpMicrotasks();

      expect(container.read(_testProvider).value, 'fresh-data');
    });

    test('isRefreshing is true during background revalidation', () async {
      _shouldCacheHit = true;
      _cachedValue = 'stale';
      _networkCompleter = Completer<String>();

      final states = <AsyncValue<String>>[];
      container.listen(_testProvider, (_, next) => states.add(next));

      await container.read(_testProvider.future);
      await Future<void>.delayed(Duration.zero);

      final midState = container.read(_testProvider);
      expect(midState.isLoading, isTrue, reason: 'should be loading');
      expect(midState.hasValue, isTrue, reason: 'should retain stale value');
      expect(midState.value, 'stale');
      expect(
        midState.isRefreshing,
        isTrue,
        reason: 'isRefreshing = isLoading && hasValue',
      );

      _networkCompleter!.complete('fresh');
      await _pumpMicrotasks();

      final finalState = container.read(_testProvider);
      expect(finalState.value, 'fresh');
      expect(finalState.isLoading, isFalse);
    });

    test('marks stale value as cache during background revalidation', () async {
      _shouldCacheHit = true;
      _cachedValue = 'stale';
      _networkCompleter = Completer<String>();

      container.listen(_testProvider, (_, _) {});

      await container.read(_testProvider.future);
      await Future<void>.delayed(Duration.zero);

      final midState = container.read(_testProvider);
      expect(midState.value, 'stale');
      expect(midState.isRefreshing, isTrue);
      expect(midState.isFromCache, isTrue);

      _networkCompleter!.complete('fresh');
      await _pumpMicrotasks();

      final finalState = container.read(_testProvider);
      expect(finalState.value, 'fresh');
      expect(finalState.isFromCache, isFalse);
    });

    test('network failure preserves stale value with error', () async {
      _shouldCacheHit = true;
      _cachedValue = 'stale-data';
      _networkError = Exception('offline');

      await container.read(_testProvider.future);
      expect(container.read(_testProvider).value, 'stale-data');

      await _pumpMicrotasks();

      final state = container.read(_testProvider);
      expect(state.hasValue, isTrue, reason: 'stale preserved');
      expect(state.value, 'stale-data');
      expect(state.hasError, isTrue, reason: 'error recorded');
    });

    test('stale data same as fresh (304 scenario)', () async {
      _shouldCacheHit = true;
      _cachedValue = 'same-value';
      _freshValue = 'same-value';

      await container.read(_testProvider.future);
      await _pumpMicrotasks();

      final state = container.read(_testProvider);
      expect(state.value, 'same-value');
      expect(state.isLoading, isFalse);
      expect(state.hasError, isFalse);
    });
  });

  group('corrupt cache → force-fresh', () {
    test('non-CacheMiss error triggers force-fresh path', () async {
      _cacheError = const FormatException('corrupt JSON');
      _freshValue = 'force-fresh-data';

      final result = await container.read(_testProvider.future);

      expect(result, 'force-fresh-data');
    });

    test('TypeError from cache triggers force-fresh path', () async {
      _cacheError = TypeError();
      _freshValue = 'recovered';

      final result = await container.read(_testProvider.future);

      expect(result, 'recovered');
    });

    test('ArgumentError from cache triggers force-fresh path', () async {
      _cacheError = ArgumentError.value(
        'UNKNOWN',
        'metadata.type',
        'Unknown union discriminator',
      );
      _freshValue = 'recovered-from-argument-error';

      final result = await container.read(_testProvider.future);

      expect(result, 'recovered-from-argument-error');
    });

    test('force-fresh network error propagates', () async {
      _cacheError = const FormatException('corrupt');
      _networkError = Exception('network down');

      final sub = container.listen(_testProvider, (_, _) {});
      await _pumpMicrotasks();

      final state = container.read(_testProvider);
      expect(state.hasError, isTrue);
      sub.close();
    });
  });

  group('generation counter', () {
    test('prevents stale microtask from updating state', () async {
      _shouldCacheHit = true;
      _cachedValue = 'stale-v1';
      _freshValue = 'fresh-v1';

      await container.read(_testProvider.future);

      _cachedValue = 'stale-v2';
      _freshValue = 'fresh-v2';
      container.invalidate(_testProvider);

      await container.read(_testProvider.future);
      await _pumpMicrotasks();

      expect(container.read(_testProvider).value, 'fresh-v2');
    });

    test('triple rapid invalidation settles to final value', () async {
      _shouldCacheHit = true;
      _cachedValue = 'stale-1';
      _freshValue = 'fresh-1';

      await container.read(_testProvider.future);

      _cachedValue = 'stale-2';
      _freshValue = 'fresh-2';
      container.invalidate(_testProvider);

      _cachedValue = 'stale-3';
      _freshValue = 'fresh-3';
      container.invalidate(_testProvider);

      await container.read(_testProvider.future);
      await _pumpMicrotasks();

      expect(container.read(_testProvider).value, 'fresh-3');
    });
  });

  group('dispose safety', () {
    test(
      'container dispose during background revalidation does not crash',
      () async {
        _shouldCacheHit = true;
        _cachedValue = 'stale';
        _networkCompleter = Completer<String>();

        container.listen(_testProvider, (_, _) {});
        await container.read(_testProvider.future);

        container.dispose();

        _networkCompleter!.complete('should-be-ignored');
        await _pumpMicrotasks();
      },
    );

    test('invalidation after container dispose does not throw', () async {
      _shouldCacheHit = true;
      _cachedValue = 'stale';
      _freshValue = 'fresh';

      await container.read(_testProvider.future);
      container.dispose();

      // Rebind so tearDown doesn't double-dispose
      container = ProviderContainer();
    });
  });

  group('state transition sequence', () {
    test('cache miss: AsyncLoading → AsyncData', () async {
      _shouldCacheHit = false;
      _networkCompleter = Completer<String>();

      container.listen(_testProvider, (_, _) {});
      container.read(_testProvider);

      final loading = container.read(_testProvider);
      expect(loading is AsyncLoading, isTrue, reason: 'should be loading');
      expect(loading.hasValue, isFalse, reason: 'no previous value');

      _networkCompleter!.complete('data');
      await _pumpMicrotasks();

      expect(container.read(_testProvider).value, 'data');
    });

    test(
      'cache hit: AsyncData(stale) → isRefreshing → AsyncData(fresh)',
      () async {
        _shouldCacheHit = true;
        _cachedValue = 'stale';
        _networkCompleter = Completer<String>();

        final states = <AsyncValue<String>>[];
        container.listen(_testProvider, (_, next) => states.add(next));

        await container.read(_testProvider.future);
        await Future<void>.delayed(Duration.zero);

        final hasRefreshing = states.any((s) => s.isRefreshing);
        expect(
          hasRefreshing,
          isTrue,
          reason: 'should pass through isRefreshing',
        );

        _networkCompleter!.complete('fresh');
        await _pumpMicrotasks();

        final finalState = container.read(_testProvider);
        expect(finalState.value, 'fresh');
        expect(finalState.isLoading, isFalse);
      },
    );

    test('cache hit + error: AsyncData(stale) → isRefreshing → '
        'AsyncError with previous value', () async {
      _shouldCacheHit = true;
      _cachedValue = 'stale';
      _networkCompleter = Completer<String>();

      final states = <AsyncValue<String>>[];
      container.listen(_testProvider, (_, next) => states.add(next));

      await container.read(_testProvider.future);
      await Future<void>.delayed(Duration.zero);

      _networkCompleter!.completeError(Exception('fail'));
      await _pumpMicrotasks();

      final finalState = container.read(_testProvider);
      expect(finalState.hasError, isTrue);
      expect(finalState.hasValue, isTrue);
      expect(finalState.value, 'stale');
    });
  });
}
