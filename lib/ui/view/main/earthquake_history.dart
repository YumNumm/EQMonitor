// ignore_for_file: lines_longer_than_80_chars

import 'package:eqmonitor/api/remote/supabase/telegram.dart';
import 'package:eqmonitor/provider/setting/intensity_color_provider.dart';
import 'package:eqmonitor/ui/route.dart';
import 'package:eqmonitor/ui/theme/jma_intensity.dart';
import 'package:eqmonitor/ui/view/main/earthquake_history.viewmodel.dart';
import 'package:eqmonitor/ui/view/widget/intensity_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class EarthquakeHistoryPage extends HookConsumerWidget {
  EarthquakeHistoryPage({super.key});

  final TelegramApi telegramApi = TelegramApi();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(earthquakeHistoryViewModel);
    final appBar = AppBar(
      title: const Text('地震履歴'),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () async =>
              ref.read(earthquakeHistoryViewModel.notifier).refresh(),
        ),
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: vm.when<Widget>(
        data: (items) {
          return NotificationListener<ScrollEndNotification>(
            onNotification: (notification) {
              final scrollPosition = notification.metrics.pixels /
                  notification.metrics.maxScrollExtent;
              if (scrollPosition > 0.8 && (vm.value?.isNotEmpty ?? false)) {
                ref.read(earthquakeHistoryViewModel.notifier).fetch();
                return true;
              }
              return false;
            },
            child: Scrollbar(
              interactive: true,
              child: ListView.builder(
                itemCount: items.length + (vm.isLoading ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == items.length) {
                    // InfiniteScroll Indicator
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 32),
                      child: Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
                    );
                  }
                  final item = items[index];

                  final maxInt = JmaIntensity.values.firstWhere(
                    (e) => e.name == (item.intensity?.maxInt.name),
                    orElse: () => JmaIntensity.unknown,
                  );
                  final colors = ref.watch(jmaIntensityColorProvider);

                  return DecoratedBox(
                    decoration: BoxDecoration(
                      color: maxInt.fromUser(colors).withOpacity(0.3),
                    ),
                    child: ListTile(
                      onTap: () => EarthquakeHistoryItemRoute(eventId: item.id)
                          .go(context),
                      trailing: Text(
                        (item.component?.magnitude != null)
                            ? (item.component!.magnitude.condition != null)
                                ? item.component!.magnitude.condition!.name
                                : (item.component!.magnitude.value != null)
                                    ? 'M${item.component!.magnitude.value!}'
                                    : 'M不明'
                            : '',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      leading: IntensityWidget(
                        intensity: maxInt,
                        opacity: 1,
                        size: 42,
                      ),
                      enableFeedback: true,
                      title: Text(
                        item.component?.hypocenter.name ?? '震源調査中',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        (StringBuffer()
                              ..writeAll(
                                <String>[
                                  if (item.component?.originTime != null)
                                    "${DateFormat('yyyy/MM/dd HH:mm').format(item.component!.originTime.toLocal())}頃 ",
                                  ' ',
                                  // 震源の深さ
                                  if (item.component?.hypocenter.depth != null)
                                    (item.component?.hypocenter.depth
                                                .condition !=
                                            null)
                                        ? '深さ${item.component!.hypocenter.depth.condition!.description} '
                                        : (item.component!.hypocenter.depth
                                                    .value !=
                                                null)
                                            ? '深さ${item.component!.hypocenter.depth.value}km'
                                            : '深さ不明',
                                ],
                              ))
                            .toString(),
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) {
          ref
              .read(earthquakeHistoryViewModel.notifier)
              .logError('地震履歴読み込み中にエラー発生', error, stack);
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('エラーが発生しました'),
                Text(error.runtimeType.toString()),
                Text(error.toString()),
                TextButton(
                  onPressed: () async =>
                      ref.read(earthquakeHistoryViewModel.notifier).refresh(),
                  child: const Text('再読み込み'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
