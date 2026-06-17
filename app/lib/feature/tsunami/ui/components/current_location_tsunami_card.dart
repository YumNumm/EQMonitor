import 'package:eqmonitor/core/component/decoration/warning_stripe_decoration.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/feature/location/data/location.dart';
import 'package:eqmonitor/feature/location/data/model/map_data_item.dart';
import 'package:eqmonitor/feature/location/data/nearest_jma_feature.dart';
import 'package:eqmonitor/feature/tsunami/ui/components/tsunami_observation_station_tile.dart';
import 'package:eqmonitor/feature/tsunami/ui/utils/tsunami_warning_color.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lat_lng/lat_lng.dart';

class CurrentLocationTsunamiCard extends ConsumerWidget {
  const CurrentLocationTsunamiCard({required this.tsunami, super.key});

  final TsunamiState tsunami;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final positionAsync = ref.watch(locationStreamProvider);
    if (positionAsync case AsyncData(:final value)) {
      return _buildWithPosition(context, ref, value);
    }
    return const SizedBox.shrink();
  }

  Widget _buildWithPosition(
    BuildContext context,
    WidgetRef ref,
    Position position,
  ) {
    final latLng = LatLng(position.latitude, position.longitude);
    final nearestAsync = ref.watch(
      jmaMapAreaTsunamiNearestProvider(latLng),
    );
    if (nearestAsync case AsyncData(:final value)) {
      return _buildWithNearest(context, value);
    }
    return const SizedBox.shrink();
  }

  Widget _buildWithNearest(
    BuildContext context,
    MapDataItem? nearest,
  ) {
    if (nearest == null) {
      return const SizedBox.shrink();
    }

    final regionCode = nearest.property?.code;
    if (regionCode == null) {
      return const SizedBox.shrink();
    }

    final region = tsunami.forecastRegions
        .cast<MergedForecastRegion?>()
        .firstWhere(
          (r) => r?.code == regionCode,
          orElse: () => null,
        );
    if (region == null || region.kind == TsunamiWarningKind.none) {
      return const SizedBox.shrink();
    }

    final designSystem = context.designSystem;
    final color = designSystem.color;
    final stripeColors = TsunamiWarningColor.stripeColors(region.kind);
    final headerBg = TsunamiWarningColor.headerColor(region.kind);
    final distanceKm = nearest.distanceToCoastlineKm;

    final observedStations = region.observation?.stations
            .where((s) => !(s.firstHeight.isMissing ?? false))
            .toList() ??
        [];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedSuperellipseBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: color.outlineSoft),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (stripeColors.isNotEmpty)
              WarningStripeDecoration(colors: stripeColors),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              color: headerBg,
              child: Text(
                '${region.name}  ${TsunamiWarningColor.displayName(region.kind)}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
              child: Text(
                '現在地付近の津波情報',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: designSystem.textColor.primary,
                ),
              ),
            ),
            if (distanceKm != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                child: Text(
                  '海岸線まで約${distanceKm.round()}km',
                  style: TextStyle(
                    fontSize: 13,
                    color: designSystem.textColor.secondary,
                  ),
                ),
              ),
            if (observedStations.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
                child: Text(
                  '観測状況',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: designSystem.textColor.primary,
                  ),
                ),
              ),
              for (final station in observedStations)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TsunamiObservationStationTile(station: station),
                ),
              const SizedBox(height: 12),
            ] else
              const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
