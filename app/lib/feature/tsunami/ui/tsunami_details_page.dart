import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/core/component/sheet/basic_modal_sheet.dart';
import 'package:eqmonitor/feature/tsunami/data/notifier/tsunami_details_notifier.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TsunamiDetailsPage extends HookConsumerWidget {
  const TsunamiDetailsPage({required this.tsunamiId, super.key});

  final String tsunamiId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(tsunamiDetailsProvider(tsunamiId));
    final colorScheme = Theme.of(context).colorScheme;

    return switch (state) {
      AsyncLoading() => Scaffold(
        appBar: AppBar(),
        body: const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      ),
      AsyncError(:final error) => Scaffold(
        appBar: AppBar(),
        body: ErrorCard(
          error: error,
          onReload: () async => ref.refresh(
            tsunamiDetailsProvider(tsunamiId),
          ),
        ),
      ),
      AsyncData(value: final tsunami) => Scaffold(
        body: Stack(
          children: [
            // TODO: TsunamiDetailsMapView
            const ColoredBox(
              color: Colors.grey,
              child: SizedBox.expand(),
            ),
            SafeArea(
              bottom: false,
              child: BasicModalSheet(
                hasAppBar: false,
                child: SingleChildScrollView(
                  child: SafeArea(
                    child: Column(
                      children: [
                        // TODO: TsunamiWarningStatusCard
                        // TODO: CurrentLocationTsunamiCard
                        // TODO: TsunamiRegionList
                        // TODO: AdBanner
                        // TODO: TsunamiEarthquakeCard
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            'Tsunami: ${tsunami.id}\n'
                            'Active: ${tsunami.isActive}\n'
                            'Regions: ${tsunami.forecastRegions.length}',
                          ),
                        ),
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
      ),
    };
  }
}
