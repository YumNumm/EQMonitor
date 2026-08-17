import 'dart:convert';
import 'dart:typed_data';

import 'package:eqmonitor_map/src/tile/mvt/mvt_decode_exception.dart';
import 'package:eqmonitor_map/src/tile/mvt/mvt_decode_limits.dart';
import 'package:eqmonitor_map/src/tile/mvt/mvt_tile.dart';

/// MVT layerがextentを宣言しない場合の既定値(MVT仕様 v2.1の`optional uint32
/// extent = 5 [default = 4096]`)。extentはlayerごとの宣言値を読むのが原則で、
/// tippecanoe既定出力(4096)前提の値を各所へ散らさないため、fallbackとしての
/// 参照はこの定数1箇所だけに集約する。
const mvtDefaultExtent = 4096;

const _wireTypeVarint = 0;
const _wireType64Bit = 1;
const _wireTypeLengthDelimited = 2;
const _wireType32Bit = 5;

const _geomCommandMoveTo = 1;
const _geomCommandLineTo = 2;
const _geomCommandClosePath = 7;

/// PMTilesから取り出したtile bytesをMVTとしてstrict decodeする。
/// `protobuf`パッケージのコード生成は使わず、wire formatを自前で読む。
MvtTile decodeMvtTile(Uint8List bytes, {required MvtDecodeLimits limits}) {
  return const MvtDecoder().decode(bytes: bytes, limits: limits);
}

final class MvtDecoder {
  const new();

  static const _layerFieldNumber = 3;

  MvtTile decode({required Uint8List bytes, required MvtDecodeLimits limits}) {
    final reader = _ProtoReader(bytes);
    final layers = <MvtLayer>[];
    while (!reader.isAtEnd) {
      final tag = reader.readTag();
      if (tag.fieldNumber == _layerFieldNumber &&
          tag.wireType == _wireTypeLengthDelimited) {
        final layerBytes = reader.readLengthDelimited();
        if (layers.length >= limits.maxLayers) {
          throw MvtDecodeException.limitExceeded(
            reason:
                'A tile exceeds the configured layer limit '
                '(${limits.maxLayers}).',
          );
        }
        layers.add(
          const _MvtLayerDecoder().decode(bytes: layerBytes, limits: limits),
        );
      } else {
        reader.skipField(tag.wireType);
      }
    }
    return MvtTile(layers: List.unmodifiable(layers));
  }
}

final class _MvtLayerDecoder {
  const new();

  static const _nameFieldNumber = 1;
  static const _featuresFieldNumber = 2;
  static const _extentFieldNumber = 5;
  static const _versionFieldNumber = 15;

