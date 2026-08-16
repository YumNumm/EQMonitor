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

/// Directory bundled into every app artifact and retained across R2 updates.
const _bundledAssetPackDirectory = 'platform';

typedef ResolveAssetPackFile = Future<String> Function(String relativePath);

/// App-bundled local assets resolver.
///
/// This is **not** FlutterGen / Flutter AssetBundle. It resolves absolute
/// filesystem paths for files stored in the app bundle / APK assets.
abstract final class AssetsUtil {
  /// Returns structured diagnostics for the app-bundled Apple-platform pack.
  ///
  /// This is observational and does not trigger an update check or download.
  static Future<AssetPackDiagnostics> diagnosePack() {
    if (kIsWeb || !Platform.isIOS) {
      throw UnsupportedError(
        'assets_util.diagnosePack is only supported on iOS',
      );
    }
    return AssetsUtilApple.diagnosePack(
      packIdentifier: _bundledAssetPackDirectory,
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
  /// - iOS / macOS: the bundled `platform` directory inside `Bundle.main`.
  /// - Android: `assets/platform` extracted once into app-private storage.
  ///
  /// Throws [AssetPackNotReadyException] if the pack isn't available yet
  /// (or is missing/corrupt). Never invents placeholder data.
  /// Throws [UnsupportedError] on web and any other platform.
  static Future<String> resolvePackRoot() {
    if (kIsWeb) {
      return Future<String>.error(
        UnsupportedError('assets_util is not supported on web'),
      );
    }
    if (Platform.isIOS || Platform.isMacOS) {
      return AssetsUtilApple.resolvePackRoot(
        packIdentifier: _bundledAssetPackDirectory,
      );
    }
    if (Platform.isAndroid) {
      return AssetsUtilAndroid.resolvePackRoot(
        packName: _bundledAssetPackDirectory,
      );
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
  /// Apple platforms resolve files from the immutable bundled `platform`
  /// directory. Android resolves from its private extracted bundle copy.
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
        packIdentifier: _bundledAssetPackDirectory,
      );
    }
    if (Platform.isAndroid) {
      final root = await AssetsUtilAndroid.resolvePackRoot(
        packName: _bundledAssetPackDirectory,
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
