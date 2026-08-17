import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_source.dart';

final class SeismicityPmTilesContentRangeValidator {
  const new();

  Uint8List validate({
    required Headers headers,
    required Uint8List bytes,
    required SeismicityPmTilesNetworkSource source,
    required int requestedOffset,
    required int requestedLength,
    required int expectedSizeBytes,
  }) {
    final expectedEnd = requestedOffset + requestedLength - 1;
    final expectedValue =
        'bytes $requestedOffset-$expectedEnd/$expectedSizeBytes';
    final values = headers['content-range'];
    final receivedValue = values != null && values.length == 1
        ? values.single
        : null;
    final match = receivedValue == null
        ? null
        : RegExp(r'^bytes ([0-9]+)-([0-9]+)/([0-9]+)$').firstMatch(
            receivedValue,
          );
    final actualStart = match == null
        ? null
        : int.tryParse(match.group(1) ?? '');
    final actualEnd = match == null ? null : int.tryParse(match.group(2) ?? '');
    final actualSize = match == null
        ? null
        : int.tryParse(match.group(3) ?? '');
    final hasExpectedRange =
        actualStart == requestedOffset &&
        actualEnd == expectedEnd &&
        actualSize == expectedSizeBytes;
    if (!hasExpectedRange) {
      throw SeismicityPmTilesException.invalidNetworkResponse(
        source: source,
        statusCode: 206,
        reason: 'Content-Range must equal $expectedValue.',
      );
    }
    final receivedLength = bytes.length;
    if (receivedLength != requestedLength) {
      throw SeismicityPmTilesException.invalidNetworkResponse(
        source: source,
        statusCode: 206,
        reason:
            'Expected $requestedLength response bytes but received '
            '$receivedLength.',
      );
    }
    return Uint8List.fromList(bytes);
  }
}