  MvtLayer decode({required Uint8List bytes, required MvtDecodeLimits limits}) {
    final reader = _ProtoReader(bytes);
    String? name;
    int? version;
    int? extent;
    final features = <MvtFeature>[];
    while (!reader.isAtEnd) {
      final tag = reader.readTag();
      if (tag.fieldNumber == _nameFieldNumber &&
          tag.wireType == _wireTypeLengthDelimited) {
        final nameBytes = reader.readLengthDelimited();
        if (nameBytes.length > limits.maxLayerNameBytes) {
          throw MvtDecodeException.limitExceeded(
            reason:
                'A layer name exceeds the configured byte limit '
                '(${limits.maxLayerNameBytes}).',
          );
        }
        name = utf8.decode(nameBytes);
      } else if (tag.fieldNumber == _featuresFieldNumber &&
          tag.wireType == _wireTypeLengthDelimited) {
        final featureBytes = reader.readLengthDelimited();
        if (features.length >= limits.maxFeaturesPerLayer) {
          throw MvtDecodeException.limitExceeded(
            reason:
                'A layer exceeds the configured feature limit '
                '(${limits.maxFeaturesPerLayer}).',
          );
        }
        features.add(
          const _MvtFeatureDecoder().decode(
            bytes: featureBytes,
            limits: limits,
          ),
        );
      } else if (tag.fieldNumber == _extentFieldNumber &&
          tag.wireType == _wireTypeVarint) {
        extent = reader.readVarintValue();
      } else if (tag.fieldNumber == _versionFieldNumber &&
          tag.wireType == _wireTypeVarint) {
        version = reader.readVarintValue();
      } else {
        reader.skipField(tag.wireType);
      }
    }
    final resolvedName = name;
    if (resolvedName == null) {
      throw const MvtDecodeException.malformedProtobuf(
        reason: 'A layer is missing its required name field.',
      );
    }
    // MVT仕様でversionは`required`。既定値へのfallbackはせず、欠落は
    // malformedとして拒否する。
    final resolvedVersion = version;
    if (resolvedVersion == null) {
      throw const MvtDecodeException.malformedProtobuf(
        reason: 'A layer is missing its required version field.',
      );
    }
    if (resolvedVersion != 1 && resolvedVersion != 2) {
      throw MvtDecodeException.unsupportedLayerVersion(
        version: resolvedVersion,
      );
    }
    final resolvedExtent = extent ?? mvtDefaultExtent;
    if (resolvedExtent <= 0) {
      throw MvtDecodeException.malformedProtobuf(
        reason: 'A layer declares a non-positive extent $resolvedExtent.',
      );
    }
    return MvtLayer(
      name: resolvedName,
      version: resolvedVersion,
      extent: resolvedExtent,
      features: List.unmodifiable(features),
    );
  }
}

final class _MvtFeatureDecoder {
  const new();

  static const _typeFieldNumber = 3;
  static const _geometryFieldNumber = 4;

  MvtFeature decode({
    required Uint8List bytes,
    required MvtDecodeLimits limits,
  }) {
    final reader = _ProtoReader(bytes);
    // GeomType未指定時のprotobuf既定値はUNKNOWN(0)。properties(tag/key/value)
    // とfeature IDはこの縦切りではモデルへ持たせないため、値を保持せずwire上
    // のskipだけ行う。
    var geomTypeValue = 0;
    List<int>? rawCommands;
    while (!reader.isAtEnd) {
      final tag = reader.readTag();
      if (tag.fieldNumber == _typeFieldNumber &&
          tag.wireType == _wireTypeVarint) {
        geomTypeValue = reader.readVarintValue();
      } else if (tag.fieldNumber == _geometryFieldNumber &&
          tag.wireType == _wireTypeLengthDelimited) {
        final geometryBytes = reader.readLengthDelimited();
        rawCommands = _decodePackedVarints(geometryBytes);
      } else {
        reader.skipField(tag.wireType);
      }
    }
    final type = _mapGeometryType(geomTypeValue);
    final rings = const _MvtGeometryDecoder().decode(
      rawCommands: rawCommands ?? const <int>[],
      type: type,
      limits: limits,
    );
    return MvtFeature(type: type, rings: rings);
  }

  MvtGeometryType _mapGeometryType(int value) {
    switch (value) {
      case 1:
        return MvtGeometryType.point;
      case 2:
        return MvtGeometryType.lineString;
      case 3:
        return MvtGeometryType.polygon;
      default:
        throw MvtDecodeException.invalidGeometryCommand(
          reason: 'Unsupported MVT geometry type $value.',
        );
    }
  }

  List<int> _decodePackedVarints(Uint8List bytes) {
    final reader = _ProtoReader(bytes);
    final values = <int>[];
    while (!reader.isAtEnd) {
      values.add(reader.readVarintValue());
    }
    return values;
  }
}

/// commandの総数(繰り返し回数の総和)を、頂点を読み出す前に検証するための
/// 早期チェック。ring/頂点ごとの上限はbufferへ積んだ後に効くのに対し、これは
/// 単一のcommand headerが巨大なcountを宣言した時点でbailoutする。
final class _CommandBudget {
  new({required this.limit});

  final int limit;
  var _total = 0;

