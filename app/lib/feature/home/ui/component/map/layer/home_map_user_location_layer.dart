import 'dart:async';

import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geolocator/geolocator.dart';
import 'package:maplibre/maplibre.dart' hide Position;
import 'package:material_ui/material_ui.dart';

/// ホームマップ上に現在地を表示する。
///
/// 権限の要求は行わない。「現在地を地図上に表示する」を有効にする際に
/// 設定画面側で権限を取得済みであることを前提とし、未許可なら何も描画しない。
class const HomeMapUserLocationLayer({super.key}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final permission = useFuture(useMemoized(Geolocator.checkPermission)).data;
    final isGranted = permission == .always || permission == .whileInUse;
    final locations = useMemoized(
      () =>
          isGranted ? const HomeMapUserLocationStreamFactory().create() : null,
      [isGranted],
    );
    if (locations == null) {
      return const SizedBox.shrink();
    }
    return UserLocationLayer(locations: locations);
  }
}

class const HomeMapUserLocationStreamFactory() {
  static const _locationSettings = LocationSettings(accuracy: .high);

  Stream<UserLocation> create() {
    late final StreamController<UserLocation> controller;
    StreamSubscription<Position>? subscription;
    var isCanceled = false;

    Future<void> start() async {
      var hasStreamed = false;
      // UserLocationLayer は stream のエラーを処理しないため、ここで握りつぶす。
      subscription =
          Geolocator.getPositionStream(
            locationSettings: _locationSettings,
          ).listen(
            (position) {
              hasStreamed = true;
              controller.add(toUserLocation(position));
            },
            onError: (Object error, StackTrace stackTrace) =>
                talker.handle(error, stackTrace),
          );
      try {
        final lastKnown = await Geolocator.getLastKnownPosition();
        if (lastKnown != null && !isCanceled && !hasStreamed) {
          controller.add(toUserLocation(lastKnown));
        }
      } on Exception catch (error, stackTrace) {
        talker.handle(error, stackTrace);
      }
    }

    controller = StreamController<UserLocation>(
      onListen: () => unawaited(start()),
      onCancel: () {
        isCanceled = true;
        return subscription?.cancel();
      },
    );
    return controller.stream;
  }

  /// 計測できなかった方位(負値)と精度(0 以下)は null にする。
  UserLocation toUserLocation(Position position) => UserLocation(
    position: Geographic(lon: position.longitude, lat: position.latitude),
    accuracy: position.accuracy > 0 ? position.accuracy : null,
    heading: position.heading >= 0 ? position.heading % 360 : null,
    timestamp: position.timestamp,
  );
}
