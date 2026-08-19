import 'dart:io';

import 'package:eqmonitor/core/provider/app_lifecycle.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location_accuracy_provider.g.dart';

/// `Info.plist` の `NSLocationTemporaryUsageDescriptionDictionary` に
/// 定義したキーと一致させる必要がある。
const locationTemporaryFullAccuracyPurposeKey = 'CurrentLocationIntensity';

/// 位置情報権限の精度。
///
/// iOS の「正確な位置情報」オフ / Android の「おおよその位置」許可で
/// [LocationAccuracyStatus.reduced] になる。取得できない場合も精度を保証
/// できないため [LocationAccuracyStatus.reduced] として扱う。
///
/// 設定アプリで変更されうるため、アプリ復帰時に再取得する。
@riverpod
Future<LocationAccuracyStatus> locationAccuracyStatus(Ref ref) async {
  ref.listen(appLifecycleProvider, (prev, next) {
    if (prev != null &&
        prev != AppLifecycleState.resumed &&
        next == AppLifecycleState.resumed) {
      ref.invalidateSelf();
    }
  });

  try {
    return await Geolocator.getLocationAccuracy();
  } on Object catch (e, st) {
    // 権限未許可などで取得できない。
    talker.handle(e, st, 'Failed to get location accuracy');
    return LocationAccuracyStatus.reduced;
  }
}

/// iOS の「正確な位置情報」の一時許可を要求する。
final class TemporaryPreciseLocationRequester {
  const new();

  /// Android には該当APIが無い（`requestTemporaryFullAccuracy` は
  /// `notImplemented`）ため、iOS 以外では何もしない。
  /// 呼び出し後は [locationAccuracyStatusProvider] を invalidate すること。
  Future<void> request() async {
    if (!Platform.isIOS) {
      return;
    }
    try {
      await Geolocator.requestTemporaryFullAccuracy(
        purposeKey: locationTemporaryFullAccuracyPurposeKey,
      );
    } on Object catch (e, st) {
      talker.handle(e, st, 'Failed to request temporary full accuracy');
    }
  }
}
