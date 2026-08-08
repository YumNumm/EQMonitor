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
    required int maxCacheBytes,
    SeismicityPmTilesHttpRangeRequestBuilder requestBuilder =
        const SeismicityPmTilesHttpRangeRequestBuilder(),
    SeismicityPmTilesHttpIdentityValidator identityValidator =
        const SeismicityPmTilesHttpIdentityValidator(),
    SeismicityPmTilesContentRangeValidator contentRangeValidator =
        const SeismicityPmTilesContentRangeValidator(),
  }) : _requestBuilder = requestBuilder,
       _identityValidator = identityValidator,
       _contentRangeValidator = contentRangeValidator,
       _cache = SeismicityPmTilesNetworkRangeLruCache(
         maxBytes: maxCacheBytes,
       );

  final SeismicityPmTilesNetworkSource source;
  final Dio dio;
  @override
  final int sizeBytes;
  final CancelToken cancelToken;
  final SeismicityPmTilesHttpRangeRequestBuilder _requestBuilder;
  final SeismicityPmTilesHttpIdentityValidator _identityValidator;
  final SeismicityPmTilesContentRangeValidator _contentRangeValidator;
  final SeismicityPmTilesNetworkRangeLruCache _cache;

  String? _strongEtag;

  @override
  Future<Uint8List> readAt({required int offset, required int length}) async {
    final cached = switch (_strongEtag) {
      final strongEtag? => _cache.read(
        archiveUri: source.archiveUri,
        strongEtag: strongEtag,
        offset: offset,
        length: length,
      ),
      null => null,
    };
    if (cached != null) {
      return cached;
    }
    late final Response<Uint8List> response;
    try {
      response = await dio.getUri<Uint8List>(
        source.archiveUri,
        options: _requestBuilder.build(
          offset: offset,
          length: length,
          sizeBytes: sizeBytes,
          strongEtag: _strongEtag,
        ),
        cancelToken: cancelToken,
      );
    } on DioException catch (exception) {
      if (exception.type == DioExceptionType.cancel) {
        rethrow;
      }
      throw SeismicityPmTilesException.networkRequestFailed(
        source: source,
        statusCode: exception.response?.statusCode,
      );
    }
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
    _cache.write(
      archiveUri: source.archiveUri,
      strongEtag: receivedEtag,
      offset: offset,
      length: length,
      bytes: validated,
    );
    return validated;
  }

  @override
  Future<void> close() async {}
}

final class SeismicityPmTilesNetworkRangeLruCache {
  SeismicityPmTilesNetworkRangeLruCache({required this.maxBytes});

  final int maxBytes;
  final _entries =
      <
        ({Uri archiveUri, String strongEtag, int offset, int length}),
        Uint8List
      >{};
  var _aggregateBytes = 0;

  Uint8List? read({
    required Uri archiveUri,
    required String strongEtag,
    required int offset,
    required int length,
  }) {
    final key = (
      archiveUri: archiveUri,
      strongEtag: strongEtag,
      offset: offset,
      length: length,
    );
    final cached = _entries.remove(key);
    if (cached == null) {
      return null;
    }
    _entries[key] = cached;
    return Uint8List.fromList(cached);
  }

  void write({
    required Uri archiveUri,
    required String strongEtag,
    required int offset,
    required int length,
    required Uint8List bytes,
  }) {
    final value = Uint8List.fromList(bytes);
    if (value.length > maxBytes) {
      return;
    }
    final key = (
      archiveUri: archiveUri,
      strongEtag: strongEtag,
      offset: offset,
      length: length,
    );
    final replaced = _entries.remove(key);
    if (replaced != null) {
      _aggregateBytes -= replaced.length;
    }
    _entries[key] = value;
    _aggregateBytes += value.length;
    while (_aggregateBytes > maxBytes) {
      final oldest = _entries.entries.first;
      _entries.remove(oldest.key);
      _aggregateBytes -= oldest.value.length;
    }
  }
}
