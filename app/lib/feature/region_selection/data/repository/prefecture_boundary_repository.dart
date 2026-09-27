import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'prefecture_boundary_repository.g.dart';

@Riverpod(keepAlive: true)
Future<String> prefectureBoundaryGeoJson(Ref ref) async {
  final data = await rootBundle.load('assets/prefecture_boundaries.geojson.gz');
  return compute(
    const PrefectureBoundaryDecoder().decode,
    data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
  );
}

final class const PrefectureBoundaryDecoder() {
  String decode(Uint8List bytes) => utf8.decode(gzip.decode(bytes));
}
