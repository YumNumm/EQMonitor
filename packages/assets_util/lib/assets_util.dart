import 'dart:io';

import 'package:assets_util/src/asset_pack_diagnostics.dart';
import 'package:assets_util/src/asset_pack_not_ready_exception.dart';
import 'package:assets_util/src/assets_util_android.dart';
import 'package:assets_util/src/assets_util_ios.dart';
import 'package:flutter/foundation.dart';

export 'package:assets_util/src/asset_pack_diagnostics.dart';
export 'package:assets_util/src/asset_pack_not_ready_exception.dart';
export 'package:assets_util/src/assets_util_android.dart'
    show AssetsUtilAndroid;

/// The Asset Pack identifier registered in App Store Connect's Background
/// Assets management (`IOS_BACKGROUND_ASSET_PACK_ID` in
/// `.github/workflows/upload-asset-pack.yaml`; see `docs/asset-pack-cd.md`
/// and `docs/ios-background-assets.md`). The Xcode project does not declare
/// it anywhere — a mismatch with the workflow is therefore invisible at
/// build time, and is guarded by `tool/asset_pack/check_asset_pack_id.py`.
const _iosAssetPackIdentifier = 'eqmonitor-assets';

/// The Play Asset Delivery install-time pack's module name (
/// `app/android/assetpacks/eqmonitor_assets`, wired via
/// `assetPacks += setOf(":assetpacks:eqmonitor_assets")`). Necessarily a
/// different literal than the iOS identifier: Gradle module names disallow
/// hyphens, and App Store Connect rejects underscores and dots (ITMS-91133).
const _androidAssetPackName = 'eqmonitor_assets';

typedef ResolveAssetPackFile = Future<String> Function(String relativePath);

/// Platform-managed local assets resolver.
///
/// This is **not** FlutterGen / Flutter AssetBundle. It resolves absolute
/// filesystem paths for files managed by the platform (app bundle / APK
/// assets, iOS Managed Background Assets, Android Play Asset Delivery,
/// macOS native bundling).
abstract final class AssetsUtil {
  /// Returns structured iOS Managed Background Assets diagnostics.
  ///
  /// This is observational and does not trigger an update check or download.
  static Future<AssetPackDiagnostics> diagnosePack() {
    if (kIsWeb || !Platform.isIOS) {
      throw UnsupportedError(
        'assets_util.diagnosePack is only supported on iOS',
      );
    }
    return AssetsUtilApple.diagnosePack(
      packIdentifier: _iosAssetPackIdentifier,
    );
  }

  /// Explicitly asks Background Assets to check for Asset Pack updates.
  ///
  /// A successful response only describes the accepted update operation; it
  /// does not mean every file has finished downloading.
  static Future<AssetPackUpdateResult> checkForUpdates() {
    if (kIsWeb || !Platform.isIOS) {
      throw UnsupportedError(
        'assets_util.checkForUpdates is only supported on iOS',
      );
    }
    return AssetsUtilApple.checkForUpdates(
      packIdentifier: _iosAssetPackIdentifier,
    );
  }

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
    throw UnsupportedError('assets_util is only supported on iOS and Android');
  }

  /// Returns the absolute path to the Asset Pack root directory.
  ///
  /// - iOS: the on-device directory of the Managed Background Assets pack
  ///   (`eqmonitor-assets`) once fully downloaded.
  /// - Android: the Play Asset Delivery install-time pack
  ///   (`eqmonitor_assets`) location, via `AssetPackManager`.
  /// - macOS: the bundled `platform` directory inside `Bundle.main`
  ///   (always available; native bundling, no store-based delivery).
  ///
  /// Throws [AssetPackNotReadyException] if the pack isn't available yet
  /// (or is missing/corrupt). Never falls back to fake/bundled data.
  /// Throws [UnsupportedError] on web and any other platform.
  static Future<String> resolvePackRoot() {
    if (kIsWeb) {
      return Future<String>.error(
        UnsupportedError('assets_util is not supported on web'),
      );
    }
    if (Platform.isIOS || Platform.isMacOS) {
      return AssetsUtilApple.resolvePackRoot(
        packIdentifier: _iosAssetPackIdentifier,
      );
    }
    if (Platform.isAndroid) {
      return AssetsUtilAndroid.resolvePackRoot(packName: _androidAssetPackName);
    }
    return Future<String>.error(
      UnsupportedError(
        'assets_util.resolvePackRoot is only supported on '
        'iOS, Android and macOS',
      ),
    );
  }

  /// Resolves one logical Asset Pack path to a verified regular file.
  ///
  /// iOS files are resolved independently through Background Assets. Callers
  /// must not derive sibling paths from a returned URL because the API exposes
  /// a shared logical namespace rather than a stable physical pack root.
  static Future<String> resolvePackFile({required String relativePath}) async {
    if (kIsWeb) {
      throw UnsupportedError('assets_util is not supported on web');
    }
    final segments = relativePath.split('/');
    if (relativePath.isEmpty ||
        File(relativePath).isAbsolute ||
        segments.contains('..')) {
      throw AssetPackNotReadyException(
        'Invalid Asset Pack relative path: $relativePath',
      );
    }
    if (Platform.isIOS || Platform.isMacOS) {
      return AssetsUtilApple.resolvePackFile(
        relativePath: relativePath,
        packIdentifier: _iosAssetPackIdentifier,
      );
    }
    if (Platform.isAndroid) {
      final root = await AssetsUtilAndroid.resolvePackRoot(
        packName: _androidAssetPackName,
      );
      final file = File('$root/$relativePath');
      if (FileSystemEntity.typeSync(file.path) != FileSystemEntityType.file) {
        throw AssetPackNotReadyException(
          'Asset Pack file is unavailable: $relativePath',
        );
      }
      return file.path;
    }
    throw UnsupportedError(
      'assets_util.resolvePackFile is only supported on iOS, Android and macOS',
    );
  }
}
