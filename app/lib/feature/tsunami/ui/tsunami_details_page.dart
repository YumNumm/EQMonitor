import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/core/component/sheet/basic_modal_sheet.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/feature/ads/ui/component/ad_banner.dart';
import 'package:eqmonitor/feature/tsunami/data/notifier/effective_tsunami_state_provider.dart';
import 'package:eqmonitor/feature/tsunami/data/notifier/tsunami_details_notifier.dart';
import 'package:eqmonitor/feature/tsunami/data/notifier/tsunami_telegrams_provider.dart';
import 'package:eqmonitor/feature/tsunami/ui/components/current_location_tsunami_card.dart';
import 'package:eqmonitor/feature/tsunami/ui/components/tsunami_details_map_view.dart';
import 'package:eqmonitor/feature/tsunami/ui/components/tsunami_earthquake_card.dart';
import 'package:eqmonitor/feature/tsunami/ui/components/tsunami_region_list.dart';
import 'package:eqmonitor/feature/tsunami/ui/components/tsunami_timeline_overlay.dart';
import 'package:eqmonitor/feature/tsunami/ui/components/tsunami_warning_status_card.dart';
import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TsunamiDetailsPage extends HookConsumerWidget {
  const new({required this.tsunamiId, super.key});

  final String tsunamiId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(tsunamiDetailsProvider(tsunamiId));

    // Prefetch telegrams for overlay
    ref.watch(tsunamiTelegramsProvider(tsunamiId));

    return switch (state) {
      AsyncLoading() => Scaffold(
        appBar: AppBar(),
        body: const Center(child: CircularProgressIndicator.adaptive()),
      ),
      AsyncError(:final error) => Scaffold(
        appBar: AppBar(),
        body: ErrorCard(
          error: error,
          onReload: () async => ref.refresh(tsunamiDetailsProvider(tsunamiId)),
        ),
      ),
      AsyncData() => _buildContent(context, ref),
    };
  }

  Widget _buildContent(BuildContext context, WidgetRef ref) {
    final colorTheme = context.designSystem.colorTheme;
    final effectiveState = ref.watch(effectiveTsunamiStateProvider(tsunamiId));
    final tsunami =
        effectiveState ??
        ref.watch(tsunamiDetailsProvider(tsunamiId)).requireValue;

    return Scaffold(
      body: Stack(
        children: [
          TsunamiDetailsMapView(tsunami: tsunami),
          SafeArea(
            bottom: false,
            child: BasicModalSheet(
              hasAppBar: false,
              child: SingleChildScrollView(
                child: SafeArea(
                  child: Column(
                    children: [
                      TsunamiWarningStatusCard(tsunami: tsunami),
                      CurrentLocationTsunamiCard(tsunami: tsunami),
                      TsunamiRegionList(tsunami: tsunami),
                      if (tsunami.updatedAt.difference(DateTime.now()).abs() >
                          const Duration(hours: 24))
                        const AdBanner(),
                      for (final earthquake in tsunami.earthquakes)
                        TsunamiEarthquakeCard(
                          earthquake: earthquake,
                          eventIds: tsunami.eventIds,
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
                          color: colorTheme.primary.withValues(alpha: 0.2),
                        ),
                        borderRadius: BorderRadius.circular(128),
                      ),
                    ),
                  ),
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => context.pop(),
                  color: colorTheme.primary,
                  padding: const EdgeInsets.all(12),
                ),
              ),
            ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: TsunamiTimelineOverlay(tsunamiId: tsunamiId),
          ),
        ],
      ),
    );
  }
}
