import 'dart:typed_data';

import 'package:seismicity_pmtiles/src/archive/pmtiles_v3_header.dart';
import 'package:seismicity_pmtiles/src/archive/pmtiles_v3_tile_id.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';

final class PmTilesV3HeaderDecoder {
  const PmTilesV3HeaderDecoder();

  static const headerLength = 127;
  static const rootDirectoryWindowLength = 16384;
  static const mvtTileType = 1;
  static const maxSignedInteger = 0x7FFFFFFFFFFFFFFF;
  static const magic = <int>[0x50, 0x4D, 0x54, 0x69, 0x6C, 0x65, 0x73];

  PmTilesV3Header decode({
    required Uint8List bytes,
    required int archiveSizeBytes,
  }) {
    validateHeaderEnvelope(bytes: bytes, archiveSizeBytes: archiveSizeBytes);
    final data = ByteData.sublistView(bytes);
    final header = PmTilesV3Header(
      rootDirectoryOffset: readUint64(data: data, offset: 8),
      rootDirectoryLength: readUint64(data: data, offset: 16),
      metadataOffset: readUint64(data: data, offset: 24),
      metadataLength: readUint64(data: data, offset: 32),
      leafDirectoriesOffset: readUint64(data: data, offset: 40),
      leafDirectoriesLength: readUint64(data: data, offset: 48),
      tileDataOffset: readUint64(data: data, offset: 56),
      tileDataLength: readUint64(data: data, offset: 64),
      addressedTilesCount: readUint64(data: data, offset: 72),
      tileEntriesCount: readUint64(data: data, offset: 80),
      tileContentsCount: readUint64(data: data, offset: 88),
      clustered: readClustered(data: data),
      internalCompression: data.getUint8(97),
      tileCompression: data.getUint8(98),
      tileType: data.getUint8(99),
      minZoom: data.getUint8(100),
      maxZoom: data.getUint8(101),
      minLongitude: readCoordinate(data: data, offset: 102),
      minLatitude: readCoordinate(data: data, offset: 106),
      maxLongitude: readCoordinate(data: data, offset: 110),
      maxLatitude: readCoordinate(data: data, offset: 114),
      centerZoom: data.getUint8(118),
      centerLongitude: readCoordinate(data: data, offset: 119),
      centerLatitude: readCoordinate(data: data, offset: 123),
    );
    validateHeader(header: header, archiveSizeBytes: archiveSizeBytes);
    return header;
  }

  void validateHeaderEnvelope({
    required Uint8List bytes,
    required int archiveSizeBytes,
  }) {
    if (bytes.length != headerLength || archiveSizeBytes < headerLength) {
      throw const SeismicityPmTilesException.corruptArchive(
        reason: 'PMTiles v3 header must contain exactly $headerLength bytes.',
      );
    }
    for (var index = 0; index < magic.length; index++) {
      if (bytes[index] != magic[index]) {
        throw const SeismicityPmTilesException.corruptArchive(
          reason: 'Invalid PMTiles magic number.',
        );
      }
    }
    if (bytes[7] != 3) {
      throw SeismicityPmTilesException.corruptArchive(
        reason: 'Unsupported PMTiles version ${bytes[7]}; expected version 3.',
      );
    }
  }

  int readUint64({required ByteData data, required int offset}) {
    if ((data.getUint8(offset + 7) & 0x80) != 0) {
      throw const SeismicityPmTilesException.corruptArchive(
        reason: 'A PMTiles uint64 field exceeds the supported signed range.',
      );
    }
    return data.getUint64(offset, Endian.little);
  }

  bool readClustered({required ByteData data}) {
    final value = data.getUint8(96);
    if (value != 0 && value != 1) {
      throw SeismicityPmTilesException.corruptArchive(
        reason: 'Invalid clustered flag $value.',
      );
    }
    return value == 1;
  }

  double readCoordinate({required ByteData data, required int offset}) {
    return data.getInt32(offset, Endian.little) / 10000000;
  }

