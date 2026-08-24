import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'native_auth_attempt_coordinator.g.dart';

@Riverpod(keepAlive: true)
NativeAuthAttemptCoordinator nativeAuthAttemptCoordinator(Ref ref) =>
    NativeAuthAttemptCoordinator();

final class NativeAuthAttemptCoordinator {
  NativeAuthAttempt? _activeAttempt;

  NativeAuthAttempt? tryBegin() {
    if (_activeAttempt != null) {
      return null;
    }
    final attempt = NativeAuthAttempt._(coordinator: this);
    _activeAttempt = attempt;
    return attempt;
  }

  bool _isCurrent({required NativeAuthAttempt attempt}) =>
      identical(_activeAttempt, attempt);

  bool release({required NativeAuthAttempt attempt}) {
    if (!_isCurrent(attempt: attempt)) {
      return false;
    }
    _activeAttempt = null;
    attempt._released = true;
    return true;
  }
}

final class NativeAuthAttempt {
  new _({
    required NativeAuthAttemptCoordinator coordinator,
  }) : _coordinator = coordinator;

  final NativeAuthAttemptCoordinator _coordinator;
  var _released = false;

  bool get isCurrent => !_released && _coordinator._isCurrent(attempt: this);

  void release() {
    if (_released) {
      return;
    }
    _coordinator.release(attempt: this);
  }
}
