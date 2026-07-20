import 'dart:io';

import 'package:assets_util/assets_util.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'base_map_pmtiles_repository.g.dart';

const _baseMapPmtilesFileName = 'earthquake_tsunami_all.pmtiles';

@Riverpod(keepAlive: true)
BaseMapPmtilesRepository baseMapPmtilesRepository(Ref ref) =>
    BaseMapPmtilesRepository();

class BaseMapPmtilesRepository {
  const BaseMapPmtilesRepository();

  /// Returns a MapLibre vector source URI for the base map PMTiles.
  ///
  /// iOS/Android: `pmtiles://file://...` from [AssetsUtil].
  Future<String> resolveSourceUri() async {
    if (kIsWeb || !(Platform.isIOS || Platform.isAndroid)) {
      throw UnimplementedError('PMTiles is not supported on this platform.');
    }
    return 'pmtiles://asset://earthquake_tsunami_all.pmtiles';

    final absolutePath = AssetsUtil.resolveLocalPath(
      fileName: _baseMapPmtilesFileName,
    );

    final file = File(absolutePath);
    if (!file.existsSync()) {
      throw StateError('Base PMTiles file not found: $absolutePath');
    }
    final info = await file.stat();
    if (info.size == 0) {
      throw StateError('Base PMTiles file is empty: $absolutePath');
    }
    return 'pmtiles://file://${Uri.file(absolutePath)}';
  }
}
