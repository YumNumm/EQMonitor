import 'dart:typed_data';

import 'package:pmtiles_v3/src/archive/pmtiles_v3_compression_decoder.dart';
import 'package:pmtiles_v3/src/archive/pmtiles_v3_directory_decoder.dart';
import 'package:pmtiles_v3/src/archive/pmtiles_v3_directory_entry.dart';
import 'package:pmtiles_v3/src/archive/pmtiles_v3_header.dart';
import 'package:pmtiles_v3/src/archive/pmtiles_v3_header_decoder.dart';
import 'package:pmtiles_v3/src/archive/pmtiles_v3_tile_id.dart';
import 'package:pmtiles_v3/src/model/pmtiles_v3_exception.dart';
import 'package:pmtiles_v3/src/model/pmtiles_v3_limits.dart';
import 'package:pmtiles_v3/src/reader/pmtiles_random_access_reader.dart';

abstract interface class PmTilesV3Archive {
  static Future<PmTilesV3Archive> open({
    required PmTilesRandomAccessReader reader,
    required PmTilesV3Limits limits,
  }) {
    return const PmTilesV3ArchiveOpener().open(reader: reader, limits: limits);
  }

  PmTilesV3Header get header;

  /// XYZタイル座標からarchive内のtileを読む。z/x/yはHilbert曲線でtile IDへ
  /// 変換したうえで[readTileById]と同じ意味論で解決する。
  Future<Uint8List?> readTile({required int z, required int x, required int y});

  /// archive内部のtile IDから直接tileを読む。z/x/yへ写像しないarchive
  /// （例: seismicityデータのように独自のtile ID割り当てを持つarchive）は
  /// このメソッドを使う。
  Future<Uint8List?> readTileById({required int tileId});

  Stream<int> occupiedTileIdsAtZoom({required int zoom});

  Future<void> close();
}

final class PmTilesV3ArchiveOpener {
  const new({
    this.headerDecoder = const PmTilesV3HeaderDecoder(),
    this.directoryDecoder = const PmTilesV3DirectoryDecoder(),
    this.compressionDecoder = const PmTilesV3CompressionDecoder(),
  });

  final PmTilesV3HeaderDecoder headerDecoder;
  final PmTilesV3DirectoryDecoder directoryDecoder;
  final PmTilesV3CompressionDecoder compressionDecoder;

  Future<PmTilesV3Archive> open({
    required PmTilesRandomAccessReader reader,
    required PmTilesV3Limits limits,
  }) async {
    try {
      const PmTilesV3LimitsValidator().validate(limits);
      final headerBytes = await reader.readAt(
        offset: 0,
        length: PmTilesV3HeaderDecoder.headerLength,
      );
      final header = headerDecoder.decode(
        bytes: headerBytes,
        archiveSizeBytes: reader.sizeBytes,
        limits: limits,
      );
      compressionDecoder
        ..validateSupported(compression: header.internalCompression)
        ..validateSupported(compression: header.tileCompression);
      compressionDecoder.validateLength(
        length: header.rootDirectoryLength,
        maxBytes: limits.maxDirectoryEncodedBytes,
        resource: PmTilesV3Resource.directoryEncoded,
      );
      final rootBytes = await reader.readAt(
        offset: header.rootDirectoryOffset,
        length: header.rootDirectoryLength,
      );
      final rootEntries = directoryDecoder.decode(
        bytes: rootBytes,
        compression: header.internalCompression,
        maxEncodedBytes: limits.maxDirectoryEncodedBytes,
        maxDecodedBytes: limits.maxDirectoryDecodedBytes,
        maxEntries: limits.maxDirectoryEntries,
      );
      const tileId = PmTilesV3TileId();
      final lowerRange = tileId.rangeForZoom(zoom: header.minZoom);
      final upperRange = tileId.rangeForZoom(zoom: header.maxZoom);
      final archiveLowerTileId = lowerRange.start;
      final archiveUpperTileIdExclusive = upperRange.endExclusive;
      final validator = PmTilesV3DirectoryValidator(header: header);
      validator.validate(
        entries: rootEntries,
        lowerTileId: archiveLowerTileId,
        upperTileIdExclusive: archiveUpperTileIdExclusive,
        requireFirstTileId: false,
      );
      final traversal = PmTilesV3DirectoryTraversal(
        reader: reader,
        header: header,
        directoryDecoder: directoryDecoder,
        compressionDecoder: compressionDecoder,
        validator: validator,
        limits: limits,
      );
      // 設計正本(docs/superpowers/specs/2026-08-02-eqmonitor-map-renderer-design.md
      // :210)は、runtimeがarchive全体をscanしてglobal coverageや件数を
      // 再検証するとはしないと定めている。archive全体の先行検証は
      // producer契約がclustered orderingと件数一致を保証する呼び出し側
      // (`limits.validateFullArchiveOnOpen`)だけが明示的に有効化する。
      if (limits.validateFullArchiveOnOpen) {
        await traversal.validateArchive(
          entries: rootEntries,
          upperTileIdExclusive: archiveUpperTileIdExclusive,
          clustered: header.clustered,
        );
      }
      return _PmTilesV3ArchiveImpl(
        reader: reader,
        header: header,
        rootEntries: rootEntries,
        archiveLowerTileId: archiveLowerTileId,
        archiveUpperTileIdExclusive: archiveUpperTileIdExclusive,
        traversal: traversal,
        compressionDecoder: compressionDecoder,
        limits: limits,
      );
    } catch (error, stackTrace) {
      await closeAfterOpenFailure(reader: reader);
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  Future<void> closeAfterOpenFailure({
    required PmTilesRandomAccessReader reader,
  }) async {
    try {
      await reader.close();
      // Reader implementations may throw any error while closing; cleanup must
      // preserve the original open failure regardless of its type.
      // ignore: avoid_catches_without_on_clauses
    } catch (_) {
      // The original open failure and stack are the authoritative failure.
    }
  }
}

final class _PmTilesV3ArchiveImpl implements PmTilesV3Archive {
  new({
    required this.reader,
    required this.header,
    required this.rootEntries,
    required this.archiveLowerTileId,
    required this.archiveUpperTileIdExclusive,
    required this.traversal,
    required this.compressionDecoder,
    required this.limits,
  });

  final PmTilesRandomAccessReader reader;
  @override
  final PmTilesV3Header header;
  final List<PmTilesV3DirectoryEntry> rootEntries;
  final int archiveLowerTileId;
  final int archiveUpperTileIdExclusive;
  final PmTilesV3DirectoryTraversal traversal;
  final PmTilesV3CompressionDecoder compressionDecoder;
  final PmTilesV3Limits limits;
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
      lowerTileId: archiveLowerTileId,
      upperTileIdExclusive: archiveUpperTileIdExclusive,
      depth: 1,
    );
  }

