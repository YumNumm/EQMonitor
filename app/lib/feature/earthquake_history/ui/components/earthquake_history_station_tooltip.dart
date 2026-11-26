import 'package:eqmonitor/core/component/intenisty/jma_intensity_icon.dart';
import 'package:eqmonitor/core/component/intenisty/jma_lpgm_intensity_icon.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_station_selection.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/shindo_db_intensity_class_icon.dart';
import 'package:maplibre/maplibre.dart';
import 'package:material_ui/material_ui.dart';

class const EarthquakeHistoryStationTooltip({
  required final EarthquakeHistoryStationSelection selection,
  required final VoidCallback onTap,
  super.key,
}) extends StatelessWidget {
  static const _anchorGap = 14.0;
  static const _arrowSize = Size(16, 8);
  static const _screenMargin = 8.0;
  static const _flipThreshold = 96.0;

  @override
  Widget build(BuildContext context) {
    final controller = MapController.maybeOf(context);
    final camera = CameraPosition.maybeOf(context);
    if (controller == null || camera == null) {
      return const SizedBox.shrink();
    }
    final anchor = controller.toScreenLocation(selection.point);
    final below = anchor.dy < _flipThreshold;
    final color = context.designSystem.colorTheme.surfaceContainerHigh;

    return SizedBox.expand(
      child: CustomMultiChildLayout(
        delegate: _TooltipLayoutDelegate(
          anchor: anchor,
          below: below,
          anchorGap: _anchorGap,
          arrowSize: _arrowSize,
          screenMargin: _screenMargin,
        ),
        children: [
          LayoutId(
            id: _TooltipSlot.arrow,
            child: CustomPaint(
              size: _arrowSize,
              painter: _ArrowPainter(color: color, pointsDown: !below),
            ),
          ),
          LayoutId(
            id: _TooltipSlot.bubble,
            child: _Bubble(selection: selection, color: color, onTap: onTap),
          ),
        ],
      ),
    );
  }
}

enum _TooltipSlot { arrow, bubble }

class _TooltipLayoutDelegate({
  required final Offset anchor,
  required final bool below,
  required final double anchorGap,
  required final Size arrowSize,
  required final double screenMargin,
}) extends MultiChildLayoutDelegate {
  @override
  void performLayout(Size size) {
    final arrow = layoutChild(
      _TooltipSlot.arrow,
      BoxConstraints.tight(arrowSize),
    );
    final maxWidth = (size.width - screenMargin * 2).clamp(0.0, 320.0);
    final bubble = layoutChild(
      _TooltipSlot.bubble,
      BoxConstraints(maxWidth: maxWidth),
    );

    final arrowTop = below
        ? anchor.dy + anchorGap
        : anchor.dy - anchorGap - arrow.height;
    positionChild(
      _TooltipSlot.arrow,
      Offset(anchor.dx - arrow.width / 2, arrowTop),
    );

    final minLeft = screenMargin;
    final maxLeft = size.width - screenMargin - bubble.width;
    final left = maxLeft < minLeft
        ? minLeft
        : (anchor.dx - bubble.width / 2).clamp(minLeft, maxLeft);
    final top = below
        ? arrowTop + arrow.height - 0.5
        : arrowTop - bubble.height + 0.5;
    positionChild(_TooltipSlot.bubble, Offset(left, top));
  }

  @override
  bool shouldRelayout(_TooltipLayoutDelegate oldDelegate) =>
      anchor != oldDelegate.anchor ||
      below != oldDelegate.below ||
      anchorGap != oldDelegate.anchorGap ||
      arrowSize != oldDelegate.arrowSize ||
      screenMargin != oldDelegate.screenMargin;
}

class const _ArrowPainter({
  required final Color color,
  required final bool pointsDown,
}) extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = pointsDown
        ? (Path()
            ..moveTo(0, 0)
            ..lineTo(size.width, 0)
            ..lineTo(size.width / 2, size.height)
            ..close())
        : (Path()
            ..moveTo(0, size.height)
            ..lineTo(size.width, size.height)
            ..lineTo(size.width / 2, 0)
            ..close());
    canvas.drawPath(path, Paint()..color = color);
  }

  @override
  bool shouldRepaint(_ArrowPainter oldDelegate) =>
      color != oldDelegate.color || pointsDown != oldDelegate.pointsDown;
}

class const _Bubble({
  required final EarthquakeHistoryStationSelection selection,
  required final Color color,
  required final VoidCallback onTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorTheme = context.designSystem.colorTheme;
    final theme = Theme.of(context);
    final (:icons, :name, :subtitle) = switch (selection) {
      EarthquakeHistoryShindoDbStationSelection(:final station) => (
        icons: <Widget>[
          ShindoDbIntensityClassIcon(
            intensityClass: station.record.intensityClass,
            size: 32,
          ),
        ],
        name: station.name,
        subtitle: switch (station.record.instrumentalIntensity) {
          final value? => '計測震度 ${value.toStringAsFixed(1)}',
          null => station.record.intensityClass.historicalDescription,
        },
      ),
      EarthquakeHistoryJmaStationSelection(
        :final station,
        :final showingLpgmIntensity,
      ) =>
        (
          icons: <Widget>[
            if (station.intensity?.maxIntensity case final intensity?)
              JmaIntensityIcon(intensity: intensity, type: .filled, size: 32),
            if (showingLpgmIntensity)
              if (station.intensity?.maxLpgmIntensity case final lpgm?)
                JmaLpgmIntensityIcon(intensity: lpgm, type: .filled, size: 32),
          ],
          name: station.station.name.ja,
          subtitle: showingLpgmIntensity
              ? switch (station.intensity?.sva) {
                  final sva? => '最大 ${sva.toStringAsFixed(1)} cm/s',
                  null => null,
                }
              : null,
        ),
    };

    return Semantics(
      button: true,
      hint: '観測点の詳細を表示',
      child: Material(
        color: color,
        elevation: 3,
        shape: RoundedSuperellipseBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        clipBehavior: .antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 8, 4, 8),
            child: Row(
              mainAxisSize: .min,
              spacing: 8,
              children: [
                ...icons,
                Flexible(
                  child: Column(
                    mainAxisSize: .min,
                    crossAxisAlignment: .start,
                    children: [
                      Text(
                        name,
                        maxLines: 1,
                        overflow: .ellipsis,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: .bold,
                          fontFamily: FontFamily.notoSansJP,
                        ),
                      ),
                      if (subtitle case final text?)
                        Text(
                          text,
                          maxLines: 1,
                          overflow: .ellipsis,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorTheme.onSurfaceVariant,
                            fontFamily: FontFamily.googleSansCode,
                            fontFamilyFallback: const [FontFamily.notoSansJP],
                          ),
                        ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: colorTheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
