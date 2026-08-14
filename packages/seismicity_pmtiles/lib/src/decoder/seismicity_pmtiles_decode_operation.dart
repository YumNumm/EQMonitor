import 'dart:async';

import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_dataset.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_decode_progress.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_load_state.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_result.dart';

/// Public decode operation: one result, ordered load states, idempotent cancel.
abstract interface class SeismicityPmTilesDecodeOperation {
  Future<SeismicityPmTilesResult<SeismicityPmTilesDataset>> get result;

  Stream<SeismicityPmTilesLoadState> get states;

  Future<void> cancel();
}

/// Non-export controller that owns result/state completion for runners.
final class SeismicityPmTilesDecodeOperationController
    implements SeismicityPmTilesDecodeOperation {
  SeismicityPmTilesDecodeOperationController({
    Future<void> Function()? onCancel,
  }) : _onCancel = onCancel;

  final Future<void> Function()? _onCancel;
  final _result =
      Completer<SeismicityPmTilesResult<SeismicityPmTilesDataset>>();
  final _states = StreamController<SeismicityPmTilesLoadState>();
  Future<void>? _cancelFuture;
  var _terminal = false;

  SeismicityPmTilesDecodeOperation get operation => this;

  void emit({required SeismicityPmTilesLoadState state}) {
    if (_terminal || _states.isClosed) {
      return;
    }
    _states.add(state);
  }

  void emitProgress({required SeismicityPmTilesDecodeProgress progress}) {
    emit(state: SeismicityPmTilesLoadState.decoding(progress: progress));
  }

  void completeSuccess({required SeismicityPmTilesDataset dataset}) {
    finish(
      state: const SeismicityPmTilesLoadState.completed(),
      result: SeismicityPmTilesResult.success(value: dataset),
    );
  }

  void completeFailure({required SeismicityPmTilesException exception}) {
    finish(
      state: SeismicityPmTilesLoadState.failed(exception: exception),
      result: SeismicityPmTilesResult.failure(exception: exception),
    );
  }

  void completeCancelled({required SeismicityPmTilesException exception}) {
    finish(
      state: const SeismicityPmTilesLoadState.cancelled(),
      result: SeismicityPmTilesResult.failure(exception: exception),
    );
  }

  void finish({
    required SeismicityPmTilesLoadState state,
    required SeismicityPmTilesResult<SeismicityPmTilesDataset> result,
  }) {
    if (_terminal) {
      return;
    }
    _terminal = true;
    if (!_states.isClosed) {
      _states.add(state);
      unawaited(_states.close());
    }
    if (!_result.isCompleted) {
      _result.complete(result);
    }
  }

  @override
  Future<SeismicityPmTilesResult<SeismicityPmTilesDataset>> get result =>
      _result.future;

  @override
  Stream<SeismicityPmTilesLoadState> get states => _states.stream;

  @override
  Future<void> cancel() {
    final existing = _cancelFuture;
    if (existing != null) {
      return existing;
    }
    final onCancel = _onCancel;
    final future = onCancel == null
        ? Future<void>.value()
        : Future<void>.sync(onCancel);
    _cancelFuture = future;
    return future;
  }
}
