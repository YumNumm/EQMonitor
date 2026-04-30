import 'package:collection/collection.dart';
import 'package:eqmonitor/core/component/intenisty/jma_forecast_intensity_icon.dart';
import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/core/designsystem/extensions/typography_theme_extension.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/core/provider/time_ticker.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/location/data/location.dart';
import 'package:eqmonitor/feature/location/data/nearest_jma_feature.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lat_lng/lat_lng.dart' as lat_lng;

class EewCard extends ConsumerWidget {
  const EewCard({required this.eew, required this.index, super.key});

  final EewTelegramItem eew;
  final String? index;

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
                jmaMapAreaForecastLocalEewInsideProvider(
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
      return regions.firstWhereOrNull(
        (r) => r.code == regionCode,
      );
    }

    final localRegion = localForecastRegion(eew, regionCode);
    final localForecastIntensity = localRegion?.intensity;

    final nowValue = now.asData?.value;
    final localIsArrived = localRegion?.isArrived ?? false;
    final localArrivalTime = localRegion?.arrivalTime;
    final hasArrived =
        localIsArrived ||
        (localArrivalTime != null &&
            nowValue != null &&
            nowValue.isAfter(localArrivalTime));

    int? secondsUntilArrival;
    if (!hasArrived && localArrivalTime != null && nowValue != null) {
      final diff = localArrivalTime.difference(nowValue).inSeconds;
      if (diff > 0) {
        secondsUntilArrival = diff;
      }
    }

    final designSystem = Theme.of(context).designSystemThemeExtension;
    final textColor = designSystem.textColor;

