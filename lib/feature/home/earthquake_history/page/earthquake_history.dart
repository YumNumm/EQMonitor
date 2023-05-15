import 'package:eqapi_schema/eqapi_schema.dart';
import 'package:eqmonitor/common/component/chip/custom_chip.dart';
import 'package:eqmonitor/common/component/intenisty/intensity_icon_type.dart';
import 'package:eqmonitor/common/component/intenisty/jma_intensity_icon.dart';
import 'package:eqmonitor/common/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/common/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/feature/home/earthquake_history/model/state/earthquake_history_item.dart';
import 'package:eqmonitor/feature/home/earthquake_history/viewmodel/earthquake_history_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class EarthquakeHistoryPage extends HookConsumerWidget {
  const EarthquakeHistoryPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();
    useEffect(
      () {
        WidgetsBinding.instance.endOfFrame.then(
          (_) async {
            // 表示領域の0.9に到達したら次のページを読み込む
            scrollController.addListener(() {
              if (scrollController.position.extentAfter <
                  scrollController.position.viewportDimension * 0.9) {
                ref
                    .read(earthquakeHistoryViewModelProvider.notifier)
                    .loadMore();
              }
            });
            // 初回読み込みを行う
            await ref
                .read(earthquakeHistoryViewModelProvider.notifier)
                .loadIfNull();
          },
        );
        return null;
      },
      [],
    );
    final state = ref.watch(earthquakeHistoryViewModelProvider);
    final body = CustomScrollView(
      slivers: [
        SliverAppBar.medium(
          title: const Text('地震の履歴'),
        ),
        /*+ SliverList(
                // Use a delegate to build items as they're scrolled on screen.
                delegate: SliverChildBuilderDelegate(
                  // The builder function returns a ListTile with a title that
                  // displays the index of the current item.
                  (context, index) => ListTile(title: Text('Item #$index')),
                  // Builds 1000 ListTiles
                  childCount: 1000,
                ),
              ),*/
        state.when(
          data: (data) {
            if (data.isEmpty) {
              return SliverFillRemaining(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '地震履歴がありません。',
                    ),
                    FilledButton.tonal(
                      onPressed: ref
                          .read(
                            earthquakeHistoryViewModelProvider.notifier,
                          )
                          .reload,
                      child: const Text('読み込む'),
                    ),
                  ],
                ),
              );
            }
            return _earthquakeHistorySliverList(data, ref);
          },
          error: (error, stackTrace) {
            // dataがある場合にはそれを表示
            if (state.hasValue) {
              final data = state.value!;
              return _earthquakeHistorySliverList(data, ref);
            }
            return SliverFillRemaining(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
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
                ],
              ),
            );
          },
          loading: () => const SliverFillRemaining(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '地震履歴を取得中です。',
                ),
                CircularProgressIndicator(),
              ],
            ),
          ),
        ),
      ],
    );
    return Scaffold(
      body: body,
    );
  }
}

Widget _earthquakeHistorySliverList(
  List<EarthquakeHistoryItem> data,
  WidgetRef ref,
) =>
    RefreshIndicator.adaptive(
      onRefresh: ref.read(earthquakeHistoryViewModelProvider.notifier).loadMore,
      child: SliverList(
        delegate: SliverChildBuilderDelegate(
          childCount: data.length,
          (context, index) {
            final item = data[index];
            return EarthquakeHistoryTileWidget(item: item);
          },
        ),
      ),
    );

class EarthquakeHistoryTileWidget extends ConsumerWidget {
  const EarthquakeHistoryTileWidget({
    required this.item,
    super.key,
  });

  final EarthquakeHistoryItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    if (item.earthquake.earthquake == null &&
        item.earthquake.intensity == null) {
      return const SizedBox.shrink();
    }
    // 遠地地震かどうか
    final isFar =
        item.telegrams.any((e) => e.headline?.contains('海外で規模の大きな地震') ?? false);
    // 震度速報のみかどうか
    final isOnlyVxse51 =
        item.telegrams.every((e) => e.type == TelegramType.vxse51);
    // 震度速報+震源に関する情報かどうか
    final isOnlyVxse51And52 = item.telegrams.every(
          (e) => e.type == TelegramType.vxse51,
        ) &&
        item.telegrams.every((e) => e.type == TelegramType.vxse52);
    // 長周期地震動に関する観測情報があるかどうか
    final hasVxse62 = item.telegrams.any((e) => e.type == TelegramType.vxse62);

