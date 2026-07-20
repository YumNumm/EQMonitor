import 'package:assets_util/src/ios/eqm_assets_util.dart';
import 'package:objective_c/objective_c.dart';

/// iOS implementation backed by Dart Native Assets + ffigen.
abstract final class AssetsUtilIos {
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
}
