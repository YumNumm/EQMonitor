import 'dart:typed_data';

import 'package:seismicity_pmtiles/src/archive/pmtiles_v3_compression_decoder.dart';
import 'package:seismicity_pmtiles/src/archive/pmtiles_v3_directory_decoder.dart';
import 'package:seismicity_pmtiles/src/archive/pmtiles_v3_directory_entry.dart';
import 'package:seismicity_pmtiles/src/archive/pmtiles_v3_header.dart';
import 'package:seismicity_pmtiles/src/archive/pmtiles_v3_header_decoder.dart';
import 'package:seismicity_pmtiles/src/archive/pmtiles_v3_tile_id.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_archive_descriptor.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_source.dart';
import 'package:seismicity_pmtiles/src/reader/seismicity_random_access_reader.dart';

abstract interface class SeismicityPmTilesArchive {
  static Future<SeismicityPmTilesArchive> open({
    required SeismicityRandomAccessReader reader,
    required SeismicityPmTilesArchiveDescriptor descriptor,
  }) {
    return const SeismicityPmTilesArchiveOpener().open(
      reader: reader,
      descriptor: descriptor,
    );
  }

  PmTilesV3Header get header;

  Stream<int> occupiedTileIdsAtZoom({required int zoom});

  Future<Uint8List> readTile({required int tileId});

  Future<void> close();
}

final class SeismicityPmTilesArchiveOpener {
  const SeismicityPmTilesArchiveOpener({
    this.headerDecoder = const PmTilesV3HeaderDecoder(),
    this.directoryDecoder = const PmTilesV3DirectoryDecoder(),
    this.compressionDecoder = const PmTilesV3CompressionDecoder(),
  });

  final PmTilesV3HeaderDecoder headerDecoder;
  final PmTilesV3DirectoryDecoder directoryDecoder;
  final PmTilesV3CompressionDecoder compressionDecoder;

  Future<SeismicityPmTilesArchive> open({
    required SeismicityRandomAccessReader reader,
    required SeismicityPmTilesArchiveDescriptor descriptor,
  }) async {
    try {
      validateDescriptor(reader: reader, descriptor: descriptor);
      final headerBytes = await reader.readAt(
        offset: 0,
        length: PmTilesV3HeaderDecoder.headerLength,
      );
      final header = headerDecoder.decode(
        bytes: headerBytes,
        archiveSizeBytes: reader.sizeBytes,
      );
      validateDescriptorZoom(header: header, descriptor: descriptor);
      compressionDecoder
        ..validateSupported(compression: header.internalCompression)
        ..validateSupported(compression: header.tileCompression);
      final rootBytes = await reader.readAt(
        offset: header.rootDirectoryOffset,
        length: header.rootDirectoryLength,
      );
      final rootEntries = directoryDecoder.decode(
        bytes: rootBytes,
        compression: header.internalCompression,
      );
      final validator = PmTilesV3DirectoryValidator(header: header);
      validator.validate(
        entries: rootEntries,
        lowerTileId: 0,
        upperTileIdExclusive: PmTilesV3TileId.maxValue + 1,
        requireFirstTileId: false,
      );
      return PmTilesV3Archive(
        reader: reader,
        descriptorSource: descriptor.source,
        header: header,
        rootEntries: rootEntries,
        traversal: PmTilesV3DirectoryTraversal(
          reader: reader,
          header: header,
          directoryDecoder: directoryDecoder,
          validator: validator,
        ),
        compressionDecoder: compressionDecoder,
      );
    } on SeismicityPmTilesException {
      await closeAfterOpenFailure(reader: reader);
      rethrow;
    }
  }

  void validateDescriptor({
    required SeismicityRandomAccessReader reader,
    required SeismicityPmTilesArchiveDescriptor descriptor,
  }) {
    if (descriptor.expectedSizeBytes <= 0 ||
        descriptor.expectedSizeBytes != reader.sizeBytes) {
      throw SeismicityPmTilesException.invalidDescriptor(
        reason:
            'Expected archive size ${descriptor.expectedSizeBytes}, '
            'received ${reader.sizeBytes}.',
      );
    }
    if (descriptor.dataZoom < 0 ||
        descriptor.dataZoom > PmTilesV3TileId.maxZoom) {
      throw SeismicityPmTilesException.invalidDescriptor(
        reason: 'Invalid data zoom ${descriptor.dataZoom}.',
      );
    }
  }

  void validateDescriptorZoom({
    required PmTilesV3Header header,
    required SeismicityPmTilesArchiveDescriptor descriptor,
  }) {
    if (descriptor.dataZoom < header.minZoom ||
        descriptor.dataZoom > header.maxZoom) {
      throw SeismicityPmTilesException.invalidDescriptor(
        reason:
            'Data zoom ${descriptor.dataZoom} is outside archive zoom range '
            '${header.minZoom}-${header.maxZoom}.',
      );
    }
  }

