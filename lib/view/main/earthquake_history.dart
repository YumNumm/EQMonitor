// ignore_for_file: lines_longer_than_80_chars

import 'package:eqmonitor/const/kmoni/jma_intensity.dart';
import 'package:eqmonitor/provider/earthquake/earthquake_controller.dart';
import 'package:eqmonitor/provider/setting/intensity_color_provider.dart';
import 'package:eqmonitor/schema/dmdata/commonHeader.dart';
import 'package:eqmonitor/schema/dmdata/eq-information/earthquake-information.dart';
import 'package:eqmonitor/schema/supabase/telegram.dart';
import 'package:eqmonitor/widget/intensity_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../api/remote_db/telegram.dart';

class EarthquakeHistoryPage extends HookConsumerWidget {
  EarthquakeHistoryPage({super.key});

  final TelegramApi telegramApi = TelegramApi();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      // SliverAppBar
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            expandedHeight: 100,
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                '地震履歴',
                style: Theme.of(context).textTheme.headline6,
              ),
              stretchModes: const [
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
                StretchMode.fadeTitle,
              ],
            ),
          ),
          // SliverList
          ref.watch(earthquakeHistoryFutureProvider).when<Widget>(
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (context, error) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'エラーが発生しました',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('$error'),
                    FloatingActionButton.extended(
                      label: const Text('再読み込みする'),
                      icon: const Icon(Icons.refresh),
                      onPressed: () =>
                          ref.refresh(earthquakeHistoryFutureProvider),
                    ),
                  ],
                ),
                data: (data) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final key = data.keys.elementAt(index);
                        final telegrams = data[key]!;
                        return EarthquakeHistoryTile(
                          telegrams: telegrams,
                        );
                      },
                    ),
                  );
                },
              ),
        ],
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

    return DecoratedBox(
      decoration: BoxDecoration(
        color: maxInt.fromUser(colors).withOpacity(0.3),
      ),
      child: ListTile(
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
    );
  }
}
