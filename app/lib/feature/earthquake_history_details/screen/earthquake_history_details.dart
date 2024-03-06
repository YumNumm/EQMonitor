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
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/core/provider/jma_code_table_provider.dart';
import 'package:eqmonitor/core/util/event_id.dart';
import 'package:eqmonitor/feature/earthquake_history/data/earthquake_history_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_v1_extended.dart';
import 'package:eqmonitor/feature/earthquake_history_details/component/earthquake_map.dart';
import 'package:eqmonitor/feature/earthquake_history_details/component/prefecture_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history_details/component/prefecture_lpgm_intensity.dart';
import 'package:eqmonitor/feature/settings/children/config/earthquake_history/earthquake_history_config_page.dart';
import 'package:eqmonitor/gen/fonts.gen.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
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
                  IgnorePointer(
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
                            if (maxIntensity != null)
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
          _EarthquakeHypoInfoWidget(item: item),
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

class _EarthquakeHypoInfoWidget extends HookConsumerWidget {
  const _EarthquakeHypoInfoWidget({
    required this.item,
  });

  final EarthquakeV1Extended item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final intensityColorScheme = ref.watch(intensityColorProvider);

    final maxIntensity = item.maxIntensity;
    final colorScheme = switch (maxIntensity) {
      final JmaIntensity intensity =>
        intensityColorScheme.fromJmaIntensity(intensity),
      _ => null,
    };
    final codeTable = ref.watch(jmaCodeTableProvider);

    final hypoName = useMemoized(
      () => codeTable.areaEpicenter.items.firstWhereOrNull(
        (e) => int.tryParse(e.code) == item.epicenterCode,
      ),
      [item.epicenterCode],
    );
    final hypoDetailName = useMemoized(
      () => codeTable.areaEpicenterDetail.items.firstWhereOrNull(
        (e) => int.tryParse(e.code) == item.epicenterDetailCode,
      ),
      [item.epicenterDetailCode],
    );

    final maxIntensityWidget = maxIntensity != null
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('最大震度', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              JmaIntensityIcon(
                type: IntensityIconType.filled,
                size: 60,
                intensity: maxIntensity,
              ),
            ],
          )
        : null;
    // 「MaxInt, 震源地, 規模」
    final hypoWidget = Row(
      textBaseline: TextBaseline.ideographic,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      children: [
        Text(
          '震源地',
          style: textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
            color: textTheme.bodyMedium!.color!.withOpacity(0.8),
          ),
        ),
        const SizedBox(width: 4),
        Flexible(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: hypoName?.name ?? '不明',
                  style: textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                if (hypoDetailName != null) ...[
                  const TextSpan(text: ' '),
                  TextSpan(
                    text: '(${hypoDetailName.name})',
                    style: textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );

    final creationDateFromEventId = EventId(item.eventId).toCreationDate();

    // 地震発生時刻
    final timeTextStyle = textTheme.bodyMedium!.copyWith(
      fontFamily: FontFamily.jetBrainsMono,
      fontFamilyFallback: [FontFamily.notoSansJP],
    );
    final timeWidget = item.originTime != null
        ? Text(
            '${DateFormat('yyyy/MM/dd HH:mm頃').format(
              item.originTime!.toLocal(),
            )}'
            ' '
            '発生',
            style: timeTextStyle,
          )
        : item.arrivalTime != null
            ? Text(
                '${DateFormat('yyyy/MM/dd HH:mm頃').format(
                  item.arrivalTime!.toLocal(),
                )}'
                ' '
                '検知',
                style: timeTextStyle,
              )
            : creationDateFromEventId != null
                ? Text(
                    DateFormat('yyyy/MM/dd HH:mm頃').format(
                      creationDateFromEventId,
                    ),
                    style: timeTextStyle,
                  )
                : null;

    // 「M 8.0 / 深さ100km」
    final magnitudeWidget = Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          'M',
          style: textTheme.titleMedium!.copyWith(
            color: textTheme.titleMedium!.color!.withOpacity(0.8),
          ),
        ),
        Text(
          switch ((
            item.magnitudeCondition,
            item.magnitude,
          )) {
            (final String cond, _) => cond.toHalfWidth.replaceAll('M不明', '不明'),
            (_, final double value) => value.toString(),
            // vxse53がある場合
            _ when item.intensityCities != null => '不明',
            _ => '調査中',
          },
          style: textTheme.displaySmall!.copyWith(
            fontWeight: FontWeight.w900,
            fontFamily: FontFamily.notoSansJP,
            fontFamilyFallback: [FontFamily.notoSansJP],
          ),
        ),
      ],
    );
    final depthWidget = Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          '深さ',
          style: textTheme.titleMedium!.copyWith(
            color: textTheme.titleMedium!.color!.withOpacity(0.8),
          ),
        ),
        if (item.depth != null && item.depth != 0 && item.depth != 700) ...[
          Text(
            item.depth.toString(),
            style: textTheme.displaySmall!.copyWith(
              fontWeight: FontWeight.w900,
              fontFamily: FontFamily.notoSansJP,
              fontFamilyFallback: [FontFamily.notoSansJP],
            ),
          ),
          Text(
            'km',
            style: textTheme.titleMedium!.copyWith(
              color: textTheme.titleMedium!.color!.withOpacity(0.8),
            ),
          ),
        ] else
          Text(
            switch (item.depth) {
              0 => 'ごく浅い',
              700 => '700km以上',
              // vxse53がある場合
              _ when item.intensityCities != null => '不明',
              _ => '調査中',
            },
            style: textTheme.displaySmall!.copyWith(
              fontWeight: FontWeight.w900,
              fontFamily: FontFamily.jetBrainsMono,
              fontFamilyFallback: [FontFamily.notoSansJP],
            ),
          ),
      ],
    );
    // M・深さ ともに不明の場合
    final isMagnitudeAndDepthUnknown =
        (item.magnitudeCondition?.toHalfWidth == 'M不明' ||
                item.magnitude == null) &&
            item.depth == null;
    final magnitudeDepthUnknownWidget = Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          'M・深さ',
          style: textTheme.titleMedium!.copyWith(
            color: textTheme.titleMedium!.color!.withOpacity(0.8),
          ),
        ),
        Text(
          switch (item.depth) {
            _ when item.intensityCities != null => '不明',
            _ => '調査中',
          },
          style: textTheme.displaySmall!.copyWith(
            fontWeight: FontWeight.w900,
            fontFamily: FontFamily.jetBrainsMono,
            fontFamilyFallback: [FontFamily.notoSansJP],
          ),
        ),
      ],
    );

    // M・深さ・震源 ともに不明の場合
    final isEarthquakeNull =
        isMagnitudeAndDepthUnknown && item.epicenterCode == null;

    final earthquakeNullWidget = Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          'M・深さ・震源地',
          style: textTheme.titleMedium!.copyWith(
            color: textTheme.titleMedium!.color!.withOpacity(0.8),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          item.intensityCities != null ? '不明' : '調査中',
          style: textTheme.displaySmall!.copyWith(
            fontWeight: FontWeight.w900,
            fontFamily: FontFamily.jetBrainsMono,
            fontFamilyFallback: [FontFamily.notoSansJP],
          ),
        ),
      ],
    );
    final body = Wrap(
      spacing: 8,
      crossAxisAlignment: WrapCrossAlignment.end,
      alignment: WrapAlignment.center,
      children: [
        const Row(),
        if (isEarthquakeNull)
          earthquakeNullWidget
        else if (isMagnitudeAndDepthUnknown) ...[
          magnitudeDepthUnknownWidget,
          hypoWidget,
        ] else ...[
          magnitudeWidget,
          depthWidget,
          hypoWidget,
        ],
        if (timeWidget != null) timeWidget,
      ],
    );

    final card = Card(
      margin: const EdgeInsets.all(4),
      elevation: 0,
      shadowColor: Colors.transparent,
      // 角丸にして Border
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: colorScheme?.background ?? Colors.transparent,
          width: 0,
        ),
      ),
      color: (colorScheme?.background ?? Colors.transparent).withOpacity(0.3),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        ),
        child: Column(
          children: [
            const SizedBox(height: 2),
            Row(
              children: [
                if (maxIntensityWidget != null) maxIntensityWidget,
                const SizedBox(width: 4),
                Expanded(child: body),
              ],
            ),
          ],
        ),
      ),
    );
    return card;
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
