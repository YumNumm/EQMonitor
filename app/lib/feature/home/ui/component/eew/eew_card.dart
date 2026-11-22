import 'dart:async';

import 'package:clock/clock.dart';
import 'package:collection/collection.dart';
import 'package:eqmonitor/core/component/decoration/warning_stripe_decoration.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/designsystem/extensions/typography_theme_extension.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/core/provider/clock/app_clock.dart';
import 'package:eqmonitor/core/provider/clock/time_mode.dart';
import 'package:eqmonitor/core/provider/time_ticker.dart';
import 'package:eqmonitor/core/theme/model/intensity_colors.dart';
import 'package:eqmonitor/core/util/date_time_format.dart';
import 'package:eqmonitor/feature/eew/data/logic/eew_deep_hypocenter_intensity_notice.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_estimated_region.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/location/data/location.dart';
import 'package:eqmonitor/feature/location/data/nearest_jma_feature.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lat_lng/lat_lng.dart' as lat_lng;
import 'package:material_ui/material_ui.dart';

/// Live Activity は文字サイズに応じた光学サイズが自動で効く。Flutter では明示しないと既定値のまま字形と字間がずれる。
class _EewFlexTextStyle extends TextStyle {
  new({
    required double size,
    required FontWeight weight,
    required Color color,
  }) : super(
         fontFamily: primaryFontFamily,
         fontFamilyFallback: japaneseFontFamilyFallback,
         fontSize: size,
         height: _EewCodeTextStyle.lineHeight,
         fontWeight: weight,
         fontVariations: [
           FontVariation.opticalSize(size),
           FontVariation.weight(weight.value.toDouble()),
         ],
         letterSpacing: 0,
         color: color,
       );
}

class _EewCodeTextStyle extends TextStyle {
  new({
    required double size,
    required FontWeight weight,
    required Color color,
  }) : super(
         fontFamily: codeFontFamily,
         fontFamilyFallback: japaneseFontFamilyFallback,
         fontSize: size,
         height: lineHeight,
         fontWeight: weight,
         fontVariations: [FontVariation.weight(weight.value.toDouble())],
         letterSpacing: 0,
         color: color,
       );

  static const lineHeight = 1.25;
}

