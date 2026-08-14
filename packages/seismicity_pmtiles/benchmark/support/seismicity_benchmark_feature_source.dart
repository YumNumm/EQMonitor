import 'dart:convert';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:uuid/uuid.dart';

/// One transient deterministic benchmark hypocenter derived from a global
/// index.
final class SeismicityBenchmarkFeature {
  const SeismicityBenchmarkFeature({
    required this.index,
    required this.hypocenterId,
    required this.hypocenterIdText,
    required this.globalX,
    required this.globalY,
    required this.longitude,
    required this.latitude,
    required this.originTimeUnixMilliseconds,
    required this.magnitude,
    required this.depthKm,
    required this.maxIntensityUtf8,
    required this.determinationFlagUtf8,
    required this.earthquakeEventIdUtf8,
    required this.geometryClamped,
    required this.expectedPublicBytes,
  });

  final int index;
  final Uint8List hypocenterId;
  final String hypocenterIdText;
  final int globalX;
  final int globalY;
  final double longitude;
  final double latitude;
  final int originTimeUnixMilliseconds;
  final double? magnitude;
  final double? depthKm;
  final Uint8List? maxIntensityUtf8;
  final Uint8List? determinationFlagUtf8;
  final Uint8List earthquakeEventIdUtf8;
  final bool? geometryClamped;
  final int expectedPublicBytes;
}

/// Stateless index → fixture feature derivation for decoder benchmarks.
final class SeismicityBenchmarkFeatureSource {
  const SeismicityBenchmarkFeatureSource();

  static const dataZoom = 6;
  static const extent = 4096;
  static const int fixedPublicBytesPerRow = 16 + 8 + 8 + 4 + 4 + 8 + 4;

  SeismicityBenchmarkFeature featureAt({required int index}) {
    if (index < 0) {
      throw ArgumentError.value(index, 'index', 'must be non-negative');
    }
    final idText = uuidTextFor(index: index);
    final idBytes = Uint8List.fromList(Uuid.parse(idText));
    final point = pointFor(index: index);
    final magnitude = index.isEven ? index * 0.01 : null;
    final depthKm = index % 3 == 0 ? index * 0.1 : null;
    final maxIntensityUtf8 = intensityUtf8For(index: index);
    final determinationFlagUtf8 = determinationUtf8For(index: index);
    final eventIdUtf8 = Uint8List.fromList(utf8.encode('E$index'));
    final geometryClamped = index % 5 == 0 ? false : null;
    return SeismicityBenchmarkFeature(
      index: index,
      hypocenterId: idBytes,
      hypocenterIdText: idText,
      globalX: point.globalX,
      globalY: point.globalY,
      longitude: point.longitude,
      latitude: point.latitude,
      originTimeUnixMilliseconds: index,
      magnitude: magnitude,
      depthKm: depthKm,
      maxIntensityUtf8: maxIntensityUtf8,
      determinationFlagUtf8: determinationFlagUtf8,
      earthquakeEventIdUtf8: eventIdUtf8,
      geometryClamped: geometryClamped,
      expectedPublicBytes: expectedPublicBytesFor(
        maxIntensityUtf8: maxIntensityUtf8,
      ),
    );
  }

  String uuidTextFor({required int index}) {
    final hi = index >> 32;
    final lo = index & 0xffffffff;
    final bytes = ByteData(16)
      ..setUint32(0, hi)
      ..setUint32(4, lo)
      ..setUint32(8, hi ^ 0xa5a5a5a5)
      ..setUint32(12, lo ^ 0x5a5a5a5a);
    bytes.setUint8(6, (bytes.getUint8(6) & 0x0f) | 0x40);
    bytes.setUint8(8, (bytes.getUint8(8) & 0x3f) | 0x80);
    return Uuid.unparse(bytes.buffer.asUint8List());
  }

  ({int globalX, int globalY, double longitude, double latitude}) pointFor({
    required int index,
  }) {
    const tileCount = 1 << dataZoom;
    const worldWidth = extent * tileCount;
    final globalX = index % worldWidth;
    final globalY = (index ~/ worldWidth) % worldWidth;
    final longitude = globalX / worldWidth * 360 - 180;
    final mercatorY = math.pi * (1 - 2 * globalY / worldWidth);
    final sinh = (math.exp(mercatorY) - math.exp(-mercatorY)) / 2;
    final latitude = math.atan(sinh) * 180 / math.pi;
    return (
      globalX: globalX,
      globalY: globalY,
      longitude: longitude,
      latitude: latitude,
    );
  }

  Uint8List? intensityUtf8For({required int index}) {
    if (index % 4 == 1) {
      return null;
    }
    if (index % 4 == 2) {
      return Uint8List(0);
    }
    return Uint8List.fromList(utf8.encode('I$index'));
  }

  Uint8List? determinationUtf8For({required int index}) {
    if (index % 3 == 1) {
      return null;
    }
    if (index % 3 == 2) {
      return Uint8List(0);
    }
    return Uint8List.fromList(utf8.encode('D$index'));
  }

  int expectedPublicBytesFor({required Uint8List? maxIntensityUtf8}) {
    final intensityBytes = maxIntensityUtf8?.lengthInBytes ?? 0;
    return checkedAdd(left: fixedPublicBytesPerRow, right: intensityBytes);
  }

  int checkedAdd({required int left, required int right}) {
    final sum = left + right;
    if (sum < left || sum < right) {
      throw StateError('Public byte contribution overflowed.');
    }
    return sum;
  }
}
