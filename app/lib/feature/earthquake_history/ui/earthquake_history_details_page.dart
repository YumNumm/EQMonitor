import 'package:eqmonitor/core/component/cached_data_banner.dart';
import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/core/component/sheet/basic_modal_sheet.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/ads/ui/component/ad_banner.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_display_mode.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_details_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/estimated_intensity_notice_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/current_location_intensity_card.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_details_map_view.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_hypocenter_information_card.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_intensity_card.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/modal/estimated_intensity_notice_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EarthquakeHistoryDetailsPage extends HookConsumerWidget {
  const EarthquakeHistoryDetailsPage({required this.eventId, super.key});

  final String eventId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailsState = ref.watch(earthquakeHistoryDetailsProvider(eventId));

    // SWR 再検証中は「値を保持した AsyncLoading」が流れるため、値ありを最優先で
    // マッチさせて stale 表示を維持する (Loading 優先だと全画面スピナーに戻る)。
    return switch (detailsState) {
      AsyncValue(:final value?) => _LoadedContent(earthquake: value),
      AsyncError(:final error) => Scaffold(
        appBar: AppBar(),
        body: ErrorCard(
          error: error,
          onReload: () async =>
              ref.refresh(earthquakeHistoryDetailsProvider(eventId)),
        ),
      ),
      _ => Scaffold(
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
    };
  }
}

class _LoadedContent extends HookConsumerWidget {
  const _LoadedContent({required this.earthquake});

  final Earthquake earthquake;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasEstimated = earthquake.estimatedIntensityTileUrl != null;
    final hasLpgm = earthquake.intensity?.maxLpgmIntensity != null;

    final displayMode = useState(
      hasEstimated ? IntensityDisplayMode.estimated : IntensityDisplayMode.jma,
    );

    final noticeShown = ref.watch(estimatedIntensityNoticeShownProvider);

    useEffect(() {
      if (hasEstimated && !noticeShown) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          if (!context.mounted) {
            return;
          }
          await EstimatedIntensityNoticeDialog.show(context);
          await ref
              .read(estimatedIntensityNoticeShownProvider.notifier)
              .markShown();
        });
      }
      return null;
    }, [hasEstimated, noticeShown]);

    final availableModes = [
      IntensityDisplayMode.jma,
      if (hasLpgm) IntensityDisplayMode.lpgm,
      if (hasEstimated) IntensityDisplayMode.estimated,
    ];

    final designSystem = context.designSystem;

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
                      CachedDataBanner(
                        values: [
                          ref.watch(
                            earthquakeHistoryDetailsProvider(
                              earthquake.eventId,
                            ),
                          ),
                        ],
                      ),
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
                          color: designSystem.colorTheme.primary.withValues(
                            alpha: 0.2,
                          ),
                        ),
                        borderRadius: BorderRadius.circular(128),
                      ),
                    ),
                  ),
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => context.pop(),
                  color: designSystem.colorTheme.primary,
                  padding: const EdgeInsets.all(12),
                ),
              ),
            ),
          // データソースラベル
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Align(
                alignment: .bottomRight,
                child: Text(
                  'データソース: ${earthquake.dataSources.map((e) => switch (e) {
                    .jmaDisasterInformationXml => "気象庁災害情報XML",
                    .jmaIntensityDatabase => "気象庁震度データベース",
                  }).join(', ')}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
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
    final designSystem = context.designSystem;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: FilledButton.tonalIcon(
        onPressed: () =>
            TelegramListByEventIdRoute(eventId: eventId).push<void>(context),
        icon: const Icon(Icons.list_alt),
        label: const Text('電文一覧を見る'),
        style: FilledButton.styleFrom(
          minimumSize: const Size(double.infinity, 48),
          backgroundColor: designSystem.colorTheme.secondaryContainer,
          foregroundColor: designSystem.colorTheme.onSecondaryContainer,
        ),
      ),
    );
  }
}