class const EewCard({
  required final EewTelegramItem eew,
  required final String? index,
  final DateTime? nowOverride,

  /// 距離減衰式による推計震度。JMAが現在地の予想震度を発表していない場合の
  /// フォールバックとして利用する。
  final List<EewEstimatedRegion>? estimatedRegions,

  /// 過去のEEWを再生する画面では、現在地への警報と誤解させないため無効にする。
  final bool emphasizesLocalWarning = true,
  super.key,
}) extends ConsumerWidget {
  static const _localWarningSurfaceColor = Color.fromRGBO(51, 0, 0, 1);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isWarning = eew.isWarning ?? false;

    // 取消報は発生時刻を持たないが、取消の旨を表示するためカードは描画する。
    final happenedTime = eew.originTime ?? eew.arrivalTime;
    if (happenedTime == null && !eew.isCanceled) {
      return const SizedBox.shrink();
    }

    final positionAsync = ref.watch(locationStreamProvider);
    final position = positionAsync.value;
    final regionItem = position != null
        ? ref
              .watch(
                jmaMapAreaForecastLocalEInsideProvider(
                  lat_lng.LatLng(position.latitude, position.longitude),
                ),
              )
              .value
        : null;

    final regionCode = regionItem?.property?.code;
    final regionDisplayName = regionItem?.property?.name;

    EewForecastRegionInfo? localForecastRegion(
      EewTelegramItem eew,
      String? regionCode,
    ) {
      if (regionCode == null) {
        return null;
      }
      final regions = eew.forecastIntensity?.regions;
      if (regions == null || regions.isEmpty) {
        return null;
      }
      return regions.firstWhereOrNull((r) => r.code == regionCode);
    }

    final localRegion = localForecastRegion(eew, regionCode);

    // JMAのlocalRegionがない場合、推定値をフォールバック
    final estimate = regionCode != null
        ? estimatedRegions?.firstWhereOrNull((e) => e.regionCode == regionCode)
        : null;
    final effectiveLocalIntensity =
        localRegion?.intensity ?? estimate?.jmaIntensity;
    final effectiveRegionName = regionDisplayName ?? estimate?.regionName;

    // PLUM法は到達時刻が発表されない。報全体がPLUM法なら現在地の予想もPLUM法による。
    final isLocalPlum = eew.isPlum || (localRegion?.isPlum ?? false);
    final hideArrival = eew.isCanceled || isLocalPlum;

    // 到達時間: JMA値を優先、なければ推定値
    final effectiveArrivalTime = hideArrival
        ? null
        : (localRegion?.arrivalTime ?? estimate?.sWaveArrivalTime);
    final effectiveIsArrived = hideArrival
        ? false
        : (localRegion?.isArrived ?? estimate?.isArrived ?? false);

    // 推計値は警報対象かどうかを持たないため、JMAの発表値だけで判定する。
    final isLocalWarning =
        emphasizesLocalWarning &&
        !eew.isCanceled &&
        isWarning &&
        (localRegion?.isWarning ?? false);

    final colorTheme = context.designSystem.colorTheme;
    final usesDarkSurface =
        isLocalWarning || Theme.of(context).brightness == Brightness.dark;
    final colors = usesDarkSurface
        ? _EewCardColors(
            surface: isLocalWarning ? _localWarningSurfaceColor : Colors.black,
            border: isLocalWarning
                ? _localWarningSurfaceColor
                : colorTheme.outlineVariant,
            primary: Colors.white,
            secondary: Colors.white.withValues(alpha: 0.8),
            divider: Colors.white.withValues(alpha: 0.35),
            watermark: Colors.white.withValues(alpha: 0.2),
          )
        : _EewCardColors(
            surface: colorTheme.surfaceContainer,
            border: colorTheme.outlineVariant,
            primary: colorTheme.onSurface,
            secondary: colorTheme.onSurfaceVariant,
            divider: colorTheme.outline,
            watermark: colorTheme.onSurfaceVariant.withValues(alpha: 0.2),
          );

    return Stack(
      alignment: Alignment.center,
      children: [
        if (index case final index?)
          _WatermarkText(text: index, color: colors.watermark),
        _EewMainCard(
          eew: eew,
          colors: colors,
          isWarning: isWarning,
          isLocalWarning: isLocalWarning,
          happenedTime: happenedTime,
          localForecastIntensity: effectiveLocalIntensity,
          regionDisplayName: effectiveRegionName,
          arrivalTime: effectiveArrivalTime,
          isArrived: effectiveIsArrived,
          isImminentArrival: !eew.isCanceled && isLocalPlum,
          nowOverride: nowOverride,
          showDeepHypocenterIntensityNotice: ref
              .watch(eewDeepHypocenterIntensityNoticeProvider)
              .shouldShow(eew: eew),
        ),
        if (eew.status != TelegramStatus.normal)
          _WatermarkText(text: eew.status.name, color: colors.watermark),
      ],
    );
  }
}

class const _EewCardColors({
  required final Color surface,
  required final Color border,
  required final Color primary,
  required final Color secondary,
  required final Color divider,
  required final Color watermark,
});

