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
import 'package:eqmonitor/feature/earthquake_history/data/model/sort_order.dart';
import 'package:eqmonitor/feature/earthquake_history/data/provider/similar_earthquake_provider.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_list_tile.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/modal/nearby_earthquake_parameter_sheet.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SimilarEarthquakeCard extends HookConsumerWidget {
  const SimilarEarthquakeCard({required this.earthquake, super.key});

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
      _ => null,
    };

    final sortBy = useState(api.EarthquakeSortBy.maxIntensity);
    final sortOrder = useState(api.SortOrder.desc);
    final searchParam = useState(const NearbyEarthquakeParameter());
    final theme = Theme.of(context);

    final asyncItems = ref.watch(
      nearbyEarthquakeProvider(
        earthquake.eventId,
        coordinates.latitude,
        coordinates.longitude,
        depth,
        sortBy.value,
        sortOrder.value,
        searchParam.value,
      ),
    );

    void onSortChanged(api.EarthquakeSortBy newSortBy) {
      if (sortBy.value == newSortBy) {
        sortOrder.value = sortOrder.value == api.SortOrder.asc
            ? api.SortOrder.desc
            : api.SortOrder.asc;
      } else {
        sortBy.value = newSortBy;
        sortOrder.value = switch (newSortBy) {
          api.EarthquakeSortBy.depth => api.SortOrder.asc,
          _ => api.SortOrder.desc,
        };
      }
    }

    Future<void> onShowAll() async {
      final param = searchParam.value;
      await EarthquakeHistoryRoute(
        $extra: EarthquakeHistoryParameter(
          latitudeGte: coordinates.latitude - param.latitudeOffset,
          latitudeLte: coordinates.latitude + param.latitudeOffset,
          longitudeGte: coordinates.longitude - param.longitudeOffset,
          longitudeLte: coordinates.longitude + param.longitudeOffset,
          depthGte: depth != null
              ? (depth - param.depthOffset).clamp(0, 9999)
              : null,
          depthLte: depth != null ? depth + param.depthOffset : null,
          sortBy: sortBy.value.toEarthquakeSortBy,
          sortOrder: sortOrder.value.toSortOrder,
        ),
      ).push<void>(context);
    }

    return BorderedContainer(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
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
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.tune, size: 20),
                  tooltip: '探索パラメータを変更',
                  visualDensity: VisualDensity.compact,
                  onPressed: () async {
                    final result =
                        await showModalBottomSheet<NearbyEarthquakeParameter>(
                          context: context,
                          builder: (_) => NearbyEarthquakeParameterSheet(
                            initial: searchParam.value,
                            hasDepth: depth != null,
                          ),
                        );
                    if (result != null) {
                      searchParam.value = result;
                    }
                  },
                ),
              ],
            ),
          ),
          _ParameterSummary(
            parameter: searchParam.value,
            hasDepth: depth != null,
          ),
          const SizedBox(height: 4),
          _SortButtonRow(
            sortBy: sortBy.value,
            sortOrder: sortOrder.value,
            onSortChanged: onSortChanged,
          ),
          const SizedBox(height: 8),
          // SWR 再検証中の「値を保持した AsyncLoading」で stale 表示を維持するため
          // 値ありを最優先でマッチさせる。
          switch (asyncItems) {
            AsyncValue(:final value?) when value.isEmpty => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              child: Center(
                child: Text(
                  '該当する地震がありません',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: context.designSystem.colorTheme.onSurfaceVariant,
                  ),
                ),
              ),
            ),
            AsyncValue(:final value?) => _NearbyEarthquakeList(
              items: value,
              onShowAll: onShowAll,
            ),
            AsyncError() => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  const Icon(Icons.error_outline, size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '近傍の地震の取得に失敗しました',
                      style: theme.textTheme.bodySmall,
                    ),
                  ),
                  TextButton(
                    onPressed: () => ref.invalidate(
                      nearbyEarthquakeProvider(
                        earthquake.eventId,
                        coordinates.latitude,
                        coordinates.longitude,
                        depth,
                        sortBy.value,
                        sortOrder.value,
                        searchParam.value,
                      ),
                    ),
                    child: const Text('再試行'),
                  ),
                ],
              ),
            ),
            _ => const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator.adaptive(strokeWidth: 2),
                ),
              ),
            ),
          },
        ],
      ),
    );
  }
}

class _ParameterSummary extends StatelessWidget {
  const _ParameterSummary({required this.parameter, required this.hasDepth});

  final NearbyEarthquakeParameter parameter;
  final bool hasDepth;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final latStr = '緯度±${parameter.latitudeOffset.toStringAsFixed(1)}°';
    final lngStr = '経度±${parameter.longitudeOffset.toStringAsFixed(1)}°';
    final depthStr = hasDepth ? '  深さ±${parameter.depthOffset}km' : '';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Text(
        '$latStr  $lngStr$depthStr',
        style: theme.textTheme.bodySmall?.copyWith(
          color: context.designSystem.colorTheme.onSurfaceVariant,
        ),
      ),
    );
  }
}

class _NearbyEarthquakeList extends StatelessWidget {
  const _NearbyEarthquakeList({required this.items, required this.onShowAll});

  final List<EarthquakePartial> items;
  final Future<void> Function() onShowAll;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final item in items) ...[
          EarthquakeHistoryListTile(
            item: item,
            onTap: () async => EarthquakeHistoryDetailsRoute(
              eventId: item.eventId,
            ).push<void>(context),
            showBackgroundColor: false,
            intensityIconSize: 32,
            dense: true,
          ),
          const Divider(height: 1, indent: 12, endIndent: 12),
        ],
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: TextButton(onPressed: onShowAll, child: const Text('すべて表示')),
        ),
      ],
    );
  }
}

class _SortButtonRow extends StatelessWidget {
  const _SortButtonRow({
    required this.sortBy,
    required this.sortOrder,
    required this.onSortChanged,
  });

  final api.EarthquakeSortBy sortBy;
  final api.SortOrder sortOrder;
  final ValueChanged<api.EarthquakeSortBy> onSortChanged;

  static const List<(api.EarthquakeSortBy, String)> _sortOptions = [
    (api.EarthquakeSortBy.originTime, '日時'),
    (api.EarthquakeSortBy.magnitude, 'M'),
    (api.EarthquakeSortBy.maxIntensity, '最大震度'),
    (api.EarthquakeSortBy.depth, '深さ'),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          for (final (value, label) in _sortOptions)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: FilterChip(
                selected: sortBy == value,
                showCheckmark: false,
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(label),
                    if (sortBy == value) ...[
                      const SizedBox(width: 2),
                      Icon(
                        sortOrder == api.SortOrder.asc
                            ? Icons.arrow_upward
                            : Icons.arrow_downward,
                        size: 14,
                      ),
                    ],
                  ],
                ),
                onSelected: (_) => onSortChanged(value),
                visualDensity: VisualDensity.compact,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
        ],
      ),
    );
  }
}
