import 'dart:convert';
import 'dart:typed_data';

/// `eqmonitor_map` の tile 契約 test が必要とする最小限の PMTiles v3 archive
/// (root directory のみ・leaf なし・無圧縮・tile 1枚)を自前で組み立てる。
///
/// `pmtiles_v3` 側にも汎用の fixture builder
/// (`packages/pmtiles_v3/test/support/pmtiles_v3_fixture_builder.dart`)があるが、
/// `test/` 配下は package の `lib/` 外にあるため `package:pmtiles_v3/...`
/// import では参照できず、パッケージを跨いだ相対 import はこのリポジトリの規約
/// (CLAUDE.md: cross-package import は package import を使う)に反する。そのため
/// この package の test が必要とする分だけをここで組み立てる
/// (`packages/seismicity_pmtiles/test/archive/seismicity_pmtiles_archive_test.dart`
/// と同じ方針)。
///
/// header の各 offset は PMTiles v3 spec の固定レイアウトであり、
/// `pmtiles_v3` の `PmTilesV3HeaderDecoder` が読む位置と一致させている。
final class MinimalPmTilesArchiveBuilder {
  const new();

  /// PMTiles v3 header は固定長 127 byte。
  static const headerLength = 127;

  /// `PmTilesV3CompressionDecoder.none`。
  static const _compressionNone = 1;

  /// `PmTilesV3HeaderDecoder.mvtTileType`。
  static const _mvtTileType = 1;

  /// ASCII `PMTiles`。
  static const _magic = <int>[0x50, 0x4D, 0x54, 0x69, 0x6C, 0x65, 0x73];

  static const _varint = PmTilesVarintEncoder();

  /// [tileId]1件だけを root directory に持つ clustered archive を返す。
  Uint8List buildSingleTile({
    required int tileId,
    required List<int> tileBytes,
    required int minZoom,
    required int maxZoom,
  }) {
    final directory = Uint8List.fromList([
      ..._varint.encode(1), // entry count
      ..._varint.encode(tileId), // tileId delta (previous is 0)
      ..._varint.encode(1), // runLength
      ..._varint.encode(tileBytes.length), // content length
      ..._varint.encode(1), // content offset 0 は `offset + 1` として符号化する
    ]);
    final metadata = Uint8List.fromList(utf8.encode('{}'));

    const rootOffset = headerLength;
    final metadataOffset = rootOffset + directory.length;
    final leafOffset = metadataOffset + metadata.length;
    final tileDataOffset = leafOffset; // leaf directory は持たない

    final header = Uint8List(headerLength)..setRange(0, _magic.length, _magic);
    header[7] = 3; // spec version
    ByteData.sublistView(header)
      ..setUint64(8, rootOffset, Endian.little)
      ..setUint64(16, directory.length, Endian.little)
      ..setUint64(24, metadataOffset, Endian.little)
      ..setUint64(32, metadata.length, Endian.little)
      ..setUint64(40, leafOffset, Endian.little)
      ..setUint64(48, 0, Endian.little) // leaf directory length
      ..setUint64(56, tileDataOffset, Endian.little)
      ..setUint64(64, tileBytes.length, Endian.little)
      ..setUint64(72, 1, Endian.little) // addressed tiles
      ..setUint64(80, 1, Endian.little) // tile entries
      ..setUint64(88, 1, Endian.little) // tile contents
      ..setUint8(96, 1) // clustered
      ..setUint8(97, _compressionNone) // internal compression
      ..setUint8(98, _compressionNone) // tile compression
      ..setUint8(99, _mvtTileType)
      ..setUint8(100, minZoom)
      ..setUint8(101, maxZoom)
      ..setInt32(102, 1220000000, Endian.little) // min lon (E7)
      ..setInt32(106, 200000000, Endian.little) // min lat (E7)
      ..setInt32(110, 1540000000, Endian.little) // max lon (E7)
      ..setInt32(114, 460000000, Endian.little) // max lat (E7)
      ..setUint8(118, minZoom) // center zoom
      ..setInt32(119, 1380000000, Endian.little) // center lon (E7)
      ..setInt32(123, 350000000, Endian.little); // center lat (E7)

    return (BytesBuilder(copy: false)
          ..add(header)
          ..add(directory)
          ..add(metadata)
          ..add(Uint8List.fromList(tileBytes)))
        .toBytes();
  }
}

/// PMTiles v3 の directory が使う LEB128 可変長整数の符号化。
///
/// リポジトリ規約により top-level 関数もクラス内 private メソッドも使えないため、
/// 単体で test 可能な公開クラスとして切り出している。
final class PmTilesVarintEncoder {
  const new();

  List<int> encode(int value) {
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
    return output;
  }
}
