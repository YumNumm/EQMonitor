import 'dart:async';
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
  }) : _callerCancellationWasPreexisting = cancelToken.isCancelled,
       _requestBuilder = requestBuilder,
       _identityValidator = identityValidator,
       _contentRangeValidator = contentRangeValidator,
       _cache = SeismicityPmTilesNetworkRangeLruCache(
         maxBytes: maxCacheBytes,
       ) {
    if (_callerCancellationWasPreexisting) {
      _callerCancellationBarrier.complete();
    } else {
      cancelToken.whenCancel.then<void>((_) async {
        final activeTokens = _activeRequestTokens.toList();
        final activeRequests = _inFlight.values.toSet().toList();
        for (final token in activeTokens) {
          token.cancel('Caller cancelled request.');
        }
        await Future.wait(
          activeRequests.map(
            (request) => request.then<void>((_) {}, onError: (_, _) {}),
          ),
        );
        _callerCancellationBarrier.complete();
      }).ignore();
    }
  }

  final SeismicityPmTilesNetworkSource source;
  final Dio dio;
  @override
  final int sizeBytes;
  final CancelToken cancelToken;
  final SeismicityPmTilesHttpRangeRequestBuilder _requestBuilder;
  final SeismicityPmTilesHttpIdentityValidator _identityValidator;
  final SeismicityPmTilesContentRangeValidator _contentRangeValidator;
  final SeismicityPmTilesNetworkRangeLruCache _cache;
  final _activeRequestTokens = <CancelToken>{};
  final _callerCancellationBarrier = Completer<void>();
  final bool _callerCancellationWasPreexisting;

  String? _strongEtag;
  SeismicityPmTilesArchiveChangedException? _terminalArchiveFailure;
  Future<Uint8List>? _initialIdentityFuture;
  final _inFlight =
      <
        ({Uri archiveUri, String? strongEtag, int offset, int length}),
        Future<Uint8List>
      >{};

  @override
  Future<Uint8List> readAt({required int offset, required int length}) {
    try {
      const PmTilesV3RangeValidator().validate(
        offset: offset,
        length: length,
        sizeBytes: sizeBytes,
      );
    } on PmTilesV3InvalidRangeException catch (exception, stackTrace) {
      return Future<Uint8List>.error(exception, stackTrace);
    }
    if (_callerCancellationWasPreexisting) {
      return Future<Uint8List>.error(
        SeismicityPmTilesException.cancelled(source: source),
      );
    }
    if (cancelToken.isCancelled && !_callerCancellationBarrier.isCompleted) {
      return _callerCancellationBarrier.future.then(
        (_) => readAt(offset: offset, length: length),
      );
    }
    final terminalArchiveFailure = _terminalArchiveFailure;
    if (terminalArchiveFailure != null) {
      return Future<Uint8List>.error(terminalArchiveFailure);
    }
    final strongEtag = _strongEtag;
    final cached = switch (strongEtag) {
      final strongEtag? => _cache.read(
        archiveUri: source.archiveUri,
        strongEtag: strongEtag,
        offset: offset,
        length: length,
      ),
      null => null,
    };
    if (cached != null) {
      return Future<Uint8List>.value(cached);
    }
    final key = (
      archiveUri: source.archiveUri,
      strongEtag: strongEtag,
      offset: offset,
      length: length,
    );
    final inFlight = _inFlight[key];
    if (inFlight != null) {
      return inFlight;
    }
    final initialIdentityFuture = _initialIdentityFuture;
    if (strongEtag == null && initialIdentityFuture != null) {
      final waitingRequest = initialIdentityFuture.then<Uint8List>(
        (_) => readAt(offset: offset, length: length),
      );
      _inFlight[key] = waitingRequest;
      waitingRequest.whenComplete(() {
        if (identical(_inFlight[key], waitingRequest)) {
          final completedRequest = _inFlight.remove(key);
          completedRequest?.ignore();
        }
      }).ignore();
      return waitingRequest;
    }

    final ownedCancelToken = CancelToken();
    _activeRequestTokens.add(ownedCancelToken);
    final request = Future<Uint8List>.sync(() async {
      late final Response<Uint8List> response;
      try {
        response = await dio.getUri<Uint8List>(
          source.archiveUri,
          options: _requestBuilder.build(
            offset: offset,
            length: length,
            sizeBytes: sizeBytes,
            strongEtag: strongEtag,
          ),
          cancelToken: ownedCancelToken,
        );
      } on DioException catch (exception) {
        if (exception.type == DioExceptionType.cancel) {
          throw SeismicityPmTilesException.cancelled(source: source);
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
      late final String receivedEtag;
      try {
        receivedEtag = _identityValidator.validate(
          statusCode: statusCode,
          headers: response.headers,
          source: source,
          expectedEtag: strongEtag,
        );
      } on SeismicityPmTilesArchiveChangedException catch (exception) {
        final terminalArchiveFailure = _terminalArchiveFailure;
        if (terminalArchiveFailure != null) {
          throw terminalArchiveFailure;
        }
        _terminalArchiveFailure = exception;
        _cache.clear();
        final failureToThrow = _terminalArchiveFailure ?? exception;
        throw failureToThrow;
      }
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
    });
    _inFlight[key] = request;
    if (strongEtag == null) {
      _initialIdentityFuture = request;
    }
    request.whenComplete(() {
      _activeRequestTokens.remove(ownedCancelToken);
      if (identical(_inFlight[key], request)) {
        final completedRequest = _inFlight.remove(key);
        completedRequest?.ignore();
      }
      if (identical(_initialIdentityFuture, request)) {
        _initialIdentityFuture = null;
      }
    }).ignore();
    return request;
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

  void clear() {
    _entries.clear();
    _aggregateBytes = 0;
  }
}
