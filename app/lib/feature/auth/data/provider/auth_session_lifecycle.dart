import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_session_lifecycle.g.dart';

@Riverpod(keepAlive: true)
AuthSessionLifecycle authSessionLifecycle(Ref ref) {
  final lifecycle = AuthSessionLifecycle();
  ref.onDispose(lifecycle.dispose);
  return lifecycle;
}

enum AuthSessionLifecycleStatus { active, invalidating, signedOut, disposed }

final class AuthSessionLifecycle {
  var _generation = 0;
  var _status = AuthSessionLifecycleStatus.active;

  int get generation => _generation;

  bool get allowsJwtRefresh => _status == AuthSessionLifecycleStatus.active;

  bool get allowsSessionRestore => _status == AuthSessionLifecycleStatus.active;

  int beginInvalidation() {
    _generation++;
    _status = AuthSessionLifecycleStatus.invalidating;
    return _generation;
  }

  void completeInvalidation({required int generation}) {
    if (_generation == generation &&
        _status == AuthSessionLifecycleStatus.invalidating) {
      _status = AuthSessionLifecycleStatus.signedOut;
    }
  }

  bool acceptSignIn() {
    if (_status
        case AuthSessionLifecycleStatus.invalidating ||
            AuthSessionLifecycleStatus.disposed) {
      return false;
    }
    _generation++;
    _status = AuthSessionLifecycleStatus.active;
    return true;
  }

  bool isCurrent({required int generation}) =>
      generation == _generation && allowsJwtRefresh;

  void dispose() {
    _generation++;
    _status = AuthSessionLifecycleStatus.disposed;
  }
}