  void consume(int count) {
    _total += count;
    if (_total > limit) {
      throw MvtDecodeException.limitExceeded(
        reason: 'A feature exceeds the configured command limit ($limit).',
      );
    }
  }
}

final class _MvtGeometryDecoder {
  const new();

  List<Int32List> decode({
    required List<int> rawCommands,
    required MvtGeometryType type,
    required MvtDecodeLimits limits,
  }) {
    if (rawCommands.isEmpty) {
      throw const MvtDecodeException.invalidGeometryCommand(
        reason: 'A feature has no geometry commands.',
      );
    }
    if (type == MvtGeometryType.point) {
      return _decodePoint(rawCommands: rawCommands, limits: limits);
    }
    return _decodeParts(rawCommands: rawCommands, type: type, limits: limits);
  }

  // Pointは`MoveTo`のみを受理する。count回の繰り返しはMultiPointの各点を
  // 表し、1つのringへ交互のx,yとしてまとめて入れる。
  List<Int32List> _decodePoint({
    required List<int> rawCommands,
    required MvtDecodeLimits limits,
  }) {
    final budget = _CommandBudget(limit: limits.maxCommandsPerFeature);
    final header = _readCommandHeader(rawCommands, 0);
    budget.consume(header.count);
    if (header.id != _geomCommandMoveTo) {
      throw MvtDecodeException.invalidGeometryCommand(
        reason:
            'A point feature must start with a MoveTo command, got '
            'command id ${header.id}.',
      );
    }
    if (header.count < 1) {
      throw const MvtDecodeException.invalidGeometryCommand(
        reason: 'A MoveTo command must repeat at least once.',
      );
    }
    var index = header.nextIndex;
    var x = 0;
    var y = 0;
    final vertices = <int>[];
    for (var i = 0; i < header.count; i++) {
      final params = _readParamPair(rawCommands, index);
      index = params.nextIndex;
      x += _zigZagDecode(params.dx);
      y += _zigZagDecode(params.dy);
      vertices
        ..add(x)
        ..add(y);
      if (vertices.length ~/ 2 > limits.maxVerticesPerRing) {
        throw MvtDecodeException.limitExceeded(
          reason:
              'A point feature exceeds the configured vertex limit '
              '(${limits.maxVerticesPerRing}).',
        );
      }
    }
    if (index != rawCommands.length) {
      throw const MvtDecodeException.invalidGeometryCommand(
        reason:
            'A point feature must contain exactly one MoveTo command '
            'and nothing else.',
      );
    }
    if (limits.maxRingsPerFeature < 1) {
      throw MvtDecodeException.limitExceeded(
        reason:
            'A point feature exceeds the configured ring limit '
            '(${limits.maxRingsPerFeature}).',
      );
    }
    return [Int32List.fromList(vertices)];
  }

