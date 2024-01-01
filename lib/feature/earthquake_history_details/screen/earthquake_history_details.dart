import 'package:collection/collection.dart';
import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:eqmonitor/core/component/intenisty/intensity_icon_type.dart';
import 'package:eqmonitor/core/component/intenisty/jma_intensity_icon.dart';
import 'package:eqmonitor/core/component/sheet/basic_modal_sheet.dart';
import 'package:eqmonitor/core/component/sheet/sheet_floating_action_buttons.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/core/provider/topology_map/provider/topology_maps.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/earthquake_history/model/state/earthquake_history_item.dart';
import 'package:eqmonitor/feature/earthquake_history/viewmodel/earthquake_history_view_model.dart';
import 'package:eqmonitor/feature/earthquake_history_details/component/earthquake_map.dart';
import 'package:eqmonitor/feature/earthquake_history_details/component/prefecture_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history_details/component/prefecture_lpgm_intensity.dart';
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
    required this.eventId,
    super.key,
  });

  final int eventId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 当該データがアレばOK
    final data = ref
        .watch(earthquakeHistoryViewModelProvider)
        ?.value
        ?.firstWhereOrNull((e) => e.eventId == eventId);
    if (data == null) {
      final state = ref.watch(earthquakeHistoryViewModelProvider);
      final isLoading = state?.isLoading ?? false;
      final isReloading = state?.isReloading ?? false;
      final disableLoading = isLoading || isReloading;
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('当該データが見つかりませんでした\n再度地震の履歴を読み込んでください'),
              const SizedBox(height: 8),
              FilledButton(
                onPressed: disableLoading
                    ? null
                    : () => ref
                        .read(earthquakeHistoryViewModelProvider.notifier)
                        .fetch(isLoadMore: true),
                child: const Text('追加で地震履歴を読み込む'),
              ),
              if (disableLoading) ...[
                const SizedBox(height: 8),
                const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              ],
            ],
          ),
        ),
      );
    }
    final sheetController = SheetController();
    final zoomCachedMapData =
        ref.watch(zoomCachedProjectedFeatureLayerProvider).valueOrNull;

    final navigateToHomeFunction = useState<VoidCallback?>(null);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final telegramType = data.telegrams.map((e) => e.status).toSet()
      ..remove(TelegramStatus.normal);

    return Scaffold(
      body: Stack(
        children: [
          if (zoomCachedMapData == null)
            const Center(
              child: CircularProgressIndicator.adaptive(),
            )
          else
            EarthquakeMapWidget(
              item: data,
              showIntensityIcon: true,
              mapData: zoomCachedMapData,
              registerNavigateToHome: (func) =>
                  navigateToHomeFunction.value = func,
            ),
          if (telegramType.isNotEmpty)
            Positioned(
              right: 10,
              top: 10,
              child: SafeArea(
                child: Text(
                  telegramType
                      .map(
                        (e) => switch (e) {
                          TelegramStatus.test => '試験報',
                          TelegramStatus.training => '訓練報',
                          TelegramStatus.normal => '',
                        },
                      )
                      .join('・'),
                  style: theme.textTheme.displayLarge!.copyWith(
                    color: colorScheme.error.withOpacity(0.4),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          Stack(
            children: [
              SheetFloatingActionButtons(
                hasAppBar: false,
                controller: sheetController,
                fab: [
                  FloatingActionButton.small(
                    heroTag: 'earthquake_history_details_fab',
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
              // Sheet
              _Sheet(
                sheetController: sheetController,
                item: data,
              ),
            ],
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
  final EarthquakeHistoryItem item;

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
          PrefectureIntensityWidget(item: item),
          if (item.earthquake.lgIntensity != null)
            PrefectureLpgmIntensityWidget(
              item: item,
            ),
          _EarthquakeCommentWidget(item: item),
          if (item.latestEewTelegram != null)
            ListTile(
              title: const Text('この地震に関する緊急地震速報'),
              subtitle: Text('${item.eewList.length}件'),
              onTap: () => context.push(
                EewDetailedHistoryRoute(
                  item.eventId,
                ).location,
              ),
            ),
        ],
      ),
    );
  }
}

class _EarthquakeHypoInfoWidget extends ConsumerWidget {
  const _EarthquakeHypoInfoWidget({
    required this.item,
  });

  final EarthquakeHistoryItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final intensityColorScheme = ref.watch(intensityColorProvider);
    final eq = item.earthquake;

    final maxIntensity = eq.intensity?.maxInt;
    final colorScheme = switch (maxIntensity) {
      final JmaIntensity intensity =>
        intensityColorScheme.fromJmaIntensity(intensity),
      _ => null,
    };
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
    // 「[MaxInt, 震源地, 規模」
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
          child: Text(
            eq.earthquake?.hypocenter.name ?? '不明',
            style: textTheme.headlineMedium!.copyWith(
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ],
    );

    // 地震発生時刻
    final timeWidget = eq.earthquake != null
        ? Text(
            '${DateFormat('yyyy/MM/dd HH:mm頃').format(
              eq.earthquake!.originTime.toLocal(),
            )}'
            ' '
            '発生',
            style: textTheme.bodyMedium!.copyWith(
              fontFamily: FontFamily.jetBrainsMono,
              fontFamilyFallback: [FontFamily.notoSansJP],
            ),
          )
        : item.telegrams.firstOrNull != null
            ? Text(
                '${DateFormat('yyyy/MM/dd HH:mm頃').format(
                  item.telegrams.firstOrNull!.pressTime.toLocal(),
                )}'
                ' '
                '発表',
                style: textTheme.bodyMedium!.copyWith(
                  fontFamily: FontFamily.jetBrainsMono,
                  fontFamilyFallback: [FontFamily.notoSansJP],
                ),
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
            eq.earthquake?.magnitude.condition,
            eq.earthquake?.magnitude.value
          )) {
            (final String cond, _) => cond.toHalfWidth.replaceAll('M不明', '不明'),
            (_, final double value) => value.toString(),
            _
                when item.telegrams
                    .any((element) => element.type == TelegramType.vxse53) =>
              '不明',
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
        if (eq.earthquake?.hypocenter.depth != null &&
            eq.earthquake?.hypocenter.depth != 0 &&
            eq.earthquake?.hypocenter.depth != 700) ...[
          Text(
            eq.earthquake!.hypocenter.depth.toString(),
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
            switch (eq.earthquake?.hypocenter.depth) {
              0 => 'ごく浅い',
              700 => '700km以上',
              _
                  when item.telegrams
                      .any((element) => element.type == TelegramType.vxse53) =>
                '不明',
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
        (eq.earthquake?.magnitude.condition?.toHalfWidth == 'M不明' ||
                eq.earthquake?.magnitude.value == null) &&
            eq.earthquake?.hypocenter.depth == null;
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
          switch (eq.earthquake?.hypocenter.depth) {
            _
                when item.telegrams
                    .any((element) => element.type == TelegramType.vxse53) =>
              '不明',
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
    final isEarthquakeNull = eq.earthquake == null;

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
          item.telegrams.any((element) => element.type == TelegramType.vxse53)
              ? '不明'
              : '調査中',
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
      crossAxisAlignment: WrapCrossAlignment.center,
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

  final EarthquakeHistoryItem item;

  @override
  Widget build(BuildContext context) {
    final comment = item.earthquake.comment;
    if (comment != null) {
      return BorderedContainer(
        padding: const EdgeInsets.all(8),
        elevation: 1,
        child: Markdown(
          data: switch ((comment.forecast?.text, comment.free)) {
            (final String text, final String free) => '$text\n\n$free',
            (final String text, _) => text,
            (_, final String free) => free,
            _ => '',
          }
              .toHalfWidth,
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
    return Container();
  }
}
