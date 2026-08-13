import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter_x.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/provider/region_name_resolver.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_not_found.dart';
import 'package:eqmonitor/feature/home/data/model/home_configuration_model.dart';
import 'package:eqmonitor/feature/home/data/notifier/home_configuration_notifier.dart';
import 'package:eqmonitor/feature/home/data/provider/home_earthquake_history_parameter_provider.dart';
import 'package:eqmonitor/feature/home/ui/component/sheet/component/home_earthquake_list.dart';
import 'package:eqmonitor/feature/home/ui/component/sheet/component/home_scope_selector.dart';
import 'package:eqmonitor/feature/home/ui/component/sheet/component/home_scope_unavailable_body.dart';
import 'package:eqmonitor/feature/home/ui/page/home_designated_region_picker_page.dart';
import 'package:material_ui/material_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeEarthquakeHistorySheet extends HookConsumerWidget {
  const HomeEarthquakeHistorySheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final designSystem = context.designSystem;
    final colorTheme = designSystem.colorTheme;
    final spacing = designSystem.spacing;
    final shape = designSystem.shape;
    final homeAsync = ref.watch(homeConfigurationProvider);
    final paramAsync = ref.watch(homeEarthquakeHistoryParameterProvider);

    return homeAsync.when(
      data: (home) {
        final scope = home.common.earthquakeHistoryScope;
        // 地域コードから名称を解決する。解決できない場合はコードをそのまま表示。
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
              // クリアされた場合は parameter のみ消し、スコープは保持する
              await notifier.clearCustomEarthquakeHistoryParameter();
            } else {
              await notifier.setCustomEarthquakeHistoryParameter(result);
            }
          });
        }

        return Card.outlined(
          margin: EdgeInsets.zero,
          color: colorTheme.surfaceContainerHigh,
          clipBehavior: Clip.antiAlias,
          elevation: 0,
          shape: RoundedSuperellipseBorder(
            borderRadius: BorderRadius.circular(shape.card),
            side: BorderSide(color: colorTheme.outlineVariant),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              HomeScopeSelector(
                scope: scope,
                onScopeChanged: (newScope) async {
                  if (newScope == HomeEarthquakeHistoryScope.custom &&
                      home.common.parameter == null) {
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
                locationName: locationName,
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
                      onConfigureRegion:
                          scope == HomeEarthquakeHistoryScope.custom
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
                    // スコープに対応する検索パラメータが解決できないときは
                    // 「全国」が開いてしまい一覧の表示条件と一致しないため、
                    // 一覧ボタン自体を無効化する（未設定/未解決の案内は
                    // 上の HomeScopeUnavailableBody が担当する）。
                    onPressed: paramAsync.value == null
                        ? null
                        : () async => EarthquakeHistoryRoute(
                            $extra: paramAsync.value,
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
        color: colorTheme.surfaceContainerHigh,
        elevation: 0,
        shape: RoundedSuperellipseBorder(
          borderRadius: BorderRadius.circular(shape.card),
          side: BorderSide(color: colorTheme.outlineVariant),
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
    final colorTheme = designSystem.colorTheme;

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
                color: colorTheme.surfaceContainerLow,
                borderRadius: BorderRadius.circular(shape.sm),
              ),
            ),
            SizedBox(height: spacing.sm),
            Container(
              height: 44,
              decoration: BoxDecoration(
                color: colorTheme.surfaceContainerLow,
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
