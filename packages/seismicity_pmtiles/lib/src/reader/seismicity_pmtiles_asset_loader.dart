import 'dart:typed_data';

typedef SeismicityPmTilesAssetLoader =
    Future<Uint8List> Function({required String assetKey});
