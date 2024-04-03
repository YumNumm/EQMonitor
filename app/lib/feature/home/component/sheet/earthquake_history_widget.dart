import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:eqmonitor/core/component/widget/error_widget.dart';
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
          switch (state) {
            AsyncData(:final value) => () {
                final data = value.$1.take(3).toList();
                if (data.isEmpty) {
                  return const SizedBox.shrink();
                }
                return Column(
                  children: data
                      .map(
                        (e) => EarthquakeHistoryListTile(
                          item: e,
                          onTap: () => EarthquakeHistoryDetailsRoute(
                            eventId: e.eventId.toString(),
                          ).push<void>(context),
                          showBackgroundColor: false,
                        ),
                      )
                      .toList(),
                );
              }(),
            AsyncLoading() => loading,
            AsyncError(:final error) => ErrorInfoWidget(
                error: error,
                onRefresh: () async {
                  await ref
                      .read(defaultEarthquakeHistoryNotifierProvider.notifier)
                      .refresh();
                },
              ),
          },
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
