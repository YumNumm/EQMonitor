// ignore_for_file: implementation_imports, invalid_use_of_internal_member

import 'package:eqmonitor/core/component/cached_data_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/src/internals.dart' show DataKind;

const _revalidatingText = 'キャッシュ表示中・更新を確認しています…';
const _staleErrorText = '最新情報の取得に失敗しました（キャッシュ表示中）';

/// CachedNotifier が裏更新中に流す「キャッシュ由来の値を保持した Loading」状態。
AsyncValue<String> _cacheRevalidating() => const AsyncLoading<String>()
    .copyWithPrevious(AsyncData('stale', kind: DataKind.cache));

/// 再検証失敗で stale を維持した状態。
AsyncValue<String> _staleWithError() => AsyncError<String>(
  Exception('offline'),
  StackTrace.empty,
).copyWithPrevious(const AsyncData('stale'));

Future<void> _pump(WidgetTester tester, List<AsyncValue<Object?>> values) {
  return tester.pumpWidget(
    MaterialApp(
      home: Scaffold(body: CachedDataBanner(values: values)),
    ),
  );
}

void main() {
  testWidgets('fresh のみでは何も表示しない', (tester) async {
    await _pump(tester, [const AsyncData('fresh')]);
    expect(find.text(_revalidatingText), findsNothing);
    expect(find.text(_staleErrorText), findsNothing);
  });

  testWidgets('値なし Loading (初回ロード) では何も表示しない', (tester) async {
    await _pump(tester, [const AsyncLoading<String>()]);
    expect(find.text(_revalidatingText), findsNothing);
    expect(find.text(_staleErrorText), findsNothing);
  });

  testWidgets('キャッシュ由来の値を再検証中は更新中バナーを表示する', (tester) async {
    await _pump(tester, [_cacheRevalidating()]);
    expect(find.text(_revalidatingText), findsOneWidget);
  });

  testWidgets('cache マークなしの isRefreshing では表示しない', (tester) async {
    final refreshing = const AsyncLoading<String>().copyWithPrevious(
      const AsyncData('value'),
    );
    await _pump(tester, [refreshing]);
    expect(find.text(_revalidatingText), findsNothing);
  });

  testWidgets('再検証失敗 (stale + error) は失敗バナーを表示する', (tester) async {
    await _pump(tester, [_staleWithError()]);
    expect(find.text(_staleErrorText), findsOneWidget);
  });

  testWidgets('複数 values は 1 つでも該当すれば表示する', (tester) async {
    await _pump(tester, [const AsyncData('fresh'), _cacheRevalidating()]);
    expect(find.text(_revalidatingText), findsOneWidget);
  });

  testWidgets('失敗が更新中より優先される', (tester) async {
    await _pump(tester, [_cacheRevalidating(), _staleWithError()]);
    expect(find.text(_staleErrorText), findsOneWidget);
    expect(find.text(_revalidatingText), findsNothing);
  });
}
