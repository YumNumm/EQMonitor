import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/theme/model/intensity_colors.dart';
import 'package:eqmonitor/core/util/date_time_format.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/model/kyoshin_waveform_trace.dart';
import 'package:material_ui/material_ui.dart';
import 'package:realtime_seismic_intensity/realtime_seismic_intensity.dart';

class const KyoshinWaveformChart({
  required final List<KyoshinWaveformTrace> traces,
  required final String unit,
  required final int samplingRate,
  required final DateTime startTime,
  required final Duration duration,
  final RealtimeIntensitySeries? intensities,
  final Duration? position,
  super.key,
}) extends StatelessWidget {
  static const _bandOpacity = 0.22;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.designSystem.colorTheme.intensity;
    final style = _KyoshinWaveformStyle(
      textStyle: (theme.textTheme.labelSmall ?? const TextStyle()).copyWith(
        color: theme.colorScheme.onSurfaceVariant,
        fontFeatures: const [FontFeature.tabularFigures()],
      ),
      textScaler: MediaQuery.textScalerOf(context),
      traceColor: theme.colorScheme.onSurface,
      axisColor: theme.colorScheme.outline,
      cursorColor: theme.colorScheme.primary,
      intensityBands: [
        for (final (lower, upper, intensity) in _IntensityScale.classes)
          _IntensityBand(
            lower: lower,
            upper: upper,
            color: colors
                .fromJmaIntensity(intensity)
                .background
                .withValues(alpha: _bandOpacity),
          ),
      ],
    );
    final chart = _KyoshinWaveformChartData(
      traces: traces,
      unit: unit,
      samplingRate: samplingRate,
      startTime: startTime,
      duration: duration,
      intensities: intensities,
    );
    final currentPosition = position;
    return Stack(
      fit: StackFit.expand,
      children: [
        RepaintBoundary(
          child: CustomPaint(
            painter: _KyoshinWaveformPainter(chart: chart, style: style),
          ),
        ),
        if (currentPosition != null)
          CustomPaint(
            painter: _KyoshinWaveformCursorPainter(
              chart: chart,
              style: style,
              position: currentPosition,
            ),
          ),
      ],
    );
  }
}

class const _IntensityScale() {
  static const minimum = -1.0;
  static const maximum = 7.0;
  static const ticks = [0, 1, 2, 3, 4, 5, 6, 7];

  // 計測震度の階級の境界（気象庁震度階級）。
  static const classes = <(double, double, JmaIntensity)>[
    (minimum, 0.5, JmaIntensity.zero),
    (0.5, 1.5, JmaIntensity.one),
    (1.5, 2.5, JmaIntensity.two),
    (2.5, 3.5, JmaIntensity.three),
    (3.5, 4.5, JmaIntensity.four),
    (4.5, 5.0, JmaIntensity.fiveLower),
    (5.0, 5.5, JmaIntensity.fiveUpper),
    (5.5, 6.0, JmaIntensity.sixLower),
    (6.0, 6.5, JmaIntensity.sixUpper),
    (6.5, maximum, JmaIntensity.seven),
  ];
}

class const _IntensityBand({
  required final double lower,
  required final double upper,
  required final Color color,
}) {
  @override
  bool operator ==(Object other) =>
      other is _IntensityBand &&
      other.lower == lower &&
      other.upper == upper &&
      other.color == color;

  @override
  int get hashCode => Object.hash(lower, upper, color);
}

class const _KyoshinWaveformChartData({
  required final List<KyoshinWaveformTrace> traces,
  required final String unit,
  required final int samplingRate,
  required final DateTime startTime,
  required final Duration duration,
  required final RealtimeIntensitySeries? intensities,
}) {
  @override
  bool operator ==(Object other) =>
      other is _KyoshinWaveformChartData &&
      identical(other.traces, traces) &&
      other.unit == unit &&
      other.samplingRate == samplingRate &&
      other.startTime == startTime &&
      other.duration == duration &&
      identical(other.intensities, intensities);

  @override
  int get hashCode => Object.hash(
    identityHashCode(traces),
    unit,
    samplingRate,
    startTime,
    duration,
    identityHashCode(intensities),
  );
}

