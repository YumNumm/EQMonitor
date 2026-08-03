import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/earthquake_history/data/logic/earthquake_activity_eligibility.dart';
import 'package:eqmonitor/feature/earthquake_history/data/logic/earthquake_activity_summary_builder.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/coordinate.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_activity_query.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_depth.dart';
import 'package:eqmonitor/feature/earthquake_history/data/provider/earthquake_activity_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EarthquakeActivityCard extends ConsumerWidget {
  const EarthquakeActivityCard({required this.earthquake, super.key});

  final Earthquake earthquake;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coordinates = earthquake.hypocenter?.coordinates;
    final originTime = earthquake.originTime;
    if (!const EarthquakeActivityEligibility().isEligible(earthquake) ||
        coordinates is! CoordinateLatLng ||
        originTime == null) {
      return const SizedBox.shrink();
    }
    final depth = switch (earthquake.hypocenter?.depth) {
      EarthquakeDepthShallow() => 0,
      EarthquakeDepthValue(:final value) => value,
      EarthquakeDepthOver700km() => 700,
      EarthquakeDepthUnknown() || null => null,
    };
    final query = EarthquakeActivityQuery(
      baseEventId: earthquake.eventId,
      baseOriginTime: originTime,
      latitude: coordinates.latitude,
      longitude: coordinates.longitude,
      depth: depth,
      beforeDays: 1,
      afterDays: 7,
      radiusKm: 25,
      depthOffsetKm: depth == null ? null : 20,
    );
    final state = ref.watch(earthquakeActivityProvider(query));

    return BorderedContainer(
      child: ListTile(
        title: const Text('周辺の地震活動'),
        subtitle: switch (state) {
          AsyncValue(:final value?) => Text(
            (() {
              final summary = const EarthquakeActivitySummaryBuilder().build(
                items: value.items,
                query: query,
              );
              return '前1日 ${summary.beforeCount}件・発生後7日 ${summary.afterCount}件\n'
                  '半径25km、深さ${depth == null ? '指定なし' : '±20km'}';
            })(),
          ),
          AsyncError() => const Text('周辺の地震活動を取得できませんでした'),
          _ => const Text('地震履歴を確認しています…'),
        },
        trailing: const Icon(Icons.chevron_right),
        onTap: () => EarthquakeActivityRoute($extra: query).push<void>(context),
      ),
    );
  }
}
