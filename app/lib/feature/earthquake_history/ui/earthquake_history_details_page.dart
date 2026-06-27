import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/core/component/sheet/basic_modal_sheet.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/ads/ui/component/ad_banner.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_display_mode.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_details_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/current_location_intensity_card.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_details_map_view.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_hypocenter_information_card.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_intensity_card.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/similar_earthquake_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EarthquakeHistoryDetailsPage extends HookConsumerWidget {
  const EarthquakeHistoryDetailsPage({required this.eventId, super.key});

  final String eventId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailsState = ref.watch(
      earthquakeHistoryDetailsProvider(eventId),
    );

    return switch (detailsState) {
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
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
      AsyncError(:final error) => Scaffold(
        appBar: AppBar(),
        body: ErrorCard(
          error: error,
          onReload: () async => ref.refresh(
            earthquakeHistoryDetailsProvider(eventId),
          ),
        ),
      ),
      AsyncData(value: final earthquake) => _LoadedContent(
        earthquake: earthquake,
      ),
    };
  }
}

class _LoadedContent extends HookWidget {
  const _LoadedContent({required this.earthquake});

  final Earthquake earthquake;

  @override
  Widget build(BuildContext context) {
    final hasEstimated = earthquake.estimatedIntensityTileUrl != null;
    final hasLpgm = earthquake.intensity?.maxLpgmIntensity != null;

    final displayMode = useState(
      hasEstimated
          ? IntensityDisplayMode.estimated
          : IntensityDisplayMode.jma,
    );

    final availableModes = [
      IntensityDisplayMode.jma,
      if (hasLpgm) IntensityDisplayMode.lpgm,
      if (hasEstimated) IntensityDisplayMode.estimated,
    ];

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: Stack(
        children: [
          EarthquakeHistoryDetailsMapView(
            earthquake: earthquake,
            displayMode: displayMode.value,
          ),
          SafeArea(
            bottom: false,
            child: BasicModalSheet(
              hasAppBar: false,
              child: SingleChildScrollView(
                child: SafeArea(
                  child: Column(
                    children: [
                      EarthquakeHypocenterInformationCard(item: earthquake),
                      CurrentLocationIntensityCard(item: earthquake),
                      EarthquakeIntensityCard(
                        item: earthquake,
                        displayMode: displayMode.value,
                        onDisplayModeChanged: (mode) =>
                            displayMode.value = mode,
                        availableModes: availableModes,
                      ),
                      if (earthquake.originTime != null &&
                          DateTime.now().difference(earthquake.originTime!) >
                              const Duration(hours: 24))
                        const AdBanner(),
                      SimilarEarthquakeCard(eventId: earthquake.eventId),
                      _TelegramListButton(eventId: earthquake.eventId),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (Navigator.canPop(context))
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: IconButton.filledTonal(
                  style: ButtonStyle(
                    shape: WidgetStatePropertyAll(
                      RoundedSuperellipseBorder(
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
                  padding: const EdgeInsets.all(12),
                ),
              ),
            ),
        ],
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
