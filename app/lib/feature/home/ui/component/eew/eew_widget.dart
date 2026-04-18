import 'package:collection/collection.dart';
import 'package:eqmonitor/core/component/intenisty/jma_forecast_intensity_icon.dart';
import 'package:eqmonitor/core/component/intenisty/jma_forecast_lg_intensity_icon.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/core/provider/time_ticker.dart';
import 'package:eqmonitor/core/provider/travel_time/model/travel_time_table.dart';
import 'package:eqmonitor/core/provider/travel_time/provider/travel_time_provider.dart';
import 'package:eqmonitor/core/theme/build_theme.dart';
import 'package:eqmonitor/feature/eew/data/eew_alive_telegram.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/location/data/location.dart';
import 'package:eqmonitor/feature/location/data/nearest_jma_feature.dart';
import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lat_lng/lat_lng.dart' as lat_lng;
import 'package:latlong2/latlong.dart' as latlong2;

class EewWidgets extends ConsumerWidget {
  const EewWidgets({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(eewAliveTelegramProvider) ?? [];

    return Column(
      children: state.reversed
          .mapIndexed(
            (index, element) => EewWidget(
              eew: element,
              index: (state.length > 1) ? '${index + 1}' : null,
            ),
          )
          .toList(),
    );
  }
}

class EewWidget extends ConsumerWidget {
  const EewWidget({required this.eew, required this.index, super.key});

  final EewTelegramItem eew;
  final String? index;

  static const _warningHeaderColor = Color.fromRGBO(179, 26, 26, 1);
  static const _forecastHeaderColor = Color.fromRGBO(204, 102, 13, 1);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorTheme = theme.colorScheme;
    final intensityColorScheme = ref.watch(intensityColorProvider);
    ref.watch(timeTickerProvider(const Duration(seconds: 1)));