    // ! title
    final title = StringBuffer();
    if (item.earthquake.earthquake != null) {
      final hypo = item.earthquake.earthquake!.hypocenter;
      if (item.earthquake.earthquake!.hypocenter.detailed != null) {
        title.write(
          '${hypo.name}(${hypo.detailed!.name})',
        );
      } else {
        title.write(hypo.name);
      }
    } else if (item.earthquake.intensity != null) {
      // 「最大震度XをTT県などで観測」
      final intensity = item.earthquake.intensity!;
      final maxIntensityPrefs =
          intensity.prefectures.where((e) => e.maxInt == intensity.maxInt);
      title.writeAll([
        '最大震度${intensity.maxInt}を',
        maxIntensityPrefs.firstOrNull?.name ?? '不明な地域',
        if (maxIntensityPrefs.length > 1) 'など',
        'で観測'
      ]);
    }
    // ! body
    final body = StringBuffer();
    if (item.earthquake.earthquake != null) {
      // 発生時刻
      body
        ..write(
          DateFormat('yyyy/MM/dd HH:mm')
              .format(item.earthquake.earthquake!.originTime.toLocal()),
        )
        ..write('頃')
        ..write(' 深さ');
      // 深さ
      switch (item.earthquake.earthquake!.hypocenter.depth) {
        case 0:
          body.write('ごく浅い');
        case 700:
          body.write('やや深い');
        case _:
          body.write('${item.earthquake.earthquake!.hypocenter.depth}km');
      }
    }
    var trailing = '';
    if (item.earthquake.isVolcano) {
      trailing = '大規模な噴火';
    } else {
      if (item.earthquake.earthquake != null) {
        if (item.earthquake.earthquake!.magnitude.value != null) {
          trailing = 'M${item.earthquake.earthquake!.magnitude.value}';
        } else if (item.earthquake.earthquake!.magnitude.condition != null) {
          trailing = item.earthquake.earthquake!.magnitude.condition ?? '';
        }
      }
    }

    final maxIntenisty = item.earthquake.intensity?.maxInt;
    final (intensityColor) = maxIntenisty != null
        ? ref.watch(intensityColorProvider).fromJmaIntensity(maxIntenisty)
        : null;
    final backgroundColor = intensityColor?.$2;

    return ListTile(
      title: Text(
        title.toString(),
      ),
      subtitle: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 8,
        children: [
          Text(
            body.toString(),
          ),
          if (item.tsunami.forecasts != null ||
              item.tsunami.observations != null ||
              item.tsunami.estimations != null)
            const CustomChip(
              child: Text(
                '津波情報',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          if (hasVxse62)
            CustomChip(
              child: Text(
                '長周期地震動 最大階級${item.earthquake.intensity!.maxLgInt}',
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          if (isFar)
            if (item.earthquake.isVolcano)
              const CustomChip(
                child: Text(
                  '大規模な火山',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              )
            else
              const CustomChip(
                child: Text(
                  '遠地地震',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              )
          else ...[
            // 速報
            if (isOnlyVxse51)
              const CustomChip(
                child: Text(
                  '震度速報',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            if (isOnlyVxse51And52)
              const CustomChip(
                child: Text(
                  '震度速報+震源情報',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
          ]
        ],
      ),
      trailing: Text(
        trailing,
        style: theme.textTheme.labelLarge!.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: isFar
          ? JmaIntensityIcon(
              intensity: JmaIntensity.fiveLower,
              type: IntensityIconType.filled,
              customText: item.earthquake.isVolcano ? '火山\n情報' : '遠地\n地震',
            )
          : maxIntenisty != null
              ? JmaIntensityIcon(
                  intensity: maxIntenisty,
                  type: IntensityIconType.filled,
                )
              : null,
      tileColor: backgroundColor?.withOpacity(0.4),
    );
  }
}
