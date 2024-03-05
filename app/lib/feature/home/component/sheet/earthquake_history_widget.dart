import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/earthquake_history/data/earthquake_history_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_list_tile.dart';
import 'package:eqmonitor/feature/home/component/sheet/sheet_header.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EarthquakeHistorySheetWidget extends HookConsumerWidget {
  const EarthquakeHistorySheetWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final defaultEarthquakeHistoryNotifierProvider =
        earthquakeHistoryNotifierProvider(const EarthquakeHistoryParameter());
    final state = ref.watch(
      defaultEarthquakeHistoryNotifierProvider,
    );
    const loading = Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: CircularProgressIndicator.adaptive(),
      ),
    );

    return BorderedContainer(
      elevation: 1,
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      child: Column(
        children: [
          const SheetHeader(
            title: '地震履歴',
          ),
          ...state.when(
                data: (data) {
                  // 地震情報を持つもののうち上から3つのみ表示
                  final items = data.$1.take(3).toList();
                  return [
                    for (final item in items)
                      EarthquakeHistoryListTile(
                        item: item,
                        showBackgroundColor: false,
                      ),
                  ];
                },
                error: (error, stackTrace) {
                  // dataがある場合にはそれを表示
                  if (state.hasValue) {
                    final data = state.value!;
                    // 上から3つのみ表示
                    final items = data.$1.take(3).toList();

                    return [
                      for (final item in items)
                        EarthquakeHistoryListTile(
                          showBackgroundColor: false,
                          item: item,
                        ),
                    ];
                  }
                  return [
                    const Text(
                      '地震履歴の取得中にエラーが発生しました。',
                    ),
                    FilledButton.tonal(
                      onPressed: () async =>
                          ref.refresh(defaultEarthquakeHistoryNotifierProvider),
                      child: const Text('再読み込み'),
                    ),
                  ];
                },
                loading: () => [
                  loading,
                ],
              ) ??
              [
                loading,
              ],
          Row(
            children: [
              const Spacer(),
              TextButton(
                onPressed: () =>
                    const EarthquakeHistoryRoute().push<void>(context),
                child: const Text('さらに表示'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