  // LineStringとPolygonは、MoveTo(count=1)で始まりLineTo(count>=1)が続く
  // partの繰り返し。Polygonはさらに各partがClosePath(count=1)で閉じる。
  List<Int32List> _decodeParts({
    required List<int> rawCommands,
    required MvtGeometryType type,
    required MvtDecodeLimits limits,
  }) {
    final budget = _CommandBudget(limit: limits.maxCommandsPerFeature);
    final rings = <Int32List>[];
    var index = 0;
    var x = 0;
    var y = 0;
    List<int>? currentPart;
    var currentPartHasLineTo = false;

    void finalizeCurrentPart() {
      final part = currentPart;
      if (part == null) {
        return;
      }
      if (rings.length >= limits.maxRingsPerFeature) {
        throw MvtDecodeException.limitExceeded(
          reason:
              'A feature exceeds the configured ring limit '
              '(${limits.maxRingsPerFeature}).',
        );
      }
      rings.add(Int32List.fromList(part));
      currentPart = null;
      currentPartHasLineTo = false;
    }

    while (index < rawCommands.length) {
      final header = _readCommandHeader(rawCommands, index);
      index = header.nextIndex;
      budget.consume(header.count);
      switch (header.id) {
        case _geomCommandMoveTo:
          if (header.count != 1) {
            throw MvtDecodeException.invalidGeometryCommand(
              reason:
                  'A MoveTo command for $type geometry must repeat '
                  'exactly once, got count ${header.count}.',
            );
          }
          if (type == MvtGeometryType.lineString && currentPart != null) {
            if (!currentPartHasLineTo) {
              throw const MvtDecodeException.invalidGeometryCommand(
                reason:
                    'A LineString part requires at least one LineTo '
                    'command before the next MoveTo.',
              );
            }
            finalizeCurrentPart();
          } else if (type == MvtGeometryType.polygon && currentPart != null) {
            throw const MvtDecodeException.invalidGeometryCommand(
              reason:
                  'A Polygon ring must be closed by ClosePath before the '
                  'next MoveTo.',
            );
          }
          final params = _readParamPair(rawCommands, index);
          index = params.nextIndex;
          x += _zigZagDecode(params.dx);
          y += _zigZagDecode(params.dy);
          currentPart = [x, y];
          currentPartHasLineTo = false;
          if (currentPart!.length ~/ 2 > limits.maxVerticesPerRing) {
            throw MvtDecodeException.limitExceeded(
              reason:
                  'A ring exceeds the configured vertex limit '
                  '(${limits.maxVerticesPerRing}).',
            );
          }
        case _geomCommandLineTo:
          final part = currentPart;
          if (part == null) {
            throw const MvtDecodeException.invalidGeometryCommand(
              reason: 'A LineTo command appeared before any MoveTo.',
            );
          }
          if (header.count < 1) {
            throw const MvtDecodeException.invalidGeometryCommand(
              reason: 'A LineTo command must repeat at least once.',
            );
          }
          for (var i = 0; i < header.count; i++) {
            final params = _readParamPair(rawCommands, index);
            index = params.nextIndex;
            x += _zigZagDecode(params.dx);
            y += _zigZagDecode(params.dy);
            part
              ..add(x)
              ..add(y);
            if (part.length ~/ 2 > limits.maxVerticesPerRing) {
              throw MvtDecodeException.limitExceeded(
                reason:
                    'A ring exceeds the configured vertex limit '
                    '(${limits.maxVerticesPerRing}).',
              );
            }
          }
          currentPartHasLineTo = true;
        case _geomCommandClosePath:
          if (type != MvtGeometryType.polygon) {
            throw MvtDecodeException.invalidGeometryCommand(
              reason:
                  'ClosePath is only valid for polygon geometry, not '
                  '$type.',
            );
          }
          if (currentPart == null) {
            throw const MvtDecodeException.invalidGeometryCommand(
              reason: 'A ClosePath command appeared before any MoveTo.',
            );
          }
          if (header.count != 1) {
            throw MvtDecodeException.invalidGeometryCommand(
              reason:
                  'A ClosePath command must have count exactly 1, got '
                  '${header.count}.',
            );
          }
          if (!currentPartHasLineTo) {
            throw const MvtDecodeException.invalidGeometryCommand(
              reason:
                  'A Polygon ring requires at least one LineTo before '
                  'ClosePath.',
            );
          }
          finalizeCurrentPart();
        default:
          throw MvtDecodeException.invalidGeometryCommand(
            reason: 'Unsupported geometry command id ${header.id}.',
          );
      }
    }

    if (currentPart != null) {
      if (type == MvtGeometryType.polygon) {
        throw const MvtDecodeException.invalidGeometryCommand(
          reason: 'A Polygon ring was not closed by ClosePath.',
        );
      }
      if (!currentPartHasLineTo) {
        throw const MvtDecodeException.invalidGeometryCommand(
          reason: 'A LineString part requires at least one LineTo command.',
        );
      }
      finalizeCurrentPart();
    }

    if (rings.isEmpty) {
      throw const MvtDecodeException.invalidGeometryCommand(
        reason: 'A feature produced no geometry parts.',
      );
    }
    return rings;
  }

