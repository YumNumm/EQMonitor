import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'native_auth_attempt_coordinator.g.dart';

@Riverpod(keepAlive: true)
NativeAuthAttemptCoordinator nativeAuthAttemptCoordinator(Ref ref) =>
    NativeAuthAttemptCoordinator();

final class NativeAuthAttemptCoordinator {
  var _nextAttemptId = 0;
  int? _activeAttemptId;

  NativeAuthAttempt? tryBegin() {
    if (_activeAttemptId != null) {
      return null;
    }
    _nextAttemptId++;
    _activeAttemptId = _nextAttemptId;
    return NativeAuthAttempt(
      coordinator: this,
      attemptId: _nextAttemptId,
    );
  }

  bool isCurrent({required int attemptId}) => _activeAttemptId == attemptId;

  void release({required int attemptId}) {
    if (_activeAttemptId == attemptId) {
      _activeAttemptId = null;
    }
  }
}

final class NativeAuthAttempt {
  new({
    required NativeAuthAttemptCoordinator coordinator,
    required int attemptId,
  }) : _coordinator = coordinator,
       _attemptId = attemptId;

  final NativeAuthAttemptCoordinator _coordinator;
  final int _attemptId;
  var _released = false;

  bool get isCurrent =>
      !_released && _coordinator.isCurrent(attemptId: _attemptId);

  void release() {
    if (_released) {
      return;
    }
    _released = true;
    _coordinator.release(attemptId: _attemptId);
  }
}
