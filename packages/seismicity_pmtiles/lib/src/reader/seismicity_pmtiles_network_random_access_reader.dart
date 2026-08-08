import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:pmtiles_v3/pmtiles_v3.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_source.dart';
import 'package:seismicity_pmtiles/src/reader/seismicity_pmtiles_content_range_validator.dart';
import 'package:seismicity_pmtiles/src/reader/seismicity_pmtiles_http_identity_validator.dart';
import 'package:seismicity_pmtiles/src/reader/seismicity_pmtiles_http_range_request.dart';

final class SeismicityPmTilesNetworkRandomAccessReader
    implements PmTilesRandomAccessReader {
  SeismicityPmTilesNetworkRandomAccessReader({
    required this.source,
    required this.dio,
    required this.sizeBytes,
    required this.cancelToken,
    SeismicityPmTilesHttpRangeRequestBuilder requestBuilder =
        const SeismicityPmTilesHttpRangeRequestBuilder(),
    SeismicityPmTilesHttpIdentityValidator identityValidator =
        const SeismicityPmTilesHttpIdentityValidator(),
    SeismicityPmTilesContentRangeValidator contentRangeValidator =
        const SeismicityPmTilesContentRangeValidator(),
  }) : _requestBuilder = requestBuilder,
       _identityValidator = identityValidator,
       _contentRangeValidator = contentRangeValidator;

  final SeismicityPmTilesNetworkSource source;
  final Dio dio;
  @override
  final int sizeBytes;
  final CancelToken cancelToken;
  final SeismicityPmTilesHttpRangeRequestBuilder _requestBuilder;
  final SeismicityPmTilesHttpIdentityValidator _identityValidator;
  final SeismicityPmTilesContentRangeValidator _contentRangeValidator;

  String? _strongEtag;

  @override
  Future<Uint8List> readAt({required int offset, required int length}) async {
    final response = await dio.getUri<Uint8List>(
      source.archiveUri,
      options: _requestBuilder.build(
        offset: offset,
        length: length,
        sizeBytes: sizeBytes,
        strongEtag: _strongEtag,
      ),
      cancelToken: cancelToken,
    );
    final statusCode = response.statusCode;
    if (statusCode == null) {
      throw SeismicityPmTilesException.networkRequestFailed(
        source: source,
        statusCode: null,
      );
    }
    final receivedEtag = _identityValidator.validate(
      statusCode: statusCode,
      headers: response.headers,
      source: source,
      expectedEtag: _strongEtag,
    );
    final bytes = response.data;
    if (bytes == null) {
      throw SeismicityPmTilesException.invalidNetworkResponse(
        source: source,
        statusCode: statusCode,
        reason: 'Expected $length response bytes but received 0.',
      );
    }
    final validated = _contentRangeValidator.validate(
      headers: response.headers,
      bytes: bytes,
      source: source,
      requestedOffset: offset,
      requestedLength: length,
      expectedSizeBytes: sizeBytes,
    );
    _strongEtag = receivedEtag;
    return validated;
  }

  @override
  Future<void> close() async {}
}