  @override
  Future<Uint8List?> readTile({
    required int z,
    required int x,
    required int y,
  }) {
    return Future<Uint8List?>.sync(() {
      ensureOpen();
      // headerのzoom範囲外は「archiveが持たないzoom」であり、そのzoom内の
      // sparseな欠損とは意味が違う。nullへ丸めずtyped exceptionにする。
      if (z < header.minZoom || z > header.maxZoom) {
        throw PmTilesV3Exception.invalidTileCoordinate(z: z, x: x, y: y);
      }
      final tileId = const PmTilesV3TileId().tileIdForZxy(z: z, x: x, y: y);
      return readTileById(tileId: tileId);
    });
  }

  @override
  Future<Uint8List?> readTileById({required int tileId}) async {
    ensureOpen();
    const PmTilesV3TileId().validateArgument(tileId: tileId);
    final entry = await traversal.resolveTile(
      tileId: tileId,
      entries: rootEntries,
      lowerTileId: archiveLowerTileId,
      upperTileIdExclusive: archiveUpperTileIdExclusive,
      depth: 1,
    );
    if (entry == null) {
      return null;
    }
    compressionDecoder.validateLength(
      length: entry.length,
      maxBytes: limits.maxTileEncodedBytes,
      resource: PmTilesV3Resource.tileEncoded,
    );
    final bytes = await reader.readAt(
      offset: header.tileDataOffset + entry.offset,
      length: entry.length,
    );
    return compressionDecoder.decodeBounded(
      bytes: bytes,
      compression: header.tileCompression,
      maxEncodedBytes: limits.maxTileEncodedBytes,
      maxDecodedBytes: limits.maxTileDecodedBytes,
      encodedResource: PmTilesV3Resource.tileEncoded,
      decodedResource: PmTilesV3Resource.tileDecoded,
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
      throw const PmTilesV3Exception.sourceReadFailed(
        reason: 'The PMTiles archive is closed.',
      );
    }
  }
}

final class PmTilesV3DirectoryValidator {
  const new({required this.header});

  final PmTilesV3Header header;

