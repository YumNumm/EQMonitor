import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:pmtiles_v3/src/archive/pmtiles_v3_compression_decoder.dart';
import 'package:pmtiles_v3/src/archive/pmtiles_v3_directory_entry.dart';
import 'package:pmtiles_v3/src/archive/pmtiles_v3_header_decoder.dart';

sealed class PmTilesV3FixtureNode {
  const PmTilesV3FixtureNode({required this.tileId});

  final int tileId;
}

final class PmTilesV3FixtureTile extends PmTilesV3FixtureNode {
  const PmTilesV3FixtureTile({
    required super.tileId,
    required this.bytes,
    this.runLength = 1,
    this.contentOffset,
  });

  final List<int> bytes;
  final int runLength;
  final int? contentOffset;
}

final class PmTilesV3FixtureLeaf extends PmTilesV3FixtureNode {
  const PmTilesV3FixtureLeaf({
    required super.tileId,
    required this.entries,
  });

  final List<PmTilesV3FixtureNode> entries;
}

final class PmTilesV3Fixture {
  const PmTilesV3Fixture({required this.bytes});

  final Uint8List bytes;
}

final class PmTilesV3FixtureBuilder {
  const PmTilesV3FixtureBuilder();

  PmTilesV3Fixture build({
    required List<PmTilesV3FixtureNode> rootEntries,
    int internalCompression = PmTilesV3CompressionDecoder.none,
    int tileCompression = PmTilesV3CompressionDecoder.none,
    int minZoom = 0,
    int maxZoom = 2,
    bool clustered = true,
  }) {
    final assembly = PmTilesV3FixtureAssembly(
      internalCompression: internalCompression,
      tileCompression: tileCompression,
      clustered: clustered,
    );
    final rootDirectory = assembly.assembleDirectory(nodes: rootEntries);
    final metadata = assembly.compressInternal(
      bytes: Uint8List.fromList(utf8.encode('{}')),
    );
    const rootOffset = PmTilesV3HeaderDecoder.headerLength;
    final metadataOffset = rootOffset + rootDirectory.length;
    final leafOffset = metadataOffset + metadata.length;
    final tileOffset = leafOffset + assembly.leafBytes.length;
    final archiveLength = tileOffset + assembly.tileBytes.length;
    final header = assembly.buildHeader(
      archiveLength: archiveLength,
      rootOffset: rootOffset,
      rootLength: rootDirectory.length,
      metadataOffset: metadataOffset,
      metadataLength: metadata.length,
      leafOffset: leafOffset,
      minZoom: minZoom,
      maxZoom: maxZoom,
    );
    final archive = BytesBuilder(copy: false)
      ..add(header)
      ..add(rootDirectory)
      ..add(metadata)
      ..add(assembly.leafBytes.toBytes())
      ..add(assembly.tileBytes.toBytes());
    return PmTilesV3Fixture(bytes: archive.toBytes());
  }
}

final class PmTilesV3FixtureAssembly {
  PmTilesV3FixtureAssembly({
    required this.internalCompression,
    required this.tileCompression,
    required this.clustered,
  });

  final int internalCompression;
  final int tileCompression;
  final bool clustered;
  final leafBytes = BytesBuilder(copy: false);
  final tileBytes = BytesBuilder(copy: false);
  var _addressedTilesCount = 0;
  var _tileEntriesCount = 0;
  var _tileContentsCount = 0;

  Uint8List assembleDirectory({
    required List<PmTilesV3FixtureNode> nodes,
  }) {
    final entries = <PmTilesV3DirectoryEntry>[];
    for (final node in nodes) {
      switch (node) {
        case PmTilesV3FixtureTile():
          final content = compressTile(bytes: Uint8List.fromList(node.bytes));
          final offset = node.contentOffset ?? tileBytes.length;
          appendTileContent(offset: offset, content: content);
          entries.add(
            PmTilesV3DirectoryEntry(
              tileId: node.tileId,
              offset: offset,
              length: content.length,
              runLength: node.runLength,
            ),
          );
          _addressedTilesCount += node.runLength;
          _tileEntriesCount++;
        case PmTilesV3FixtureLeaf():
          final directory = assembleDirectory(nodes: node.entries);
          final offset = leafBytes.length;
          leafBytes.add(directory);
          entries.add(
            PmTilesV3DirectoryEntry(
              tileId: node.tileId,
              offset: offset,
              length: directory.length,
              runLength: 0,
            ),
          );
      }
    }
    return compressInternal(bytes: encodeDirectory(entries: entries));
  }

