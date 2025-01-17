import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:earthquake_replay/src/model/replay_data.dart';
import 'package:earthquake_replay/src/model/replay_file_header.dart';
import 'package:es_compression/brotli.dart';
import 'package:es_compression/lz4.dart';
import 'package:msgpack_dart/msgpack_dart.dart';

class ReplayDataParser {
  ReplayFile parse(Uint8List data) {
    if (data.length < magicHeader.length) {
      throw Exception('Magic Header is too short');
    }
    final magicHeaderData = Uint8List.view(
      data.buffer,
      data.offsetInBytes,
      magicHeader.length,
    );
    if (!const ListEquality<int>().equals(magicHeaderData, magicHeader)) {
      throw Exception('Magic Header is invalid');
    }

    final headerDataView = Uint8List.view(
      data.buffer,
      data.offsetInBytes + magicHeader.length,
    );
    final (header, headerOffset) = _readHeader(headerDataView);
    print((header, headerOffset));

    final dataView = Uint8List.view(
      data.buffer,
      data.offsetInBytes + magicHeader.length + headerOffset,
    );
    final decompressedData = switch (header.compressionMode) {
      ReplayFileCompressionMode.none => dataView,
      ReplayFileCompressionMode.gzip => gzip.decode(dataView),
      ReplayFileCompressionMode.brotli => brotli.decode(dataView),
      ReplayFileCompressionMode.messagePackCSharpLz4BlockArray =>
        lz4.decode(dataView),
    };
    final replayData = _parseReplayData(decompressedData as Uint8List);
    return ReplayFile(
      header: header,
      data: replayData,
    );
  }

  (ReplayFileHeader, int offset) _readHeader(Uint8List data) {
    final deserializer = Deserializer(
      data,
      extDecoder: ExtTimeStampDecoder(),
    );
    final headerData = deserializer.decode();
    if (headerData is! List<dynamic>) {
      throw Exception('Header is invalid: ${headerData.runtimeType}');
    }
    print(headerData);
    final header = ReplayFileHeader.fromMsgPack(headerData);
    assert(
      header.version == 0,
      'This version is not supported: ${header.version}',
    );
    return (header, deserializer.offset);
  }

  List<ReplayData> _parseReplayData(Uint8List data) {
    final result = <ReplayData>[];
    final deserializer = Deserializer(
      data,
      extDecoder: ExtTimeStampDecoder(),
    );
    final replayData = deserializer.decode() as List<dynamic>;
    for (final data in replayData) {
      if (data is List<dynamic>) {
        result.add(ReplayData.fromMsgPack(data));
      } else {
        throw Exception('Invalid replay data: ${data.runtimeType}');
      }
    }
    return result;
  }

  static Uint8List get magicHeader => Uint8List.fromList(
        utf8.encode('EQRP'),
      );
}

class ReplayFile {
  const ReplayFile({
    required this.header,
    required this.data,
  });

  final ReplayFileHeader header;
  final List<ReplayData> data;

  @override
  String toString() => 'ReplayFile(header: $header, data: $data)';
}