class const _KyoshinWaveformStyle({
  required final TextStyle textStyle,
  required final TextScaler textScaler,
  required final Color traceColor,
  required final Color axisColor,
  required final Color cursorColor,
  required final List<_IntensityBand> intensityBands,
}) {
  TextPainter text(String value) => TextPainter(
    text: TextSpan(text: value, style: textStyle),
    textDirection: TextDirection.ltr,
    textScaler: textScaler,
  )..layout();

  Size measure(String value) {
    final painter = text(value);
    final size = painter.size;
    painter.dispose();
    return size;
  }

  @override
  bool operator ==(Object other) =>
      other is _KyoshinWaveformStyle &&
      other.textStyle == textStyle &&
      other.textScaler == textScaler &&
      other.traceColor == traceColor &&
      other.axisColor == axisColor &&
      other.cursorColor == cursorColor &&
      const ListEquality<_IntensityBand>().equals(
        other.intensityBands,
        intensityBands,
      );

  @override
  int get hashCode => Object.hash(
    textStyle,
    textScaler,
    traceColor,
    axisColor,
    cursorColor,
    Object.hashAll(intensityBands),
  );
}

class _KyoshinWaveformLayout({
  required final _KyoshinWaveformChartData chart,
  required final _KyoshinWaveformStyle style,
  required final Size size,
}) {
  static const gap = 8.0;
  static const tickLength = 4.0;
  static const intensityWeight = 1.5;
  static const intensityLabel = 'リアルタイム震度';

  late final List<String> peakLabels = [
    for (final trace in chart.traces)
      '${_formatPeak(trace.peakAbsolute)} ${chart.unit}',
  ];

  late final double _labelWidth = [
    for (final label in peakLabels) style.measure('-$label').width,
    for (final trace in chart.traces)
      style.measure(trace.component.label).width,
    if (chart.intensities != null)
      style.measure(intensityLabel).width + style.measure('7').width + gap,
  ].fold(0, max);

  late final double lineHeight = style.measure('0').height;

  late final Rect plot = Rect.fromLTRB(
    _labelWidth + gap * 2,
    0,
    size.width - style.measure('[s]').width,
    size.height - tickLength - lineHeight * 2 - gap,
  );

  late final double _weights =
      chart.traces.length + (chart.intensities == null ? 0 : intensityWeight);

  late final double bandHeight = _weights == 0 ? 0 : plot.height / _weights;

  late final double durationSeconds =
      chart.duration.inMicroseconds / Duration.microsecondsPerSecond;

  double xOf(double seconds) =>
      plot.left + plot.width * (seconds / max(durationSeconds, 1e-9));

  // 上下の振幅ラベルが隣の成分と重ならないよう、各成分の間に1行分の間隔を空ける。
  Rect traceArea(int index) => Rect.fromLTRB(
    plot.left,
    plot.top + bandHeight * index + lineHeight / 2 + 1,
    plot.right,
    plot.top + bandHeight * (index + 1) - lineHeight / 2 - 1,
  );

  Rect get intensityArea => Rect.fromLTRB(
    plot.left,
    plot.top + bandHeight * chart.traces.length + lineHeight / 2 + 1,
    plot.right,
    plot.bottom - 1,
  );

  int get tickSeconds {
    const candidates = [1, 2, 5, 10, 20, 30, 60, 120, 300, 600];
    final labelWidth =
        style.measure('${durationSeconds.ceil()}').width + gap * 2;
    final maxTicks = max(1, plot.width ~/ labelWidth);
    return candidates.firstWhere(
      (seconds) => durationSeconds / seconds <= maxTicks,
      orElse: () => candidates.last,
    );
  }

  String _formatPeak(double value) => switch (value) {
    >= 100 => value.toStringAsFixed(1),
    >= 1 => value.toStringAsFixed(2),
    _ => value.toStringAsFixed(4),
  };
}

