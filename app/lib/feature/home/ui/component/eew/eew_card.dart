import 'package:collection/collection.dart';
import 'package:eqmonitor/core/component/decoration/warning_stripe_decoration.dart';
import 'package:eqmonitor/core/component/intenisty/jma_intensity_icon.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/designsystem/extensions/typography_theme_extension.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/core/provider/time_ticker.dart';
import 'package:eqmonitor/feature/eew/data/logic/eew_deep_hypocenter_intensity_notice.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_estimated_region.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/location/data/location.dart';
import 'package:eqmonitor/feature/location/data/nearest_jma_feature.dart';
import 'package:material_ui/material_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lat_lng/lat_lng.dart' as lat_lng;

class EewCard extends ConsumerWidget {
  const new({
    required this.eew,
    required this.index,
    this.nowOverride,
    this.estimatedRegions,
    super.key,
  });

  final EewTelegramItem eew;
  final String? index;
  final DateTime? nowOverride;

  /// 距離減衰式による推計震度。JMAが現在地の予想震度を発表していない場合の
  /// フォールバックとして利用する。
  final List<EewEstimatedRegion>? estimatedRegions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = ref.watch(timeTickerProvider());
    final isWarning = eew.isWarning ?? false;

    final happenedTime = eew.originTime ?? eew.arrivalTime;
    if (happenedTime == null) {
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

    // PLUM法の地域は到達予想時刻が意味を持たないため、カウントダウンを出さない
    final isRegionPlum = localRegion?.isPlum ?? false;

    // 到達時間: JMA値を優先、なければ推定値
    final effectiveArrivalTime = isRegionPlum
        ? null
        : (localRegion?.arrivalTime ?? estimate?.sWaveArrivalTime);
    final effectiveIsArrived = isRegionPlum
        ? false
        : (localRegion?.isArrived ?? estimate?.isArrived ?? false);

    final nowValue = nowOverride ?? now.asData?.value;
    final hasArrived =
        effectiveIsArrived ||
        (effectiveArrivalTime != null &&
            nowValue != null &&
            nowValue.isAfter(effectiveArrivalTime));

    int? secondsUntilArrival;
    if (!eew.isCanceled && effectiveArrivalTime != null && nowValue != null) {
      final diff = effectiveArrivalTime.difference(nowValue).inSeconds;
      secondsUntilArrival = diff > 0 ? diff : 0;
    }

    final designSystem = context.designSystem;
    final colorTheme = designSystem.colorTheme;

    return Stack(
      alignment: Alignment.center,
      children: [
        if (index case final index?) _BackgroundIndexText(index: index),
        _EewMainCard(
          eew: eew,
          isWarning: isWarning,
          happenedTime: happenedTime,
          localForecastIntensity: effectiveLocalIntensity,
          regionDisplayName: effectiveRegionName,
          secondsUntilArrival: secondsUntilArrival,
          showArrived:
              (localRegion != null || estimate != null) &&
              (hasArrived ||
                  (effectiveArrivalTime != null &&
                      secondsUntilArrival == null)),
          showDeepHypocenterIntensityNotice: ref
              .watch(eewDeepHypocenterIntensityNoticeProvider)
              .shouldShow(eew: eew),
        ),
        if (eew.status != TelegramStatus.normal)
          Center(
            child: FittedBox(
              child: Text(
                eew.status.name,
                style: TextStyle(
                  fontSize: 100,
                  fontWeight: FontWeight.w700,
                  color: colorTheme.onSurfaceVariant.withValues(alpha: 0.2),
                  fontFamily: codeFontFamily,
                  letterSpacing: -0.5,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _EewMainCard extends StatelessWidget {
  const new({
    required this.eew,
    required this.isWarning,
    required this.happenedTime,
    required this.localForecastIntensity,
    required this.regionDisplayName,
    required this.showArrived,
    required this.showDeepHypocenterIntensityNotice,
    this.secondsUntilArrival,
  });

  final EewTelegramItem eew;
  final bool isWarning;
  final DateTime happenedTime;
  final JmaIntensity? localForecastIntensity;
  final String? regionDisplayName;
  final bool showArrived;
  final bool showDeepHypocenterIntensityNotice;
  final int? secondsUntilArrival;

  static const _warningHeaderColor = Color.fromRGBO(179, 26, 26, 1);
  static const _forecastHeaderColor = Color.fromRGBO(255, 167, 4, 1);
  static const _canceledHeaderColor = Color.fromRGBO(102, 102, 102, 1);

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final colorTheme = designSystem.colorTheme;
    final spacing = designSystem.spacing;
    final shape = designSystem.shape;
    final forecastIntensity = eew.forecastIntensity;
    final maxIntensity =
        forecastIntensity?.maxIntensity ?? JmaIntensity.unknown;
    final maxLpgmIntensity = forecastIntensity?.maxLpgmIntensity;

    final headerBackgroundColor = eew.isCanceled
        ? _canceledHeaderColor
        : isWarning
        ? _warningHeaderColor
        : _forecastHeaderColor;

    final regionDisplayName = this.regionDisplayName;
    final showLocalForecast =
        (localForecastIntensity != null ||
            secondsUntilArrival != null ||
            showArrived) &&
        regionDisplayName != null &&
        regionDisplayName.isNotEmpty &&
        localForecastIntensity != null;

    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      color: colorTheme.surfaceContainerHigh,
      shape: RoundedSuperellipseBorder(
        borderRadius: BorderRadius.circular(shape.card),
        side: BorderSide(color: colorTheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _EewCardHeader(
            eew: eew,
            isWarning: isWarning,
            headerBackgroundColor: headerBackgroundColor,
            secondsUntilArrival: secondsUntilArrival,
          ),
          Padding(
            padding: EdgeInsets.only(
              top: spacing.xs,
              left: spacing.sm,
              right: spacing.sm,
              bottom: spacing.xs,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (eew.isCanceled)
                  Text(
                    '緊急地震速報は取り消されました',
                    style: designSystem.typography.titleMedium.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  )
                else ...[
                  Row(
                    spacing: spacing.sm,
                    children: [
                      _EewMaxIntensitySection(
                        maxIntensity: maxIntensity,
                        depth: eew.hypocenter?.depth ?? 0,
                      ),
                      Expanded(
                        child: _EewHypocenterSection(
                          eew: eew,
                          happenedTime: happenedTime,
                        ),
                      ),
                      if (showLocalForecast)
                        _EewLocalForecastSection(
                          intensity: localForecastIntensity,
                          regionDisplayName: regionDisplayName,
                        ),
                    ],
                  ),
                  if (maxLpgmIntensity != null &&
                      maxLpgmIntensity != JmaLpgmIntensity.zero)
                    _EewLpgmSection(intensity: maxLpgmIntensity),
                  if (showDeepHypocenterIntensityNotice)
                    Text(
                      '震源の深さが150km以上のため、予想震度は発表されていません',
                      style: designSystem.typography.labelMedium,
                    ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EewCardHeader extends StatelessWidget {
  const new({
    required this.eew,
    required this.isWarning,
    required this.headerBackgroundColor,
    this.secondsUntilArrival,
  });

  final EewTelegramItem eew;
  final bool isWarning;
  final Color headerBackgroundColor;
  final int? secondsUntilArrival;

  static const _secondaryTextColor = Color.fromRGBO(255, 255, 255, 0.7);

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final typography = designSystem.typography;
    final spacing = designSystem.spacing;

    final typeLabel = eew.isCanceled
        ? '緊急地震速報(取消)'
        : isWarning
        ? '緊急地震速報(警報)'
        : '緊急地震速報(予報)';
    final serialLabel = eew.isLastInfo
        ? '最終 第${eew.serialNo}報'
        : '第${eew.serialNo}報';
    final typeLabelWithSerial = '$typeLabel $serialLabel';
    final headline = eew.headline;

    final secs = secondsUntilArrival;
    final countdownText = secs != null ? '$secs秒' : null;
    final hypocenterName = eew.hypocenter?.name;
    final String? headlineText = eew.isCanceled
        ? null
        : (headline != null && headline.isNotEmpty)
        ? headline.replaceAll('　', ' ').replaceAll('で地震 ', 'で地震\n')
        : hypocenterName != null
        ? '$hypocenterNameで地震発生'
        : '地震発生';

    final leftColumn = Expanded(
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Text(
            typeLabelWithSerial,
            style: typography.monoSmall.copyWith(
              color: Colors.white,
              letterSpacing: 0,
            ),
          ),
          if (headlineText != null)
            Text(
              headlineText,
              style: typography.titleSmall.copyWith(
                fontWeight: .w700,
                color: Colors.white,
              ),
              overflow: TextOverflow.visible,
            ),
        ],
      ),
    );

    final Widget? rightColumn;
    if (countdownText != null) {
      rightColumn = Column(
        crossAxisAlignment: .end,
        children: [
          Text(
            '主要動到達まで',
            style: typography.labelSmall.copyWith(color: _secondaryTextColor),
          ),
          Text(
            countdownText,
            style: typography.monoMedium.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: -0.5,
            ),
          ),
        ],
      );
    } else {
      rightColumn = null;
    }

    return DecoratedBox(
      decoration: BoxDecoration(color: headerBackgroundColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          WarningStripeDecoration(
            colors: eew.isCanceled
                ? const [
                    Color.fromRGBO(128, 128, 128, 1),
                    Color.fromRGBO(64, 64, 64, 1),
                  ]
                : isWarning
                ? const [Colors.red, Colors.black]
                : const [
                    Color.fromARGB(255, 255, 230, 0),
                    Color.fromRGBO(197, 101, 4, 1),
                  ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: spacing.sm,
              vertical: spacing.sm,
            ),
            child: Row(
              spacing: spacing.sm,
              children: [leftColumn, ?rightColumn],
            ),
          ),
        ],
      ),
    );
  }
}

class _EewMaxIntensitySection extends StatelessWidget {
  const new({
    required this.maxIntensity,
    required this.depth,
  });

  final JmaIntensity maxIntensity;
  final int depth;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final typography = designSystem.typography;
    final colorTheme = designSystem.colorTheme;
    final spacing = designSystem.spacing;

    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: spacing.xs,
      children: [
        Text(
          '最大震度',
          style: typography.labelMedium.copyWith(
            color: colorTheme.onSurfaceVariant,
          ),
        ),
        JmaIntensityIcon(intensity: maxIntensity, type: .filled),
      ],
    );
  }
}

class _EewHypocenterSection extends StatelessWidget {
  const new({required this.eew, required this.happenedTime});

  final EewTelegramItem eew;
  final DateTime happenedTime;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final typography = designSystem.typography;
    final colorTheme = designSystem.colorTheme;
    final spacing = designSystem.spacing;
    final hypocenter = eew.hypocenter;
    final timeLabel =
        (eew.originTime == null || eew.isPlum || eew.isLevelMethod)
        ? '地震検知'
        : '地震発生';
    final localHappened = happenedTime.toLocal();
    final detectionMethodLabel = switch ((
      eew.isPlum,
      eew.isLevelMethod,
      eew.isOnePointDetection,
    )) {
      (true, _, _) => 'PLUM法による検知',
      (_, true, _) => 'レベル法による検知',
      (_, _, true) => '低精度の緊急地震速報',
      _ => null,
    };
    final magnitude = hypocenter?.magnitude;
    final depth = hypocenter?.depth;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spacing.xs,
      children: [
        if (detectionMethodLabel != null)
          Text(
            detectionMethodLabel,
            style: typography.titleMedium.copyWith(fontFamily: codeFontFamily),
          )
        else if (magnitude != null || depth != null)
          Row(
            spacing: spacing.md,
            children: [
              if (magnitude != null) _MagnitudeRow(magnitude: magnitude),
              if (depth != null) _DepthRow(depth: depth),
            ],
          ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            _SecondaryLabel(text: timeLabel),
            const SizedBox(width: 4),
            Text(
              DateFormat('MM/dd').format(localHappened),
              style: typography.labelLarge.copyWith(
                fontFamily: codeFontFamily,
                letterSpacing: -0.5,
                color: colorTheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              DateFormat('HH:mm:ss').format(localHappened),
              style: typography.titleMedium.copyWith(
                fontFamily: codeFontFamily,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _EewLocalForecastSection extends StatelessWidget {
  const new({
    required this.intensity,
    required this.regionDisplayName,
  });

  final JmaIntensity? intensity;
  final String regionDisplayName;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final typography = designSystem.typography;
    final colorTheme = designSystem.colorTheme;

    return Column(
      mainAxisSize: .min,
      children: [
        Row(
          mainAxisSize: .min,
          children: [
            Icon(
              Icons.location_on,
              size: 9,
              color: colorTheme.onSurfaceVariant,
            ),
            const SizedBox(width: 2),
            Flexible(
              child: Text(
                regionDisplayName,
                style: typography.labelMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        if (intensity case final intensity?) ...[
          const SizedBox(height: 2),
          JmaIntensityIcon(intensity: intensity, type: .filled),
        ],
      ],
    );
  }
}

class _EewLpgmSection extends StatelessWidget {
  const new({required this.intensity});

  final JmaLpgmIntensity intensity;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final typography = designSystem.typography;
    final spacing = designSystem.spacing;

    return Padding(
      padding: EdgeInsets.all(spacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '予想最大長周期地震動階級 ${intensity.label}',
            style: typography.titleMedium,
          ),
          Text('高層階では特に周期の長い揺れに注意してください', style: typography.bodySmall),
        ],
      ),
    );
  }
}

class _BackgroundIndexText extends StatelessWidget {
  const new({required this.index});

  final String index;

  @override
  Widget build(BuildContext context) {
    final colorTheme = context.designSystem.colorTheme;

    return Center(
      child: FittedBox(
        child: Text(
          index,
          style: TextStyle(
            fontSize: 100,
            fontWeight: FontWeight.w700,
            fontFamily: codeFontFamily,
            color: colorTheme.onSurfaceVariant.withValues(alpha: 0.3),
          ),
        ),
      ),
    );
  }
}

class _SecondaryLabel extends StatelessWidget {
  const new({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final typography = designSystem.typography;
    final colorTheme = designSystem.colorTheme;

    return Text(
      text,
      style: typography.labelSmall.copyWith(color: colorTheme.onSurfaceVariant),
    );
  }
}

class _MagnitudeRow extends StatelessWidget {
  const new({required this.magnitude});

  final double magnitude;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final typography = designSystem.typography;
    final colorTheme = designSystem.colorTheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          'M ',
          style: typography.labelSmall.copyWith(
            color: colorTheme.onSurfaceVariant,
          ),
        ),
        Text(
          magnitude.toStringAsFixed(1),
          style: typography.titleLarge.copyWith(
            fontFamily: codeFontFamily,
            letterSpacing: -2,
          ),
        ),
      ],
    );
  }
}

class _DepthRow extends StatelessWidget {
  const new({required this.depth});

  final int depth;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final typography = designSystem.typography;
    final colorTheme = designSystem.colorTheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          '深さ ',
          style: typography.labelSmall.copyWith(
            color: colorTheme.onSurfaceVariant,
          ),
        ),
        Text(
          '$depth',
          style: typography.titleLarge.copyWith(
            fontFamily: codeFontFamily,
            letterSpacing: -0.5,
          ),
        ),
        Text(
          ' km',
          style: typography.labelSmall.copyWith(
            color: colorTheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
