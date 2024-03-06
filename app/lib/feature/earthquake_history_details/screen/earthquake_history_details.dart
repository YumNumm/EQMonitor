// ignore_for_file: deprecated_member_use

import 'package:collection/collection.dart';
import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:eqmonitor/core/component/intenisty/intensity_icon_type.dart';
import 'package:eqmonitor/core/component/intenisty/jma_intensity_icon.dart';
import 'package:eqmonitor/core/component/intenisty/jma_lg_intensity_icon.dart';
import 'package:eqmonitor/core/component/sheet/basic_modal_sheet.dart';
import 'package:eqmonitor/core/component/sheet/sheet_floating_action_buttons.dart';
import 'package:eqmonitor/core/provider/config/earthquake_history/earthquake_history_config_provider.dart';
import 'package:eqmonitor/feature/earthquake_history/data/earthquake_history_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_v1_extended.dart';
import 'package:eqmonitor/feature/earthquake_history_details/component/earthquake_hypo_info_widget.dart';
import 'package:eqmonitor/feature/earthquake_history_details/component/earthquake_map.dart';
import 'package:eqmonitor/feature/earthquake_history_details/component/prefecture_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history_details/component/prefecture_lpgm_intensity.dart';
import 'package:eqmonitor/feature/settings/children/config/earthquake_history/earthquake_history_config_page.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheet/sheet.dart';
import 'package:url_launcher/url_launcher.dart';

class EarthquakeHistoryDetailsPage extends HookConsumerWidget {
  const EarthquakeHistoryDetailsPage({
    required EarthquakeV1Extended data,
    super.key,
  }) : _data = data;

  final EarthquakeV1Extended _data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = useState(_data);
    // earthquakeDataが変わったら再構築
    ref.listen(
      earthquakeHistoryNotifierProvider(const EarthquakeHistoryParameter()),
      (previous, next) {
        final previousItem = previous?.valueOrNull?.$1
            .firstWhereOrNull((element) => element.eventId == _data.eventId);
        final nextItem = next.valueOrNull?.$1
            .firstWhereOrNull((element) => element.eventId == _data.eventId);
        if (nextItem == null) {
          return;
        }
        if (previousItem != nextItem) {
          data.value = nextItem;
        }
      },
    );

    final maxIntensity = data.value.maxIntensity;
    final maxLgIntensity = data.value.maxLpgmIntensity;

    final config = ref
        .watch(earthquakeHistoryConfigProvider.select((value) => value.detail));

    final sheetController = SheetController();
    final navigateToHomeFunction = useState<VoidCallback?>(null);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: Stack(
        children: [
          EarthquakeMapWidget(
            item: data.value,
            showIntensityIcon: true,
            registerNavigateToHome: (func) =>
                navigateToHomeFunction.value = func,
          ),
          SheetFloatingActionButtons(
            hasAppBar: false,
            controller: sheetController,
            fab: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (maxIntensity != null)
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: IgnorePointer(
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 250),
                            child: BorderedContainer(
                              key: ValueKey(
                                (config, maxIntensity, maxLgIntensity),
                              ),
                              margin: const EdgeInsets.all(4),
                              padding: const EdgeInsets.all(4),
                              borderRadius: BorderRadius.circular((25 / 5) + 5),
                              child: Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: [
                                  if (config.showingLpgmIntensity &&
                                      maxLgIntensity != null)
                                    for (final intensity in [
                                      ...JmaLgIntensity.values,
                                    ].where(
                                      (e) =>
                                          e != JmaLgIntensity.zero &&
                                          e <= maxLgIntensity,
                                    ))
                                      JmaLgIntensityIcon(
                                        type: IntensityIconType.filled,
                                        intensity: intensity,
                                        size: 25,
                                      )
                                  else
                                    for (final intensity in [
                                      ...JmaIntensity.values,
                                    ].where(
                                      (e) => e <= maxIntensity,
                                    ))
                                      JmaIntensityIcon(
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
                    )
                  else
                    const Spacer(),
                  Column(
                    children: [
                      // layer controller
                      if (data.value.maxIntensity != null)
                        FloatingActionButton.small(
                          heroTag: 'earthquake_history_details_layer_fab',
                          tooltip: '地図の表示レイヤーを切り替える',
                          onPressed: () =>
                              showEarthquakeHistoryDetailConfigDialog(
                            context,
                            showCitySelector:
                                data.value.intensityCities != null,
                            hasLpgmIntensity:
                                data.value.maxLpgmIntensity != null,
                          ),
                          elevation: 4,
                          child: const Icon(Icons.layers),
                        ),
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
            ],
          ),
          // Sheet
          _Sheet(
            sheetController: sheetController,
            item: data.value,
          ),
          if (Navigator.canPop(context))
            // 戻るボタン
            Positioned(
              top: 0,
              left: 0,
              child: SafeArea(
                child: IconButton.filledTonal(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => context.pop(),
                  color: colorScheme.primary,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _Sheet extends StatelessWidget {
  const _Sheet({
    required this.sheetController,
    required this.item,
  });

  final SheetController sheetController;
  final EarthquakeV1Extended item;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: BasicModalSheet(
        hasAppBar: false,
        useColumn: true,
        controller: sheetController,
        children: [
          EarthquakeHypoInfoWidget(item: item),
          const Divider(),
          PrefectureIntensityWidget(item: item.v1),
          if (item.lpgmIntensityPrefectures != null)
            PrefectureLpgmIntensityWidget(
              item: item,
            ),
          _EarthquakeCommentWidget(item: item),
        ],
      ),
    );
  }
}

class _EarthquakeCommentWidget extends StatelessWidget {
  const _EarthquakeCommentWidget({required this.item});

  final EarthquakeV1Extended item;

  @override
  Widget build(BuildContext context) {
    final comment = item.text;
    if (comment != null) {
      return BorderedContainer(
        padding: const EdgeInsets.all(8),
        elevation: 1,
        child: Markdown(
          data: comment.toHalfWidth,
          selectable: true,
          softLineBreak: true,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          onTapLink: (text, href, title) async {
            final uri = Uri.tryParse(href.toString());
            if (uri == null) {
              return;
            }
            await launchUrl(
              uri,
            );
          },
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
