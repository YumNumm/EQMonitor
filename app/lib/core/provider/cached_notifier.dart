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

mixin CachedNotifier<T> on $AsyncNotifier<T> {
  Future<T> fetch(ApiClient client);

  bool get revalidateOnAppResume => false;

  var _generation = 0;

  Future<T> cachedBuild() async {
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
      final cached = await fetch(
        await ref.read(cacheOnlyApiClientProvider.future),
      );
      unawaited(Future.microtask(() => _revalidateInBackground(gen, cached)));
      return cached;
    } on Exception catch (e) {
      if (isCacheMiss(e)) {
        return fetch(await ref.read(apiClientProvider.future));
      }
      // 壊れたキャッシュ: force-fresh で if-none-match を抑止し、
      // 200 取得 → HttpCacheInterceptor が corrupt エントリを上書き
      return _fetchForceFresh();
    }
  }

  Future<void> _revalidateInBackground(int gen, T cached) async {
    if (!ref.mounted || gen != _generation) {
      return;
    }
    state = AsyncLoading<T>().copyWithPrevious(
      AsyncData<T>(cached, kind: DataKind.cache),
    );
    try {
      final fresh = await fetch(await ref.read(apiClientProvider.future));
      if (ref.mounted && gen == _generation) {
        state = AsyncData(fresh);
      }
    } on Exception catch (e, st) {
      if (ref.mounted && gen == _generation) {
        state = AsyncError<T>(e, st).copyWithPrevious(state);
      }
    }
  }

  Future<T> _fetchForceFresh() async {
    final normalDio = await ref.read(dioProvider.future);
    final dio = Dio(normalDio.options);
    dio.interceptors.add(ForceFreshInterceptor());
    dio.interceptors.addAll(normalDio.interceptors);
    return fetch(ApiClient(dio));
  }
}
