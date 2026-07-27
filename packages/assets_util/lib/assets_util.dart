import 'dart:io';

import 'package:assets_util/src/assets_util_android.dart';
import 'package:assets_util/src/assets_util_ios.dart';
import 'package:flutter/foundation.dart';

export 'package:assets_util/src/asset_pack_not_ready_exception.dart';
export 'package:assets_util/src/assets_util_android.dart' show AssetsUtilAndroid;

/// The Asset Pack identifier registered in App Store Connect's Background
/// Assets management (`IOS_BACKGROUND_ASSET_PACK_ID` in
/// `.github/workflows/upload-asset-pack.yaml`; see `docs/asset-pack-cd.md`
/// and `docs/ios-background-assets.md`). Must stay in sync with the Xcode
/// Background Assets capability and the App Store Connect resource.
const _iosAssetPackIdentifier = 'net.yumnumm.eqmonitor.assets';

/// The Play Asset Delivery install-time pack's module name (
/// `app/android/assetpacks/eqmonitor_assets`, wired via
/// `assetPacks += setOf(":assetpacks:eqmonitor_assets")`). Deliberately a
/// different literal than the iOS identifier: Android Gradle module/pack
/// names disallow dots, iOS asset pack IDs are conventionally reverse-DNS.
const _androidAssetPackName = 'eqmonitor_assets';

/// Platform-managed local assets resolver.
///
/// This is **not** FlutterGen / Flutter AssetBundle. It resolves absolute
/// filesystem paths for files managed by the platform (app bundle / APK
/// assets, iOS Managed Background Assets, Android Play Asset Delivery,
/// macOS native bundling).
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
      return AssetsUtilApple.resolveLocalPath(fileName: fileName);
    }
    if (Platform.isAndroid) {
      return AssetsUtilAndroid.resolveLocalPath(fileName: fileName);
    }
    throw UnsupportedError(
      'assets_util is only supported on iOS and Android',
    );
  }

  /// Returns the absolute path to the Asset Pack root directory.
  ///
  /// - iOS: the on-device directory of the Managed Background Assets pack
  ///   (`net.yumnumm.eqmonitor.assets`) once fully downloaded.
  /// - Android: the Play Asset Delivery install-time pack
  ///   (`eqmonitor_assets`) location, via `AssetPackManager`.
  /// - macOS: the bundled `platform` directory inside `Bundle.main`
  ///   (always available; native bundling, no store-based delivery).
  ///
  /// Throws [AssetPackNotReadyException] if the pack isn't available yet
  /// (or is missing/corrupt). Never falls back to fake/bundled data.
  /// Throws [UnsupportedError] on web and any other platform.
  static Future<String> resolvePackRoot() async {
    if (kIsWeb) {
      throw UnsupportedError('assets_util is not supported on web');
    }
    if (Platform.isIOS || Platform.isMacOS) {
      return AssetsUtilApple.resolvePackRoot(
        packIdentifier: _iosAssetPackIdentifier,
      );
    }
    if (Platform.isAndroid) {
      return AssetsUtilAndroid.resolvePackRoot(
        packName: _androidAssetPackName,
      );
    }
    throw UnsupportedError(
      'assets_util.resolvePackRoot is only supported on iOS, Android and macOS',
    );
  }
}
