// ignore_for_file: implementation_imports, invalid_use_of_internal_member

import 'dart:async';

import 'package:cache/cache.dart';
import 'package:dio/dio.dart';
import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/core/api/cache_only_api_client_provider.dart';
import 'package:eqmonitor/core/provider/app_lifecycle.dart';
import 'package:eqmonitor/core/provider/dio_provider.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:flutter/widgets.dart';
import 'package:riverpod/src/internals.dart' show DataKind;
import 'package:riverpod_annotation/riverpod_annotation.dart';

final class CachedOperationToken {
  const CachedOperationToken._(this._authority);

  final int _authority;
}

enum CachedResultSource { cache, fresh }

mixin CachedNotifier<T> on $AsyncNotifier<T> {
  Future<T> fetch(ApiClient client);

  T reconcile(
    T value, {
    required CachedOperationToken operation,
    required CachedResultSource source,
  }) => value;

  bool preserveValueOnBackgroundError(CachedOperationToken operation) => false;

  bool get revalidateOnAppResume => false;

  var _generation = 0;
  var _authority = 0;

  CachedOperationToken beginCachedOperation() =>
      CachedOperationToken._(_authority);

  void advanceCachedAuthority() => _authority += 1;

  bool isCachedOperationCurrent(CachedOperationToken operation) =>
      operation._authority == _authority;

  Future<T> cachedBuild({CachedOperationToken? operation}) async {
    final currentOperation = operation ?? beginCachedOperation();
    if (revalidateOnAppResume) {
      ref.listen(appLifecycleProvider, (prev, next) {
        if (prev != null &&
            prev != AppLifecycleState.resumed &&
            next == AppLifecycleState.resumed) {
          ref.invalidateSelf();
        }
      });
    }
    final gen = ++_generation;
    try {
      final cached = reconcile(
        await fetch(await ref.read(cacheOnlyApiClientProvider.future)),
        operation: currentOperation,
        source: CachedResultSource.cache,
      );
      unawaited(
        Future.microtask(
          () => _revalidateInBackground(gen, cached, currentOperation),
        ),
      );
      return cached;
    } on Object catch (e) {
      if (isCacheMiss(e)) {
        return reconcile(
          await fetch(await ref.read(apiClientProvider.future)),
          operation: currentOperation,
          source: CachedResultSource.fresh,
        );
      }
      // 壊れたキャッシュ: force-fresh で if-none-match を抑止し、
      // 200 取得 → HttpCacheInterceptor が corrupt エントリを上書き
      return _fetchForceFresh(currentOperation);
    }
  }

  Future<void> _revalidateInBackground(
    int gen,
    T cached,
    CachedOperationToken cachedOperation,
  ) async {
    if (!ref.mounted || gen != _generation) {
      return;
    }
    final operation = beginCachedOperation();
    final cacheState = AsyncData<T>(cached, kind: DataKind.cache);
    final previous =
        !isCachedOperationCurrent(cachedOperation) && state.hasValue
        ? state
        : cacheState;
    state = AsyncLoading<T>().copyWithPrevious(previous);
    try {
      final fresh = await fetch(await ref.read(apiClientProvider.future));
      if (ref.mounted && gen == _generation) {
        state = AsyncData(
          reconcile(
            fresh,
            operation: operation,
            source: CachedResultSource.fresh,
          ),
        );
      }
    } on Object catch (e, st) {
      if (ref.mounted && gen == _generation) {
        if (preserveValueOnBackgroundError(operation) && state.hasValue) {
          state = AsyncData(state.requireValue);
        } else {
          state = AsyncError<T>(e, st).copyWithPrevious(state);
        }
      }
    }
  }

  Future<T> _fetchForceFresh(CachedOperationToken operation) async {
    final normalDio = await ref.read(dioProvider.future);
    final dio = Dio(normalDio.options);
    dio.interceptors.add(ForceFreshInterceptor());
    dio.interceptors.addAll(normalDio.interceptors);
    return reconcile(
      await fetch(ApiClient(dio)),
      operation: operation,
      source: CachedResultSource.fresh,
    );
  }
}
