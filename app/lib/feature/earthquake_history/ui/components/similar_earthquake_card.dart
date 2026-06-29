import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/coordinate.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_depth.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_sort_by.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/nearby_earthquake_search_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/sort_order.dart';
import 'package:eqmonitor/feature/earthquake_history/data/provider/similar_earthquake_provider.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SimilarEarthquakeCard extends HookConsumerWidget {
  const SimilarEarthquakeCard({
    required this.earthquake,
    super.key,
  });

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

    final parameter = useState(
      NearbyEarthquakeSearchParameter(
        latitude: coordinates.latitude,
        longitude: coordinates.longitude,
        depth: depth,
        sortBy: EarthquakeSortBy.originTime,
        sortOrder: SortOrder.desc,
      ),
    );
    final intensityColor = ref.watch(intensityColorProvider);
    final theme = Theme.of(context);

    final asyncItems = ref.watch(
      nearbyEarthquakeProvider(
        earthquake.eventId,
        parameter.value,
      ),
    );

    return BorderedContainer(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 8, 8),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'この震源の近傍で発生した地震',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  tooltip: '探索範囲',
                  onPressed: () async {
                    final result =
                        await showModalBottomSheet<
                          NearbyEarthquakeSearchParameter
                        >(
                          context: context,
                          showDragHandle: true,
                          builder: (context) => _NearbySearchParameterSheet(
                            parameter: parameter.value,
                          ),
                        );
                    if (result != null) {
                      parameter.value = result;
                    }
                  },
                  icon: const Icon(Icons.tune),
                ),
              ],
            ),
          ),
          _SearchParameterSummary(parameter: parameter.value),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 4, 12, 0),
            child: Text(
              '最大${parameter.value.fetchLimit}件を表示',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          _SortButtonRow(
            sortBy: parameter.value.sortBy,
            sortOrder: parameter.value.sortOrder,
            onSortChanged: (newSortBy) =>
                parameter.value = parameter.value.updateSort(newSortBy),
          ),
          const SizedBox(height: 8),
          switch (asyncItems) {
            AsyncLoading() => const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator.adaptive(strokeWidth: 2),
                ),
              ),
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
                        parameter.value,
                      ),
                    ),
                    child: const Text('再試行'),
                  ),
                ],
              ),
            ),
            AsyncData(value: final items) when items.isEmpty => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              child: Center(
                child: Text(
                  '該当する地震がありません',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ),
            AsyncData(value: final items) => _NearbyEarthquakeList(
              items: items,
              parameter: parameter.value,
              intensityColor: intensityColor,
            ),
          },
        ],
      ),
    );
  }
}

class _NearbyEarthquakeList extends StatelessWidget {
  const _NearbyEarthquakeList({
    required this.items,
    required this.parameter,
    required this.intensityColor,
  });

  final List<EarthquakePartial> items;
  final NearbyEarthquakeSearchParameter parameter;
  final IntensityColorModel intensityColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final item in items) ...[
          EarthquakeHistoryListTile(
            item: item,
            intensityColor: intensityColor,
            onTap: () => EarthquakeHistoryDetailsRoute(
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
          child: TextButton.icon(
            onPressed: () => EarthquakeHistoryRoute(
              $extra: parameter.toHistoryParameter(),
            ).push<void>(context),
            icon: const Icon(Icons.open_in_new),
            label: const Text('すべて表示'),
          ),
        ),
      ],
    );
  }
}

class _SearchParameterSummary extends StatelessWidget {
  const _SearchParameterSummary({required this.parameter});

  final NearbyEarthquakeSearchParameter parameter;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Wrap(
        spacing: 8,
        runSpacing: 4,
        children: [
          _ParameterChip(label: parameter.latLngRangeLabel),
          _ParameterChip(label: parameter.depthRangeLabel),
        ],
      ),
    );
  }
}

class _ParameterChip extends StatelessWidget {
  const _ParameterChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}

class _NearbySearchParameterSheet extends HookWidget {
  const _NearbySearchParameterSheet({required this.parameter});

  final NearbyEarthquakeSearchParameter parameter;

  @override
  Widget build(BuildContext context) {
    final latLngRange = useState(parameter.latLngRange);
    final depthRangeKm = useState(parameter.depthRangeKm.toDouble());
    final theme = Theme.of(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '探索範囲',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _RangeSliderSection(
              title: '緯度経度範囲',
              valueLabel: '震源から±${latLngRange.value.toStringAsFixed(1)}°',
              slider: Slider(
                min: 0.1,
                max: 2,
                divisions: 19,
                value: latLngRange.value,
                label: '±${latLngRange.value.toStringAsFixed(1)}°',
                onChanged: (value) => latLngRange.value = value,
              ),
            ),
            const SizedBox(height: 12),
            _RangeSliderSection(
              title: '深さ範囲',
              valueLabel: parameter.depth == null
                  ? '震源の深さが不明なため条件なし'
                  : '震源から±${depthRangeKm.value.round()}km',
              slider: Slider(
                max: 300,
                divisions: 30,
                value: depthRangeKm.value,
                label: '±${depthRangeKm.value.round()}km',
                onChanged: parameter.depth == null
                    ? null
                    : (value) => depthRangeKm.value = value,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(
                    NearbyEarthquakeSearchParameter(
                      latitude: parameter.latitude,
                      longitude: parameter.longitude,
                      depth: parameter.depth,
                      sortBy: parameter.sortBy,
                      sortOrder: parameter.sortOrder,
                    ),
                  ),
                  child: const Text('リセット'),
                ),
                const Spacer(),
                FilledButton(
                  onPressed: () => Navigator.of(context).pop(
                    NearbyEarthquakeSearchParameter(
                      latitude: parameter.latitude,
                      longitude: parameter.longitude,
                      depth: parameter.depth,
                      latLngRange: latLngRange.value,
                      depthRangeKm: depthRangeKm.value.round(),
                      sortBy: parameter.sortBy,
                      sortOrder: parameter.sortOrder,
                    ),
                  ),
                  child: const Text('適用'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _RangeSliderSection extends StatelessWidget {
  const _RangeSliderSection({
    required this.title,
    required this.valueLabel,
    required this.slider,
  });

  final String title;
  final String valueLabel;
  final Widget slider;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: theme.textTheme.titleSmall,
              ),
            ),
            Text(
              valueLabel,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        slider,
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

  final EarthquakeSortBy sortBy;
  final SortOrder sortOrder;
  final ValueChanged<EarthquakeSortBy> onSortChanged;

  static const List<(EarthquakeSortBy, String)> _sortOptions = [
    (EarthquakeSortBy.originTime, '日時'),
    (EarthquakeSortBy.magnitude, 'M'),
    (EarthquakeSortBy.maxIntensity, '最大震度'),
    (EarthquakeSortBy.depth, '深さ'),
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
                        sortOrder == SortOrder.asc
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
