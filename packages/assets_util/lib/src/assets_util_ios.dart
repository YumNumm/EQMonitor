import 'package:assets_util/src/asset_pack_not_ready_exception.dart';
import 'package:assets_util/src/ios/eqm_assets_util.dart';
import 'package:objective_c/objective_c.dart';

/// Apple-platform implementation backed by Dart Native Assets + ffigen.
///
/// Shared between iOS and macOS: both link the same `EQMAssetsUtil` Swift
/// class (compiled twice by `hook/build.dart`, once per platform target),
/// so the same Dart binding surface works on both.
abstract final class AssetsUtilApple {
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

  static Future<String> resolvePackRoot({required String packIdentifier}) async {
    final util = EQMAssetsUtil.alloc();
    final path = util.resolvePackRootWithPackIdentifier(
      packIdentifier.toNSString(),
    );
    if (path == null) {
      throw AssetPackNotReadyException(
        'Asset Pack ($packIdentifier) is not available locally yet '
        '(iOS: Managed Background Assets download incomplete; '
        'macOS: bundled platform/ directory missing).',
      );
    }
    return path.toDartString();
  }
}
