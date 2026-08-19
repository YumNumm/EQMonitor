import 'dart:io';

import 'package:collection/collection.dart';
import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:eqmonitor/core/component/intenisty/jma_intensity_icon.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/current_location_intensity_display.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/data/provider/current_location_intensity_provider.dart';
import 'package:eqmonitor/feature/location/data/location.dart';
import 'package:eqmonitor/feature/location/data/location_accuracy_provider.dart';
import 'package:eqmonitor/feature/location/data/logic/current_location_precision.dart';
import 'package:eqmonitor/feature/location/data/nearest_jma_feature.dart';
import 'package:eqmonitor/feature/parameter/data/notifier/parameter_set_notifier.dart';
import 'package:geolocator/geolocator.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lat_lng/lat_lng.dart';

/// 現在地に対応する震度を表示する。
class CurrentLocationIntensityCard extends HookConsumerWidget {
  const new({required this.item, super.key});

  final Earthquake item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (item.intensity == null) {
      return const SizedBox.shrink();
    }

    final position = ref.watch(locationStreamProvider).value;
    final latLng = useMemoized(
      () => position != null
          ? LatLng(position.latitude, position.longitude)
          : null,
      [position?.latitude, position?.longitude],
    );

    if (latLng == null) {
      return const SizedBox.shrink();
    }

    final accuracyStatus = ref.watch(locationAccuracyStatusProvider).value;
    if (accuracyStatus == null) {
      // 権限の精度が判明するまでは、粗い位置で市区町村を確定させない。
      return const SizedBox.shrink();
    }
    final precision = const CurrentLocationPrecisionResolver().resolve(
      accuracyStatus: accuracyStatus,
      horizontalAccuracyMeters: position?.accuracy,
    );
    final isCityPrecision = precision == CurrentLocationPrecision.city;

    final cityCode = ref
        .watch(jmaMapAreaInformationCityInsideProvider(latLng))
        .value
        ?.property
        ?.code;
    final regionCode = ref
        .watch(jmaMapAreaForecastLocalEInsideProvider(latLng))
        .value
        ?.property
        ?.code;

    final cachedCityCode = useRef<String?>(null);
    final cachedRegionCode = useRef<String?>(null);
    if (cityCode != null) {
      cachedCityCode.value = cityCode;
    }
    if (regionCode != null) {
      cachedRegionCode.value = regionCode;
    }
    // 測位が粗いときは市区町村を使わず、細分区域までに留める。
    final effectiveCityCode = isCityPrecision
        ? cityCode ?? cachedCityCode.value
        : null;
    final effectiveRegionCode = regionCode ?? cachedRegionCode.value;

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
            .firstWhereOrNull((e) => e.city.code == effectiveCityCode),
      ),
    );
    final cityParameterName = cityParameter != null
        ? '${cityParameter.prefecture.name.ja}${cityParameter.city.name.ja}'
        : null;
    final regionParameter = ref.watch(
      parameterSetProvider.select(
        (v) => v.value?.earthquake.prefectures
            .expand((p) => p.regions)
            .firstWhereOrNull((r) => r.code == effectiveRegionCode),
      ),
    );

    final state = ref.watch(
      currentLocationIntensityProvider(
        eventId: item.eventId,
        cityAreaCode: effectiveCityCode,
        regionAreaCode: effectiveRegionCode,
      ),
    );

    return state.when(
      loading: () => const SizedBox.shrink(),
      error: (error, stackTrace) => const SizedBox.shrink(),
      data: (value) => switch (value) {
        CurrentLocationIntensityDisplayNone() => const SizedBox.shrink(),
        CurrentLocationIntensityDisplayQuick(:final intensity) =>
          _CurrentLocationIntensityContent(
            intensity: intensity,
            lpgmIntensity: null,
            title: "${regionParameter?.name.ja ?? ''} で最大震度${intensity.label}",
            stations: [],
            coarseLocationAccuracyStatus: isCityPrecision
                ? null
                : accuracyStatus,
          ),
        CurrentLocationIntensityDisplayResult(
          :final intensity,
          :final lpgmIntensity,
          :final stations,
        ) =>
          _CurrentLocationIntensityContent(
            intensity: intensity,
            lpgmIntensity: lpgmIntensity,
            title: "${cityParameterName ?? ''} で最大震度${intensity.label}",
            stations: stations,
            coarseLocationAccuracyStatus: null,
          ),
      },
      skipLoadingOnRefresh: true,
      skipLoadingOnReload: true,
    );
  }
}

class _CurrentLocationIntensityContent extends StatelessWidget {
  const new({
    required this.intensity,
    required this.lpgmIntensity,
    required this.title,
    required this.stations,
    required this.coarseLocationAccuracyStatus,
  });

  final JmaIntensity intensity;
  final JmaLpgmIntensity? lpgmIntensity;
  final String title;
  final List<StationIntensityNode> stations;

  /// 測位が粗く市区町村まで絞れていない場合の権限精度。
  /// 市区町村まで絞れている場合は null。
  final LocationAccuracyStatus? coarseLocationAccuracyStatus;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final designSystem = context.designSystem;
    final spacing = designSystem.spacing;

    return BorderedContainer(
      elevation: 1,
      child: Row(
        spacing: spacing.md,
        children: [
          JmaIntensityIcon(intensity: intensity, type: .filled, size: 40),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              spacing: spacing.xs,
              children: [
                Text(
                  title,
                  style: textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Wrap(
                  spacing: spacing.xs,
                  children: stations
                      .map((e) => Text(e.station.name.ja))
                      .toList(),
                ),
                if (coarseLocationAccuracyStatus case final status?)
                  _CoarseLocationNotice(accuracyStatus: status),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 測位が粗く市区町村まで絞れていないことの注記。
///
/// iOS で「正確な位置情報」がオフの場合のみ、一時的な許可を要求する導線を出す。
/// Android には一時許可の仕組みが無いため、注記のみとする。
class _CoarseLocationNotice extends ConsumerWidget {
  const new({required this.accuracyStatus});

  final LocationAccuracyStatus accuracyStatus;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final designSystem = context.designSystem;
    final isReduced = accuracyStatus == LocationAccuracyStatus.reduced;
    final message = isReduced
        ? '「正確な位置情報」がオフのため、市区町村までは絞り込めていません'
        : '測位精度が粗いため、市区町村までは絞り込めていません';

    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(
          message,
          style: theme.textTheme.bodySmall?.copyWith(
            color: designSystem.colorTheme.onSurfaceVariant,
          ),
        ),
        if (isReduced && Platform.isIOS)
          TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: () async {
              await const TemporaryPreciseLocationRequester().request();
              ref.invalidate(locationAccuracyStatusProvider);
            },
            child: const Text('正確な位置情報を許可する'),
          ),
      ],
    );
  }
}
