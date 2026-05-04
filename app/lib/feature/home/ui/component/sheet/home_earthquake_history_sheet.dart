import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_not_found.dart';
import 'package:eqmonitor/feature/home/data/model/home_configuration_model.dart';
import 'package:eqmonitor/feature/home/data/notifier/home_configuration_notifier.dart';
import 'package:eqmonitor/feature/home/data/provider/home_earthquake_history_parameter_provider.dart';
import 'package:eqmonitor/feature/home/ui/component/sheet/component/home_earthquake_list.dart';
import 'package:eqmonitor/feature/home/ui/component/sheet/component/home_scope_selector.dart';
import 'package:eqmonitor/feature/home/ui/component/sheet/component/home_scope_unavailable_body.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeEarthquakeHistorySheet extends HookConsumerWidget {
  const HomeEarthquakeHistorySheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final designSystem = context.designSystem;
    final color = designSystem.color;
    final spacing = designSystem.spacing;
    final shape = designSystem.shape;
    final homeAsync = ref.watch(homeConfigurationProvider);
    final paramAsync = ref.watch(homeEarthquakeHistoryParameterProvider);

    return homeAsync.when(
      data: (home) {
        final isCurrentLocation = home.common.earthquakeHistoryScope ==
            HomeEarthquakeHistoryScope.currentLocation;
        final locationName = isCurrentLocation
            ? paramAsync.value?.regionName
            : null;
        final currentParam = isCurrentLocation ? paramAsync.value : null;

        return Card.outlined(
          margin: EdgeInsets.zero,
          color: color.surfaceCard,
          clipBehavior: Clip.antiAlias,
          elevation: 0,
          shape: RoundedSuperellipseBorder(
            borderRadius: BorderRadius.circular(shape.card),
            side: BorderSide(color: color.outlineSoft),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              HomeScopeSelector(
                scope: home.common.earthquakeHistoryScope,
                onScopeChanged: (scope) async => ref
                    .read(homeConfigurationProvider.notifier)
                    .setEarthquakeHistoryScope(scope),
                locationName: locationName,
              ),
              paramAsync.when(
                data: (param) {
                  if (param == null) {
                    return HomeScopeUnavailableBody(
                      scope: home.common.earthquakeHistoryScope,
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
                    _ => const _HomeEarthquakeHistorySheetSkeleton(),
                  };
                  if (isCurrentLocation) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [listSection],
                    );
                  }
                  return listSection;
                },
                loading: () => const _HomeEarthquakeHistorySheetSkeleton(),
                error: (error, _) => ErrorCard(
                  error: error,
                  margin: EdgeInsets.zero,
                  onReload: () async =>
                      ref.invalidate(homeEarthquakeHistoryParameterProvider),
                  padding: const EdgeInsets.all(8),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  spacing.lg,
                  spacing.xs,
                  spacing.lg,
                  spacing.md,
                ),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () async => EarthquakeHistoryRoute(
                      $extra: currentParam,
                    ).push<void>(context),
                    child: const Text('さらに表示'),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      loading: () => Card.outlined(
        margin: EdgeInsets.zero,
        color: color.surfaceCard,
        elevation: 0,
        shape: RoundedSuperellipseBorder(
          borderRadius: BorderRadius.circular(shape.card),
          side: BorderSide(color: color.outlineSoft),
        ),
        child: const _HomeEarthquakeHistorySheetSkeleton(),
      ),
      error: (e, _) => const SizedBox.shrink(),
    );
  }
}

class _HomeEarthquakeHistorySheetSkeleton extends StatelessWidget {
  const _HomeEarthquakeHistorySheetSkeleton();

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final spacing = designSystem.spacing;
    final shape = designSystem.shape;
    final color = designSystem.color;

    return Padding(
      padding: EdgeInsets.all(spacing.lg),
      child: Skeletonizer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 18,
              width: 120,
              decoration: BoxDecoration(
                color: color.surfaceRaised,
                borderRadius: BorderRadius.circular(shape.sm),
              ),
            ),
            SizedBox(height: spacing.sm),
            Container(
              height: 44,
              decoration: BoxDecoration(
                color: color.surfaceRaised,
                borderRadius: BorderRadius.circular(shape.md),
              ),
            ),
            SizedBox(height: spacing.lg),
            for (final index in List.generate(3, (index) => index)) ...[
              const ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(radius: 16),
                title: Text('2026/04/21 12:34'),
                subtitle: Text('最大震度4 / M5.2 / 東京都'),
                trailing: Icon(Icons.chevron_right_rounded),
              ),
              if (index != 2) SizedBox(height: spacing.sm),
            ],
          ],
        ),
      ),
    );
  }
}
