import 'package:collection/collection.dart';
import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/component/intenisty/intensity_icon_type.dart';
import 'package:eqmonitor/core/component/intenisty/jma_intensity_icon.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/core/provider/jma_code_table_provider.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_v1_extended.dart';
import 'package:eqmonitor/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:jma_code_table_types/jma_code_table_types.dart';

class EarthquakeHistoryListTile extends HookConsumerWidget {
  const EarthquakeHistoryListTile({
    required this.item,
    this.onTap,
    this.showBackgroundColor = true,
    super.key,
  });

  final EarthquakeV1Extended item;
  final void Function()? onTap;
  final bool showBackgroundColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final codeTable = ref.watch(jmaCodeTableProvider);
    final hypoName = useMemoized(
      () => codeTable.areaEpicenter.items.firstWhereOrNull(
        (e) => int.tryParse(e.code) == item.epicenterCode,
      ),
      [item.epicenterCode],
    );
    final hypoDetailName = useMemoized(
      () => codeTable.areaEpicenterDetail.items.firstWhereOrNull(
        (e) => int.tryParse(e.code) == item.epicenterDetailCode,
      ),
      [item.epicenterDetailCode],
    );

    /// 遠地地震かどうか
    final isFarEarthquake = item.headline?.contains('海外で規模の大きな地震') ?? false;

    /// 噴火かどうか
    final isVolcano = (item.text?.contains('大規模な噴火が発生しました') ?? false) &&
        (item.text?.contains('実際には、規模の大きな地震は発生していない点に留意') ?? false);

    final maxIntensityRegionNames = item.maxIntensityRegionNames;
    final maxIntensity = item.maxIntensity;
    final title = switch ((
      hypoName,
      hypoDetailName,
      maxIntensity,
      maxIntensityRegionNames
    )) {
      (
        final AreaEpicenter_AreaEpicenterItem hypoName,
        final AreaEpicenterDetail_AreaEpicenterDetailItem hypoDetailName,
        _,
        _
      ) =>
        '${hypoName.name}(${hypoDetailName.name})',
      (
        final AreaEpicenter_AreaEpicenterItem hypoName,
        _,
        _,
        _,
      ) =>
        hypoName.name,
      (_, _, final JmaIntensity intensity, final List<String> regionNames)
          when regionNames.isNotEmpty && regionNames.length > 2 =>
        '最大震度$intensityを${regionNames.first}などで観測',
      (_, _, final JmaIntensity intensity, final List<String> regionNames)
          when regionNames.isNotEmpty =>
        '最大震度$intensityを${regionNames.first}で観測',
      (_, _, final JmaIntensity intensity, _) => '最大震度${intensity.type}を観測',
      _ => ''
    };
    final dateFormatter = DateFormat('yyyy/MM/dd HH:mm');
    final subTitle = switch ((item.originTime, item.arrivalTime)) {
          (final DateTime originTime, _) =>
            '${dateFormatter.format(originTime.toLocal())}頃発生 ',
          (_, final DateTime arrivalTime) =>
            '${dateFormatter.format(arrivalTime.toLocal())}頃検知 ',
          _ => '',
        } +
        switch (item.depth) {
          (final int depth) when depth == 0 => '深さ ごく浅い',
          (final int depth) when depth == 700 => '深さ 700km以上',
          (final int depth) => '深さ ${depth}km',
          _ => '',
        };

    final intensityColor = maxIntensity != null
        ? ref
            .watch(intensityColorProvider)
            .fromJmaIntensity(maxIntensity)
            .background
        : null;
    // 5 -> 5.0, 5.123 -> 5.1
    final magnitude = item.magnitude?.toStringAsFixed(1);
    final magnitudeCondition = item.magnitudeCondition;
    final trailingText = switch (null) {
      _ when isVolcano => '大規模な噴火',
      _ when magnitudeCondition != null => magnitudeCondition,
      _ when magnitude != null => 'M$magnitude',
      _ => '',
    };
    return ListTile(
      tileColor: showBackgroundColor ? intensityColor?.withOpacity(0.4) : null,
      onTap: onTap,
      title: Text(
        title,
        style: theme.textTheme.titleMedium!.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(subTitle),
      leading: isFarEarthquake
          ? JmaIntensityIcon(
              intensity: JmaIntensity.fiveLower,
              type: IntensityIconType.filled,
              customText: isVolcano ? '噴火\n情報' : '遠地\n地震',
            )
          : maxIntensity != null
              ? JmaIntensityIcon(
                  intensity: maxIntensity,
                  type: IntensityIconType.filled,
                )
              : null,
      trailing: Text(
        trailingText,
        style: theme.textTheme.labelLarge!.copyWith(
          fontWeight: FontWeight.bold,
          fontFamily: FontFamily.jetBrainsMono,
          fontFamilyFallback: [FontFamily.notoSansJP],
        ),
      ),
    );
  }
}
