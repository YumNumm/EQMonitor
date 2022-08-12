// ignore_for_file: lines_longer_than_80_chars

import 'package:eqmonitor/const/kmoni/jma_intensity.dart';
import 'package:eqmonitor/schema/dmdata/commonHeader.dart';
import 'package:eqmonitor/schema/dmdata/eq-information/earthquake-information.dart';
import 'package:eqmonitor/schema/supabase/telegram.dart';
import 'package:eqmonitor/state/all_state.dart';
import 'package:eqmonitor/widget/intensity/intensity_widget.dart';
import 'package:flutter/material.dart' hide Theme;
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../api/remote_db/telegram.dart';

class EarthquakeHistoryPage extends HookConsumerWidget {
  EarthquakeHistoryPage({super.key});

  final TelegramApi telegramApi = TelegramApi();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final earthquakeHistory = ref.watch(earthquakeHistoryController);

    return AnimationLimiter(
      child: RefreshIndicator(
        onRefresh: () async {
          await Future<void>.delayed(const Duration(seconds: 1));
          await ref
              .read(earthquakeHistoryController.notifier)
              .refreshTelegrams();
        },
        child: ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          itemCount: earthquakeHistory.telegramsGroupByEventId.length,
          itemBuilder: (context, index) {
            final key =
                earthquakeHistory.telegramsGroupByEventId.keys.elementAt(index);
            final telegrams = earthquakeHistory.telegramsGroupByEventId[key]!;
            return AnimationConfiguration.staggeredList(
              position: index,
              delay: const Duration(milliseconds: 20),
              child: SlideAnimation(
                duration: const Duration(milliseconds: 1000),
                curve: Curves.fastLinearToSlowEaseIn,
                child: FadeInAnimation(
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.fastLinearToSlowEaseIn,
                  child: EarthquakeHistoryTile(telegrams: telegrams),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class EarthquakeHistoryTile extends StatelessWidget {
  const EarthquakeHistoryTile({
    super.key,
    required this.telegrams,
  });

  final List<Telegram> telegrams;

  @override
  Widget build(BuildContext context) {
    // 地震情報を解析していきます
    final vxse51Telegrams = <CommonHead>[];
    final vxse52Telegrams = <CommonHead>[];
    final vxse53Telegrams = <CommonHead>[];
    final vxse61Telegrams = <CommonHead>[];
    for (final e in telegrams) {
      print(e.type);
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
        color: (maxInt != JmaIntensity.Int1)
            ? maxInt.color.withOpacity(0.3)
            : null,
      ),
      child: ListTile(
        leading: IntensityWidget(
          intensity: maxInt,
          opacity: 0.3,
          size: 42,
        ),
        enableFeedback: true,
        title: Text(
          component?.hypoCenter.name ?? '震源調査中',
          style: const TextStyle(fontSize: 18),
        ),
        subtitle: Wrap(
          
          children: [
            // 速報かどうか
            if (isSokuhou)
              const Chip(
                label: Text(
                  '速報',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            // 顕著な地震の震源要素更新のお知らせ かどうか
            if (latestVxse61Head != null)
              const Chip(
                label: Text(
                  '顕著な地震の震源要素更新のお知らせ ',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            Text(
              (StringBuffer()
                    ..writeAll(
                      <String>[
                        if (component?.originTime != null)
                          "${DateFormat('yyyy/MM/dd HH:mm').format(component!.originTime.toLocal())}頃 ",
                        // マグニチュード
                        if (component?.magnitude != null)
                          (component!.magnitude.condition != null)
                              ? component.magnitude.condition!.description
                              : (component.magnitude.value != null)
                                  ? 'M${component.magnitude.value!}'
                                  : 'M不明',
                        ' ',
                        // 震源の深さ
                        if (component?.hypoCenter.depth != null)
                          (component?.hypoCenter.depth.condition != null)
                              ? component!
                                  .hypoCenter.depth.condition!.description
                              : (component!.hypoCenter.depth.value != null)
                                  ? '深さ${component.hypoCenter.depth.value}km'
                                  : '不明',
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
