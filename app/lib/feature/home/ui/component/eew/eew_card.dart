import 'package:collection/collection.dart';
import 'package:eqmonitor/core/component/intenisty/jma_forecast_intensity_icon.dart';
import 'package:eqmonitor/core/component/intenisty/jma_forecast_lg_intensity_icon.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
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
    final localForecastIntensity = _localForecastIntensity(eew, regionCode);
    final regionDisplayName = regionItem?.property?.name;

    final nowValue = now.asData?.value;
    final hasArrived =
        eew.arrivalTime != null &&
        nowValue != null &&
        nowValue.isAfter(eew.arrivalTime!);

    final textTheme = Theme.of(context).textTheme;

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
          hasArrived: hasArrived,
        ),
        if (eew.status != TelegramStatus.normal)
          Center(
            child: FittedBox(
              child: Text(
                eew.status.name,
                style: TextStyle(
                  fontSize: 100,
                  fontWeight: FontWeight.bold,
                  color: textTheme.bodyMedium!.color!.withValues(alpha: 0.2),
                  fontFamily: FontFamily.notoSansMono,
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
    required this.hasArrived,
  });

  final EewTelegramItem eew;
  final bool isWarning;
  final DateTime happenedTime;
  final JmaIntensity? localForecastIntensity;
  final String? regionDisplayName;
  final bool hasArrived;

  static const _warningHeaderColor = Color.fromRGBO(179, 26, 26, 1);
  static const _forecastHeaderColor = Color.fromRGBO(204, 102, 13, 1);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final forecastIntensity = eew.forecastIntensity;
    final maxIntensity =
        forecastIntensity?.maxIntensity ?? JmaIntensity.unknown;
    final maxLpgmIntensity = forecastIntensity?.maxLpgmIntensity;

    final headerBackgroundColor = eew.isCanceled
        ? colorScheme.surfaceContainerLowest
        : isWarning
        ? _warningHeaderColor
        : _forecastHeaderColor;

    final showLocalForecast =
        localForecastIntensity != null &&
        regionDisplayName != null &&
        regionDisplayName!.isNotEmpty;

    return Card(
      elevation: 1,
      margin:
          const EdgeInsets.symmetric(horizontal: 12) +
          const EdgeInsets.only(bottom: 8),
      clipBehavior: Clip.antiAlias,
      color: colorScheme.surfaceContainerHighest,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Color.lerp(
            colorScheme.surface,
            colorScheme.outline.withValues(alpha: 0.5),
            0.65,
          )!,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _EewCardHeader(
            eew: eew,
            isWarning: isWarning,
            headerBackgroundColor: headerBackgroundColor,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _EewMaxIntensitySection(maxIntensity: maxIntensity),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _EewHypocenterSection(
                        eew: eew,
                        happenedTime: happenedTime,
                      ),
                    ),
                    if (showLocalForecast) ...[
                      const SizedBox(width: 8),
                      _EewLocalForecastSection(
                        intensity: localForecastIntensity!,
                        regionDisplayName: regionDisplayName!,
                        hasArrived: hasArrived,
                      ),
                    ],
                  ],
                ),
                if (maxLpgmIntensity != null &&
                    maxLpgmIntensity != JmaLpgmIntensity.zero) ...[
                  const SizedBox(height: 12),
                  _EewLpgmSection(intensity: maxLpgmIntensity),
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
  const _EewCardHeader({
    required this.eew,
    required this.isWarning,
    required this.headerBackgroundColor,
  });

  final EewTelegramItem eew;
  final bool isWarning;
  final Color headerBackgroundColor;

  @override
  Widget build(BuildContext context) {
    final typeLabel = isWarning ? '緊急地震速報（警報）' : '緊急地震速報（予報）';

    return DecoratedBox(
      decoration: BoxDecoration(
        color: headerBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 8,
            width: double.infinity,
            child: _EewStripePattern(isWarning: isWarning),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    typeLabel,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: FontFamily.notoSansMono,
                      color: Color(0xB3FFFFFF),
                    ),
                  ),
                ),
                _EewSerialBadge(eew: eew, isWarning: isWarning),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EewSerialBadge extends StatelessWidget {
  const _EewSerialBadge({required this.eew, required this.isWarning});

  final EewTelegramItem eew;
  final bool isWarning;

  static const _warningBadgeColor = Color.fromRGBO(120, 0, 0, 1);
  static const _forecastBadgeColor = Color.fromRGBO(150, 65, 0, 1);

  @override
  Widget build(BuildContext context) {
    final badgeColor = isWarning ? _warningBadgeColor : _forecastBadgeColor;
    final serialLabel = eew.isLastInfo
        ? '#${eew.serialNo}(最終)'
        : '#${eew.serialNo}';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: badgeColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        serialLabel,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          fontFamily: FontFamily.notoSansMono,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _EewMaxIntensitySection extends StatelessWidget {
  const _EewMaxIntensitySection({required this.maxIntensity});

  final JmaIntensity maxIntensity;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '予想震度',
          style: textTheme.labelLarge!.copyWith(
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface.withValues(alpha: 0.85),
          ),
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
    final textTheme = Theme.of(context).textTheme;
    final hypocenter = eew.hypocenter;
    final hypoLabel = eew.isPlum ? '検知観測点' : '震源地';
    final timeLabel = (eew.originTime == null || eew.isPlum) ? '地震検知' : '地震発生';
    final localHappened = happenedTime.toLocal();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.ideographic,
          children: [
            _SecondaryLabel(text: hypoLabel),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                hypocenter?.name ?? '不明',
                style: textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.w800,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        if (eew.isPlum)
          Text(
            'PLUM法による検知',
            style: textTheme.titleSmall!.copyWith(
              fontWeight: FontWeight.bold,
              fontFamily: FontFamily.notoSansMono,
            ),
          )
        else
          Row(
            spacing: 14,
            children: [
              _MagnitudeRow(magnitude: hypocenter?.magnitude),
              _DepthRow(depth: hypocenter?.depth),
            ],
          ),
        const SizedBox(height: 4),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            _SecondaryLabel(text: timeLabel),
            const SizedBox(width: 4),
            Text(
              DateFormat('MM/dd').format(localHappened),
              style: textTheme.labelLarge!.copyWith(
                fontWeight: FontWeight.w600,
                fontFamily: FontFamily.notoSansMono,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              DateFormat('HH:mm:ss').format(localHappened),
              style: textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.bold,
                fontFamily: FontFamily.notoSansMono,
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
    required this.hasArrived,
  });

  final JmaIntensity intensity;
  final String regionDisplayName;
  final bool hasArrived;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.location_on,
              size: 12,
              color: colorScheme.onSurface.withValues(alpha: 0.55),
            ),
            const SizedBox(width: 2),
            Flexible(
              child: Text(
                regionDisplayName,
                style: textTheme.labelSmall!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        if (hasArrived)
          Text(
            '到達済',
            style: textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          )
        else
          JmaForecastIntensityWidget(intensity: intensity),
      ],
    );
  }
}

class _EewLpgmSection extends StatelessWidget {
  const _EewLpgmSection({required this.intensity});

  final JmaLpgmIntensity intensity;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Text('最大LPGM', style: textTheme.labelLarge),
            JmaForecastLgIntensityWidget(intensity: intensity),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '予想最大長周期地震動階級 ${intensity.label}',
                style: textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text('高層階では特に周期の長い揺れに注意してください'),
            ],
          ),
        ),
      ],
    );
  }
}