  void validateHeader({
    required PmTilesV3Header header,
    required int archiveSizeBytes,
  }) {
    if (header.tileType != mvtTileType) {
      throw SeismicityPmTilesException.corruptArchive(
        reason: 'Expected MVT tile type 1, received ${header.tileType}.',
      );
    }
    if (header.minZoom > header.maxZoom ||
        header.maxZoom > PmTilesV3TileId.maxZoom) {
      throw SeismicityPmTilesException.corruptArchive(
        reason: 'Invalid zoom range ${header.minZoom}-${header.maxZoom}.',
      );
    }
    validateRequiredSection(
      name: 'root directory',
      offset: header.rootDirectoryOffset,
      length: header.rootDirectoryLength,
      archiveSizeBytes: archiveSizeBytes,
    );
    validateRequiredSection(
      name: 'metadata',
      offset: header.metadataOffset,
      length: header.metadataLength,
      archiveSizeBytes: archiveSizeBytes,
    );
    validateOptionalSection(
      name: 'leaf directories',
      offset: header.leafDirectoriesOffset,
      length: header.leafDirectoriesLength,
      archiveSizeBytes: archiveSizeBytes,
    );
    validateOptionalSection(
      name: 'tile data',
      offset: header.tileDataOffset,
      length: header.tileDataLength,
      archiveSizeBytes: archiveSizeBytes,
    );
    validateRootWindow(header: header);
    validateSectionOverlap(header: header);
  }

  void validateRequiredSection({
    required String name,
    required int offset,
    required int length,
    required int archiveSizeBytes,
  }) {
    if (length <= 0) {
      throw SeismicityPmTilesException.corruptArchive(
        reason: 'The $name section must not be empty.',
      );
    }
    validateSectionBounds(
      name: name,
      offset: offset,
      length: length,
      archiveSizeBytes: archiveSizeBytes,
    );
  }

  void validateOptionalSection({
    required String name,
    required int offset,
    required int length,
    required int archiveSizeBytes,
  }) {
    validateSectionBounds(
      name: name,
      offset: offset,
      length: length,
      archiveSizeBytes: archiveSizeBytes,
    );
  }

  void validateSectionBounds({
    required String name,
    required int offset,
    required int length,
    required int archiveSizeBytes,
  }) {
    if (offset < headerLength || length < 0 || offset > archiveSizeBytes) {
      throw SeismicityPmTilesException.corruptArchive(
        reason: 'The $name section has invalid bounds.',
      );
    }
    if (length > maxSignedInteger - offset ||
        offset + length > archiveSizeBytes) {
      throw SeismicityPmTilesException.corruptArchive(
        reason: 'The $name section exceeds the archive bounds.',
      );
    }
  }

  void validateRootWindow({required PmTilesV3Header header}) {
    if (header.rootDirectoryOffset + header.rootDirectoryLength >
        rootDirectoryWindowLength) {
      throw const SeismicityPmTilesException.corruptArchive(
        reason: 'The root directory must be contained in the first 16 KiB.',
      );
    }
  }

  void validateSectionOverlap({required PmTilesV3Header header}) {
    final sections = <({String name, int offset, int end})>[
      (
        name: 'root directory',
        offset: header.rootDirectoryOffset,
        end: header.rootDirectoryOffset + header.rootDirectoryLength,
      ),
      (
        name: 'metadata',
        offset: header.metadataOffset,
        end: header.metadataOffset + header.metadataLength,
      ),
      if (header.leafDirectoriesLength > 0)
        (
          name: 'leaf directories',
          offset: header.leafDirectoriesOffset,
          end: header.leafDirectoriesOffset + header.leafDirectoriesLength,
        ),
      if (header.tileDataLength > 0)
        (
          name: 'tile data',
          offset: header.tileDataOffset,
          end: header.tileDataOffset + header.tileDataLength,
        ),
    ]..sort((left, right) => left.offset.compareTo(right.offset));
    for (var index = 1; index < sections.length; index++) {
      final previous = sections[index - 1];
      final current = sections[index];
      if (current.offset < previous.end) {
        throw SeismicityPmTilesException.corruptArchive(
          reason: 'The ${previous.name} and ${current.name} sections overlap.',
        );
      }
    }
  }
}
