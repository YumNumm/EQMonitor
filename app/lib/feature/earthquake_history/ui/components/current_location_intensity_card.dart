import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:eqmonitor/core/component/intenisty/intensity_icon_type.dart';
import 'package:eqmonitor/core/component/intenisty/intensity_value_icon.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/current_location_intensity_display.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/repository/earthquake_history_repository.dart';
import 'package:eqmonitor/feature/location/data/location.dart';
import 'package:eqmonitor/feature/location/data/nearest_jma_feature.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lat_lng/lat_lng.dart';

/// 現在地に対応する震度を表示する。取得はウィジェット内の [useFuture] で行う。
class CurrentLocationIntensityCard extends HookConsumerWidget {
  const CurrentLocationIntensityCard({required this.item, super.key});

  final Earthquake item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eqIntensity = item.intensity;
    if (eqIntensity == null) {
      return const SizedBox.shrink();
    }

    final position = ref.watch(locationStreamProvider).value;
    final latLng = position != null
        ? LatLng(position.latitude, position.longitude)
        : null;

    final future = useMemoized(() {
      if (latLng == null) {
        return Future<CurrentLocationIntensityDisplay?>.value();
      }
      return () async {
        final repository = await ref.read(
          earthquakeHistoryRepositoryProvider.future,
        );
        final cityItem = await ref.read(
          jmaMapAreaInformationCityInsideProvider(latLng).future,
        );
        final regionItem = await ref.read(
          jmaMapAreaForecastLocalEInsideProvider(latLng).future,
        );
        return repository.resolveCurrentLocationIntensity(
          intensityTree: eqIntensity.intensityTree,
          cityAreaCode: cityItem?.property?.code,
          regionAreaCode: regionItem?.property?.code,
        );
      }();
    }, [latLng?.lat, latLng?.lon, item.eventId]);

    final snapshot = useFuture(future);

    if (latLng == null) {
      return const SizedBox.shrink();
    }

    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Center(
          child: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator.adaptive(strokeWidth: 2),
          ),
        ),
      );
    }

    if (snapshot.hasError) {
      return const SizedBox.shrink();
    }

    final display = snapshot.data;
    if (display == null) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return BorderedContainer(
      elevation: 1,
      child: Row(
        children: [
          IntensityValueIcon(
            intensity: display.intensity,
            type: IntensityIconType.filled,
            size: 40,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '現在地の震度（速報値）',
                  style: textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  display.usedCityLevelData
                      ? '市区町村に基づく震度速報です。'
                      : '細分区域に基づく震度速報です（市区町村データなし）。',
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
