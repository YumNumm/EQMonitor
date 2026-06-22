import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/feature/tsunami/data/notifier/tsunami_details_notifier.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  test('ポーリング失敗時も直前の津波詳細を保持する', () {
    fakeAsync((async) {
      final adapter = _TsunamiDetailsAdapter();
      final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
        ..httpClientAdapter = adapter;
      final container = ProviderContainer(
        overrides: [
          apiClientProvider.overrideWith((ref) async => api.ApiClient(dio)),
        ],
      );
      final provider = tsunamiDetailsProvider('tsunami-1');
      final subscription = container.listen(provider, (_, _) {});

      async.flushMicrotasks();
      async.elapse(Duration.zero);
      async.flushMicrotasks();

      expect(container.read(provider).requireValue.id, 'tsunami-1');

      async.elapse(const Duration(seconds: 30));
      async.flushMicrotasks();
      async.elapse(Duration.zero);
      async.flushMicrotasks();

      final state = container.read(provider);
      expect(adapter.requests, hasLength(2));
      expect(state, isA<AsyncData<api.TsunamiState>>());
      expect(state.requireValue.id, 'tsunami-1');

      subscription.close();
      container.dispose();
    });
  });

  test('ポーリングが Error を投げても直前の津波詳細を保持する', () {
    fakeAsync((async) {
      final adapter = _TsunamiDetailsAdapter(
        secondFailure: _SecondFailure.stateError,
      );
      final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
        ..httpClientAdapter = adapter;
      final container = ProviderContainer(
        overrides: [
          apiClientProvider.overrideWith((ref) async => api.ApiClient(dio)),
        ],
      );
      final provider = tsunamiDetailsProvider('tsunami-1');
      final subscription = container.listen(provider, (_, _) {});

      async.flushMicrotasks();
      async.elapse(Duration.zero);
      async.flushMicrotasks();
      async.elapse(const Duration(seconds: 30));
      async.flushMicrotasks();
      async.elapse(Duration.zero);
      async.flushMicrotasks();

      final state = container.read(provider);
      expect(adapter.requests, hasLength(2));
      expect(state, isA<AsyncData<api.TsunamiState>>());
      expect(state.requireValue.id, 'tsunami-1');

      subscription.close();
      container.dispose();
    });
  });

  test('前回のポーリングが完了するまでは次の取得を開始しない', () {
    fakeAsync((async) {
      final adapter = _PendingSecondTsunamiDetailsAdapter();
      final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
        ..httpClientAdapter = adapter;
      final container = ProviderContainer(
        overrides: [
          apiClientProvider.overrideWith((ref) async => api.ApiClient(dio)),
        ],
      );
      final provider = tsunamiDetailsProvider('tsunami-1');
      final subscription = container.listen(provider, (_, _) {});

      async.flushMicrotasks();
      async.elapse(Duration.zero);
      async.flushMicrotasks();

      async.elapse(const Duration(seconds: 30));
      async.flushMicrotasks();
      expect(adapter.requests, hasLength(2));

      async.elapse(const Duration(seconds: 30));
      async.flushMicrotasks();
      expect(adapter.requests, hasLength(2));

      adapter.completeSecondRequest();
      async.flushMicrotasks();

      subscription.close();
      container.dispose();
    });
  });
}

final class _TsunamiDetailsAdapter implements HttpClientAdapter {
  _TsunamiDetailsAdapter({
    this.secondFailure = _SecondFailure.connectionException,
  });

  final _SecondFailure secondFailure;
  final requests = <RequestOptions>[];
  final responseBodyFactory = _TsunamiDetailsResponseBodyFactory();

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(options);
    if (requests.length == 2) {
      switch (secondFailure) {
        case _SecondFailure.connectionException:
          throw DioException.connectionError(
            requestOptions: options,
            reason: 'temporary network failure',
          );
        case _SecondFailure.stateError:
          throw StateError('invalid tsunami response');
      }
    }

    return responseBodyFactory.create();
  }

  @override
  void close({bool force = false}) {}
}

final class _PendingSecondTsunamiDetailsAdapter implements HttpClientAdapter {
  final requests = <RequestOptions>[];
  final _secondRequestCompleter = Completer<ResponseBody>();
  final responseBodyFactory = _TsunamiDetailsResponseBodyFactory();

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(options);
    if (requests.length == 2) {
      return _secondRequestCompleter.future;
    }
    return responseBodyFactory.create();
  }

  void completeSecondRequest() {
    if (!_secondRequestCompleter.isCompleted) {
      _secondRequestCompleter.complete(responseBodyFactory.create());
    }
  }

  @override
  void close({bool force = false}) {}
}

enum _SecondFailure {
  connectionException,
  stateError,
}

final class _TsunamiDetailsResponseBodyFactory {
  ResponseBody create() => ResponseBody.fromString(
    jsonEncode(<String, dynamic>{
      'id': 'tsunami-1',
      'event_ids': ['event-1'],
      'is_active': true,
      'is_canceled': false,
      'updated_at': '2026-06-22T00:00:00Z',
      'earthquakes': <Map<String, dynamic>>[],
      'latest_telegrams': <Map<String, dynamic>>[],
      'forecast_regions': <Map<String, dynamic>>[],
      'offshore_observations': <Map<String, dynamic>>[],
    }),
    200,
    headers: {
      Headers.contentTypeHeader: [Headers.jsonContentType],
    },
  );
}
