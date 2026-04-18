import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_list_tile.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_not_found.dart';
import 'package:eqmonitor/feature/home/data/model/home_configuration_model.dart';
import 'package:eqmonitor/feature/home/data/notifier/home_configuration_notifier.dart';
import 'package:eqmonitor/feature/home/data/provider/home_earthquake_history_parameter_provider.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeEarthquakeHistorySheet extends HookConsumerWidget {
  const HomeEarthquakeHistorySheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final homeAsync = ref.watch(homeConfigurationProvider);
    final paramAsync = ref.watch(homeEarthquakeHistoryParameterProvider);

    return homeAsync.when(
      data: (home) => Card.outlined(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        color: colorScheme.surfaceContainer,
        clipBehavior: Clip.antiAlias,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
              child: _ScopeSelector(
                scope: home.earthquakeHistoryScope,
                onScopeChanged: (scope) async => ref
                    .read(homeConfigurationProvider.notifier)
                    .setEarthquakeHistoryScope(scope),
              ),
            ),
            paramAsync.when(
              data: (param) {
                if (param == null) {
                  return _ScopeUnavailableBody(
                    scope: home.earthquakeHistoryScope,
                    onRetry: () => ref.invalidate(
                      homeEarthquakeHistoryParameterProvider,
                    ),
                  );
                }
                final state = ref.watch(earthquakeHistoryProvider(param));
                return switch (state) {
                  AsyncData(:final value) =>
                    value.items.isEmpty
                        ? const EarthquakeHistoryNotFound()
                        : _EarthquakeList(earthquakes: value.items),
                  AsyncError(:final error) => ErrorCard(
                    error: error,
                    margin: EdgeInsets.zero,
                    onReload: () async {
                      ref.invalidate(homeEarthquakeHistoryParameterProvider);
                      ref.invalidate(earthquakeHistoryProvider(param));
                    },
                    padding: const EdgeInsets.all(8),
                  ),
                  _ => const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  ),
                };
              },
              loading: () => const Center(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: CircularProgressIndicator.adaptive(),
                ),
              ),
              error: (error, _) => ErrorCard(
                error: error,
                margin: EdgeInsets.zero,
                onReload: () async =>
                    ref.invalidate(homeEarthquakeHistoryParameterProvider),
                padding: const EdgeInsets.all(8),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () async =>
                      const EarthquakeHistoryRoute().push<void>(context),
                  child: const Text('さらに表示'),
                ),
              ),
            ),
          ],
        ),
      ),
      loading: () => Card.outlined(
        color: colorScheme.surfaceContainer,
        child: const Padding(
          padding: EdgeInsets.all(24),
          child: Center(child: CircularProgressIndicator.adaptive()),
        ),
      ),
      error: (e, _) => const SizedBox.shrink(),
    );
  }
}

class _ScopeSelector extends StatelessWidget {
  const _ScopeSelector({
    required this.scope,
    required this.onScopeChanged,
  });

  final HomeEarthquakeHistoryScope scope;
  final ValueChanged<HomeEarthquakeHistoryScope> onScopeChanged;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<HomeEarthquakeHistoryScope>(
      showSelectedIcon: false,
      segments: const [
        ButtonSegment(
          value: HomeEarthquakeHistoryScope.nationwide,
          label: Text('全国'),
        ),
        ButtonSegment(
          value: HomeEarthquakeHistoryScope.currentLocation,
          label: Text('現在地'),
        ),
        ButtonSegment(
          value: HomeEarthquakeHistoryScope.designatedRegion,
          label: Text('指定地域'),
        ),
      ],
      selected: {scope},
      onSelectionChanged: (next) {
        if (next.isEmpty) {
          return;
        }
        onScopeChanged(next.first);
      },
    );
  }
}

class _ScopeUnavailableBody extends StatelessWidget {
  const _ScopeUnavailableBody({required this.scope, required this.onRetry});

  final HomeEarthquakeHistoryScope scope;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final message = switch (scope) {
      HomeEarthquakeHistoryScope.currentLocation =>
        '現在地の市区町村を特定できません。位置情報の利用を許可してください。',
      HomeEarthquakeHistoryScope.designatedRegion => '指定地域が設定されていません。',
      HomeEarthquakeHistoryScope.nationwide => '',
    };

    if (message.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          if (scope == HomeEarthquakeHistoryScope.currentLocation) ...[
            const SizedBox(height: 8),
            FilledButton.tonal(
              onPressed: () async {
                final status = await Geolocator.checkPermission();
                if (status == LocationPermission.denied) {
                  await Geolocator.requestPermission();
                } else if (status == LocationPermission.deniedForever) {
                  await Geolocator.openAppSettings();
                }
                onRetry();
              },
              child: const Text('位置情報の取得を許可する'),
            ),
          ],
        ],
      ),
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
