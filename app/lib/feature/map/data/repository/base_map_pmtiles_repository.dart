import 'dart:io';

import 'package:assets_util/assets_util.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'base_map_pmtiles_repository.g.dart';

const _baseMapPmtilesFileName = 'earthquake_tsunami_all.pmtiles';
const _remoteBaseMapPmtilesUri =
    'pmtiles://https://v2.map.eqmonitor.app/all.pmtiles';

@Riverpod(keepAlive: true)
BaseMapPmtilesRepository baseMapPmtilesRepository(Ref ref) =>
    BaseMapPmtilesRepository();

class BaseMapPmtilesRepository {
  /// Returns a MapLibre vector source URI for the base map PMTiles.
  ///
  /// iOS/Android: `pmtiles://file://...` from [AssetsUtil].
  /// Other platforms: remote HTTPS PMTiles.
  Future<String> resolveSourceUri() async {
    if (kIsWeb || !(Platform.isIOS || Platform.isAndroid)) {
      return _remoteBaseMapPmtilesUri;
    }

    final absolutePath = AssetsUtil.resolveLocalPath(
      fileName: _baseMapPmtilesFileName,
    );
    return 'pmtiles://${Uri.file(absolutePath)}';
  }
}