class const _EewMainCard({
  required final EewTelegramItem eew,
  required final _EewCardColors colors,
  required final bool isWarning,
  required final bool isLocalWarning,
  required final DateTime? happenedTime,
  required final JmaIntensity? localForecastIntensity,
  required final String? regionDisplayName,
  required final DateTime? arrivalTime,
  required final bool isArrived,
  required final bool isImminentArrival,
  required final DateTime? nowOverride,
  required final bool showDeepHypocenterIntensityNotice,
}) extends StatelessWidget {
  static const _deepHypocenterIntensityNotice =
      '震源の深さが150kmより深いため、予想震度は発表されていません';
  static const _deepHypocenterIntensityNoticeLines =
      '震源の深さが150kmより深いため、\n予想震度は発表されていません';

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final spacing = designSystem.spacing;
    final forecastIntensity = eew.forecastIntensity;
    final maxLpgmIntensity = forecastIntensity?.maxLpgmIntensity;
    final happenedTime = this.happenedTime;
    final regionDisplayName = this.regionDisplayName;
    final localForecastIntensity = this.localForecastIntensity;
    final showsLocalForecast =
        regionDisplayName != null &&
        regionDisplayName.isNotEmpty &&
        localForecastIntensity != null;
    final deepNotice = Text(
      _deepHypocenterIntensityNoticeLines,
      semanticsLabel: _deepHypocenterIntensityNotice,
      style: _EewFlexTextStyle(
        size: 11,
        weight: .w500,
        color: colors.secondary,
      ),
    );

    return Card(
      elevation: 0,
      clipBehavior: .antiAlias,
      margin: EdgeInsets.zero,
      color: colors.surface,
      shape: RoundedSuperellipseBorder(
        borderRadius: BorderRadius.circular(designSystem.shape.card),
        side: BorderSide(color: colors.border),
      ),
      child: Padding(
        padding: EdgeInsets.all(spacing.md),
        child: Column(
          crossAxisAlignment: .stretch,
          children: [
            _EewCardHeader(
              eew: eew,
              isWarning: isWarning,
              maxIntensity:
                  forecastIntensity?.maxIntensity ?? JmaIntensity.unknown,
            ),
            SizedBox(height: showsLocalForecast ? 6 : spacing.sm),
            if (eew.isCanceled)
              Text(
                '緊急地震速報は取り消されました',
                style: _EewFlexTextStyle(
                  size: 15,
                  weight: .w800,
                  color: colors.primary,
                ),
              )
            else if (happenedTime != null) ...[
              LayoutBuilder(
                builder: (context, constraints) => Row(
                  crossAxisAlignment: .end,
                  spacing: spacing.sm,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: .start,
                        spacing: isLocalWarning ? 2 : spacing.xs,
                        children: [
                          _EewEventTime(
                            eew: eew,
                            happenedTime: happenedTime,
                            color: colors.secondary,
                          ),
                          if (isLocalWarning) const _EewLocalWarningNotice(),
                          _EewSourceMetrics(
                            eew: eew,
                            colors: colors,
                            isCompact:
                                isLocalWarning ||
                                showDeepHypocenterIntensityNotice,
                          ),
                        ],
                      ),
                    ),
                    if (showsLocalForecast)
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: constraints.maxWidth * 0.6,
                        ),
                        child: _EewLocalForecastSection(
                          intensity: localForecastIntensity,
                          regionDisplayName: regionDisplayName,
                          isLocalWarning: isLocalWarning,
                          arrivalTime: arrivalTime,
                          isArrived: isArrived,
                          isImminentArrival: isImminentArrival,
                          nowOverride: nowOverride,
                          colors: colors,
                        ),
                      )
                    else if (showDeepHypocenterIntensityNotice)
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: constraints.maxWidth * 0.6,
                        ),
                        child: deepNotice,
                      ),
                  ],
                ),
              ),
              if (showsLocalForecast && showDeepHypocenterIntensityNotice)
                Padding(
                  padding: EdgeInsets.only(top: spacing.sm),
                  child: deepNotice,
                ),
              if (maxLpgmIntensity != null &&
                  maxLpgmIntensity != JmaLpgmIntensity.zero)
                Padding(
                  padding: EdgeInsets.only(top: spacing.sm),
                  child: _EewLpgmSection(
                    intensity: maxLpgmIntensity,
                    colors: colors,
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }
}

