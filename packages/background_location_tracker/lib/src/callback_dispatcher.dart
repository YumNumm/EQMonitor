import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

/// killed状態から復帰した時にネイティブが呼び出すDartエントリポイント。
/// アプリの通常起動とは別のFlutterEngineで実行される。
///
/// 実際の lat/lon 永続化はネイティブ層(headless runner)が engine 起動前に
/// 行うため、この dispatcher は ready ハンドシェイクのみ担う。
/// 永続化された位置情報は通常起動時に
/// `BackgroundLocationTracker.peekPendingLocation()` から取り出される。
@pragma('vm:entry-point')
void locationUpdateCallbackDispatcher() {
  WidgetsFlutterBinding.ensureInitialized();

  const channel = MethodChannel('background_location_tracker/headless');
  channel.setMethodCallHandler((call) async {
    // ネイティブ側で永続化済みのため、Dart 側では何もしない。
  });

  unawaited(
    channel.invokeMethod<void>('ready'),
  );
}
