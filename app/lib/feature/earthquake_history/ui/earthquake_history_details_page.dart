import 'package:eqmonitor/core/component/cached_data_banner.dart';
import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/core/component/sheet/basic_modal_sheet.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/ads/ui/component/ad_banner.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_comment.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_display_mode.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_details_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/estimated_intensity_notice_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/collapsible_segmented_control.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/current_location_intensity_card.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_details_map_view.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_hypocenter_information_card.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_intensity_card.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/linkified_text.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/modal/estimated_intensity_notice_dialog.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/shindo_db_event_notes.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/shindo_db_hypocenter_information_card.dart';
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

    final catalog = earthquake.catalog;
    final hasCatalog = catalog != null;
    final hasXml = earthquake.dataSources.contains(
      EarthquakeDataSource.jmaDisasterInformationXml,
    );
    final isDbOnly = hasCatalog && !hasXml;
    final showSourceToggle = hasCatalog && hasXml;

    final source = useState(
      isDbOnly
          ? EarthquakeDataSource.jmaIntensityDatabase
          : EarthquakeDataSource.jmaDisasterInformationXml,
    );
    final effectiveSource = source.value == .jmaIntensityDatabase && hasCatalog
        ? EarthquakeDataSource.jmaIntensityDatabase
        : EarthquakeDataSource.jmaDisasterInformationXml;
    final showingDb = effectiveSource == .jmaIntensityDatabase;

    final displayMode = useState(
      hasEstimated ? IntensityDisplayMode.estimated : IntensityDisplayMode.jma,
    );

    final noticeShownAsync = ref.watch(estimatedIntensityNoticeShownProvider);
    final noticeShown = switch (noticeShownAsync) {
      AsyncData(:final value) => value,
      _ => null,
    };

    useEffect(() {
      if (hasEstimated && noticeShown == false && !showingDb) {
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
    }, [hasEstimated, noticeShown, showingDb]);

    final availableModes = <IntensityDisplayMode>[
      .jma,
      if (hasLpgm) .lpgm,
      if (hasEstimated) .estimated,
    ];

    final designSystem = context.designSystem;
    final telegramCommentLines = selectTelegramCommentLines(
      earthquake.telegramComments,
    );

    return Scaffold(
      body: Stack(
        children: [
          EarthquakeHistoryDetailsMapView(
            earthquake: earthquake,
            displayMode: displayMode.value,
            showingDb: showingDb,
          ),
          SafeArea(
            bottom: false,
            child: BasicModalSheet(
              hasAppBar: false,
              child: SingleChildScrollView(
                child: SafeArea(
                  child: Column(
                    children: [
                      if (showSourceToggle)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          child:
                              CollapsibleSegmentedControl<EarthquakeDataSource>(
                                segments: const [
                                  SegmentItem(
                                    value: .jmaDisasterInformationXml,
                                    label: '防災情報XML',
                                  ),
                                  SegmentItem(
                                    value: .jmaIntensityDatabase,
                                    label: '震度データベース',
                                  ),
                                ],
                                selected: effectiveSource,
                                onSelected: (v) => source.value = v,
                              ),
                        ),
                      CachedDataBanner(
                        values: [
                          ref.watch(
                            earthquakeHistoryDetailsProvider(
                              earthquake.eventId,
                            ),
                          ),
                        ],
                      ),
                      if (showingDb && catalog != null) ...[
                        ShindoDbHypocenterInformationCard(
                          catalog: catalog,
                          originTime: earthquake.originTime,
                        ),
                        ShindoDbEventNotes(catalog: catalog),
                      ] else
                        EarthquakeHypocenterInformationCard(item: earthquake),
                      CurrentLocationIntensityCard(item: earthquake),
                      _DataSourceAndCommentLabel(
                        commentLines: telegramCommentLines,
                        dataSources: earthquake.dataSources,
                      ),
                      EarthquakeIntensityCard(
                        item: earthquake,
                        displayMode: displayMode.value,
                        onDisplayModeChanged: (mode) =>
                            displayMode.value = mode,
                        availableModes: availableModes,
                        source: effectiveSource,
                        showDatabaseBadge: isDbOnly,
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
                padding: const .symmetric(horizontal: 8),
                child: IconButton.filledTonal(
                  style: ButtonStyle(
                    shape: WidgetStatePropertyAll(
                      RoundedSuperellipseBorder(
                        side: BorderSide(
                          color: designSystem.colorTheme.primary.withValues(
                            alpha: 0.2,
                          ),
                        ),
                        borderRadius: .circular(128),
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
        ],
      ),
    );
  }
}

class _DataSourceAndCommentLabel extends StatelessWidget {
  const _DataSourceAndCommentLabel({
    required this.commentLines,
    required this.dataSources,
  });

  final List<String> commentLines;
  final List<EarthquakeDataSource> dataSources;

  @override
  Widget build(BuildContext context) {
    final bodySmall = Theme.of(context).textTheme.bodySmall;
    final dataSourceLabel =
        'データソース: ${dataSources.map((e) => switch (e) {
          .jmaDisasterInformationXml => '気象庁防災情報XML',
          .jmaIntensityDatabase => '気象庁震度データベース',
        }).join(', ')}';

    return Padding(
      padding: const .symmetric(horizontal: 16, vertical: 4),
      child: LinkifiedText(
        text: '${commentLines.join('\n')}\n$dataSourceLabel',
        style: bodySmall!.copyWith(
          fontFamily: FontFamily.googleSansCode,
          fontFamilyFallback: [FontFamily.notoSansJP],
        ),
      ),
      // child: Align(
      // alignment: .centerRight,
      // child: Column(
      //   mainAxisSize: .min,
      //   crossAxisAlignment: .end,
      //   children: [
      //     for (final line in commentLines)
      //       LinkifiedText(text: line, style: bodySmall),
      //     Text(dataSourceLabel, style: bodySmall, textAlign: .end),
      //   ],
      // ),
      // ),
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
          minimumSize: const Size(.infinity, 48),
          backgroundColor: designSystem.colorTheme.secondaryContainer,
          foregroundColor: designSystem.colorTheme.onSecondaryContainer,
        ),
      ),
    );
  }
}
