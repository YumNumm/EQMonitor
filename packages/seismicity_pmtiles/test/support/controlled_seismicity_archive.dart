import 'dart:async';
import 'dart:typed_data';

import 'package:pmtiles_v3/pmtiles_v3.dart';
import 'package:seismicity_pmtiles/src/archive/seismicity_pmtiles_archive.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_archive_descriptor.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';

/// Test-only [SeismicityPmTilesArchive] with deterministic pause/release/close.
final class ControlledSeismicityArchive implements SeismicityPmTilesArchive {
  ControlledSeismicityArchive({
    required this.descriptor,
    required List<int> occupiedTileIds,
    required Map<int, Uint8List> tileBytes,
    PmTilesV3Header? header,
    SeismicityPmTilesException? closeReleaseFailure,
  }) : occupiedTileIds = List<int>.unmodifiable(occupiedTileIds),
       _tileBytes = Map<int, Uint8List>.unmodifiable(tileBytes),
       header = header ?? ControlledSeismicityArchive.stubHeader(),
       closeReleaseFailure =
           closeReleaseFailure ??
           SeismicityPmTilesException.closed(source: descriptor.source);

  static PmTilesV3Header stubHeader({
    int minZoom = 0,
    int maxZoom = 14,
  }) => PmTilesV3Header(
    rootDirectoryOffset: 0,
    rootDirectoryLength: 0,
    metadataOffset: 0,
    metadataLength: 0,
    leafDirectoriesOffset: 0,
    leafDirectoriesLength: 0,
    tileDataOffset: 0,
    tileDataLength: 0,
    addressedTilesCount: 0,
    tileEntriesCount: 0,
    tileContentsCount: 0,
    clustered: true,
    internalCompression: 0,
    tileCompression: 0,
    tileType: 1,
    minZoom: minZoom,
    maxZoom: maxZoom,
    minLongitude: 0,
    minLatitude: 0,
    maxLongitude: 0,
    maxLatitude: 0,
    centerZoom: 0,
    centerLongitude: 0,
    centerLatitude: 0,
  );

  @override
  final SeismicityPmTilesArchiveDescriptor descriptor;

  @override
  final PmTilesV3Header header;

  final List<int> occupiedTileIds;
  final Map<int, Uint8List> _tileBytes;
  final SeismicityPmTilesException closeReleaseFailure;
  final zoomRequests = <int>[];
  final readRequests = <int>[];

  Completer<void>? _pendingEnumerationGate;
  Completer<void>? _blockedEnumerationGate;
  Completer<void>? _pendingReadGate;
  Completer<void>? _blockedReadGate;
  Completer<void>? _closeCompleter;
  Completer<void>? _closeRelease;
  SeismicityPmTilesException? _queuedEnumerationFailure;
  SeismicityPmTilesException? _queuedReadFailure;
  var _closed = false;
  var _closeCount = 0;
  var deferCloseCompletion = false;

  int get closeCount => _closeCount;
  bool get isClosed => _closed;

  void pauseBeforeNextEnumeration() {
    _pendingEnumerationGate = Completer<void>();
  }

  void pauseBeforeNextRead() {
    _pendingReadGate = Completer<void>();
  }

  void queueEnumerationFailure({required SeismicityPmTilesException error}) {
    _queuedEnumerationFailure = error;
  }

  void queueReadFailure({required SeismicityPmTilesException error}) {
    _queuedReadFailure = error;
  }

  void releaseEnumeration() {
    final gate = _pendingEnumerationGate ?? _blockedEnumerationGate;
    if (gate != null && !gate.isCompleted) {
      gate.complete();
    }
  }

  void releaseRead() {
    final gate = _pendingReadGate ?? _blockedReadGate;
    if (gate != null && !gate.isCompleted) {
      gate.complete();
    }
  }

  @override
  Stream<int> occupiedTileIdsAtZoom({required int zoom}) async* {
    zoomRequests.add(zoom);
    final pending = _pendingEnumerationGate;
    if (pending != null) {
      _pendingEnumerationGate = null;
      _blockedEnumerationGate = pending;
      await pending.future;
      _blockedEnumerationGate = null;
    }
    final queuedFailure = _queuedEnumerationFailure;
    if (queuedFailure != null) {
      _queuedEnumerationFailure = null;
      throw queuedFailure;
    }
    if (_closed) {
      throw closeReleaseFailure;
    }
    for (final tileId in occupiedTileIds) {
      yield tileId;
    }
  }

  @override
  Future<Uint8List> readTile({required int tileId}) async {
    readRequests.add(tileId);
    final pending = _pendingReadGate;
    if (pending != null) {
      _pendingReadGate = null;
      _blockedReadGate = pending;
      await pending.future;
      _blockedReadGate = null;
    }
    final queuedFailure = _queuedReadFailure;
    if (queuedFailure != null) {
      _queuedReadFailure = null;
      throw queuedFailure;
    }
    if (_closed) {
      throw closeReleaseFailure;
    }
    final bytes = _tileBytes[tileId];
    if (bytes == null) {
      throw SeismicityPmTilesException.tileNotFound(tileId: tileId);
    }
    return bytes;
  }

  @override
  Future<void> close() {
    final existing = _closeCompleter;
    if (existing != null) {
      return existing.future;
    }
    final completer = Completer<void>();
    _closeCompleter = completer;
    _closed = true;
    _closeCount = 1;
    failOpenGate(_pendingEnumerationGate);
    failOpenGate(_blockedEnumerationGate);
    failOpenGate(_pendingReadGate);
    failOpenGate(_blockedReadGate);
    if (deferCloseCompletion) {
      final release = Completer<void>();
      _closeRelease = release;
      unawaited(
        release.future.then((_) {
          if (!completer.isCompleted) {
            completer.complete();
          }
        }),
      );
    } else {
      completer.complete();
    }
    return completer.future;
  }

  void releaseClose() {
    final release = _closeRelease;
    if (release != null && !release.isCompleted) {
      release.complete();
    }
  }

  void failOpenGate(Completer<void>? gate) {
    if (gate != null && !gate.isCompleted) {
      gate.completeError(closeReleaseFailure);
    }
  }
}
