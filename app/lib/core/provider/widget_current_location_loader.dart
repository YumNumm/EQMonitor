import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'widget_current_location_loader.g.dart';

enum WidgetLocationState { available, permissionDenied, temporarilyUnavailable }

typedef WidgetLocationLoadResult = ({
  WidgetLocationState state,
  Position? position,
});

@riverpod
WidgetCurrentLocationLoader widgetCurrentLocationLoader(Ref ref) =>
    WidgetCurrentLocationLoader(
      checkPermission: Geolocator.checkPermission,
      getLastKnownPosition: Geolocator.getLastKnownPosition,
      getCurrentPosition: () => Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(accuracy: .low),
      ),
    );

class WidgetCurrentLocationLoader {
  const new({
    required this.checkPermission,
    required this.getLastKnownPosition,
    required this.getCurrentPosition,
  });

  final Future<LocationPermission> Function() checkPermission;
  final Future<Position?> Function() getLastKnownPosition;
  final Future<Position> Function() getCurrentPosition;

  Future<WidgetLocationLoadResult> load() async {
    final LocationPermission permission;
    try {
      permission = await checkPermission();
    } catch (_) {
      return (
        state: WidgetLocationState.temporarilyUnavailable,
        position: null,
      );
    }
    if (permission != LocationPermission.always &&
        permission != LocationPermission.whileInUse) {
      return (state: WidgetLocationState.permissionDenied, position: null);
    }

    try {
      final lastKnown = await getLastKnownPosition();
      if (lastKnown != null) {
        return (state: WidgetLocationState.available, position: lastKnown);
      }
    } catch (_) {
      // 現在位置の取得へ進む。
    }

    try {
      final current = await getCurrentPosition();
      return (state: WidgetLocationState.available, position: current);
    } catch (_) {
      return (
        state: WidgetLocationState.temporarilyUnavailable,
        position: null,
      );
    }
  }
}
