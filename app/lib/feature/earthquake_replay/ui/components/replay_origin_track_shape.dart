import 'package:material_ui/material_ui.dart';

class const ReplayOriginTrackShape({
  required final double? originFraction,
  required final Color markerColor,
}) extends RoundedRectSliderTrackShape {
  static const _markerWidth = 3.0;
  static const _markerOverhang = 6.0;

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required Offset thumbCenter,
    Offset? secondaryOffset,
    bool isDiscrete = false,
    bool isEnabled = false,
    double additionalActiveTrackHeight = 2,
  }) {
    super.paint(
      context,
      offset,
      parentBox: parentBox,
      sliderTheme: sliderTheme,
      enableAnimation: enableAnimation,
      textDirection: textDirection,
      thumbCenter: thumbCenter,
      secondaryOffset: secondaryOffset,
      isDiscrete: isDiscrete,
      isEnabled: isEnabled,
      additionalActiveTrackHeight: additionalActiveTrackHeight,
    );
    final fraction = originFraction;
    if (fraction == null) {
      return;
    }
    final track = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );
    context.canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(track.left + track.width * fraction, track.center.dy),
          width: _markerWidth,
          height: track.height + _markerOverhang * 2,
        ),
        const Radius.circular(_markerWidth / 2),
      ),
      Paint()..color = markerColor,
    );
  }
}