class _BackgroundIndexText extends StatelessWidget {
  const _BackgroundIndexText({required this.index});

  final String index;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: FittedBox(
        child: Text(
          index,
          style: TextStyle(
            fontSize: 100,
            fontWeight: FontWeight.bold,
            fontFamily: FontFamily.notoSansMono,
            color: textTheme.bodyMedium!.color!.withValues(alpha: 0.3),
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
    final colorScheme = Theme.of(context).colorScheme;

    return Text(
      text,
      style: Theme.of(context).textTheme.labelSmall!.copyWith(
        fontWeight: FontWeight.bold,
        color: colorScheme.onSurface.withValues(alpha: 0.55),
      ),
    );
  }
}

class _MagnitudeRow extends StatelessWidget {
  const _MagnitudeRow({required this.magnitude});

  final double? magnitude;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final secondary = textTheme.titleSmall!.color!.withValues(alpha: 0.55);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          'M',
          style: textTheme.labelSmall!.copyWith(
            fontWeight: FontWeight.bold,
            color: secondary,
          ),
        ),
        if (magnitude != null)
          Text(
            magnitude!.toStringAsFixed(1),
            style: textTheme.headlineSmall!.copyWith(
              fontWeight: FontWeight.bold,
              fontFamily: FontFamily.notoSansMono,
              letterSpacing: -2.5,
            ),
          )
        else
          Text(
            '不明',
            style: textTheme.headlineSmall!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
      ],
    );
  }
}

class _DepthRow extends StatelessWidget {
  const _DepthRow({required this.depth});

  final int? depth;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final secondary = textTheme.titleSmall!.color!.withValues(alpha: 0.55);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          '深さ',
          style: textTheme.labelSmall!.copyWith(
            fontWeight: FontWeight.bold,
            color: secondary,
          ),
        ),
        if (depth == null)
          Text(
            '不明',
            style: textTheme.headlineSmall!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          )
        else if (depth == 0)
          Text(
            'ごく浅い',
            style: textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
          )
        else if (depth! >= 700) ...[
          Text(
            '$depth',
            style: textTheme.headlineSmall!.copyWith(
              fontWeight: FontWeight.bold,
              fontFamily: FontFamily.notoSansMono,
              letterSpacing: -1,
            ),
          ),
          Text(
            ' km以上',
            style: textTheme.labelSmall!.copyWith(
              fontWeight: FontWeight.w500,
              color: secondary,
            ),
          ),
        ] else ...[
          Text(
            '$depth',
            style: textTheme.headlineSmall!.copyWith(
              fontWeight: FontWeight.bold,
              fontFamily: FontFamily.notoSansMono,
              letterSpacing: -1,
            ),
          ),
          Text(
            ' km',
            style: textTheme.labelSmall!.copyWith(
              fontWeight: FontWeight.w500,
              color: secondary,
            ),
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

JmaIntensity? _localForecastIntensity(EewTelegramItem eew, String? regionCode) {
  if (regionCode == null) {
    return null;
  }
  final regions = eew.forecastIntensity?.regions;
  if (regions == null || regions.isEmpty) {
    return null;
  }
  return regions.firstWhereOrNull((r) => r.code == regionCode)?.intensity;
}
