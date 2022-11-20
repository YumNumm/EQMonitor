// ignore_for_file: lines_longer_than_80_chars

import 'package:eqmonitor/api/remote/supabase/telegram.dart';
import 'package:eqmonitor/provider/setting/intensity_color_provider.dart';
import 'package:eqmonitor/schema/remote/dmdata/commonHeader.dart';
import 'package:eqmonitor/schema/remote/dmdata/eq-information/earthquake-information.dart';
import 'package:eqmonitor/schema/remote/supabase/telegram.dart';
import 'package:eqmonitor/ui/theme/jma_intensity.dart';
import 'package:eqmonitor/ui/view/main/earthquake_history.viewmodel.dart';
import 'package:eqmonitor/ui/view/widget/intensity_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
                    orElse: () => JmaIntensity.Unknown,
                  );
                  final colors = ref.watch(jmaIntensityColorProvider);

                  return DecoratedBox(
                    decoration: BoxDecoration(
                      color: maxInt.fromUser(colors).withOpacity(0.3),
                    ),
                    child: Stack(
                      children: [
                        /*DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                          ),
                          child: const Expanded(
                            child: Text(
                              'テスト',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),*/
                        ListTile(
                          onTap: () => context
                              .push('/earthquake_history_item/${item.id}'),
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
                          title: Row(
                            children: [
                              Text(
                                item.component?.hypocenter.name ?? '震源調査中',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              // 速報アイコン
                              //  if (isSokuhou) const Chip(label: Text('速報')),
                            ],
                          ),
                          subtitle: Wrap(
                            children: [
                              Text(
                                (StringBuffer()
                                      ..writeAll(
                                        <String>[
                                          if (item.component?.originTime !=
                                              null)
                                            "${DateFormat('yyyy/MM/dd HH:mm').format(item.component!.originTime.toLocal())}頃 ",
                                          ' ',
                                          // 震源の深さ
                                          if (item.component?.hypocenter
                                                  .depth !=
                                              null)
                                            (item.component?.hypocenter.depth
                                                        .condition !=
                                                    null)
                                                ? '深さ${item.component!.hypocenter.depth.condition!.description} '
                                                : (item.component!.hypocenter
                                                            .depth.value !=
                                                        null)
                                                    ? '深さ${item.component!.hypocenter.depth.value}km'
                                                    : '深さ不明',
                                        ],
                                      ))
                                    .toString(),
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ],
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

class EarthquakeHistoryTile extends ConsumerWidget {
  const EarthquakeHistoryTile({
    super.key,
    required this.telegrams,
  });

  final List<Telegram> telegrams;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventId = telegrams.first.eventId!;

    final colors = ref.watch(jmaIntensityColorProvider);
    // 地震情報を解析していきます
    final vxse51Telegrams = <CommonHead>[];
    final vxse52Telegrams = <CommonHead>[];
    final vxse53Telegrams = <CommonHead>[];
    final vxse61Telegrams = <CommonHead>[];
    for (final e in telegrams) {
      switch (e.type) {
        case 'VXSE51':
          vxse51Telegrams.add(CommonHead.fromJson(e.data!));
          break;
        case 'VXSE52':
          vxse52Telegrams.add(CommonHead.fromJson(e.data!));
          break;
        case 'VXSE53':
          vxse53Telegrams.add(CommonHead.fromJson(e.data!));
          break;
        case 'VXSE61':
          vxse61Telegrams.add(CommonHead.fromJson(e.data!));
          break;
        default:
      }
    }

    final latestVxse51Head =
        (vxse51Telegrams.isEmpty) ? null : vxse51Telegrams.last;
    final latestVxse51Info = (latestVxse51Head == null)
        ? null
        : EarthquakeInformation.fromJson(latestVxse51Head.body);
    final latestVxse52Head =
        (vxse52Telegrams.isEmpty) ? null : vxse52Telegrams.last;
    final latestVxse52Info = (latestVxse52Head == null)
        ? null
        : EarthquakeInformation.fromJson(latestVxse52Head.body);
    final latestVxse53Head =
        (vxse53Telegrams.isEmpty) ? null : vxse53Telegrams.last;
    final latestVxse53Info = (latestVxse53Head == null)
        ? null
        : EarthquakeInformation.fromJson(latestVxse53Head.body);
    final latestVxse61Head =
        (vxse61Telegrams.isEmpty) ? null : vxse61Telegrams.last;
    final latestVxse61Info = (latestVxse61Head == null)
        ? null
        : EarthquakeInformation.fromJson(latestVxse61Head.body);

    // 速報かどうか
    final isSokuhou = latestVxse61Head == null && latestVxse53Head == null;

    /// ## 震源要素
    /// VXSE61 -> VXSE53 -> VXSE52
    final component = latestVxse61Info?.earthquake ??
        latestVxse53Info?.earthquake ??
        latestVxse52Info?.earthquake;

    /// ## 各地の震度
    /// VXSE53 -> VXSE51
    final intensity =
        latestVxse53Info?.intensity ?? latestVxse51Info?.intensity;
    final maxInt = JmaIntensity.values.firstWhere(
      (e) => e.name == (intensity?.maxInt ?? ''),
      orElse: () => JmaIntensity.Unknown,
    );

    final isTesting = (latestVxse61Head ??
                latestVxse53Head ??
                latestVxse52Head ??
                latestVxse51Head)!
            .status !=
        CommonHeadStatus.normal;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: maxInt.fromUser(colors).withOpacity(0.3),
      ),
      child: Stack(
        children: [
          if (isTesting)
            DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
              ),
              child: const Expanded(
                child: Text(
                  'テスト',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ListTile(
            onTap: () => context.push('/earthquake_history_item/$eventId'),
            trailing: Text(
              (component?.magnitude != null)
                  ? (component!.magnitude.condition != null)
                      ? component.magnitude.condition!.description
                      : (component.magnitude.value != null)
                          ? 'M${component.magnitude.value!}'
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
            title: Row(
              children: [
                Text(
                  component?.hypoCenter.name ?? '震源調査中',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // 速報アイコン
                if (isSokuhou) const Chip(label: Text('速報')),
              ],
            ),
            subtitle: Wrap(
              children: [
                Text(
                  (StringBuffer()
                        ..writeAll(
                          <String>[
                            if (component?.originTime != null)
                              "${DateFormat('yyyy/MM/dd HH:mm').format(component!.originTime.toLocal())}頃 ",
                            ' ',
                            // 震源の深さ
                            if (component?.hypoCenter.depth != null)
                              (component?.hypoCenter.depth.condition != null)
                                  ? '深さ${component!.hypoCenter.depth.condition!.description}'
                                  : (component!.hypoCenter.depth.value != null)
                                      ? '深さ${component.hypoCenter.depth.value}km'
                                      : '深さ不明',
                          ],
                        ))
                      .toString(),
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
