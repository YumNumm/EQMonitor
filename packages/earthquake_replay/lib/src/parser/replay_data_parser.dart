import 'dart:convert';
import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:earthquake_replay/src/model/replay_data.dart';
import 'package:earthquake_replay/src/model/replay_file_header.dart';
import 'package:msgpack_dart/msgpack_dart.dart';

class ReplayDataParser {
  Future<ReplayData> parse(Uint8List data) async {
    final header = _readHeader(data);
    throw UnimplementedError();
  }

  ReplayFileHeader _readHeader(Uint8List data) {
    print('magic: $magicHeader');
    if (data.length < magicHeader.length) {
      throw Exception('Magic Header is too short');
    }

    final magicHeaderData = data.sublist(0, magicHeader.length);

    if (!const ListEquality<int>().equals(magicHeaderData, magicHeader)) {
      throw Exception('Magic Header is invalid');
    }

    // magic headerを読み飛ばす
    final dataView =
        Uint8List.view(data.buffer, data.offsetInBytes + magicHeader.length);
    final deserializer = Deserializer(
      dataView,
      extDecoder: DateTimeExtDecoder(),
    );
    final headerData = deserializer.decode();
    if (headerData is! List<dynamic>) {
      throw Exception('Header is invalid');
    }
    print(headerData);
    final header = ReplayFileHeader.fromMsgPack(headerData);
    assert(
      header.version == 0,
      'This version is not supported: ${header.version}',
    );
    return header;
  }

  static Uint8List get magicHeader => Uint8List.fromList(
        utf8.encode('EQRP'),
      );
}
