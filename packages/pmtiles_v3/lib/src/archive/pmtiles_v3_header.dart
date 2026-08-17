import 'package:freezed_annotation/freezed_annotation.dart';

part 'pmtiles_v3_header.freezed.dart';

@freezed
abstract class PmTilesV3Header with _$PmTilesV3Header {
  const factory({
    required int rootDirectoryOffset,
    required int rootDirectoryLength,
    required int metadataOffset,
    required int metadataLength,
    required int leafDirectoriesOffset,
    required int leafDirectoriesLength,
    required int tileDataOffset,
    required int tileDataLength,
    required int addressedTilesCount,
    required int tileEntriesCount,
    required int tileContentsCount,
    required bool clustered,
    required int internalCompression,
    required int tileCompression,
    required int tileType,
    required int minZoom,
    required int maxZoom,
    required double minLongitude,
    required double minLatitude,
    required double maxLongitude,
    required double maxLatitude,
    required int centerZoom,
    required double centerLongitude,
    required double centerLatitude,
  }) = _PmTilesV3Header;
}
