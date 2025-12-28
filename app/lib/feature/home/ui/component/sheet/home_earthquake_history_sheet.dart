import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_list_tile.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_not_found.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeEarthquakeHistorySheet extends HookConsumerWidget {
  const HomeEarthquakeHistorySheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(
      earthquakeHistoryProvider(const EarthquakeHistoryParameter()),
    );

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card.outlined(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      color: colorScheme.surfaceContainer,
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: _Header(),
          ),
          switch (state) {
            AsyncData(:final value) =>
              value.items.isEmpty
                  ? const EarthquakeHistoryNotFound()
                  : _EarthquakeList(earthquakes: value.items),
            AsyncError(:final error) => ErrorCard(
              error: error,
              margin: EdgeInsets.zero,
              onReload: () async => ref.refresh(
                earthquakeHistoryProvider(
                  const EarthquakeHistoryParameter(),
                ),
              ),
              padding: const EdgeInsets.all(8),
            ),
            _ => const Center(child: CircularProgressIndicator.adaptive()),
          },
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.location_on_outlined),
            title: const Text('地域から検索'),
            trailing: const Icon(Icons.chevron_right),
            visualDensity: VisualDensity.compact,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            onTap: () async =>
                const EarthquakeSearchSelectionRoute().push<void>(context),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      children: [
        Text(
          '最近の地震',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        const Spacer(),
        FilledButton.tonal(
          onPressed: () async =>
              const EarthquakeHistoryRoute().push<void>(context),
          style: TextButton.styleFrom(
            visualDensity: VisualDensity.compact,
            padding: const EdgeInsets.symmetric(horizontal: 12),
          ),
          child: const Text('さらに表示'),
        ),
      ],
    );
  }
}

class _EarthquakeList extends StatelessWidget {
  const _EarthquakeList({required this.earthquakes});

  final List<EarthquakePartial> earthquakes;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: earthquakes
          .take(3)
          .map(
            (item) => InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () async => EarthquakeHistoryDetailsRoute(
                eventId: item.eventId,
              ).push<void>(context),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: EarthquakeHistoryListTile(
                  visualDensity: VisualDensity.compact,
                  item: item,
                  showBackgroundColor: false,
                  intensityIconSize: 32,
                  titleTextColor: colorScheme.onSurfaceVariant,
                  descriptionTextColor: colorScheme.onSurfaceVariant,
                  magnitudeTextColor: colorScheme.onPrimaryContainer,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
