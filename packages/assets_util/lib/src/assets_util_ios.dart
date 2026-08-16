import 'dart:async';

import 'package:assets_util/src/asset_pack_diagnostics.dart';
import 'package:assets_util/src/asset_pack_not_ready_exception.dart';
import 'package:assets_util/src/ios/eqm_assets_util.dart';
import 'package:objective_c/objective_c.dart';

/// Apple-platform implementation backed by Dart Native Assets + ffigen.
///
/// Shared between iOS and macOS: both link the same `EQMAssetsUtil` Swift
/// class (compiled twice by `hook/build.dart`, once per platform target),
/// so the same Dart binding surface works on both.
/// Asset Pack entry points are completion-handler based to share one binding
/// surface across Apple platforms.
abstract final class AssetsUtilApple {
  static Future<AssetPackDiagnostics> diagnosePack({
    required String packIdentifier,
  }) {
    final completer = Completer<AssetPackDiagnostics>();
    final util = EQMAssetsUtil.alloc();
    final completion = ObjCBlock_ffiVoid_NSString.listener((json) {
      try {
        completer.complete(
          AssetPackDiagnostics.fromJsonString(json.toDartString()),
        );
      } on FormatException catch (error, stackTrace) {
        completer.completeError(error, stackTrace);
      }
    });
    util.diagnoseAssetPackWithPackIdentifier(
      packIdentifier.toNSString(),
      completion: completion,
    );
    return completer.future;
  }

  static String resolveLocalPath({required String fileName}) {
    final util = EQMAssetsUtil.alloc();
    final path = util.resolveLocalPathWithFileName(fileName.toNSString());
    if (path == null) {
      throw StateError(
        'EQMAssetsUtil.resolveLocalPath returned null for $fileName. '
        'Ensure the file is registered in Runner Bundle Resources.',
      );
    }
    return path.toDartString();
  }

  static Future<String> resolvePackRoot({
    required String packIdentifier,
  }) {
    final completer = Completer<String>();
    final util = EQMAssetsUtil.alloc();
    final completion = ObjCBlock_ffiVoid_NSString$1.listener((path) {
      if (path == null) {
        completer.completeError(
          AssetPackNotReadyException(
            'The app-bundled Asset Pack directory is missing: '
            '$packIdentifier',
          ),
          StackTrace.current,
        );
        return;
      }
      completer.complete(path.toDartString());
    });
    util.resolvePackRootWithPackIdentifier(
      packIdentifier.toNSString(),
      completion: completion,
    );
    return completer.future;
  }

  static Future<String> resolvePackFile({
    required String relativePath,
    required String packIdentifier,
  }) {
    final completer = Completer<String>();
    final util = EQMAssetsUtil.alloc();
    final completion = ObjCBlock_ffiVoid_NSString$1.listener((path) {
      if (path == null) {
        completer.completeError(
          AssetPackNotReadyException(
            'Asset Pack ($packIdentifier) file is unavailable: $relativePath',
          ),
          StackTrace.current,
        );
        return;
      }
      completer.complete(path.toDartString());
    });
    util.resolveAssetPackFileWithRelativePath(
      relativePath.toNSString(),
      packIdentifier: packIdentifier.toNSString(),
      completion: completion,
    );
    return completer.future;
  }
}