  Future<void> closeAfterOpenFailure({
    required SeismicityRandomAccessReader reader,
  }) async {
    try {
      await reader.close();
    } on SeismicityPmTilesException {
      // Preserve the parse or descriptor failure that caused open to abort.
    }
  }
}

final class PmTilesV3Archive implements SeismicityPmTilesArchive {
  PmTilesV3Archive({
    required this.reader,
    required this.descriptorSource,
    required this.header,
    required this.rootEntries,
    required this.traversal,
    required this.compressionDecoder,
  });

  final SeismicityRandomAccessReader reader;
  final SeismicityPmTilesSource descriptorSource;
  @override
  final PmTilesV3Header header;
  final List<PmTilesV3DirectoryEntry> rootEntries;
  final PmTilesV3DirectoryTraversal traversal;
  final PmTilesV3CompressionDecoder compressionDecoder;
  var _isClosed = false;
  Future<void>? _closeFuture;

  @override
  Stream<int> occupiedTileIdsAtZoom({required int zoom}) {
    ensureOpen();
    final range = const PmTilesV3TileId().rangeForZoom(zoom: zoom);
    return traversal.occupiedTileIds(
      entries: rootEntries,
      requestedStart: range.start,
      requestedEndExclusive: range.endExclusive,
      lowerTileId: 0,
      upperTileIdExclusive: PmTilesV3TileId.maxValue + 1,
      depth: 1,
    );
  }

  @override
  Future<Uint8List> readTile({required int tileId}) async {
    ensureOpen();
    const PmTilesV3TileId().validate(tileId: tileId);
    final entry = await traversal.resolveTile(
      tileId: tileId,
      entries: rootEntries,
      lowerTileId: 0,
      upperTileIdExclusive: PmTilesV3TileId.maxValue + 1,
      depth: 1,
    );
    if (entry == null) {
      throw SeismicityPmTilesException.tileNotFound(tileId: tileId);
    }
    final bytes = await reader.readAt(
      offset: header.tileDataOffset + entry.offset,
      length: entry.length,
    );
    return compressionDecoder.decode(
      bytes: bytes,
      compression: header.tileCompression,
    );
  }

  @override
  Future<void> close() {
    final currentClose = _closeFuture;
    if (currentClose != null) {
      return currentClose;
    }
    _isClosed = true;
    final nextClose = reader.close();
    _closeFuture = nextClose;
    return nextClose;
  }

  void ensureOpen() {
    if (_isClosed) {
      throw SeismicityPmTilesException.sourceReadFailed(
        source: descriptorSource,
        reason: 'The PMTiles archive is closed.',
      );
    }
  }
}

final class PmTilesV3DirectoryValidator {
  const PmTilesV3DirectoryValidator({required this.header});

  final PmTilesV3Header header;

  void validate({
    required List<PmTilesV3DirectoryEntry> entries,
    required int lowerTileId,
    required int upperTileIdExclusive,
    required bool requireFirstTileId,
  }) {
    if (entries.isEmpty) {
      throw const SeismicityPmTilesException.corruptArchive(
        reason: 'A PMTiles directory must not be empty.',
      );
    }
    if (requireFirstTileId && entries.first.tileId != lowerTileId) {
      throw const SeismicityPmTilesException.corruptArchive(
        reason: 'A leaf directory must start at its parent entry tile ID.',
      );
    }
    for (final entry in entries) {
      validateEntry(
        entry: entry,
        lowerTileId: lowerTileId,
        upperTileIdExclusive: upperTileIdExclusive,
      );
    }
  }

  void validateEntry({
    required PmTilesV3DirectoryEntry entry,
    required int lowerTileId,
    required int upperTileIdExclusive,
  }) {
    if (entry.tileId < lowerTileId || entry.tileId >= upperTileIdExclusive) {
      throw const SeismicityPmTilesException.corruptArchive(
        reason: 'A directory entry is outside its parent tile ID range.',
      );
    }
    if (entry.runLength == 0) {
      validateRelativeRange(
        entry: entry,
        sectionLength: header.leafDirectoriesLength,
        sectionName: 'leaf directory',
      );
      return;
    }
    if (entry.runLength > upperTileIdExclusive - entry.tileId) {
      throw const SeismicityPmTilesException.corruptArchive(
        reason: 'A tile run is outside its parent tile ID range.',
      );
    }
    validateRelativeRange(
      entry: entry,
      sectionLength: header.tileDataLength,
      sectionName: 'tile data',
    );
  }