    if (eew.isCanceled) {
      return BorderedContainer(
        elevation: 1,
        margin:
            const EdgeInsets.symmetric(horizontal: 12) +
            const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Text(eew.headline ?? '先ほどの緊急地震速報は取り消されました'),
          ),
        ),
      );
    }

    final forecastIntensity = eew.forecastIntensity;
    final maxIntensity =
        forecastIntensity?.maxIntensity ?? JmaIntensity.unknown;
    final intensityScheme = intensityColorScheme.fromJmaIntensity(
      maxIntensity,
    );
    final (_, backgroundColor) = (
      intensityScheme.foreground,
      intensityScheme.background,
    );

    final isWarning = eew.isWarningOrFallback;
    final headerBg = isWarning ? _warningHeaderColor : _forecastHeaderColor;

    final happenedTime = eew.originTime ?? eew.arrivalTime;
    if (happenedTime == null) {
      return const SizedBox.shrink();
    }

    final positionAsync = ref.watch(locationStreamProvider);
    final travelTimeAsync = ref.watch(travelTimeProvider);
    final position = positionAsync.valueOrNull;
    final regionItem = position != null
        ? ref
            .watch(
              jmaMapAreaForecastLocalEewInsideProvider(
                lat_lng.LatLng(lat: position.latitude, lon: position.longitude),
              ),
            )
            .valueOrNull
        : null;

    final regionCode = regionItem?.property.code;
    final localForecastIntensity = _localForecastIntensity(eew, regionCode);
    final regionDisplayName = regionItem?.property.name;

    DateTime? mainMotionArrivalUtc;
    if (position != null &&
        travelTimeAsync.table.isNotEmpty &&
        eew.originTime != null &&
        eew.hypocenter?.hasLatLng == true &&
        eew.hypocenter?.depth != null) {
      final hypo = eew.hypocenter!;
      final tables = TravelTimeTables(table: travelTimeAsync.table);
      mainMotionArrivalUtc = _estimateMainMotionArrivalUtc(
        originTimeUtc: eew.originTime!.toUtc(),
        depth: hypo.depth!,
        hypoLat: hypo.latitude!,
        hypoLng: hypo.longitude!,
        userLat: position.latitude,
        userLng: position.longitude,
        tables: tables,
        nowUtc: DateTime.now().toUtc(),
      );
    }

    final typeSerialLabel = _eewTypeLabelWithSerial(eew, isWarning);
    final headlineHalf = eew.headline?.toString().toHalfWidth;
    final headlineMain = headlineHalf != null
        ? (headlineHalf.split('で地震 ').getOrNull(1) ?? headlineHalf)
        : null;

    final hypocenter = eew.hypocenter;
    final hypoLabel = eew.isPlum ? '検知観測点' : '震源地';
    final timeLabel =
        (eew.originTime == null || eew.isPlum) ? '地震検知' : '地震発生';
    final localHappened = happenedTime.toLocal();

    final maxIntensityWidget = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '最大震度',
          style: textTheme.labelLarge!.copyWith(
            fontWeight: FontWeight.w600,
            color: colorTheme.onSurface.withValues(alpha: 0.85),
          ),
        ),
        const SizedBox(height: 2),
        JmaForecastIntensityWidget(size: 50, intensity: maxIntensity),
      ],
    );

    final detailsColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.ideographic,
          children: [
            _eewSecondaryLabel(context, hypoLabel),
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
        else ...[
          Row(
            spacing: 14,
            children: [
              _magnitudeRow(context, hypocenter?.magnitude),
              _depthRow(context, hypocenter?.depth),
            ],
          ),
        ],
        const SizedBox(height: 4),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            _eewSecondaryLabel(context, timeLabel),
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

    Widget? localForecastColumn;
    if (localForecastIntensity != null &&
        regionDisplayName != null &&
        regionDisplayName.isNotEmpty) {
      localForecastColumn = Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.location_on,
                size: 12,
                color: colorTheme.onSurface.withValues(alpha: 0.55),
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
          JmaForecastIntensityWidget(
            size: 50,
            intensity: localForecastIntensity,
          ),
        ],
      );
    }

    final maxLpgmIntensity = forecastIntensity?.maxLpgmIntensity;

    final card = Card(
      elevation: 1,
      margin:
          const EdgeInsets.symmetric(horizontal: 12) +
          const EdgeInsets.only(bottom: 8),
      clipBehavior: Clip.antiAlias,
      color: colorTheme.surfaceContainerHighest,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Color.lerp(
            backgroundColor,
            colorTheme.outline.withValues(alpha: 0.5),
            0.65,
          )!,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              SizedBox(
                height: 8,
                width: double.infinity,
                child: _EewStripePattern(isWarning: isWarning),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            typeSerialLabel,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              fontFamily: FontFamily.notoSansMono,
                              color: Color(0xB3FFFFFF),
                            ),
                          ),
                          if (headlineMain != null && headlineMain.isNotEmpty)
                            Text(
                              headlineMain,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                        ],
                      ),
                    ),
                    if (mainMotionArrivalUtc != null)
                      _MainMotionCountdown(
                        arrivalUtc: mainMotionArrivalUtc,
                        nowUtc: DateTime.now().toUtc(),
                      ),
                  ],
                ),
              ),
            ],
          )
              .decorated(
                decoration: BoxDecoration(
                  color: headerBg,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
              ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    maxIntensityWidget,
                    const SizedBox(width: 10),
                    Expanded(child: detailsColumn),
                    if (localForecastColumn != null) ...[
                      const SizedBox(width: 8),
                      localForecastColumn,
                    ],
                  ],
                ),
                if (maxLpgmIntensity != null &&
                    maxLpgmIntensity != JmaLpgmIntensity.zero) ...[
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Text(
                            '最大LPGM',
                            style: textTheme.labelLarge,
                          ),
                          JmaForecastLgIntensityWidget(
                            intensity: maxLpgmIntensity,
                          ),
                        ],
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '予想最大長周期地震動階級 ${maxLpgmIntensity.label}',
                              style: textTheme.titleMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              '高層階では特に周期の長い揺れに注意してください',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );

    return Stack(
      alignment: Alignment.center,
      children: [
        if (index != null)
          Center(
            child: FittedBox(
              child: Text(
                index.toString(),
                style: TextStyle(
                  fontSize: 100,
                  fontWeight: FontWeight.bold,
                  fontFamily: monoFont,
                  color: textTheme.bodyMedium!.color!.withValues(alpha: 0.3),
                ),
              ),
            ),
          ),
        card,
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

String _eewTypeLabelWithSerial(EewTelegramItem eew, bool isWarning) {
  final typeLabel = isWarning ? '緊急地震速報(警報)' : '緊急地震速報(予報)';
  if (eew.isLastInfo) {
    return '$typeLabel 第${eew.serialNo}報(最終)';
  }
  return '$typeLabel 第${eew.serialNo}報';
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

Widget _eewSecondaryLabel(BuildContext context, String text) {
  final color = Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.55);
  return Text(
    text,
    style: Theme.of(context).textTheme.labelSmall!.copyWith(
          fontWeight: FontWeight.bold,
          color: color,
        ),
  );
}

Widget _magnitudeRow(BuildContext context, double? magnitude) {
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
          magnitude.toStringAsFixed(1),
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

Widget _depthRow(BuildContext context, int? depth) {
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
      else if (depth >= 700) ...[
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

DateTime? _estimateMainMotionArrivalUtc({
  required DateTime originTimeUtc,
  required int depth,
  required double hypoLat,
  required double hypoLng,
  required double userLat,
  required double userLng,
  required TravelTimeTables tables,
  required DateTime nowUtc,
}) {
  const distance = latlong2.Distance();
  final distKm = distance.as(
    latlong2.LengthUnit.Kilometer,
    latlong2.LatLng(hypoLat, hypoLng),
    latlong2.LatLng(userLat, userLng),
  );
  if (distKm <= 0) {
    return null;
  }

  double? sAt(double t) => tables.getValue(depth, t).sDistance;

  final elapsed = nowUtc.difference(originTimeUtc).inMilliseconds / 1000.0;
  if (elapsed < 0) {
    return null;
  }

  final current = sAt(elapsed);
  if (current != null && current >= distKm) {
    return null;
  }

  var lo = elapsed;
  var hi = 2000.0;
  final hiStart = sAt(hi);
  if (hiStart == null || hiStart < distKm) {
    return null;
  }

  for (var i = 0; i < 56; i++) {
    final mid = (lo + hi) / 2;
    final sd = sAt(mid);
    if (sd == null) {
      hi = mid;
      continue;
    }
    if (sd >= distKm) {
      hi = mid;
    } else {
      lo = mid;
    }
  }

  return originTimeUtc.add(Duration(milliseconds: (hi * 1000).round()));
}

class _MainMotionCountdown extends StatelessWidget {
  const _MainMotionCountdown({
    required this.arrivalUtc,
    required this.nowUtc,
  });

  final DateTime arrivalUtc;
  final DateTime nowUtc;

  @override
  Widget build(BuildContext context) {
    if (!arrivalUtc.isAfter(nowUtc)) {
      return const SizedBox.shrink();
    }
    final diff = arrivalUtc.difference(nowUtc);
    final totalSec = diff.inSeconds;
    final m = totalSec ~/ 60;
    final s = totalSec % 60;
    final text =
        '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '主要動到達まで',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: Colors.white.withValues(alpha: 0.7),
          ),
        ),
        Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w900,
            fontFamily: FontFamily.notoSansMono,
            color: Colors.white,
            letterSpacing: -0.5,
          ),
        ),
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
      final colorIndex =
          ((x + h) / stripeWidth).floor().abs() % colors.length;
      final paint = Paint()..color = colors[colorIndex];
      canvas.drawPath(path, paint);
      x += stripeWidth;
    }
  }

  @override
  bool shouldRepaint(covariant _StripePainter oldDelegate) {
    return oldDelegate.colors != colors;
  }
}

extension on Widget {
  Widget decorated({required BoxDecoration decoration}) {
    return DecoratedBox(
      decoration: decoration,
      child: this,
    );
  }
}
