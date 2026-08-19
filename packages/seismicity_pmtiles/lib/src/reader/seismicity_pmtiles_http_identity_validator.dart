import 'package:dio/dio.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_source.dart';
import 'package:seismicity_pmtiles/src/reader/seismicity_pmtiles_http_range_request.dart';

final class SeismicityPmTilesHttpIdentityValidator {
  const new();

  String validate({
    required int statusCode,
    required Headers headers,
    required SeismicityPmTilesNetworkSource source,
    required String? expectedEtag,
  }) {
    final etagValues = headers['etag'];
    final receivedEtag = switch (etagValues) {
      [final value] => value,
      _ => null,
    };
    if (statusCode == 412) {
      throw SeismicityPmTilesException.archiveChanged(
        source: source,
        expectedEtag: expectedEtag,
        receivedEtag: receivedEtag,
        statusCode: statusCode,
      );
    }
    if (statusCode != 206) {
      throw SeismicityPmTilesException.invalidNetworkResponse(
        source: source,
        statusCode: statusCode,
        reason: 'Expected HTTP 206 Partial Content.',
      );
    }
    final hasValidEtag =
        receivedEtag != null &&
        const SeismicityPmTilesStrongEtagValidator().isValid(
          value: receivedEtag,
        );
    if (!hasValidEtag ||
        (expectedEtag != null && expectedEtag != receivedEtag)) {
      throw SeismicityPmTilesException.archiveChanged(
        source: source,
        expectedEtag: expectedEtag,
        receivedEtag: receivedEtag,
        statusCode: statusCode,
      );
    }
    return receivedEtag;
  }
}
