import 'dart:convert';
import 'dart:typed_data';

/// テスト用にMVT protobuf bytesを手組みするbuilder。`protobuf`パッケージの
/// コード生成には頼らず、production側のwire readerと対称な素朴なvarint/
/// tag encoderだけで組み立てる。
final class MvtFixtureBuilder {
  const new();

  static const geomTypePoint = 1;
  static const geomTypeLineString = 2;
  static const geomTypePolygon = 3;

  static const _moveTo = 1;
  static const _lineTo = 2;
  static const _closePath = 7;

  Uint8List buildTile({required List<Uint8List> layers}) {
    final output = BytesBuilder(copy: false);
    for (final layer in layers) {
      output
        ..add(encodeTag(fieldNumber: 3, wireType: 2))
        ..add(encodeLengthDelimited(layer));
    }
    return output.toBytes();
  }

  Uint8List buildLayer({
    required String name,
    List<Uint8List> features = const [],
    int? version = 2,
    int? extent,
  }) {
    final output = BytesBuilder(copy: false)
      ..add(encodeTag(fieldNumber: 1, wireType: 2))
      ..add(encodeLengthDelimited(Uint8List.fromList(utf8.encode(name))));
    for (final feature in features) {
      output
        ..add(encodeTag(fieldNumber: 2, wireType: 2))
        ..add(encodeLengthDelimited(feature));
    }
    if (extent != null) {
      output
        ..add(encodeTag(fieldNumber: 5, wireType: 0))
        ..add(encodeVarint(extent));
    }
    if (version != null) {
      output
        ..add(encodeTag(fieldNumber: 15, wireType: 0))
        ..add(encodeVarint(version));
    }
    return output.toBytes();
  }

  Uint8List buildFeature({
    required int geomType,
    required List<int> rawCommands,
    bool includeId = false,
  }) {
    final output = BytesBuilder(copy: false);
    if (includeId) {
      output
        ..add(encodeTag(fieldNumber: 1, wireType: 0))
        ..add(encodeVarint(1));
    }
    output
      ..add(encodeTag(fieldNumber: 3, wireType: 0))
      ..add(encodeVarint(geomType));
    final geometry = BytesBuilder(copy: false);
    for (final value in rawCommands) {
      geometry.add(encodeVarint(value));
    }
    output
      ..add(encodeTag(fieldNumber: 4, wireType: 2))
      ..add(encodeLengthDelimited(geometry.toBytes()));
    return output.toBytes();
  }

  /// `MoveTo`の1回の繰り返しと、それに続く(dx, dy)ペアを1組ぶんの
  /// commandを積む。
  List<int> moveTo(List<(int, int)> points) {
    final commands = <int>[commandHeader(id: _moveTo, count: points.length)];
    for (final (dx, dy) in points) {
      commands
        ..add(zigZagEncode(dx))
        ..add(zigZagEncode(dy));
    }
    return commands;
  }

  List<int> lineTo(List<(int, int)> points) {
    final commands = <int>[commandHeader(id: _lineTo, count: points.length)];
    for (final (dx, dy) in points) {
      commands
        ..add(zigZagEncode(dx))
        ..add(zigZagEncode(dy));
    }
    return commands;
  }

  List<int> closePath() => [commandHeader(id: _closePath, count: 1)];

  int commandHeader({required int id, required int count}) => (count << 3) | id;

  int zigZagEncode(int value) => value >= 0 ? value * 2 : (-value * 2) - 1;

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

  Uint8List encodeTag({required int fieldNumber, required int wireType}) =>
      encodeVarint((fieldNumber << 3) | wireType);

  Uint8List encodeLengthDelimited(Uint8List content) {
    final output = BytesBuilder(copy: false)
      ..add(encodeVarint(content.length))
      ..add(content);
    return output.toBytes();
  }
}