  ({int id, int count, int nextIndex}) _readCommandHeader(
    List<int> rawCommands,
    int index,
  ) {
    if (index >= rawCommands.length) {
      throw const MvtDecodeException.invalidGeometryCommand(
        reason: 'The geometry command stream ended unexpectedly.',
      );
    }
    final raw = rawCommands[index];
    return (id: raw & 0x7, count: raw >> 3, nextIndex: index + 1);
  }

  ({int dx, int dy, int nextIndex}) _readParamPair(
    List<int> rawCommands,
    int index,
  ) {
    if (index + 1 >= rawCommands.length) {
      throw const MvtDecodeException.invalidGeometryCommand(
        reason: 'The geometry command stream ended before its parameters.',
      );
    }
    return (
      dx: rawCommands[index],
      dy: rawCommands[index + 1],
      nextIndex: index + 2,
    );
  }

  int _zigZagDecode(int raw) => (raw >> 1) ^ -(raw & 1);
}

/// tile bytesに対するprotobuf wire formatの自前reader。varint、
/// length-delimited、未知field番号のskipをここへ集約し、すべての読み出しで
/// 境界検証を行う。
final class _ProtoReader {
  new(this._bytes) : _length = _bytes.length;

  final Uint8List _bytes;
  final int _length;
  var _offset = 0;

  bool get isAtEnd => _offset >= _length;

  ({int fieldNumber, int wireType}) readTag() {
    final tag = _readVarintValue(maxBytes: 5);
    return (fieldNumber: tag >> 3, wireType: tag & 0x7);
  }

  int readVarintValue() => _readVarintValue(maxBytes: 5);

  void skipVarint() {
    for (var i = 0; i < 10; i++) {
      if (_offset >= _length) {
        throw const MvtDecodeException.malformedProtobuf(
          reason: 'A varint was truncated at the end of the buffer.',
        );
      }
      final byte = _bytes[_offset];
      _offset++;
      if ((byte & 0x80) == 0) {
        return;
      }
    }
    throw const MvtDecodeException.malformedProtobuf(
      reason: 'A varint exceeds the supported 64-bit range.',
    );
  }

  Uint8List readLengthDelimited() {
    final length = _readVarintValue(maxBytes: 5);
    if (length > _length - _offset) {
      throw const MvtDecodeException.malformedProtobuf(
        reason: 'A length-delimited field exceeds the buffer bounds.',
      );
    }
    final view = Uint8List.sublistView(_bytes, _offset, _offset + length);
    _offset += length;
    return view;
  }

  void skipField(int wireType) {
    switch (wireType) {
      case _wireTypeVarint:
        skipVarint();
      case _wireType64Bit:
        _skipFixed(8);
      case _wireTypeLengthDelimited:
        readLengthDelimited();
      case _wireType32Bit:
        _skipFixed(4);
      default:
        throw MvtDecodeException.malformedProtobuf(
          reason: 'Unsupported protobuf wire type $wireType.',
        );
    }
  }

  void _skipFixed(int byteCount) {
    if (byteCount > _length - _offset) {
      throw const MvtDecodeException.malformedProtobuf(
        reason: 'A fixed-width field exceeds the buffer bounds.',
      );
    }
    _offset += byteCount;
  }

  int _readVarintValue({required int maxBytes}) {
    var value = 0;
    var shift = 0;
    for (var i = 0; i < maxBytes; i++) {
      if (_offset >= _length) {
        throw const MvtDecodeException.malformedProtobuf(
          reason: 'A varint was truncated at the end of the buffer.',
        );
      }
      final byte = _bytes[_offset];
      _offset++;
      value |= (byte & 0x7F) << shift;
      if ((byte & 0x80) == 0) {
        return value;
      }
      shift += 7;
    }
    throw const MvtDecodeException.malformedProtobuf(
      reason: 'A varint exceeds the supported 32-bit range.',
    );
  }
}