  void appendTileContent({required int offset, required Uint8List content}) {
    if (offset < 0) {
      throw StateError('Fixture content offset must not be negative.');
    }
    if (offset > tileBytes.length) {
      tileBytes.add(Uint8List(offset - tileBytes.length));
    }
    if (offset == tileBytes.length) {
      tileBytes.add(content);
      _tileContentsCount++;
      return;
    }
    if (offset + content.length > tileBytes.length) {
      throw StateError('Shared fixture content exceeds existing tile bytes.');
    }
  }

  Uint8List encodeDirectory({
    required List<PmTilesV3DirectoryEntry> entries,
  }) {
    final output = BytesBuilder(copy: false)..add(encodeVarint(entries.length));
    var previousTileId = 0;
    for (final entry in entries) {
      output.add(encodeVarint(entry.tileId - previousTileId));
      previousTileId = entry.tileId;
    }
    for (final entry in entries) {
      output.add(encodeVarint(entry.runLength));
    }
    for (final entry in entries) {
      output.add(encodeVarint(entry.length));
    }
    var nextContiguousOffset = 0;
    for (var index = 0; index < entries.length; index++) {
      final entry = entries[index];
      final encodedOffset = index > 0 && entry.offset == nextContiguousOffset
          ? 0
          : entry.offset + 1;
      output.add(encodeVarint(encodedOffset));
      nextContiguousOffset = entry.offset + entry.length;
    }
    return output.toBytes();
  }

  Uint8List encodeVarint(int value) {
    final output = <int>[];
    var remaining = value;
    do {
      var byte = remaining & 0x7F;
      remaining >>= 7;
      if (remaining > 0) {
        byte |= 0x80;
      }
      output.add(byte);
    } while (remaining > 0);
    return Uint8List.fromList(output);
  }

  Uint8List compressInternal({required Uint8List bytes}) {
    return compress(bytes: bytes, compression: internalCompression);
  }

  Uint8List compressTile({required Uint8List bytes}) {
    return compress(bytes: bytes, compression: tileCompression);
  }

  Uint8List compress({
    required Uint8List bytes,
    required int compression,
  }) {
    return compression == PmTilesV3CompressionDecoder.gzipCompression
        ? Uint8List.fromList(gzip.encode(bytes))
        : bytes;
  }

  Uint8List buildHeader({
    required int archiveLength,
    required int rootOffset,
    required int rootLength,
    required int metadataOffset,
    required int metadataLength,
    required int leafOffset,
    required int minZoom,
    required int maxZoom,
  }) {
    final header = Uint8List(PmTilesV3HeaderDecoder.headerLength);
    header.setRange(
      0,
      PmTilesV3HeaderDecoder.magic.length,
      PmTilesV3HeaderDecoder.magic,
    );
    header[7] = 3;
    ByteData.sublistView(header)
      ..setUint64(8, rootOffset, Endian.little)
      ..setUint64(16, rootLength, Endian.little)
      ..setUint64(24, metadataOffset, Endian.little)
      ..setUint64(32, metadataLength, Endian.little)
      ..setUint64(40, leafOffset, Endian.little)
      ..setUint64(48, leafBytes.length, Endian.little)
      ..setUint64(56, leafOffset + leafBytes.length, Endian.little)
      ..setUint64(64, tileBytes.length, Endian.little)
      ..setUint64(72, _addressedTilesCount, Endian.little)
      ..setUint64(80, _tileEntriesCount, Endian.little)
      ..setUint64(88, _tileContentsCount, Endian.little)
      ..setUint8(96, clustered ? 1 : 0)
      ..setUint8(97, internalCompression)
      ..setUint8(98, tileCompression)
      ..setUint8(99, PmTilesV3HeaderDecoder.mvtTileType)
      ..setUint8(100, minZoom)
      ..setUint8(101, maxZoom)
      ..setInt32(102, 1220000000, Endian.little)
      ..setInt32(106, 200000000, Endian.little)
      ..setInt32(110, 1540000000, Endian.little)
      ..setInt32(114, 460000000, Endian.little)
      ..setUint8(118, minZoom)
      ..setInt32(119, 1380000000, Endian.little)
      ..setInt32(123, 350000000, Endian.little);
    if (archiveLength !=
        PmTilesV3HeaderDecoder.headerLength +
            rootLength +
            metadataLength +
            leafBytes.length +
            tileBytes.length) {
      throw StateError('Fixture section lengths do not match archive length.');
    }
    return header;
  }
}
