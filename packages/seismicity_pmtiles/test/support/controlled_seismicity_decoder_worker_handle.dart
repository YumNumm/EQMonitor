import 'dart:async';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:seismicity_pmtiles/src/decoder/seismicity_decoder_worker_factory.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_dataset.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_decode_progress.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';

final class ControlledSeismicityDecoderWorkerHandle
    implements SeismicityDecoderWorkerHandle {
  ControlledSeismicityDecoderWorkerHandle({this.captureTileBytes = false});

  final bool captureTileBytes;
  final _decode = Completer<SeismicityPmTilesDecodeProgress>();
  final _finish = Completer<SeismicityPmTilesDataset>();
  final _cancel = Completer<void>();
  final _close = Completer<void>();
  final _retired = Completer<void>();
  final capturedTileBytes = <List<int>>[];

  var _decodeCount = 0;
  var _finishCount = 0;
  var _cancelCount = 0;
  var _closeCount = 0;
  SeismicityPmTilesException? _decodeError;
  SeismicityPmTilesException? _finishError;

  int get decodeCount => _decodeCount;
  int get finishCount => _finishCount;
  int get cancelCount => _cancelCount;
  int get closeCount => _closeCount;

  @override
  Future<SeismicityPmTilesDecodeProgress> decode({
    required TransferableTypedData tileBytes,
  }) {
    _decodeCount++;
    if (captureTileBytes) {
      capturedTileBytes.add(
        Uint8List.fromList(tileBytes.materialize().asUint8List()).toList(),
      );
    }
    final error = _decodeError;
    return error == null
        ? _decode.future
        : Future<SeismicityPmTilesDecodeProgress>.error(error);
  }

  @override
  Future<SeismicityPmTilesDataset> finish() {
    _finishCount++;
    final error = _finishError;
    return error == null
        ? _finish.future
        : Future<SeismicityPmTilesDataset>.error(error);
  }

  @override
  Future<void> cancel() {
    _cancelCount++;
    return _cancel.future;
  }

  @override
  Future<void> close() {
    _closeCount++;
    return _close.future;
  }

  @override
  Future<void> get retired => _retired.future;

  void succeedDecode({required SeismicityPmTilesDecodeProgress progress}) {
    if (!_decode.isCompleted) {
      _decode.complete(progress);
    }
  }

  void failDecode({required SeismicityPmTilesException error}) {
    _decodeError = error;
    if (_decodeCount > 0 && !_decode.isCompleted) {
      _decode.completeError(error);
    }
  }

  void succeedFinish({required SeismicityPmTilesDataset dataset}) {
    if (!_finish.isCompleted) {
      _finish.complete(dataset);
    }
  }

  void failFinish({required SeismicityPmTilesException error}) {
    _finishError = error;
    if (_finishCount > 0 && !_finish.isCompleted) {
      _finish.completeError(error);
    }
  }

  void succeedCancel() {
    if (!_cancel.isCompleted) {
      _cancel.complete();
    }
  }

  void succeedClose() {
    if (!_close.isCompleted) {
      _close.complete();
    }
  }

  void succeedRetired() {
    if (!_retired.isCompleted) {
      _retired.complete();
    }
  }
}
