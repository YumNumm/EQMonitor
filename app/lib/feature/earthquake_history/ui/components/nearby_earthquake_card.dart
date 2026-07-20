import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/coordinate.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_depth.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_sort_by.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/nearby_earthquake_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/nearby_earthquake_query.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/sort_order.dart';
import 'package:eqmonitor/feature/earthquake_history/data/provider/nearby_earthquakes_provider.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_list_tile.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/modal/nearby_earthquake_parameter_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NearbyEarthquakeCard extends HookConsumerWidget {
  const NearbyEarthquakeCard({required this.earthquake, super.key});

  final Earthquake earthquake;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coordinates = earthquake.hypocenter?.coordinates;
    if (coordinates is! CoordinateLatLng) {
      return const SizedBox.shrink();
    }

    final depth = switch (earthquake.hypocenter?.depth) {
      EarthquakeDepthShallow() => 0,
      EarthquakeDepthValue(:final value) => value,
      EarthquakeDepthOver700km() => 700,
      EarthquakeDepthUnknown() || null => null,
    };
    final parameter = useState(const NearbyEarthquakeParameter());
    final sortBy = useState(EarthquakeSortBy.maxIntensity);
    final sortOrder = useState(SortOrder.desc);
    final query = NearbyEarthquakeQuery(
      excludeEventId: earthquake.eventId,
      latitude: coordinates.latitude,
      longitude: coordinates.longitude,
      depth: depth,
      parameter: parameter.value,
      sortBy: sortBy.value,
      sortOrder: sortOrder.value,
    );
    final searchParameter = EarthquakeHistoryParameter.all(
      sortBy: sortBy.value,
      sortOrder: sortOrder.value,
      latitudeGte: query.latitudeGte,
      latitudeLte: query.latitudeLte,
      longitudeGte: query.longitudeGte,
      longitudeLte: query.longitudeLte,
      depthGte: query.depthGte,
      depthLte: query.depthLte,
    );
    final state = ref.watch(nearbyEarthquakesProvider(query));

    return BorderedContainer(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _NearbyEarthquakeHeader(
            onSettingsPressed: () async {
              final result =
                  await showModalBottomSheet<NearbyEarthquakeParameter>(
                    context: context,
                    builder: (context) => NearbyEarthquakeParameterSheet(
                      initial: parameter.value,
                      hasDepth: depth != null,
                    ),
                  );
              if (result != null) {
                parameter.value = result;
              }
            },
          ),
          _NearbyEarthquakeParameterSummary(
            parameter: parameter.value,
            hasDepth: depth != null,
          ),
          const SizedBox(height: 8),
          _NearbyEarthquakeSortChips(
            sortBy: sortBy.value,
            sortOrder: sortOrder.value,
            onChanged: (value) {
              if (sortBy.value == value) {
                sortOrder.value = switch (sortOrder.value) {
                  .asc => .desc,
                  .desc => .asc,
                };
                return;
              }
              sortBy.value = value;
              sortOrder.value = switch (value) {
                .depth => .asc,
                _ => .desc,
              };
            },
          ),
          const SizedBox(height: 8),
          switch (state) {
            AsyncLoading() => const _NearbyEarthquakeLoading(),
            AsyncError() => _NearbyEarthquakeError(
              onRetry: () => ref.invalidate(nearbyEarthquakesProvider(query)),
            ),
            AsyncData(:final value) when value.isEmpty =>
              const _NearbyEarthquakeEmpty(),
            AsyncData(:final value) => _NearbyEarthquakeList(
              items: value.take(5).toList(),
              searchParameter: searchParameter,
              onShowAll: () async => EarthquakeHistoryRoute(
                $extra: searchParameter,
              ).push<void>(context),
            ),
          },
        ],
      ),
    );
  }
}

class _NearbyEarthquakeHeader extends StatelessWidget {
  const _NearbyEarthquakeHeader({required this.onSettingsPressed});