class const _EewCardHeader({
  required final EewTelegramItem eew,
  required final bool isWarning,
  required final JmaIntensity maxIntensity,
}) extends StatelessWidget {
  static const _warningColor = Color.fromRGBO(179, 26, 26, 1);
  static const _forecastColor = Color.fromRGBO(204, 102, 13, 1);
  static const _canceledColor = Color.fromRGBO(102, 102, 102, 1);
  static const _warningStripeColors = [
    Color.fromRGBO(255, 59, 48, 1),
    Colors.black,
  ];
  static const _forecastStripeColors = [
    Color.fromRGBO(255, 149, 0, 1),
    Color.fromRGBO(128, 64, 0, 1),
  ];
  static const _canceledStripeColors = [
    Color.fromRGBO(128, 128, 128, 1),
    Color.fromRGBO(64, 64, 64, 1),
  ];
  static const _secondaryTextColor = Color.fromRGBO(255, 255, 255, 0.7);

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final spacing = designSystem.spacing;

    final typeLabel = eew.isCanceled
        ? '緊急地震速報(取消)'
        : isWarning
        ? '緊急地震速報(警報)'
        : '緊急地震速報(予報)';
    final serialLabel = eew.isLastInfo
        ? '最終 第${eew.serialNo}報'
        : '第${eew.serialNo}報';
    final headline = eew.headline;
    final hypocenterName = eew.hypocenter?.name;
    final String? headlineText = eew.isCanceled
        ? null
        : (headline != null && headline.isNotEmpty)
        ? headline.replaceAll('　', ' ')
        : hypocenterName != null
        ? '$hypocenterNameで地震発生'
        : '地震発生';

    return ClipRRect(
      borderRadius: BorderRadius.circular(
        designSystem.shape.card - spacing.md,
      ),
      child: ColoredBox(
        color: eew.isCanceled
            ? _canceledColor
            : isWarning
            ? _warningColor
            : _forecastColor,
        child: Column(
          crossAxisAlignment: .stretch,
          children: [
            WarningStripeDecoration(
              height: 5,
              colors: eew.isCanceled
                  ? _canceledStripeColors
                  : isWarning
                  ? _warningStripeColors
                  : _forecastStripeColors,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: spacing.md,
                vertical: spacing.sm,
              ),
              child: Row(
                spacing: spacing.sm,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: .start,
                      spacing: 2,
                      children: [
                        Text(
                          '$typeLabel $serialLabel',
                          style: _EewFlexTextStyle(
                            size: 11,
                            weight: .w600,
                            color: _secondaryTextColor,
                          ),
                        ),
                        if (headlineText != null)
                          Text(
                            headlineText,
                            style: _EewFlexTextStyle(
                              size: 15,
                              weight: .w800,
                              color: Colors.white,
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (!eew.isCanceled)
                    _EewMaxIntensityLabel(intensity: maxIntensity),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 現在地の色付きバッジと混同させないため、全国の最大震度は塗らずに `MAX` を添える。
class const _EewMaxIntensityLabel({required final JmaIntensity intensity})
    extends StatelessWidget {
  static const _size = 32.0;

  @override
  Widget build(BuildContext context) {
    final numberStyle = _EewCodeTextStyle(
      size: _size,
      weight: .w800,
      color: Colors.white,
    );
    final maxLabel = Text(
      'MAX',
      style: _EewCodeTextStyle(
        size: _size * 0.28,
        weight: .w800,
        color: Colors.white,
      ),
    );
    final suffix = intensity.suffix;

    return Semantics(
      label: intensity == JmaIntensity.unknown
          ? '最大予想震度 未発表'
          : '最大予想震度 ${intensity.label}',
      excludeSemantics: true,
      child: suffix.isEmpty
          // 数字の行は高さ40pt。MAXを上へ積むぶんはヘッダーの上下の余白へ逃がし、ヘッダーの高さを変えない。
          ? Align(
              heightFactor: 1.25 / (0.28 * 1.25 + 1.25 - 0.12),
              child: Column(
                mainAxisSize: .min,
                children: [
                  maxLabel,
                  Align(
                    alignment: .bottomCenter,
                    heightFactor: 1 - 0.12 / 1.25,
                    child: Text(intensity.mainText, style: numberStyle),
                  ),
                ],
              ),
            )
          : Row(
              mainAxisSize: .min,
              crossAxisAlignment: .end,
              children: [
                Text(intensity.mainText, style: numberStyle),
                Padding(
                  padding: const EdgeInsets.only(bottom: _size * 0.12),
                  child: Column(
                    mainAxisSize: .min,
                    crossAxisAlignment: .start,
                    children: [
                      maxLabel,
                      Text(
                        suffix,
                        style: _EewFlexTextStyle(
                          size: _size * 0.45,
                          weight: .w800,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

class const _EewEventTime({
  required final EewTelegramItem eew,
  required final DateTime happenedTime,
  required final Color color,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final style = _EewCodeTextStyle(size: 10, weight: .w500, color: color);
    final timeLabel =
        (eew.originTime == null || eew.isPlum || eew.isLevelMethod)
        ? '地震検知'
        : '地震発生';

    return Wrap(
      spacing: 12,
      children: [
        Text(timeLabel, style: style),
        Text(
          '${happenedTime.formatWithTz(.monthDay)} '
          '${happenedTime.formatWithTz(.hourMinuteSecond)}',
          style: style,
        ),
      ],
    );
  }
}

class const _EewLocalWarningNotice() extends HookWidget {
  static const _fillColor = Color.fromRGBO(184, 0, 0, 1);
  static const _blinkInterval = Duration(milliseconds: 500);

  @override
  Widget build(BuildContext context) {
    final disableAnimations = MediaQuery.disableAnimationsOf(context);
    final isFilled = useState(true);
    useEffect(() {
      if (disableAnimations) {
        isFilled.value = true;
        return null;
      }
      final timer = Timer.periodic(_blinkInterval, (_) {
        isFilled.value = !isFilled.value;
      });
      return timer.cancel;
      // isFilled はこのTimer自身がトグルする値。keysに入れると500msごとに
      // Timerが破棄・再生成され点滅が破綻するため、意図的に含めない。
      // ignore_keys: isFilled.value
    }, [disableAnimations]);

    return Semantics(
      label: '現在地は緊急地震速報の警報対象地域です',
      excludeSemantics: true,
      child: FittedBox(
        fit: .scaleDown,
        alignment: .centerLeft,
        child: ColoredBox(
          color: isFilled.value ? _fillColor : Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
            child: Text(
              '強い揺れに警戒!',
              style: _EewFlexTextStyle(
                size: 12,
                weight: .w800,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class const _EewSourceMetrics({
  required final EewTelegramItem eew,
  required final _EewCardColors colors,
  required final bool isCompact,
}) extends StatelessWidget {
  static const _size = 28.0;
  static const _compactSize = 77.23 / 3;

  @override
  Widget build(BuildContext context) {
    final detectionMethodLabel = switch ((
      eew.isPlum,
      eew.isLevelMethod,
      eew.isOnePointDetection,
    )) {
      (true, _, _) => 'PLUM法',
      (_, true, _) => 'レベル法',
      (_, _, true) => '低精度',
      _ => null,
    };
    if (detectionMethodLabel != null) {
      return Padding(
        padding: const EdgeInsets.all(4),
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(color: colors.primary.withValues(alpha: 0.5)),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
            child: Text(
              detectionMethodLabel,
              style: _EewFlexTextStyle(
                size: 12,
                weight: .w700,
                color: colors.primary,
              ).copyWith(height: 14 / 12),
            ),
          ),
        ),
      );
    }

    final size = isCompact ? _compactSize : _size;
    final depth = eew.hypocenter?.depth;
    final labelStyle = _EewFlexTextStyle(
      size: size * 0.44,
      weight: .w500,
      color: colors.primary,
    );
    final valueStyle = _EewCodeTextStyle(
      size: size,
      weight: .w700,
      color: colors.primary,
    );
    final magnitudeParts = eew.hypocenter?.magnitude
        ?.toStringAsFixed(1)
        .split('.');

    return FittedBox(
      fit: .scaleDown,
      alignment: .centerLeft,
      child: Text.rich(
        TextSpan(
          children: [
            if (magnitudeParts != null) ...[
              TextSpan(text: 'M', style: labelStyle),
              // 等幅フォントの小数点は1文字分の幅を取るため、小数点の前後だけを詰める。
              TextSpan(
                text: '${magnitudeParts.first}.',
                style: valueStyle.copyWith(letterSpacing: size * -0.14),
              ),
              TextSpan(text: magnitudeParts.last, style: valueStyle),
            ],
            if (magnitudeParts != null && depth != null)
              TextSpan(
                text: '  ',
                style: _EewFlexTextStyle(
                  size: 18,
                  weight: .w400,
                  color: colors.primary,
                ),
              ),
            if (depth != null) ...[
              TextSpan(text: '深さ ', style: labelStyle),
              if (depth == 0)
                TextSpan(
                  text: 'ごく浅い',
                  style: _EewFlexTextStyle(
                    size: size,
                    weight: .w700,
                    color: colors.primary,
                  ),
                )
              else ...[
                TextSpan(text: '$depth', style: valueStyle),
                TextSpan(
                  text: depth == 700 ? 'km以上' : 'km',
                  style: labelStyle,
                ),
              ],
            ],
          ],
        ),
        maxLines: 1,
      ),
    );
  }
}

class const _EewLocalForecastSection({
  required final JmaIntensity intensity,
  required final String regionDisplayName,
  required final bool isLocalWarning,
  required final DateTime? arrivalTime,
  required final bool isArrived,
  required final bool isImminentArrival,
  required final DateTime? nowOverride,
  required final _EewCardColors colors,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final labelStyle = _EewFlexTextStyle(
      size: 10,
      weight: .w700,
      color: colors.secondary,
    );
    final showsCountdown = arrivalTime != null || isArrived;

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(left: BorderSide(color: colors.divider, width: 0.5)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 7),
        child: Row(
          mainAxisSize: .min,
          crossAxisAlignment: .end,
          spacing: 6,
          children: [
            Flexible(
              // 予想震度と到達予想がそろうときは地名を省き、カウントダウンを大きく見せる。
              child: isImminentArrival
                  ? Column(
                      mainAxisSize: .min,
                      crossAxisAlignment: .start,
                      spacing: 2,
                      children: [
                        Text('現在地', style: labelStyle),
                        FittedBox(
                          fit: .scaleDown,
                          alignment: .centerLeft,
                          child: Text(
                            'すぐに到達',
                            style: _EewFlexTextStyle(
                              size: 16,
                              weight: .w800,
                              color: colors.primary,
                            ),
                          ),
                        ),
                      ],
                    )
                  : showsCountdown
                  ? Column(
                      mainAxisSize: .min,
                      crossAxisAlignment: .start,
                      children: [
                        Text('現在地\n揺れ到達まで', style: labelStyle),
                        _EewArrivalCountdown(
                          arrivalTime: arrivalTime,
                          isArrived: isArrived,
                          nowOverride: nowOverride,
                          color: colors.primary,
                        ),
                      ],
                    )
                  : Column(
                      mainAxisSize: .min,
                      crossAxisAlignment: .start,
                      spacing: 2,
                      children: [
                        Text(
                          isLocalWarning ? '現在地に警報' : '現在地',
                          style: labelStyle,
                        ),
                        Text(
                          regionDisplayName,
                          style: _EewFlexTextStyle(
                            size: 10,
                            weight: .w800,
                            color: colors.primary,
                          ),
                          maxLines: 2,
                          overflow: .ellipsis,
                        ),
                      ],
                    ),
            ),
            _EewLocalIntensityBadge(intensity: intensity),
          ],
        ),
      ),
    );
  }
}

class const _EewArrivalCountdown({
  required final DateTime? arrivalTime,
  required final bool isArrived,
  required final DateTime? nowOverride,
  required final Color color,
}) extends HookConsumerWidget {
  static const _refreshInterval = Duration(milliseconds: 50);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tick = ref.watch(timeTickerProvider()).value;
    // リプレイは再生位置が毎フレーム届き、一時停止や倍速もあるため、経過時間で進めない。
    final replayTime = switch (ref.watch(appClockProvider)) {
      ReplayTimeMode(:final currentTime) => currentTime,
      _ => null,
    };
    final fixedNow = nowOverride ?? replayTime;
    // 時刻の配信は1秒おき。その間は経過時間を足して0.1秒の桁を進める。
    final anchor = useMemoized(
      () => (time: tick, elapsed: clock.stopwatch()..start()),
      [tick],
    );
    final arrivalTime = this.arrivalTime;
    final now = fixedNow ?? anchor.time?.add(anchor.elapsed.elapsed);
    final remaining = isArrived || arrivalTime == null || now == null
        ? Duration.zero
        : arrivalTime.difference(now);
    final isCountingDown = fixedNow == null && remaining > Duration.zero;
    final refreshCount = useState(0);
    useEffect(() {
      if (!isCountingDown) {
        return null;
      }
      final timer = Timer.periodic(_refreshInterval, (_) {
        refreshCount.value++;
      });
      return timer.cancel;
      // ignore_keys: refreshCount.value
    }, [isCountingDown]);

    if (!isArrived && (arrivalTime == null || now == null)) {
      return const SizedBox.shrink();
    }
    final tenths = remaining.isNegative
        ? 0
        : (remaining.inMilliseconds / 100).ceil();
    final minutes = tenths ~/ 600;
    final seconds = (tenths % 600) ~/ 10;
    final hasMinutes = minutes > 0;

    // 桁数が変わっても小数点と「秒」の位置が動かないよう、最長の桁で幅を確保して右寄せにする。
    return FittedBox(
      fit: .scaleDown,
      alignment: .centerLeft,
      child: Stack(
        alignment: .centerRight,
        children: [
          ExcludeSemantics(
            child: Visibility.maintain(
              visible: false,
              child: _EewCountdownText(
                whole: hasMinutes ? '1:11' : '11',
                fraction: '.1',
                showsUnit: !hasMinutes,
                color: color,
              ),
            ),
          ),
          _EewCountdownText(
            whole: hasMinutes
                ? '$minutes:${seconds.toString().padLeft(2, '0')}'
                : '$seconds',
            fraction: tenths == 0 ? null : '.${tenths % 10}',
            showsUnit: !hasMinutes,
            color: color,
          ),
        ],
      ),
    );
  }
}

/// Live Activity の `EQCountdown.ttf` と同じ比率で、小数と「秒」を小さく描く。
class const _EewCountdownText({
  required final String whole,
  required final String? fraction,
  required final bool showsUnit,
  required final Color color,
}) extends StatelessWidget {
  static const _size = 26.0;
  static const _fractionScale = 0.62;
  static const _unitScale = 0.56;
  static const _decimalPointTrim = _size * -0.083;

  @override
  Widget build(BuildContext context) {
    final fraction = this.fraction;
    final wholeStyle = _EewCodeTextStyle(
      size: _size,
      weight: .w700,
      color: color,
    ).copyWith(height: 32 / _size);
    final fractionStyle = _EewCodeTextStyle(
      size: _size * _fractionScale,
      weight: .w800,
      color: color,
    );

    return Text.rich(
      TextSpan(
        children: [
          if (fraction == null)
            TextSpan(text: whole)
          else ...[
            TextSpan(text: whole.substring(0, whole.length - 1)),
            // 等幅フォントの小数点は1文字分の幅を取るため、小数点の前後だけを詰める。
            TextSpan(
              text: whole.substring(whole.length - 1),
              style: wholeStyle.copyWith(letterSpacing: _decimalPointTrim),
            ),
            TextSpan(
              text: fraction.substring(0, 1),
              style: fractionStyle.copyWith(letterSpacing: _decimalPointTrim),
            ),
            TextSpan(text: fraction.substring(1), style: fractionStyle),
          ],
          if (showsUnit)
            const TextSpan(
              text: '秒',
              style: TextStyle(
                fontFamily: FontFamily.notoSansJP,
                fontSize: _size * _unitScale,
                height: 1,
                fontWeight: .w700,
              ),
            ),
        ],
      ),
      style: wholeStyle,
      maxLines: 1,
      softWrap: false,
    );
  }
}

class const _EewLocalIntensityBadge({required final JmaIntensity intensity})
    extends StatelessWidget {
  static const _size = 48.0;

  @override
  Widget build(BuildContext context) {
    final colorEntry = context.designSystem.colorTheme.intensity
        .fromJmaIntensity(intensity);
    final foreground = colorEntry.resolvedForeground;
    final suffix = intensity.suffix;

    return Semantics(
      label: '現在地の予想震度 ${intensity.label}',
      excludeSemantics: true,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: _size, minHeight: _size),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: colorEntry.background,
            borderRadius: BorderRadius.circular(_size * 0.2),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: _size * 0.08),
            child: Center(
              widthFactor: 1,
              heightFactor: 1,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: intensity.mainText),
                    if (suffix.isNotEmpty)
                      TextSpan(
                        text: suffix,
                        style: _EewFlexTextStyle(
                          size: _size * 0.36,
                          weight: .w800,
                          color: foreground,
                        ),
                      ),
                  ],
                ),
                style: _EewCodeTextStyle(
                  size: _size * 0.76,
                  weight: .w800,
                  color: foreground,
                ),
                maxLines: 1,
                softWrap: false,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class const _EewLpgmSection({
  required final JmaLpgmIntensity intensity,
  required final _EewCardColors colors,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(
          '予想最大長周期地震動階級 ${intensity.label}',
          style: _EewFlexTextStyle(
            size: 15,
            weight: .w700,
            color: colors.primary,
          ),
        ),
        Text(
          '高層階では特に周期の長い揺れに注意してください',
          style: _EewFlexTextStyle(
            size: 11,
            weight: .w500,
            color: colors.secondary,
          ),
        ),
      ],
    );
  }
}

class const _WatermarkText({
  required final String text,
  required final Color color,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FittedBox(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 100,
            fontWeight: .w700,
            fontFamily: codeFontFamily,
            letterSpacing: -0.5,
            color: color,
          ),
        ),
      ),
    );
  }
}
