import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/core/component/intenisty/intensity_icon_type.dart';
import 'package:eqmonitor/core/component/intenisty/intensity_value_icon.dart';
import 'package:eqmonitor/core/component/intenisty/lpgm_intensity_icon.dart';
import 'package:eqmonitor/core/component/sheet/basic_modal_sheet.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_config_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_details_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_details_map_view.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_hypocenter_information_card.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/prefecture_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/prefecture_lpgm_intensity.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheet/sheet.dart';

class EarthquakeHistoryDetailsPage extends HookConsumerWidget {
  const EarthquakeHistoryDetailsPage({required this.eventId, super.key});

  final String eventId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailsState = ref.watch(
      earthquakeHistoryDetailsProvider(eventId),
    );
    final details = detailsState.value;

    if (details == null) {
      return Scaffold(
        appBar: AppBar(),
        body: switch (detailsState) {
          AsyncError(:final error) when !detailsState.isLoading => ErrorCard(
            error: error,
            onReload: () async => ref.refresh(
              earthquakeHistoryDetailsProvider(eventId),
            ),
          ),
          AsyncLoading() || _ when detailsState.isLoading => Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator.adaptive(),
                const SizedBox(height: 8),
                Text(
                  '各地の震度データを取得中...',
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          _ => const Center(child: CircularProgressIndicator.adaptive()),
        },
      );
    }
    final intensity = details.intensity;
    final maxIntensity = intensity?.maxIntensity;
    final maxLgIntensity = intensity?.maxLpgmIntensity;

    final sheetController = SheetController();
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: Stack(
        children: [
          EarthquakeHistoryDetailsMapView(earthquake: details),
          if (maxIntensity != null)
            _IntensityIcons(
              maxIntensity: maxIntensity,
              maxLgIntensity: maxLgIntensity,
            ),
          _Sheet(sheetController: sheetController, item: details),
          if (Navigator.canPop(context))
            SafeArea(
              child: IconButton.filledTonal(
                style: ButtonStyle(
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      side: BorderSide(
                        color: colorScheme.primary.withValues(alpha: 0.2),
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
    );
  }
}

class _IntensityIcons extends ConsumerWidget {
  const _IntensityIcons({
    required this.maxIntensity,
    required this.maxLgIntensity,
  });

  final IntensityValue maxIntensity;
  final LpgmIntensityValue? maxLgIntensity;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(
      earthquakeHistoryConfigProvider.select((value) => value.detail),
    );
    final showingLpgmIntensity = config.showingLpgmIntensity;

    return IgnorePointer(
      child: SafeArea(
        child: Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: BorderedContainer(
                key: ValueKey((config, maxIntensity, maxLgIntensity)),
                margin: const EdgeInsets.all(4),
                padding: const EdgeInsets.all(4),
                borderRadius: BorderRadius.circular((25 / 5) + 5),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    if (showingLpgmIntensity && maxLgIntensity != null)
                      for (final intensity
                          in [...LpgmIntensityValue.values].where(
                            (e) =>
                                e != LpgmIntensityValue.zero &&
                                e.index <= maxLgIntensity!.index,
                          ))
                        LpgmIntensityIcon(
                          type: IntensityIconType.filled,
                          intensity: intensity,
                          size: 25,
                        )
                    else
                      for (final intensity in [...IntensityValue.values].where(
                        (e) =>
                            e != IntensityValue.zero &&
                            e != IntensityValue.fiveLowerNoInput &&
                            e.index <= maxIntensity.index,
                      ))
                        IntensityValueIcon(
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
    );
  }
}

class _Sheet extends StatelessWidget {
  const _Sheet({required this.sheetController, required this.item});

  final SheetController sheetController;
  final Earthquake item;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: BasicModalSheet(
        hasAppBar: false,
        child: Expanded(
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: SafeArea(
              child: Column(
                children: [
                  EarthquakeHypocenterInformationCard(item: item),
                  PrefectureIntensityWidget(item: item),
                  if (item.intensity?.maxLpgmIntensity != null)
                    PrefectureLpgmIntensityWidget(item: item),
                  _TelegramListButton(eventId: item.eventId),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TelegramListButton extends StatelessWidget {
  const _TelegramListButton({required this.eventId});

  final String eventId;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: FilledButton.tonalIcon(
        onPressed: () =>
            TelegramListByEventIdRoute(eventId: eventId).push<void>(context),
        icon: const Icon(Icons.list_alt),
        label: const Text('電文一覧を見る'),
        style: FilledButton.styleFrom(
          minimumSize: const Size(double.infinity, 48),
          backgroundColor: colorScheme.secondaryContainer,
          foregroundColor: colorScheme.onSecondaryContainer,
        ),
      ),
    );
  }
}
