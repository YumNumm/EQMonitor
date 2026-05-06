import 'package:collection/collection.dart';
import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:eqmonitor/core/component/intenisty/jma_intensity_icon.dart';
import 'package:eqmonitor/core/component/intenisty/jma_lpgm_intensity_icon.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/current_location_intensity_display.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/provider/current_location_intensity_provider.dart';
import 'package:eqmonitor/feature/location/data/location.dart';
import 'package:eqmonitor/feature/location/data/nearest_jma_feature.dart';
import 'package:eqmonitor/feature/parameter/data/notifier/parameter_set_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lat_lng/lat_lng.dart';

/// 現在地に対応する震度を表示する。
class CurrentLocationIntensityCard extends ConsumerWidget {
  const CurrentLocationIntensityCard({required this.item, super.key});

  final Earthquake item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (item.intensity == null) {
      return const SizedBox.shrink();
    }

    final position = ref.watch(locationStreamProvider).value;
    final latLng = position != null
        ? LatLng(position.latitude, position.longitude)
        : null;

    if (latLng == null) {
      return const SizedBox.shrink();
    }

    final city = ref
        .watch(
          jmaMapAreaInformationCityInsideProvider(latLng),
        )
        .value;
    final cityCode = city?.property?.code;
    final cityParameter = ref.watch(
      parameterSetProvider.select(
        (v) => v.value?.earthquake.prefectures
            .expand(
              (prefecture) => prefecture.regions.expand(
                (region) => region.cities.map(
                  (city) => (prefecture: prefecture, city: city),
                ),
              ),
            )
            .firstWhereOrNull((e) => e.city.code == cityCode),
      ),
    );
    final cityParameterName = cityParameter != null
        ? '${cityParameter.prefecture.name.ja}${cityParameter.city.name.ja}'
        : null;
    final region = ref
        .watch(
          jmaMapAreaForecastLocalEInsideProvider(latLng),
        )
        .value;
    final regionCode = region?.property?.code;
    final regionParameter = ref.watch(
      parameterSetProvider.select(
        (v) => v.value?.earthquake.prefectures
            .expand((p) => p.regions)
            .firstWhereOrNull((r) => r.code == regionCode),
      ),
    );

    final state = ref.watch(
      currentLocationIntensityProvider(
        eventId: item.eventId,
        cityAreaCode: city?.property?.code,
        regionAreaCode: region?.property?.code,
      ),
    );

    return state.when(
      loading: () => const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Center(
          child: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator.adaptive(strokeWidth: 2),
          ),
        ),
      ),
      error: (error, stackTrace) => const SizedBox.shrink(),
      data: (value) => switch (value) {
        CurrentLocationIntensityDisplayNone() => const SizedBox.shrink(),
        CurrentLocationIntensityDisplayQuick(:final intensity) =>
          _CurrentLocationIntensityContent(
            intensity: intensity,
            lpgmIntensity: null,
            title: "${regionParameter?.name.ja ?? ''} で最大震度${intensity.label}",
            description: regionParameter?.name.ja ?? '',
          ),
        CurrentLocationIntensityDisplayResult(
          :final intensity,
          :final lpgmIntensity,
        ) =>
          _CurrentLocationIntensityContent(
            intensity: intensity,
            lpgmIntensity: lpgmIntensity,
            title: "${cityParameterName ?? ''} で最大震度${intensity.label}",
            description:
                '${cityParameterName ?? ''}で最大震度${intensity.label}を観測しました',
          ),
      },
      skipLoadingOnRefresh: true,
      skipLoadingOnReload: true,
    );
  }
}

class _CurrentLocationIntensityContent extends StatelessWidget {
  const _CurrentLocationIntensityContent({
    required this.intensity,
    required this.lpgmIntensity,
    required this.title,
    required this.description,
  });

  final JmaIntensity intensity;
  final JmaLpgmIntensity? lpgmIntensity;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final icons = [
      JmaIntensityIcon(
        intensity: intensity,
        type: .filled,
        size: 40,
      ),
      if (lpgmIntensity != null) ...[
        const SizedBox(width: 4),
        JmaLpgmIntensityIcon(
          intensity: lpgmIntensity!,
          type: .filled,
          size: 34,
        ),
      ],
    ];

    return BorderedContainer(
      elevation: 1,
      child: Row(
        children: [
          Row(mainAxisSize: MainAxisSize.min, children: icons),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
