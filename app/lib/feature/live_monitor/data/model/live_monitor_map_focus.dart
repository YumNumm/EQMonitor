import 'package:freezed_annotation/freezed_annotation.dart';

part 'live_monitor_map_focus.freezed.dart';

@freezed
abstract class LiveMonitorGeoBounds with _$LiveMonitorGeoBounds {
  const factory LiveMonitorGeoBounds({
    required double minLat,
    required double maxLat,
    required double minLng,
    required double maxLng,
  }) = _LiveMonitorGeoBounds;
}

extension LiveMonitorGeoBoundsX on LiveMonitorGeoBounds {
  bool contains({required double latitude, required double longitude}) =>
      minLat <= latitude &&
      latitude <= maxLat &&
      minLng <= longitude &&
      longitude <= maxLng;
}

@freezed
abstract class LiveMonitorMapPadding with _$LiveMonitorMapPadding {
  const factory LiveMonitorMapPadding({
    @Default(8) double top,
    @Default(8) double right,
    @Default(8) double bottom,
    @Default(8) double left,
  }) = _LiveMonitorMapPadding;
}

@freezed
abstract class LiveMonitorMapFocus with _$LiveMonitorMapFocus {
  const factory LiveMonitorMapFocus({
    required LiveMonitorGeoBounds bounds,
    required LiveMonitorMapPadding padding,
  }) = _LiveMonitorMapFocus;
}