class const _KyoshinWaveformPainter({
  required final _KyoshinWaveformChartData chart,
  required final _KyoshinWaveformStyle style,
}) extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final layout = _KyoshinWaveformLayout(
      chart: chart,
      style: style,
      size: size,
    );
    if (layout.plot.width <= 0 || layout.bandHeight <= 0) {
      return;
    }
    final axisPaint = Paint()
      ..color = style.axisColor
      ..strokeWidth = 1;
    final baselinePaint = Paint()
      ..color = style.axisColor.withValues(alpha: 0.4)
      ..strokeWidth = 1;
    final tracePaint = Paint()
      ..color = style.traceColor
      ..strokeWidth = 1;
    for (var index = 0; index < chart.traces.length; index++) {
      _paintTrace(
        canvas: canvas,
        layout: layout,
        index: index,
        axisPaint: axisPaint,
        baselinePaint: baselinePaint,
        tracePaint: tracePaint,
      );
    }
    final intensities = chart.intensities;
    if (intensities != null) {
      _paintIntensities(
        canvas: canvas,
        layout: layout,
        intensities: intensities,
        axisPaint: axisPaint,
      );
    }
    _paintTimeAxis(canvas: canvas, layout: layout, axisPaint: axisPaint);
  }

  void _paintVerticalAxis({
    required Canvas canvas,
    required Rect area,
    required Paint axisPaint,
  }) {
    final axisX = area.left - _KyoshinWaveformLayout.gap;
    canvas
      ..drawLine(Offset(axisX, area.top), Offset(axisX, area.bottom), axisPaint)
      ..drawLine(
        Offset(axisX - _KyoshinWaveformLayout.tickLength, area.top),
        Offset(axisX, area.top),
        axisPaint,
      )
      ..drawLine(
        Offset(axisX - _KyoshinWaveformLayout.tickLength, area.bottom),
        Offset(axisX, area.bottom),
        axisPaint,
      );
  }

  void _paintTrace({
    required Canvas canvas,
    required _KyoshinWaveformLayout layout,
    required int index,
    required Paint axisPaint,
    required Paint baselinePaint,
    required Paint tracePaint,
  }) {
    final trace = chart.traces[index];
    final band = layout.traceArea(index);
    final axisX = band.left - _KyoshinWaveformLayout.gap;
    _paintVerticalAxis(canvas: canvas, area: band, axisPaint: axisPaint);
    canvas.drawLine(
      Offset(axisX, band.center.dy),
      Offset(band.right, band.center.dy),
      baselinePaint,
    );
    final peakLabel = layout.peakLabels[index];
    final labelRight = axisX - _KyoshinWaveformLayout.gap;
    _paintText(canvas, peakLabel, Offset(labelRight, band.top), _Anchor.right);
    _paintText(
      canvas,
      '-$peakLabel',
      Offset(labelRight, band.bottom),
      _Anchor.right,
    );
    _paintText(
      canvas,
      trace.component.label,
      Offset(labelRight, band.center.dy),
      _Anchor.right,
    );
    final points = _KyoshinWaveformEnvelope(
      samples: trace.samples,
      peak: trace.peakAbsolute,
      band: band,
      sampleCount: (layout.durationSeconds * chart.samplingRate).round(),
    ).points();
    canvas.drawRawPoints(PointMode.lines, points, tracePaint);
  }

  void _paintIntensities({
    required Canvas canvas,
    required _KyoshinWaveformLayout layout,
    required RealtimeIntensitySeries intensities,
    required Paint axisPaint,
  }) {
    final area = layout.intensityArea;
    if (area.height <= 0) {
      return;
    }
    double yOf(double value) =>
        area.bottom -
        area.height *
            ((value.clamp(_IntensityScale.minimum, _IntensityScale.maximum) -
                    _IntensityScale.minimum) /
                (_IntensityScale.maximum - _IntensityScale.minimum));
    for (final band in style.intensityBands) {
      canvas.drawRect(
        Rect.fromLTRB(area.left, yOf(band.upper), area.right, yOf(band.lower)),
        Paint()..color = band.color,
      );
    }
    _paintVerticalAxis(canvas: canvas, area: area, axisPaint: axisPaint);
    final axisX = area.left - _KyoshinWaveformLayout.gap;
    final labelRight = axisX - _KyoshinWaveformLayout.gap;
    final tickStep = area.height / 8 < layout.lineHeight ? 2 : 1;
    for (final tick in _IntensityScale.ticks) {
      if (tick % tickStep != 0 && tick != _IntensityScale.ticks.last) {
        continue;
      }
      final y = yOf(tick.toDouble());
      canvas.drawLine(
        Offset(axisX - _KyoshinWaveformLayout.tickLength, y),
        Offset(axisX, y),
        axisPaint,
      );
      _paintText(canvas, '$tick', Offset(labelRight, y), _Anchor.right);
    }
    _paintText(
      canvas,
      _KyoshinWaveformLayout.intensityLabel,
      Offset(
        labelRight - style.measure('7').width - _KyoshinWaveformLayout.gap,
        area.center.dy,
      ),
      _Anchor.right,
    );
    final path = Path();
    var drawing = false;
    final stepSeconds =
        intensities.interval.inMicroseconds / Duration.microsecondsPerSecond;
    final offsetSeconds =
        intensities.startTime.difference(chart.startTime).inMicroseconds /
        Duration.microsecondsPerSecond;
    for (var i = 0; i < intensities.values.length; i++) {
      final value = intensities.values[i];
      if (value == null) {
        drawing = false;
        continue;
      }
      final x0 = layout.xOf(offsetSeconds + (i + 1) * stepSeconds);
      final x1 = layout.xOf(offsetSeconds + (i + 2) * stepSeconds);
      final y = yOf(value);
      if (drawing) {
        path.lineTo(x0, y);
      } else {
        path.moveTo(x0, y);
        drawing = true;
      }
      path.lineTo(min(x1, area.right), y);
    }
    canvas
      ..save()
      ..clipRect(area)
      ..drawPath(
        path,
        Paint()
          ..color = style.traceColor
          ..strokeWidth = 1.5
          ..style = PaintingStyle.stroke,
      )
      ..restore();
  }

  void _paintTimeAxis({
    required Canvas canvas,
    required _KyoshinWaveformLayout layout,
    required Paint axisPaint,
  }) {
    final plot = layout.plot;
    canvas.drawLine(
      Offset(plot.left, plot.bottom),
      Offset(plot.right, plot.bottom),
      axisPaint,
    );
    final tick = layout.tickSeconds;
    for (var seconds = 0; seconds <= layout.durationSeconds; seconds += tick) {
      final x = layout.xOf(seconds.toDouble());
      canvas.drawLine(
        Offset(x, plot.bottom),
        Offset(x, plot.bottom + _KyoshinWaveformLayout.tickLength),
        axisPaint,
      );
      _paintText(
        canvas,
        '$seconds',
        Offset(x, plot.bottom + _KyoshinWaveformLayout.tickLength),
        _Anchor.top,
      );
    }
    final secondRow =
        plot.bottom + _KyoshinWaveformLayout.tickLength + layout.lineHeight;
    _paintText(
      canvas,
      chart.startTime.formatWithTz(
        DateTimeFormat.yearMonthDayHourMinuteSecondHyphen,
      ),
      Offset(plot.left, secondRow),
      _Anchor.topLeft,
    );
    _paintText(canvas, '[s]', Offset(plot.right, secondRow), _Anchor.topLeft);
  }

  void _paintText(Canvas canvas, String value, Offset at, _Anchor anchor) {
    final painter = style.text(value);
    final offset = switch (anchor) {
      _Anchor.right => at - Offset(painter.width, painter.height / 2),
      _Anchor.top => at - Offset(painter.width / 2, 0),
      _Anchor.topLeft => at,
    };
    painter
      ..paint(canvas, offset)
      ..dispose();
  }

  @override
  bool shouldRepaint(covariant _KyoshinWaveformPainter oldDelegate) =>
      oldDelegate.chart != chart || oldDelegate.style != style;
}

