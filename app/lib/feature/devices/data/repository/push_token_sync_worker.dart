import 'dart:async';

import 'package:eqmonitor/feature/devices/data/exception/device_provisioning_exception.dart';
import 'package:eqmonitor/feature/devices/data/model/push_token_sync_worker_state.dart';
import 'package:eqmonitor/feature/devices/data/retry/interruptible_backoff.dart';

typedef PushTokenUpsert = Future<void> Function(String token);

final class PushTokenSyncWorker {
  PushTokenSyncWorker({
    required PushTokenUpsert upsert,
    required InterruptibleBackoff backoff,
    PushTokenBackoff policy = const PushTokenBackoff(),
    DateTime Function()? clock,
  }) : _upsert = upsert,
       _backoff = backoff,
       _policy = policy,
       _clock = clock ?? DateTime.now;

  final PushTokenUpsert _upsert;
  final InterruptibleBackoff _backoff;
  final PushTokenBackoff _policy;
  final DateTime Function() _clock;
  final StreamController<PushTokenSyncWorkerState> _statesController =
      StreamController<PushTokenSyncWorkerState>.broadcast();

  PushTokenSyncWorkerState _state = const PushTokenSyncWorkerState.absent();
  PushTokenSyncWorkerState get state => _state;
  Stream<PushTokenSyncWorkerState> get states => _statesController.stream;

  String? _latestToken;
  String? _lastSyncedToken;
  String? _blockedToken;
  Future<void>? _pumpFuture;
  Future<void>? _disposeFuture;
  var _attempt = 0;
  var _disposed = false;

  void accept({required String token}) {
    if (_disposed || token.isEmpty) {
      return;
    }

    final isNewToken = token != _latestToken;
    if (!isNewToken) {
      return;
    }

    _latestToken = token;
    _attempt = 0;
    _blockedToken = null;
    _backoff.interrupt();
    if (_pumpFuture != null) {
      return;
    }
    if (token == _lastSyncedToken) {
      return;
    }

    late final Future<void> pump;
    pump = process().whenComplete(() {
      if (identical(_pumpFuture, pump)) {
        _pumpFuture = null;
      }
      final latestToken = _latestToken;
      if (!_disposed &&
          latestToken != null &&
          latestToken != _lastSyncedToken &&
          latestToken != _blockedToken) {
        _latestToken = null;
        accept(token: latestToken);
      }
    });
    _pumpFuture = pump;
  }

  void retry() {
    if (_disposed || _latestToken == null || _blockedToken == null) {
      return;
    }

    _attempt = 0;
    _blockedToken = null;
    final latestToken = _latestToken;
    if (latestToken != null) {
      _latestToken = null;
      accept(token: latestToken);
    }
  }

  Future<void> process() async {
    while (!_disposed) {
      final attemptedToken = _latestToken;
      if (attemptedToken == null || attemptedToken.isEmpty) {
        return;
      }
      _state = PushTokenSyncWorkerState.syncing(attempt: _attempt);
      _statesController.add(_state);
      try {
        await _upsert(attemptedToken);
        if (_disposed) {
          return;
        }
        _lastSyncedToken = attemptedToken;
        if (_latestToken == attemptedToken) {
          _state = const PushTokenSyncWorkerState.synced();
          _statesController.add(_state);
          return;
        }
        _attempt = 0;
      } on DeviceProvisioningException catch (error) {
        if (_disposed) {
          return;
        }
        if (_latestToken != attemptedToken) {
          _attempt = 0;
          continue;
        }
        if (!error.isRetryable) {
          _blockedToken = attemptedToken;
          _state = PushTokenSyncWorkerState.failed(
            attempt: _attempt,
            error: error,
          );
          _statesController.add(_state);
          return;
        }

        final retryAfter = error is RateLimitedException
            ? error.retryAfter
            : null;
        final duration = _policy.durationFor(
          attempt: _attempt,
          retryAfter: retryAfter,
        );
        _state = PushTokenSyncWorkerState.waiting(
          attempt: _attempt,
          error: error,
          resumeAt: _clock().add(duration),
        );
        _statesController.add(_state);
        await _backoff.wait(duration);
        if (_latestToken == attemptedToken) {
          _attempt++;
        } else {
          _attempt = 0;
        }
      } catch (error, stackTrace) {
        if (_disposed) {
          return;
        }
        final unexpected = UnexpectedProvisioningException(
          cause: error,
          stackTrace: stackTrace,
        );
        _blockedToken = attemptedToken;
        _state = PushTokenSyncWorkerState.failed(
          attempt: _attempt,
          error: unexpected,
        );
        _statesController.add(_state);
        return;
      }
    }
  }

  Future<void> dispose() {
    final existingDispose = _disposeFuture;
    if (existingDispose != null) {
      return existingDispose;
    }

    _disposed = true;
    _backoff.dispose();
    _state = const PushTokenSyncWorkerState.disposed();
    _statesController.add(_state);
    final pump = _pumpFuture;
    final disposing = pump == null
        ? _statesController.close()
        : pump.whenComplete(_statesController.close);
    _disposeFuture = disposing;
    return disposing;
  }
}
