# family Provider を引数に依存せず override する

## 結論

Widget が引数を動的に変える family Provider（例: ソート条件を含む `earthquakeHistoryProvider(parameter)`）は、
テストで**引数を固定した override を書かない**。引数が 1 つでも変わると override が外れ、実 API 実装が走る。

family 全体を override するときは `overrideWith2` を使う。`Family.overrideWith` は riverpod 3.2 以降 deprecated。

```dart
// ❌ 引数が変わると override が外れる
earthquakeHistoryProvider(
  const EarthquakeHistoryParameter.city(
    cityCode: '1720400',
    sortBy: EarthquakeSortBy.eventId,
    sortOrder: SortOrder.desc,
  ),
).overrideWith(_FakeNotifier.new)

// ❌ deprecated (info: Use overrideWith2 instead)
earthquakeHistoryProvider.overrideWith(_FakeNotifier.new)

// ✅ family 全体を override する
earthquakeHistoryProvider.overrideWith2((_) => _FakeNotifier())
```

`overrideWith2` のコールバックは引数 (`ArgT`) を受け取るので、
Notifier 側で `build(parameter)` を記録すれば「UI 操作で検索条件が変わったか」を検証できる。

```dart
class _RecordingNotifier extends EarthquakeHistoryNotifier {
  static final parameters = <EarthquakeHistoryParameter>[];

  @override
  Future<PaginatedResponse<EarthquakePartial>> build(
    EarthquakeHistoryParameter parameter,
  ) async {
    parameters.add(parameter);
    return const PaginatedResponse(items: [], nextToken: null);
  }
}
```

## 確認コマンド

```bash
mise exec -- flutter test test/feature/intensity_history/city_detail_modal_test.dart
mise exec -- flutter analyze test/feature/intensity_history
```
