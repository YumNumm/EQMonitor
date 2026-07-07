import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:paging_view/paging_view.dart';

/// paging_view DataSource の初回ページ (Refresh) を cache-first にする。
///
/// cache-only 取得がヒットしたら即 [Success] を返し、背景で通常取得して
/// [upsert] で in-place 更新する。cache-only が失敗 (miss/corrupt) したら
/// 通常取得にフォールバックし、それも失敗すれば [Failure]。
///
/// 背景更新は [isActive] が false (DataSource 破棄後) ならスキップし、
/// 失敗は [onRevalidateError] に渡して握りつぶさない。
/// 世代ガードは持たないため、直前の Refresh の背景更新が新しい Refresh 後に
/// 走り得るが、[upsert] は id 一致の冪等マージのため実害はない。
Future<LoadResult<String?, V>> cacheFirstRefresh<V>({
  required Future<PageData<String?, V>> Function({required bool cacheOnly})
  fetchPage,
  required void Function(List<V> fresh) upsert,
  required bool Function() isActive,
  ValueNotifier<bool>? isRevalidating,
  void Function(Object error, StackTrace stackTrace)? onRevalidateError,
}) async {
  try {
    final cached = await fetchPage(cacheOnly: true);
    // cache 読込中に破棄された場合、破棄済み ValueNotifier への書き込みを避ける。
    if (isActive()) {
      isRevalidating?.value = true;
    }
    unawaited(
      Future.microtask(() async {
        try {
          final fresh = await fetchPage(cacheOnly: false);
          if (isActive()) {
            upsert(fresh.data);
          }
        } on Object catch (error, stackTrace) {
          onRevalidateError?.call(error, stackTrace);
        } finally {
          if (isActive()) {
            isRevalidating?.value = false;
          }
        }
      }),
    );
    return Success(page: cached);
  } on Object catch (_) {
    try {
      final fresh = await fetchPage(cacheOnly: false);
      return Success(page: fresh);
    } on Exception catch (error, stackTrace) {
      return Failure(error: error, stackTrace: stackTrace);
    }
  }
}
