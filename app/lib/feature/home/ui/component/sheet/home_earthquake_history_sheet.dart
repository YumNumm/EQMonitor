import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_not_found.dart';
import 'package:eqmonitor/feature/home/data/notifier/home_configuration_notifier.dart';
import 'package:eqmonitor/feature/home/data/provider/home_earthquake_history_parameter_provider.dart';
import 'package:eqmonitor/feature/home/ui/component/sheet/component/home_earthquake_list.dart';
import 'package:eqmonitor/feature/home/ui/component/sheet/component/home_scope_selector.dart';
import 'package:eqmonitor/feature/home/ui/component/sheet/component/home_scope_unavailable_body.dart';
import 'package:flutter/material.dart';
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
            HomeScopeSelector(
              scope: home.earthquakeHistoryScope,
              onScopeChanged: (scope) async => ref
                  .read(homeConfigurationProvider.notifier)
                  .setEarthquakeHistoryScope(scope),
            ),
            paramAsync.when(
              data: (param) {
                if (param == null) {
                  return HomeScopeUnavailableBody(
                    scope: home.earthquakeHistoryScope,
                    onRetry: () => ref.invalidate(
                      homeEarthquakeHistoryParameterProvider,
                    ),
                  );
                }
                final state = ref.watch(earthquakeHistoryProvider(param));
                final listSection = switch (state) {
                  AsyncData(:final value) =>
                    value.items.isEmpty
                        ? const EarthquakeHistoryNotFound()
                        : HomeEarthquakeList(earthquakes: value.items),
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
                if (home.earthquakeHistoryScope == .currentLocation) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      listSection,
                    ],
                  );
                }
                return listSection;
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