    return Stack(
      alignment: Alignment.center,
      children: [
        if (index != null) _BackgroundIndexText(index: index!),
        _EewMainCard(
          eew: eew,
          isWarning: isWarning,
          happenedTime: happenedTime,
          localForecastIntensity: localForecastIntensity,
          regionDisplayName: regionDisplayName,
          secondsUntilArrival: secondsUntilArrival,
          showArrived:
              localRegion != null &&
              (hasArrived ||
                  (localArrivalTime != null && secondsUntilArrival == null)),
        ),
        if (eew.status != TelegramStatus.normal)
          Center(
            child: FittedBox(
              child: Text(
                eew.status.name,
                style: TextStyle(
                  fontSize: 100,
                  fontWeight: FontWeight.w700,
                  color: textColor.secondary.withValues(alpha: 0.2),
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
  const _EewMainCard({
    required this.eew,
    required this.isWarning,
    required this.happenedTime,
    required this.localForecastIntensity,
    required this.regionDisplayName,
    required this.showArrived,
    this.secondsUntilArrival,
  });

  final EewTelegramItem eew;
  final bool isWarning;
  final DateTime happenedTime;
  final JmaIntensity? localForecastIntensity;
  final String? regionDisplayName;
  final bool showArrived;
  final int? secondsUntilArrival;

  static const _warningHeaderColor = Color.fromRGBO(179, 26, 26, 1);
  static const _forecastHeaderColor = Color.fromRGBO(204, 102, 13, 1);

  @override
  Widget build(BuildContext context) {
    final designSystem = Theme.of(context).designSystemThemeExtension;
    final color = designSystem.color;
    final spacing = designSystem.spacing;
    final shape = designSystem.shape;
    final forecastIntensity = eew.forecastIntensity;
    final maxIntensity =
        forecastIntensity?.maxIntensity ?? JmaIntensity.unknown;
    final maxLpgmIntensity = forecastIntensity?.maxLpgmIntensity;

    final headerBackgroundColor = eew.isCanceled
        ? color.surfaceRaised
        : isWarning
        ? _warningHeaderColor
        : _forecastHeaderColor;

    final showLocalForecast =
        localForecastIntensity != null &&
        regionDisplayName != null &&
        regionDisplayName!.isNotEmpty;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: spacing.lg),
      child: Card(
        elevation: 0,
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.zero,
        color: color.surfaceCard,
        shape: RoundedSuperellipseBorder(
          borderRadius: BorderRadius.circular(shape.card),
          side: BorderSide(color: color.outlineSoft),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _EewCardHeader(
              eew: eew,
              isWarning: isWarning,
              headerBackgroundColor: headerBackgroundColor,
              secondsUntilArrival: secondsUntilArrival,
              showArrived: showArrived,
            ),
            Padding(
              padding: EdgeInsets.all(spacing.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _EewMaxIntensitySection(maxIntensity: maxIntensity),
                      SizedBox(width: spacing.sm),
                      Expanded(
                        child: _EewHypocenterSection(
                          eew: eew,
                          happenedTime: happenedTime,
                        ),
                      ),
                      if (showLocalForecast) ...[
                        SizedBox(width: spacing.sm),
                        _EewLocalForecastSection(
                          intensity: localForecastIntensity!,
                          regionDisplayName: regionDisplayName!,
                        ),
                      ],
                    ],
                  ),
                  if (maxLpgmIntensity != null &&
                      maxLpgmIntensity != JmaLpgmIntensity.zero) ...[
                    SizedBox(height: spacing.sm),
                    _EewLpgmSection(intensity: maxLpgmIntensity),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EewCardHeader extends StatelessWidget {
  const _EewCardHeader({
    required this.eew,
    required this.isWarning,
    required this.headerBackgroundColor,
    required this.showArrived,
    this.secondsUntilArrival,
  });

  final EewTelegramItem eew;
  final bool isWarning;
  final Color headerBackgroundColor;
  final bool showArrived;
  final int? secondsUntilArrival;

  static const _secondaryTextColor = Color.fromRGBO(255, 255, 255, 0.7);

  @override
  Widget build(BuildContext context) {
    final designSystem = Theme.of(context).designSystemThemeExtension;
    final typography = designSystem.typography;
    final spacing = designSystem.spacing;

    final typeLabel = isWarning ? '緊急地震速報(警報)' : '緊急地震速報(予報)';
    final serialLabel = eew.isLastInfo
        ? '最終 第${eew.serialNo}報'
        : '第${eew.serialNo}報';
    final typeLabelWithSerial = '$typeLabel $serialLabel';
    final headline = eew.headline;

    final secs = secondsUntilArrival;
    final countdownText = (secs != null && secs > 0) ? '$secs秒' : null;
    final hypocenterName = eew.hypocenter?.name;
    final headlineText = (headline != null && headline.isNotEmpty)
        ? headline.replaceAll('　', ' ').replaceAll('で地震 ', 'で地震\n')
        : hypocenterName != null
        ? '$hypocenterNameで地震発生'
        : '地震発生';

    final leftColumn = Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            typeLabelWithSerial,
            style: typography.monoSmall.copyWith(
              color: _secondaryTextColor,
              letterSpacing: 0,
            ),
          ),
          Text(
            headlineText,
            style: typography.titleSmall.copyWith(
              fontWeight: FontWeight.w700,
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
        crossAxisAlignment: CrossAxisAlignment.end,
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
    } else if (showArrived) {
      rightColumn = Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '主要動',
            style: typography.labelSmall.copyWith(color: _secondaryTextColor),
          ),
          Text(
            '到達済み',
            style: typography.titleSmall.copyWith(
              fontWeight: FontWeight.w700,
              color: Colors.white,
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
          SizedBox(
            height: 8,
            width: double.infinity,
            child: _EewStripePattern(isWarning: isWarning),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: spacing.sm,
              vertical: spacing.sm,
            ),
            child: Row(
              spacing: spacing.sm,
              children: [
                leftColumn,
                ?rightColumn,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EewMaxIntensitySection extends StatelessWidget {
  const _EewMaxIntensitySection({required this.maxIntensity});

  final JmaIntensity maxIntensity;

  @override
  Widget build(BuildContext context) {
    final designSystem = Theme.of(context).designSystemThemeExtension;
    final typography = designSystem.typography;
    final textColor = designSystem.textColor;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '最大震度',
          style: typography.labelMedium.copyWith(color: textColor.secondary),
        ),
        const SizedBox(height: 2),
        JmaForecastIntensityWidget(intensity: maxIntensity),
      ],
    );
  }
}

class _EewHypocenterSection extends StatelessWidget {
  const _EewHypocenterSection({
    required this.eew,
    required this.happenedTime,
  });

  final EewTelegramItem eew;
  final DateTime happenedTime;

  @override
  Widget build(BuildContext context) {
    final designSystem = Theme.of(context).designSystemThemeExtension;
    final typography = designSystem.typography;
    final textColor = designSystem.textColor;
    final spacing = designSystem.spacing;
    final hypocenter = eew.hypocenter;
    final timeLabel = (eew.originTime == null || eew.isPlum) ? '地震検知' : '地震発生';
    final localHappened = happenedTime.toLocal();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.ideographic,
          children: [
            if (eew.isPlum)
              Text(
                'PLUM法による検知',
                style: typography.titleSmall.copyWith(
                  fontFamily: codeFontFamily,
                ),
              )
            else
              Row(
                spacing: spacing.md,
                children: [
                  _MagnitudeRow(magnitude: hypocenter?.magnitude),
                  _DepthRow(depth: hypocenter?.depth),
                ],
              ),
          ],
        ),
        const SizedBox(height: 4),
        const SizedBox(height: 4),
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
                color: textColor.secondary,
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
  const _EewLocalForecastSection({
    required this.intensity,
    required this.regionDisplayName,
  });

  final JmaIntensity intensity;
  final String regionDisplayName;

  @override
  Widget build(BuildContext context) {
    final designSystem = Theme.of(context).designSystemThemeExtension;
    final typography = designSystem.typography;
    final textColor = designSystem.textColor;

    return Column(
      mainAxisSize: .min,
      children: [
        Row(
          mainAxisSize: .min,
          children: [
            Icon(
              Icons.location_on,
              size: 9,
              color: textColor.secondary,
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
        const SizedBox(height: 2),
        JmaForecastIntensityWidget(
          intensity: intensity,
        ),
      ],
    );
  }
}

class _EewLpgmSection extends StatelessWidget {
  const _EewLpgmSection({required this.intensity});

  final JmaLpgmIntensity intensity;

  @override
  Widget build(BuildContext context) {
    final designSystem = Theme.of(context).designSystemThemeExtension;
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
          Text(
            '高層階では特に周期の長い揺れに注意してください',
            style: typography.bodySmall,
          ),
        ],
      ),
    );
  }
}

class _BackgroundIndexText extends StatelessWidget {
  const _BackgroundIndexText({required this.index});

  final String index;

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).designSystemThemeExtension.textColor;

    return Center(
      child: FittedBox(
        child: Text(
          index,
          style: TextStyle(
            fontSize: 100,
            fontWeight: FontWeight.w700,
            fontFamily: codeFontFamily,
            color: textColor.secondary.withValues(alpha: 0.3),
          ),
        ),
      ),
    );
  }
}

class _SecondaryLabel extends StatelessWidget {
  const _SecondaryLabel({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final designSystem = Theme.of(context).designSystemThemeExtension;
    final typography = designSystem.typography;
    final textColor = designSystem.textColor;

    return Text(
      text,
      style: typography.labelSmall.copyWith(color: textColor.secondary),
    );
  }
}

class _MagnitudeRow extends StatelessWidget {
  const _MagnitudeRow({required this.magnitude});

  final double? magnitude;

  @override
  Widget build(BuildContext context) {
    final designSystem = Theme.of(context).designSystemThemeExtension;
    final typography = designSystem.typography;
    final textColor = designSystem.textColor;

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          'M ',
          style: typography.labelSmall.copyWith(color: textColor.secondary),
        ),
        if (magnitude != null)
          Text(
            magnitude!.toStringAsFixed(1),
            style: typography.titleLarge.copyWith(
              fontFamily: codeFontFamily,
              letterSpacing: -0.5,
            ),
          )
        else
          Text('不明', style: typography.titleLarge),
      ],
    );
  }
}

class _DepthRow extends StatelessWidget {
  const _DepthRow({required this.depth});

  final int? depth;

  @override
  Widget build(BuildContext context) {
    final designSystem = Theme.of(context).designSystemThemeExtension;
    final typography = designSystem.typography;
    final textColor = designSystem.textColor;

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          '深さ ',
          style: typography.labelSmall.copyWith(color: textColor.secondary),
        ),
        if (depth == null)
          Text('不明', style: typography.titleLarge)
        else if (depth == 0)
          Text('ごく浅い', style: typography.titleLarge)
        else if (depth! >= 700) ...[
          Text(
            '$depth',
            style: typography.titleLarge.copyWith(
              fontFamily: codeFontFamily,
              letterSpacing: -0.5,
            ),
          ),
          Text(
            ' km以上',
            style: typography.labelSmall.copyWith(color: textColor.secondary),
          ),
        ] else ...[
          Text(
            '$depth ',
            style: typography.titleLarge.copyWith(
              fontFamily: codeFontFamily,
              letterSpacing: -0.5,
            ),
          ),
          Text(
            'km',
            style: typography.labelSmall.copyWith(color: textColor.secondary),
          ),
        ],
      ],
    );
  }
}

class _EewStripePattern extends StatelessWidget {
  const _EewStripePattern({required this.isWarning});

  final bool isWarning;

  @override
  Widget build(BuildContext context) {
    final colors = isWarning
        ? const [Colors.red, Colors.black]
        : const [Color(0xFFFFA500), Color.fromRGBO(128, 64, 0, 1)];
    return CustomPaint(
      painter: _StripePainter(colors: colors),
      size: const Size(double.infinity, 8),
    );
  }
}

class _StripePainter extends CustomPainter {
  _StripePainter({required this.colors});

  final List<Color> colors;

  @override
  void paint(Canvas canvas, Size size) {
    const stripeWidth = 8.0;
    final h = size.height;
    final totalWidth = size.width + h * 2;
    var x = -h;
    while (x < totalWidth) {
      final path = Path()
        ..moveTo(x, h)
        ..lineTo(x + stripeWidth, h)
        ..lineTo(x + h + stripeWidth, 0)
        ..lineTo(x + h, 0)
        ..close();
      final colorIndex = ((x + h) / stripeWidth).floor().abs() % colors.length;
      final paint = Paint()..color = colors[colorIndex];
      canvas.drawPath(path, paint);
      x += stripeWidth;
    }
  }

  @override
  bool shouldRepaint(covariant _StripePainter oldDelegate) =>
      oldDelegate.colors != colors;
}