  void validate({
    required List<PmTilesV3DirectoryEntry> entries,
    required int lowerTileId,
    required int upperTileIdExclusive,
    required bool requireFirstTileId,
  }) {
    if (entries.isEmpty) {
      throw const PmTilesV3Exception.corruptArchive(
        reason: 'A PMTiles directory must not be empty.',
      );
    }
    if (requireFirstTileId && entries.first.tileId != lowerTileId) {
      throw const PmTilesV3Exception.corruptArchive(
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
      throw const PmTilesV3Exception.corruptArchive(
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
      throw const PmTilesV3Exception.corruptArchive(
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
      throw PmTilesV3Exception.corruptArchive(
        reason: 'A directory entry exceeds the $sectionName section.',
      );
    }
  }
}

final class PmTilesV3DirectoryTraversal {
  new({
    required this.reader,
    required this.header,
    required this.directoryDecoder,
    required this.compressionDecoder,
    required this.validator,
    required this.limits,
  });

  final PmTilesRandomAccessReader reader;
  final PmTilesV3Header header;
  final PmTilesV3DirectoryDecoder directoryDecoder;
  final PmTilesV3CompressionDecoder compressionDecoder;
  final PmTilesV3DirectoryValidator validator;
  final PmTilesV3Limits limits;
  final Map<({int offset, int length}), List<PmTilesV3DirectoryEntry>>
  _leafCache = {};

  Future<void> validateArchive({
    required List<PmTilesV3DirectoryEntry> entries,
    required int upperTileIdExclusive,
    required bool clustered,
  }) async {
    final ordering = clustered ? PmTilesV3ClusteredOrdering() : null;
    await validateDirectoryTree(
      entries: entries,
      upperTileIdExclusive: upperTileIdExclusive,
      depth: 1,
      ordering: ordering,
    );
  }

  Future<void> validateDirectoryTree({
    required List<PmTilesV3DirectoryEntry> entries,
    required int upperTileIdExclusive,
    required int depth,
    required PmTilesV3ClusteredOrdering? ordering,
  }) async {
    for (var index = 0; index < entries.length; index++) {
      final entry = entries[index];
      if (entry.runLength > 0) {
        ordering?.validate(entry: entry);
        continue;
      }
      validateLeafDepth(depth: depth);
      final childUpper = index + 1 < entries.length
          ? entries[index + 1].tileId
          : upperTileIdExclusive;
      final children = await readLeaf(
        entry: entry,
        lowerTileId: entry.tileId,
        upperTileIdExclusive: childUpper,
      );
      await validateDirectoryTree(
        entries: children,
        upperTileIdExclusive: childUpper,
        depth: depth + 1,
        ordering: ordering,
      );
    }
  }

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
    final key = (offset: entry.offset, length: entry.length);
    final cached = _leafCache.remove(key);
    final entries = cached ?? await decodeLeaf(entry: entry);
    if (limits.maxCachedLeafDirectories > 0) {
      while (_leafCache.length >= limits.maxCachedLeafDirectories) {
        _leafCache.remove(_leafCache.keys.first);
      }
      _leafCache[key] = entries;
    }
    validator.validate(
      entries: entries,
      lowerTileId: lowerTileId,
      upperTileIdExclusive: upperTileIdExclusive,
      requireFirstTileId: true,
    );
    return entries;
  }

  Future<List<PmTilesV3DirectoryEntry>> decodeLeaf({
    required PmTilesV3DirectoryEntry entry,
  }) async {
    compressionDecoder.validateLength(
      length: entry.length,
      maxBytes: limits.maxDirectoryEncodedBytes,
      resource: PmTilesV3Resource.directoryEncoded,
    );
    final bytes = await reader.readAt(
      offset: header.leafDirectoriesOffset + entry.offset,
      length: entry.length,
    );
    return directoryDecoder.decode(
      bytes: bytes,
      compression: header.internalCompression,
      maxEncodedBytes: limits.maxDirectoryEncodedBytes,
      maxDecodedBytes: limits.maxDirectoryDecodedBytes,
      maxEntries: limits.maxDirectoryEntries,
    );
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
    if (depth >= limits.maxDirectoryDepth) {
      throw const PmTilesV3Exception.corruptArchive(
        reason:
            'PMTiles archives deeper than the configured directory depth '
            'limit are not supported.',
      );
    }
  }
}

final class PmTilesV3ClusteredOrdering {
  final Map<int, int> _contentLengths = {};
  int? _previousContentOffset;
  int? _previousContentEnd;

  void validate({required PmTilesV3DirectoryEntry entry}) {
    final previousOffset = _previousContentOffset;
    final previousEnd = _previousContentEnd;
    if (previousOffset == null || previousEnd == null) {
      validateFirst(entry: entry);
      return;
    }
    final knownLength = _contentLengths[entry.offset];
    final isContiguous = entry.offset == previousEnd;
    final isKnownBackReference =
        entry.offset < previousOffset &&
        knownLength != null &&
        knownLength == entry.length;
    if (isContiguous) {
      validateKnownLength(entry: entry, knownLength: knownLength);
      _contentLengths[entry.offset] = entry.length;
      updatePrevious(entry: entry);
      return;
    }
    if (isKnownBackReference) {
      updatePrevious(entry: entry);
      return;
    }
    throw const PmTilesV3Exception.corruptArchive(
      reason:
          'Clustered content must follow the previous entry or reference '
          'known content at a strictly smaller offset.',
    );
  }

  void validateKnownLength({
    required PmTilesV3DirectoryEntry entry,
    required int? knownLength,
  }) {
    if (knownLength != null && knownLength != entry.length) {
      throw const PmTilesV3Exception.corruptArchive(
        reason: 'A clustered content offset changed its known length.',
      );
    }
  }

  void validateFirst({required PmTilesV3DirectoryEntry entry}) {
    if (entry.offset != 0) {
      throw const PmTilesV3Exception.corruptArchive(
        reason: 'The first clustered tile content offset must be zero.',
      );
    }
    _contentLengths[entry.offset] = entry.length;
    updatePrevious(entry: entry);
  }

  void updatePrevious({required PmTilesV3DirectoryEntry entry}) {
    _previousContentOffset = entry.offset;
    _previousContentEnd = entry.offset + entry.length;
  }
}
