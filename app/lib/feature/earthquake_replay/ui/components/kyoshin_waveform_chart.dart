import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:eqmonitor/core/util/date_time_format.dart';
import 'package:kyoshin_waveform/kyoshin_waveform.dart';
import 'package:material_ui/material_ui.dart';

class const KyoshinWaveformChart({
  required final KyoshinWaveformRecord record,
  final Duration? position,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = _KyoshinWaveformStyle(
      textStyle: (theme.textTheme.labelSmall ?? const TextStyle()).copyWith(
        color: theme.colorScheme.onSurfaceVariant,
        fontFeatures: const [FontFeature.tabularFigures()],
      ),
      textScaler: MediaQuery.textScalerOf(context),
      traceColor: theme.colorScheme.onSurface,
      axisColor: theme.colorScheme.outline,
      cursorColor: theme.colorScheme.primary,
    );
    final currentPosition = position;
    return Stack(
      fit: StackFit.expand,
      children: [
        RepaintBoundary(
          child: CustomPaint(
            painter: _KyoshinWaveformPainter(record: record, style: style),
          ),
        ),
        if (currentPosition != null)
          CustomPaint(
            painter: _KyoshinWaveformCursorPainter(
              record: record,
              style: style,
              position: currentPosition,
            ),
          ),
      ],
    );
  }
}

class const _KyoshinWaveformStyle({
  required final TextStyle textStyle,
  required final TextScaler textScaler,
  required final Color traceColor,
  required final Color axisColor,
  required final Color cursorColor,
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
      other.cursorColor == cursorColor;

  @override
  int get hashCode =>
      Object.hash(textStyle, textScaler, traceColor, axisColor, cursorColor);
}

class _KyoshinWaveformLayout({
  required final KyoshinWaveformRecord record,
  required final _KyoshinWaveformStyle style,
  required final Size size,
}) {
  static const gap = 8.0;
  static const tickLength = 4.0;

  late final List<String> peakLabels = [
    for (final channel in record.channels)
      '${channel.peakAbsoluteGal.toStringAsFixed(3)} gal',
  ];

  late final double _labelWidth = [
    for (final label in peakLabels) style.measure('-$label').width,
    for (final channel in record.channels)
      style.measure(channel.component.label).width,
  ].fold(0, max);

  late final double lineHeight = style.measure('0').height;

  late final Rect plot = Rect.fromLTRB(
    _labelWidth + gap * 2,
    0,
    size.width - style.measure('[s]').width,
    size.height - tickLength - lineHeight * 2 - gap,
  );

  late final double bandHeight = record.channels.isEmpty
      ? 0
      : plot.height / record.channels.length;

  late final double durationSeconds =
      record.duration.inMicroseconds / Duration.microsecondsPerSecond;

  double xOf(double seconds) =>
      plot.left + plot.width * (seconds / max(durationSeconds, 1e-9));

  // 上下の振幅ラベルが隣の成分と重ならないよう、各成分の間に1行分の間隔を空ける。
  Rect traceArea(int index) => Rect.fromLTRB(
    plot.left,
    plot.top + bandHeight * index + lineHeight / 2 + 1,
    plot.right,
    plot.top + bandHeight * (index + 1) - lineHeight / 2 - 1,
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
}

class const _KyoshinWaveformPainter({
  required final KyoshinWaveformRecord record,
  required final _KyoshinWaveformStyle style,
}) extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final layout = _KyoshinWaveformLayout(
      record: record,
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
    for (var index = 0; index < record.channels.length; index++) {
      _paintChannel(
        canvas: canvas,
        layout: layout,
        index: index,
        axisPaint: axisPaint,
        baselinePaint: baselinePaint,
        tracePaint: tracePaint,
      );
    }
    _paintTimeAxis(canvas: canvas, layout: layout, axisPaint: axisPaint);
  }

  void _paintChannel({
    required Canvas canvas,
    required _KyoshinWaveformLayout layout,
    required int index,
    required Paint axisPaint,
    required Paint baselinePaint,
    required Paint tracePaint,
  }) {
    final channel = record.channels[index];
    final band = layout.traceArea(index);
    final axisX = band.left - _KyoshinWaveformLayout.gap;
    canvas
      ..drawLine(Offset(axisX, band.top), Offset(axisX, band.bottom), axisPaint)
      ..drawLine(
        Offset(axisX - _KyoshinWaveformLayout.tickLength, band.top),
        Offset(axisX, band.top),
        axisPaint,
      )
      ..drawLine(
        Offset(axisX - _KyoshinWaveformLayout.tickLength, band.bottom),
        Offset(axisX, band.bottom),
        axisPaint,
      )
      ..drawLine(
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
      channel.component.label,
      Offset(labelRight, band.center.dy),
      _Anchor.right,
    );
    final points = _KyoshinWaveformEnvelope(
      samples: channel.accelerationGal,
      peak: channel.peakAbsoluteGal,
      band: band,
      sampleCount: (layout.durationSeconds * record.samplingRate).round(),
    ).points();
    canvas.drawRawPoints(PointMode.lines, points, tracePaint);
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
      record.startTime.formatWithTz(
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
      oldDelegate.record != record || oldDelegate.style != style;
}

enum _Anchor { right, top, topLeft }

class const _KyoshinWaveformCursorPainter({
  required final KyoshinWaveformRecord record,
  required final _KyoshinWaveformStyle style,
  required final Duration position,
}) extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final layout = _KyoshinWaveformLayout(
      record: record,
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
      oldDelegate.record != record ||
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
