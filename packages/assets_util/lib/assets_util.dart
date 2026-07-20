import 'dart:io';

import 'package:assets_util/src/assets_util_android.dart';
import 'package:assets_util/src/assets_util_ios.dart';
import 'package:flutter/foundation.dart';

export 'package:assets_util/src/assets_util_android.dart' show AssetsUtilAndroid;

/// Platform-managed local assets resolver.
///
/// This is **not** FlutterGen / Flutter AssetBundle. It resolves absolute
/// filesystem paths for files managed by the platform (app bundle / APK
/// assets today; Background Assets / Play Asset Delivery later).
abstract final class AssetsUtil {
  /// Returns an absolute path to [fileName] on the local filesystem.
  ///
  /// Throws [UnsupportedError] on platforms other than iOS/Android.
  /// Throws if the underlying native resolver fails.
  static String resolveLocalPath({required String fileName}) {
    if (kIsWeb) {
      throw UnsupportedError('assets_util is not supported on web');
    }
    if (Platform.isIOS) {
      return AssetsUtilIos.resolveLocalPath(fileName: fileName);
    }
    if (Platform.isAndroid) {
      return AssetsUtilAndroid.resolveLocalPath(fileName: fileName);
    }
    throw UnsupportedError(
      'assets_util is only supported on iOS and Android',
    );
  }
}
