import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqapi_types/model/v1/earthquake_early.dart';
import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:eqmonitor/core/component/intenisty/intensity_icon_type.dart';
import 'package:eqmonitor/core/component/intenisty/jma_forecast_intensity_icon.dart';
import 'package:eqmonitor/core/component/sheet/basic_modal_sheet.dart';
import 'package:eqmonitor/core/component/sheet/sheet_floating_action_buttons.dart';
import 'package:eqmonitor/feature/earthquake_history_early/data/earthquake_history_early_details_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history_early/ui/components/earthquake_early_hypo_info_widget.dart';
import 'package:eqmonitor/feature/earthquake_history_early/ui/components/earthquake_early_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheet/sheet.dart';

class EarthquakeHistoryEarlyDetailsRoute extends GoRouteData {
  const EarthquakeHistoryEarlyDetailsRoute({
    required this.id,
  });

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return EarthquakeHistoryEarlyDetailsScreen(
      id: id,
    );
  }
}

class EarthquakeHistoryEarlyDetailsScreen extends HookConsumerWidget {
  const EarthquakeHistoryEarlyDetailsScreen({
    required this.id,
    super.key,
  });

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sheetController = SheetController();
    final navigateToHomeFunction = useState<VoidCallback?>(null);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final state = ref.watch(earthquakeHistoryEarlyEventProvider(id));
    return switch (state) {
      AsyncError(:final error) => Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Text('Error: $error'),
          ),
        ),
      AsyncLoading() => Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator.adaptive(),
                const SizedBox(height: 8),
                Text(
                  '各地の震度データを取得中...',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
        ),
      AsyncData(:final value) => Scaffold(
          body: Stack(
            children: [
              EarthquakeEarlyMapWidget(
                item: value,
                showIntensityIcon: true,
                registerNavigateToHome: (func) {
                  navigateToHomeFunction.value = func;
                },
              ),

              IgnorePointer(
                child: SafeArea(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 250),
                        child: BorderedContainer(
                          margin: const EdgeInsets.all(4),
                          padding: const EdgeInsets.all(4),
                          borderRadius: BorderRadius.circular((25 / 5) + 5),
                          child: Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              for (final intensity in [
                                ...JmaForecastIntensity.values,
                              ].where(
                                (e) => e <= value.maxIntensity!,
                              ))
                                JmaForecastIntensityIcon(
                                  type: IntensityIconType.filled,
                                  intensity: intensity,
                                  size: 25,
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SheetFloatingActionButtons(
                hasAppBar: false,
                controller: sheetController,
                fab: [
                  Column(
                    children: [
                      FloatingActionButton.small(
                        heroTag: 'earthquake_history_details_fab',
                        tooltip: '表示領域を地図に合わせる',
                        onPressed: () {
                          if (navigateToHomeFunction.value != null) {
                            navigateToHomeFunction.value!.call();
                          }
                        },
                        elevation: 4,
                        child: const Icon(Icons.home),
                      ),
                    ],
                  ),
                ],
              ),
              // Sheet
              _Sheet(
                sheetController: sheetController,
                item: value,
              ),
              if (Navigator.canPop(context))
                // 戻るボタン
                SafeArea(
                  child: IconButton.filledTonal(
                    style: ButtonStyle(
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          side: BorderSide(
                            color: colorScheme.primary.withOpacity(0.2),
                          ),
                          borderRadius: BorderRadius.circular(128),
                        ),
                      ),
                    ),
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => context.pop(),
                    color: colorScheme.primary,
                  ),
                ),
            ],
          ),
        ),
    };
  }
}

class _Sheet extends StatelessWidget {
  const _Sheet({
    required this.sheetController,
    required this.item,
  });

  final SheetController sheetController;
  final EarthquakeEarlyEvent item;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: BasicModalSheet(
        hasAppBar: false,
        controller: sheetController,
        children: [
          EarthquakeEarlyHypoInfoWidget(item: item),
        ],
      ),
    );
  }
}
