import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/earthquake_history/component/earthquake_history_tile_widget.dart';
import 'package:eqmonitor/feature/earthquake_history/viewmodel/earthquake_history_view_model.dart';
import 'package:eqmonitor/feature/home/component/sheet/sheet_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EarthquakeHistorySheetWidget extends HookConsumerWidget {
  const EarthquakeHistorySheetWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(earthquakeHistoryViewModelProvider);
    final theme = Theme.of(context);

    useEffect(
      () {
        WidgetsBinding.instance.endOfFrame.then(
          (_) =>
              // 初回読み込みを行う
              ref
                  .read(earthquakeHistoryViewModelProvider.notifier)
                  .loadIfNull(),
        );
        return null;
      },
      [key],
    );

    return Card(
      margin: const EdgeInsets.all(4),
      elevation: 1,
      shadowColor: Colors.transparent,
      // 角丸にして Border
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: theme.dividerColor.withOpacity(0.6),
          width: 0,
        ),
      ),
      child: Padding(
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
                final items = data
                    .where(
                      (e) =>
                          e.earthquake.earthquake != null ||
                          e.earthquake.intensity != null,
                    )
                    .take(3)
                    .toList();
                return [
                  for (final item in items)
                    EarthquakeHistoryTileWidget(
                      item: item,
                      onTap: (p0) => context.push(
                        EarthquakeHistoryDetailsRoute(p0.eventId).location,
                      ),
                      showBackgroundColor: false,
                    ),
                ];
              },
              error: (error, stackTrace) {
                // dataがある場合にはそれを表示
                if (state.hasValue) {
                  final data = state.value!;
                  // 上から3つのみ表示
                  final items = data.take(3).toList();

                  return [
                    for (final item in items)
                      EarthquakeHistoryTileWidget(
                        showBackgroundColor: false,
                        item: item,
                        onTap: (p0) => context.push(
                          EarthquakeHistoryDetailsRoute(p0.eventId).location,
                        ),
                      ),
                  ];
                }
                return [
                  const Text(
                    '地震履歴の取得中にエラーが発生しました。',
                  ),
                  Text(
                    ' $error',
                  ),
                  FilledButton.tonal(
                    onPressed: ref
                        .read(earthquakeHistoryViewModelProvider.notifier)
                        .reload,
                    child: const Text('再読み込み'),
                  ),
                ];
              },
              loading: () => [
                const Text(
                  '地震履歴を取得中です。',
                ),
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: CircularProgressIndicator.adaptive(),
                ),
              ],
            ),
            Row(
              children: [
                const Spacer(),
                TextButton(
                  onPressed: () =>
                      context.push(const EarthquakeHistoryRoute().location),
                  child: const Text('さらに表示'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
