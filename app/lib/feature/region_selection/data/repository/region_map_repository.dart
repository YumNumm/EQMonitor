import 'dart:convert';
import 'dart:io';

import 'package:eqmonitor/feature/asset_pack/data/model/asset_pack_manifest.dart';
import 'package:eqmonitor/feature/asset_pack/data/repository/asset_pack_repository.dart';
import 'package:eqmonitor/feature/region_selection/data/model/region_map_metadata.dart';
import 'package:pmtiles_v3/pmtiles_v3.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'region_map_repository.g.dart';

@riverpod
RegionMapRepository regionMapRepository(Ref ref) => RegionMapRepository(
  assetPack: ref.watch(assetPackRepositoryProvider),
);

final class const RegionMapRepository({
  required final AssetPackRepository assetPack,
}) {
  Future<RegionMapMetadata> metadata() async {
    final file = await assetPack.resolveAsset(AssetPackAssetId.baseMapPmtiles);
    final reader = await PmTilesV3FileRandomAccessReader.open(path: file.path);
    try {
      final archive = await PmTilesV3Archive.open(
        reader: reader,
        limits: const PmTilesV3Limits(
          maxDirectoryDepth: 3,
          rootDirectoryWindowLength: 16384,
          maxDirectoryEncodedBytes: 1024 * 1024,
          maxDirectoryDecodedBytes: 8 * 1024 * 1024,
          maxDirectoryEntries: 100000,
          maxCachedLeafDirectories: 1,
          maxTileEncodedBytes: 8 * 1024 * 1024,
          maxTileDecodedBytes: 32 * 1024 * 1024,
        ),
      );
      final header = archive.header;
      if (header.metadataLength > 1024 * 1024) {
        throw const FormatException('Map metadata is too large');
      }
      final bytes = await reader.readAt(
        offset: header.metadataOffset,
        length: header.metadataLength,
      );
      final decoded = switch (header.internalCompression) {
        1 => bytes,
        2 => gzip.decode(bytes),
        _ => throw const FormatException(
          'Unsupported map metadata compression',
        ),
      };
      return RegionMapMetadata.fromJson(
        jsonDecode(utf8.decode(decoded)) as Map<String, dynamic>,
      );
    } finally {
      await reader.close();
    }
  }
}