  void validateRelativeRange({
    required PmTilesV3DirectoryEntry entry,
    required int sectionLength,
    required String sectionName,
  }) {
    if (entry.offset < 0 ||
        entry.length <= 0 ||
        entry.offset > sectionLength ||
        entry.length > sectionLength - entry.offset) {
      throw SeismicityPmTilesException.corruptArchive(
        reason: 'A directory entry exceeds the $sectionName section.',
      );
    }
  }
}

final class PmTilesV3DirectoryTraversal {
  const PmTilesV3DirectoryTraversal({
    required this.reader,
    required this.header,
    required this.directoryDecoder,
    required this.validator,
  });

  static const maxDirectoryDepth = 3;

  final SeismicityRandomAccessReader reader;
  final PmTilesV3Header header;
  final PmTilesV3DirectoryDecoder directoryDecoder;
  final PmTilesV3DirectoryValidator validator;

  Future<PmTilesV3DirectoryEntry?> resolveTile({
    required int tileId,
    required List<PmTilesV3DirectoryEntry> entries,
    required int lowerTileId,
    required int upperTileIdExclusive,
    required int depth,
  }) async {
    final index = candidateIndex(entries: entries, tileId: tileId);
    if (index < 0) {
      return null;
    }
    final entry = entries[index];
    if (entry.runLength > 0) {
      return tileId < entry.tileId + entry.runLength ? entry : null;
    }
    validateLeafDepth(depth: depth);
    final childUpper = index + 1 < entries.length
        ? entries[index + 1].tileId
        : upperTileIdExclusive;
    if (tileId >= childUpper) {
      return null;
    }
    final leafEntries = await readLeaf(
      entry: entry,
      lowerTileId: entry.tileId,
      upperTileIdExclusive: childUpper,
    );
    return resolveTile(
      tileId: tileId,
      entries: leafEntries,
      lowerTileId: entry.tileId,
      upperTileIdExclusive: childUpper,
      depth: depth + 1,
    );
  }

  Stream<int> occupiedTileIds({
    required List<PmTilesV3DirectoryEntry> entries,
    required int requestedStart,
    required int requestedEndExclusive,
    required int lowerTileId,
    required int upperTileIdExclusive,
    required int depth,
  }) async* {
    for (var index = 0; index < entries.length; index++) {
      final entry = entries[index];
      final logicalEnd = index + 1 < entries.length
          ? entries[index + 1].tileId
          : upperTileIdExclusive;
      if (entry.runLength > 0) {
        final runEnd = entry.tileId + entry.runLength;
        final start = entry.tileId > requestedStart
            ? entry.tileId
            : requestedStart;
        final end = runEnd < requestedEndExclusive
            ? runEnd
            : requestedEndExclusive;
        for (var tileId = start; tileId < end; tileId++) {
          yield tileId;
        }
        continue;
      }
      if (entry.tileId >= requestedEndExclusive ||
          logicalEnd <= requestedStart) {
        continue;
      }
      validateLeafDepth(depth: depth);
      final leafEntries = await readLeaf(
        entry: entry,
        lowerTileId: entry.tileId,
        upperTileIdExclusive: logicalEnd,
      );
      yield* occupiedTileIds(
        entries: leafEntries,
        requestedStart: requestedStart,
        requestedEndExclusive: requestedEndExclusive,
        lowerTileId: entry.tileId,
        upperTileIdExclusive: logicalEnd,
        depth: depth + 1,
      );
    }
  }

  Future<List<PmTilesV3DirectoryEntry>> readLeaf({
    required PmTilesV3DirectoryEntry entry,
    required int lowerTileId,
    required int upperTileIdExclusive,
  }) async {
    final bytes = await reader.readAt(
      offset: header.leafDirectoriesOffset + entry.offset,
      length: entry.length,
    );
    final entries = directoryDecoder.decode(
      bytes: bytes,
      compression: header.internalCompression,
    );
    validator.validate(
      entries: entries,
      lowerTileId: lowerTileId,
      upperTileIdExclusive: upperTileIdExclusive,
      requireFirstTileId: true,
    );
    return entries;
  }

  int candidateIndex({
    required List<PmTilesV3DirectoryEntry> entries,
    required int tileId,
  }) {
    var low = 0;
    var high = entries.length - 1;
    var candidate = -1;
    while (low <= high) {
      final middle = low + ((high - low) ~/ 2);
      if (entries[middle].tileId <= tileId) {
        candidate = middle;
        low = middle + 1;
      } else {
        high = middle - 1;
      }
    }
    return candidate;
  }

  void validateLeafDepth({required int depth}) {
    if (depth >= maxDirectoryDepth) {
      throw const SeismicityPmTilesException.corruptArchive(
        reason:
            'PMTiles archives deeper than three directory levels '
            'are not supported.',
      );
    }
  }
}
