import 'package:eqmonitor/feature/auth/data/model/auth_session.dart';
import 'package:eqmonitor/feature/auth/data/model/debug_auth_state.dart';

final class DebugAuthPresentationOperationCoordinator {
  DebugAuthPresentationOperationCapability? _active;

  DebugAuthPresentationOperationCapability begin({
    required DebugAuthOperation operation,
  }) {
    invalidate();
    final capability = DebugAuthPresentationOperationCapability._(
      coordinator: this,
      operation: operation,
    );
    _active = capability;
    return capability;
  }

  bool observeSessionMutation({required AuthSessionStatus status}) {
    final active = _active;
    if (active == null || active._sessionMutationCount > 0) {
      invalidate();
      return false;
    }
    final expected = switch ((active.operation, status)) {
      (DebugAuthOperation.restoring, _) => true,
      (
        DebugAuthOperation.googleSignIn ||
            DebugAuthOperation.appleSignIn ||
            DebugAuthOperation.passkeySignIn ||
            DebugAuthOperation.jwtRefresh,
        AuthSessionStatus.authenticated,
      ) =>
        true,
      (DebugAuthOperation.signOut, AuthSessionStatus.signedOut) => true,
      _ => false,
    };
    if (!expected) {
      invalidate();
      return false;
    }
    active._sessionMutationCount++;
    return true;
  }

  bool isCurrent({
    required DebugAuthPresentationOperationCapability capability,
  }) => identical(_active, capability) && !capability._released;

  void invalidate() {
    final active = _active;
    if (active != null) {
      active._released = true;
    }
    _active = null;
  }

  void release({
    required DebugAuthPresentationOperationCapability capability,
  }) {
    if (!isCurrent(capability: capability)) {
      return;
    }
    capability._released = true;
    _active = null;
  }
}

final class DebugAuthPresentationOperationCapability {
  new _({
    required DebugAuthPresentationOperationCoordinator coordinator,
    required this.operation,
  }) : _coordinator = coordinator;

  final DebugAuthPresentationOperationCoordinator _coordinator;
  final DebugAuthOperation operation;
  var _released = false;
  var _sessionMutationCount = 0;

  bool get isCurrent => _coordinator.isCurrent(capability: this);

  bool get hasObservedSessionMutation => _sessionMutationCount > 0;

  void release() {
    _coordinator.release(capability: this);
  }
}