enum _Anchor { right, top, topLeft }

class const _KyoshinWaveformCursorPainter({
  required final _KyoshinWaveformChartData chart,
  required final _KyoshinWaveformStyle style,
  required final Duration position,
}) extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final layout = _KyoshinWaveformLayout(
      chart: chart,
      style: style,
      size: size,
    );
    final seconds = position.inMicroseconds / Duration.microsecondsPerSecond;
    if (seconds < 0 || seconds > layout.durationSeconds) {
      return;
    }
    final x = layout.xOf(seconds);
    canvas.drawLine(
      Offset(x, layout.plot.top),
      Offset(x, layout.plot.bottom),
      Paint()
        ..color = style.cursorColor
        ..strokeWidth = 1.5,
    );
  }

  @override
  bool shouldRepaint(covariant _KyoshinWaveformCursorPainter oldDelegate) =>
      oldDelegate.position != position ||
      oldDelegate.chart != chart ||
      oldDelegate.style != style;
}

// 描画幅より多いサンプルは、1ピクセルごとの最小値と最大値を結ぶ縦線にまとめる。
class const _KyoshinWaveformEnvelope({
  required final Float64List samples,
  required final double peak,
  required final Rect band,
  required final int sampleCount,
}) {
  Float32List points() {
    final columns = max(1, band.width.floor());
    final left = band.left.floorToDouble() + 0.5;
    final scale = peak > 0 ? band.height / 2 / peak : 0.0;
    final center = band.center.dy;
    final result = Float32List(columns * 4);
    var previous = samples.isEmpty ? 0.0 : samples.first;
    for (var column = 0; column < columns; column++) {
      final start = column * sampleCount ~/ columns;
      final end = min(
        samples.length,
        max(start + 1, (column + 1) * sampleCount ~/ columns),
      );
      var low = previous;
      var high = previous;
      for (var i = start; i < end; i++) {
        final value = samples[i];
        low = min(low, value);
        high = max(high, value);
      }
      if (end > start) {
        previous = samples[end - 1];
      }
      final x = left + column;
      result
        ..[column * 4] = x
        ..[column * 4 + 1] = center - high * scale
        ..[column * 4 + 2] = x
        ..[column * 4 + 3] = center - low * scale;
    }
    return result;
  }
}
