import 'dart:async';

import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter_x.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/provider/region_name_resolver.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_not_found.dart';
import 'package:eqmonitor/feature/home/data/notifier/home_configuration_notifier.dart';
import 'package:eqmonitor/feature/home/data/provider/home_earthquake_history_parameter_provider.dart';
import 'package:eqmonitor/feature/home/ui/component/sheet/component/home_earthquake_list.dart';
import 'package:eqmonitor/feature/home/ui/component/sheet/component/home_scope_selector.dart';
import 'package:eqmonitor/feature/home/ui/component/sheet/component/home_scope_unavailable_body.dart';
import 'package:eqmonitor/feature/home/ui/component/sheet/component/home_sheet_card.dart';
import 'package:eqmonitor/feature/home/ui/page/home_designated_region_picker_page.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeEarthquakeHistorySheet extends HookConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeAsync = ref.watch(homeConfigurationProvider);
    final paramAsync = ref.watch(homeEarthquakeHistoryParameterProvider);

    return homeAsync.when(
      data: (home) {
        final scope = home.common.earthquakeHistoryScope;
        final selection = paramAsync.value?.regionSelection;
        final locationName = selection != null
            ? ref.watch(regionNameProvider(selection.$1, selection.$2)).value ??
                  selection.$2
            : null;

        Future<void> openRegionPicker() async {
          final result = await HomeDesignatedRegionPickerPage.show(
            context,
            initialParameter: home.common.parameter,
          );
          if (result == null) {
            return;
          }
          await HomeConfigurationNotifier.saveMutation.run(ref, (tsx) async {
            final notifier = tsx.get(homeConfigurationProvider.notifier);
            if (result is EarthquakeHistoryParameterAll) {
              await notifier.clearCustomEarthquakeHistoryParameter();
            } else {
              await notifier.setCustomEarthquakeHistoryParameter(result);
            }
          });
        }

        return HomeSheetCard(
          children: [
            HomeSheetCardHeader(
              title: '最近の地震',
              action: HomeScopeSelector(
                scope: scope,
                onScopeChanged: (newScope) async {
                  await HapticFeedback.lightImpact();
                  if (newScope == .custom && home.common.parameter == null) {
                    await openRegionPicker();
                  } else {
                    await HomeConfigurationNotifier.saveMutation.run(
                      ref,
                      (tsx) async => tsx
                          .get(homeConfigurationProvider.notifier)
                          .setEarthquakeHistoryScope(newScope),
                    );
                  }
                },
                onEditRegion: openRegionPicker,
                locationName: locationName,
              ),
            ),
            paramAsync.when(
              data: (param) {
                if (param == null) {
                  return HomeScopeUnavailableBody(
                    scope: scope,
                    onRetry: () => ref.invalidate(
                      homeEarthquakeHistoryParameterProvider,
                      asReload: true,
                    ),
                    onConfigureRegion: scope == .custom
                        ? openRegionPicker
                        : null,
                  );
                }
                final state = ref.watch(earthquakeHistoryProvider(param));
                final listSection = switch (state) {
                  AsyncData(:final value) =>
                    value.items.isEmpty
                        ? const EarthquakeHistoryNotFound()
                        : HomeEarthquakeList(
                            earthquakes: value.items,
                            showCurrentLocationIntensity:
                                scope == .currentLocation,
                          ),
                  AsyncError(:final error) => ErrorCard(
                    error: error,
                    onReload: () async {
                      ref.invalidate(
                        homeEarthquakeHistoryParameterProvider,
                        asReload: true,
                      );
                      ref.invalidate(
                        earthquakeHistoryProvider(param),
                        asReload: true,
                      );
                    },
                  ),
                  _ => const _HomeEarthquakeHistorySheetSkeleton(),
                };
                return listSection;
              },
              loading: () => const _HomeEarthquakeHistorySheetSkeleton(),
              error: (error, _) => ErrorCard(
                error: error,
                onReload: () async => ref.invalidate(
                  homeEarthquakeHistoryParameterProvider,
                  asReload: true,
                ),
              ),
            ),
            Align(
              alignment: .centerEnd,
              child: TextButton(
                onPressed: paramAsync.value == null
                    ? null
                    : () async =>
                          EarthquakeHistoryRoute($extra: paramAsync.value)
                              .push<void>(context),
                child: Text('さらに表示'),
              ),
            ),
          ],
        );
      },
      loading: () => const HomeSheetCard(
        children: [
          HomeSheetCardHeader(title: '最近の地震'),
          _HomeEarthquakeHistorySheetSkeleton(),
        ],
      ),
      error: (error, _) => HomeSheetCard(
        children: [
          const HomeSheetCardHeader(title: '最近の地震'),
          ErrorCard(
            error: error,
            onReload: () async =>
                ref.invalidate(homeConfigurationProvider, asReload: true),
          ),
        ],
      ),
    );
  }
}

class _HomeEarthquakeHistorySheetSkeleton extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    final spacing = context.designSystem.spacing;

    return Padding(
      padding: EdgeInsets.fromLTRB(spacing.lg, 0, spacing.lg, spacing.sm),
      child: Skeletonizer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (var index = 0; index < 3; index++) ...[
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
