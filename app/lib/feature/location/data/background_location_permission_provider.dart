import 'package:eqmonitor/core/provider/app_lifecycle.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'background_location_permission_provider.g.dart';

/// バックグラウンド位置情報のパーミッション状態を保持する。
/// アプリがフォアグラウンドに復帰した時に自動で再取得する。
@Riverpod(keepAlive: true)
Future<LocationPermission> backgroundLocationPermission(Ref ref) async {
  ref.listen(appLifecycleProvider, (_, next) {
    if (next == AppLifecycleState.resumed) {
      ref.invalidateSelf();
    }
  });
  return Geolocator.checkPermission();
}
