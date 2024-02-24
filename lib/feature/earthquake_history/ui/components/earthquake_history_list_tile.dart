import 'package:collection/collection.dart';
import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/component/intenisty/intensity_icon_type.dart';
import 'package:eqmonitor/core/component/intenisty/jma_intensity_icon.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_v1_extended.dart';
import 'package:eqmonitor/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jma_parameter_api_client/jma_parameter_api_client.dart';

class EarthquakeHistoryListTile extends ConsumerWidget {
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

    /// 遠地地震かどうか
    final isFarEarthquake = item.headline?.contains('海外で規模の大きな地震') ?? false;

    /// 噴火かどうか
    final isVolcano = (item.text?.contains('大規模な噴火が発生しました') ?? false) &&
        (item.text?.contains('実際には、規模の大きな地震は発生していない点に留意') ?? false);

    const title = 'たいとる';
    const subTitle = 'サブタイトル';

    final maxIntensity = item.maxIntensity;
    final intensityColor = maxIntensity != null
        ? ref
            .watch(intensityColorProvider)
            .fromJmaIntensity(maxIntensity)
            .background
        : null;
    final magnitude = item.magnitude;
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
      title: const Text(title),
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
          fontWeight: FontWeight.w900,
          fontFamily: FontFamily.jetBrainsMono,
          fontFamilyFallback: [FontFamily.notoSansJP],
        ),
      ),
    );
  }

  String? _parseRegionCode({
    required String regionCode,
    required List<EarthquakeParameterRegionItem> parameter,
  }) =>
      parameter.firstWhereOrNull((e) => e.code == regionCode)?.name;
}
