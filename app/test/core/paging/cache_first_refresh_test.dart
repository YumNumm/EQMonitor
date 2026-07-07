import 'package:eqmonitor/core/paging/cache_first_refresh.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:paging_view/paging_view.dart';

PageData<String?, int> _page(List<int> data) =>
    PageData(data: data, appendKey: null);

void main() {
  test('cache hit: Success を即返し、背景で upsert が呼ばれる', () async {
    final upserted = <int>[];
    final result = await cacheFirstRefresh<int>(
      fetchPage: ({required cacheOnly}) async =>
          _page(cacheOnly ? [1, 2] : [1, 2, 3]),
      upsert: upserted.addAll,
      isActive: () => true,
    );
    expect(result, isA<Success<String?, int>>());
    expect((result as Success<String?, int>).page.data, [1, 2]);
    await Future<void>.delayed(Duration.zero);
    expect(upserted, [1, 2, 3]); // 背景 revalidate の fresh
  });

  test('cache miss: 通常取得の Success を返す', () async {
    final result = await cacheFirstRefresh<int>(
      fetchPage: ({required cacheOnly}) async {
        if (cacheOnly) throw Exception('cache miss');
        return _page([9]);
      },
      upsert: (_) {},
      isActive: () => true,
    );
    expect((result as Success<String?, int>).page.data, [9]);
  });

  test('cache miss かつ通常取得も失敗 → Failure', () async {
    final result = await cacheFirstRefresh<int>(
      fetchPage: ({required cacheOnly}) async => throw Exception('offline'),
      upsert: (_) {},
      isActive: () => true,
    );
    expect(result, isA<Failure<String?, int>>());
  });

  test('isActive()==false なら背景 upsert をスキップ', () async {
    final upserted = <int>[];
    await cacheFirstRefresh<int>(
      fetchPage: ({required cacheOnly}) async => _page([1]),
      upsert: upserted.addAll,
      isActive: () => false,
    );
    await Future<void>.delayed(Duration.zero);
    expect(upserted, isEmpty);
  });

  test('cache hit で isRevalidating が true→false に遷移', () async {
    final flag = ValueNotifier(false);
    await cacheFirstRefresh<int>(
      fetchPage: ({required cacheOnly}) async => _page([1]),
      upsert: (_) {},
      isActive: () => true,
      isRevalidating: flag,
    );
    expect(flag.value, isTrue); // 即返し直後は revalidate 中
    await Future<void>.delayed(Duration.zero);
    expect(flag.value, isFalse); // 背景完了で false
  });
}