  final VoidCallback onSettingsPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 4, 0),
      child: Row(
        children: [
          Icon(
            Icons.location_searching,
            size: 18,
            color: context.designSystem.colorTheme.onSurfaceVariant,
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              'この震源の近傍で発生した地震',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.tune, size: 20),
            tooltip: '探索パラメータを変更',
            visualDensity: VisualDensity.compact,
            onPressed: onSettingsPressed,
          ),
        ],
      ),
    );
  }
}

class _NearbyEarthquakeParameterSummary extends StatelessWidget {
  const _NearbyEarthquakeParameterSummary({
    required this.parameter,
    required this.hasDepth,
  });

  final NearbyEarthquakeParameter parameter;
  final bool hasDepth;

  @override
  Widget build(BuildContext context) {
    final depthText = hasDepth ? '  深さ±${parameter.depthOffset}km' : '';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Text(
        '緯度±${parameter.latitudeOffset.toStringAsFixed(1)}°  '
        '経度±${parameter.longitudeOffset.toStringAsFixed(1)}°$depthText',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: context.designSystem.colorTheme.onSurfaceVariant,
        ),
      ),
    );
  }
}

class _NearbyEarthquakeSortChips extends StatelessWidget {
  const _NearbyEarthquakeSortChips({
    required this.sortBy,
    required this.sortOrder,
    required this.onChanged,
  });

  final EarthquakeSortBy sortBy;
  final SortOrder sortOrder;
  final ValueChanged<EarthquakeSortBy> onChanged;

  @override
  Widget build(BuildContext context) {
    const options = [
      (EarthquakeSortBy.eventId, '発生時刻'),
      (EarthquakeSortBy.magnitude, 'M'),
      (EarthquakeSortBy.maxIntensity, '最大震度'),
      (EarthquakeSortBy.depth, '深さ'),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Wrap(
        spacing: 8,
        runSpacing: 4,
        children: [
          for (final (value, label) in options)
            FilterChip(
              selected: sortBy == value,
              showCheckmark: false,
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(label),
                  if (sortBy == value) ...[
                    const SizedBox(width: 2),
                    Icon(switch (sortOrder) {
                      .asc => Icons.arrow_upward,
                      .desc => Icons.arrow_downward,
                    }, size: 14),
                  ],
                ],
              ),
              onSelected: (_) => onChanged(value),
              visualDensity: VisualDensity.compact,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
        ],
      ),
    );
  }
}

class _NearbyEarthquakeLoading extends StatelessWidget {
  const _NearbyEarthquakeLoading();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: SizedBox.square(
          dimension: 24,
          child: CircularProgressIndicator.adaptive(strokeWidth: 2),
        ),
      ),
    );
  }
}

class _NearbyEarthquakeError extends StatelessWidget {
  const _NearbyEarthquakeError({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          const Icon(Icons.error_outline, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              '近傍の地震の取得に失敗しました',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          TextButton(onPressed: onRetry, child: const Text('再試行')),
        ],
      ),
    );
  }
}

class _NearbyEarthquakeEmpty extends StatelessWidget {
  const _NearbyEarthquakeEmpty();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: Center(
        child: Text(
          '該当する地震がありません',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: context.designSystem.colorTheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}

class _NearbyEarthquakeList extends StatelessWidget {
  const _NearbyEarthquakeList({
    required this.items,
    required this.searchParameter,
    required this.onShowAll,
  });

  final List<EarthquakePartial> items;
  final EarthquakeHistoryParameter searchParameter;
  final VoidCallback onShowAll;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return EarthquakeHistoryListTile(
              item: item,
              searchParameter: searchParameter,
              onTap: () async => EarthquakeHistoryDetailsRoute(
                eventId: item.earthquake.eventId,
              ).push<void>(context),
              showBackgroundColor: false,
              intensityIconSize: 32,
              dense: true,
            );
          },
          separatorBuilder: (context, index) =>
              const Divider(height: 1, indent: 12, endIndent: 12),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: TextButton(onPressed: onShowAll, child: const Text('すべて表示')),
        ),
      ],
    );
  }
}
