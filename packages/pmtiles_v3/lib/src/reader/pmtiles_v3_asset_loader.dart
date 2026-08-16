import 'dart:typed_data';

typedef PmTilesV3AssetLoader = Future<Uint8List> Function({
  required String assetKey,
});
