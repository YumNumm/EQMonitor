import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

/// killed状態から復帰した時にネイティブが呼び出すDartエントリポイント。
/// アプリの通常起動とは別のFlutterEngineで実行される。
@pragma('vm:entry-point')
void locationUpdateCallbackDispatcher() {
  WidgetsFlutterBinding.ensureInitialized();

  const channel = MethodChannel('background_location_tracker/headless');
  channel.setMethodCallHandler((call) async {
    if (call.method == 'onLocationUpdate') {
      final args = call.arguments as Map<Object?, Object?>;
      final lat = (args['latitude'] as num).toDouble();
      final lon = (args['longitude'] as num).toDouble();
      await _onLocationUpdateInBackground(lat, lon);
    }
  });

  channel.invokeMethod<void>('ready');
}

/// バックグラウンドでの位置更新処理。
/// アプリ側で override するためにトップレベル関数として定義。
/// BackgroundLocationService がこのストリームを listen する。
Future<void> _onLocationUpdateInBackground(double lat, double lon) async {
  // 実際の処理はアプリ側の BackgroundLocationService で行う。
  // ここでは最小限の実装のみ。
}
