import 'dart:async';

import 'package:eqmonitor/core/component/error/error_card.dart';
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
import 'package:eqmonitor/feature/home/ui/action/home_region_selection_action.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';

class HomeEarthquakeHistorySheet extends HookConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeAsync = ref.watch(homeConfigurationProvider);
    final paramAsync = ref.watch(homeEarthquakeHistoryParameterProvider);

    return homeAsync.when(
      skipLoadingOnReload: true,
      data: (home) {
        final scope = home.common.earthquakeHistoryScope;
        final parameter = paramAsync.value;
        // 地域の再判定中も履歴を監視し、autoDispose による再取得を防ぐ。
        final historyAsync = parameter == null
            ? null
            : ref.watch(earthquakeHistoryProvider(parameter));
        final selection = paramAsync.value?.regionSelection;
        final locationName = selection != null
            ? ref.watch(regionNameProvider(selection.$1, selection.$2)).value ??
                  selection.$2
            : null;

        Future<void> openRegionPicker() async {
          final result = await const HomeRegionSelectionAction().pick(
            context: context,
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
              titleTrailing:
                  homeAsync.isLoading ||
                      paramAsync.isLoading ||
                      (historyAsync?.isLoading ?? false)
                  ? const _HistoryLoadingIndicator()
                  : null,
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
              skipLoadingOnReload: true,
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
                return historyAsync?.when(
                      skipLoadingOnReload: true,
                      skipError: true,
                      data: (value) => value.items.isEmpty
                          ? const EarthquakeHistoryNotFound()
                          : HomeEarthquakeList(
                              earthquakes: value.items,
                              showCurrentLocationIntensity:
                                  scope == .currentLocation,
                            ),
                      error: (error, _) => ErrorCard(
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
                      loading: () => const SizedBox.shrink(),
                    ) ??
                    const SizedBox.shrink();
              },
              loading: () => const SizedBox.shrink(),
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
              child: M3ETextButton(
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
          HomeSheetCardHeader(
            title: '最近の地震',
            titleTrailing: _HistoryLoadingIndicator(),
          ),
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

class _HistoryLoadingIndicator extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '最近の地震を読み込み中',
      child: const SizedBox.square(
        dimension: 20,
        child: M3ECircularProgressIndicator(strokeWidth: 2),
      ),
    );
  }
}
