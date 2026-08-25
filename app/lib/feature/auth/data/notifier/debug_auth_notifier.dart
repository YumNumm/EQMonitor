import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/auth/data/model/auth_failure.dart';
import 'package:eqmonitor/feature/auth/data/model/auth_session.dart';
import 'package:eqmonitor/feature/auth/data/model/debug_auth_state.dart';
import 'package:eqmonitor/feature/auth/data/notifier/auth_session_notifier.dart';
import 'package:eqmonitor/feature/auth/data/notifier/debug_auth_action.dart';
import 'package:eqmonitor/feature/auth/data/notifier/debug_auth_operation_coordinator.dart';
import 'package:eqmonitor/feature/auth/data/provider/auth_environment_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debug_auth_notifier.g.dart';

@riverpod
class DebugAuthNotifier extends _$DebugAuthNotifier {
  final _operations = DebugAuthPresentationOperationCoordinator();

  @override
  Future<DebugAuthState> build() async {
    final operation = _operations.begin(
      operation: DebugAuthOperation.restoring,
    );
    ref.onDispose(_operations.invalidate);
    ref.listen(authSessionProvider, (_, next) {
      if (!ref.mounted) {
        return;
      }
      if (next is AsyncData<AuthSession>) {
        return;
      }
      _operations.invalidate();
      final current = currentValue;
      if (current == null || !ref.mounted) {
        return;
      }
      state = AsyncData(
        current.clearedForSessionChange(preserveOperation: false),
      );
    });
    ref.listen(authSessionRevisionProvider, (_, _) {
      if (!ref.mounted) {
        return;
      }
      final session = ref.read(authSessionProvider);
      final preserveOperation = switch (session) {
        AsyncData(:final value) => _operations.observeSessionMutation(
          status: value.status,
        ),
        _ => false,
      };
      if (!preserveOperation) {
        _operations.invalidate();
      }
      final current = currentValue;
      if (current == null || !ref.mounted) {
        return;
      }
      state = AsyncData(
        current.clearedForSessionChange(
          preserveOperation: preserveOperation,
        ),
      );
    });

    var resultState = const DebugAuthState.idle();
    try {
      final environmentResult = await ref.watch(
        authEnvironmentProvider.future,
      );
      if (!ref.mounted || !operation.isCurrent) {
        return resultState;
      }
      if (environmentResult case Failure(:final exception)) {
        resultState = resultState.withFailure(kind: exception.kind);
      } else {
        if (!ref.mounted || !operation.isCurrent) {
          return resultState;
        }
        final restoreResult = await ref
            .read(authSessionProvider.notifier)
            .restore();
        if (!ref.mounted || !operation.isCurrent) {
          return resultState;
        }
        switch (restoreResult) {
          case Failure(:final exception):
            if (!operation.hasObservedSessionMutation) {
              resultState = resultState.withFailure(kind: exception.kind);
            }
          case Success():
            final session = ref.read(authSessionProvider);
            if (session case AsyncData(:final value)
                when value.isAuthenticated) {
              if (!ref.mounted || !operation.isCurrent) {
                return resultState;
              }
              final readExpiry = await ref.read(
                debugAuthJwtExpiryProvider.future,
              );
              if (!ref.mounted || !operation.isCurrent) {
                return resultState;
              }
              final expiry = await readExpiry();
              if (!ref.mounted || !operation.isCurrent) {
                return resultState;
              }
              resultState = resultState.signedIn(
                authenticatedProvider: null,
                expiresAt: expiry,
                success: DebugAuthSuccessKind.restored,
              );
            }
        }
      }
    } on Exception {
      if (ref.mounted && operation.isCurrent) {
        resultState = operation.hasObservedSessionMutation
            ? const DebugAuthState.idle()
            : resultState.withFailure(kind: AuthFailureKind.unknown);
      }
    }
    if (ref.mounted && operation.isCurrent) {
      operation.release();
    }
    return resultState;
  }

  DebugAuthState? get currentValue => switch (state) {
    AsyncData(:final value) => value,
    _ => null,
  };

  Future<void> signInWithGoogle() => runSignIn(
    provider: DebugAuthProviderKind.google,
    operationKind: DebugAuthOperation.googleSignIn,
  );

  Future<void> signInWithApple() => runSignIn(
    provider: DebugAuthProviderKind.apple,
    operationKind: DebugAuthOperation.appleSignIn,
  );

  Future<void> signInWithPasskey() => runSignIn(
    provider: DebugAuthProviderKind.passkey,
    operationKind: DebugAuthOperation.passkeySignIn,
  );

  Future<void> runSignIn({
    required DebugAuthProviderKind provider,
    required DebugAuthOperation operationKind,
  }) async {
    final current = currentValue;
    if (current == null || current.isBusy) {
      return;
    }
    final operation = _operations.begin(operation: operationKind);
    if (!ref.mounted || !operation.isCurrent) {
      return;
    }
    state = AsyncData(current.working(nextOperation: operationKind));
    try {
      if (!ref.mounted || !operation.isCurrent) {
        return;
      }
      final action = ref.read(debugAuthSignInActionProvider);
      final outcome = await action.execute(
        ref: ref,
        capability: operation,
        provider: provider,
      );
      if (!ref.mounted || !operation.isCurrent) {
        return;
      }
      if (outcome.kind != DebugAuthActionOutcomeKind.succeeded &&
          operation.hasObservedSessionMutation) {
        final latest = currentValue;
        if (latest == null || !ref.mounted || !operation.isCurrent) {
          return;
        }
        state = AsyncData(
          latest.clearedForSessionChange(preserveOperation: false),
        );
        operation.release();
        return;
      }
      state = AsyncData(
        switch (outcome.kind) {
          DebugAuthActionOutcomeKind.succeeded => current.signedIn(
            authenticatedProvider: provider,
            expiresAt: outcome.expiresAt,
            success: DebugAuthSuccessKind.signedIn,
          ),
          DebugAuthActionOutcomeKind.cancelled => current,
          DebugAuthActionOutcomeKind.failed => current.failed(
            kind: outcome.failureKind ?? AuthFailureKind.unknown,
          ),
          DebugAuthActionOutcomeKind.stale => current,
        },
      );
      operation.release();
    } on Exception {
      if (!ref.mounted || !operation.isCurrent) {
        return;
      }
      if (operation.hasObservedSessionMutation) {
        final latest = currentValue;
        if (latest == null || !ref.mounted || !operation.isCurrent) {
          return;
        }
        state = AsyncData(
          latest.clearedForSessionChange(preserveOperation: false),
        );
        operation.release();
        return;
      }
      state = AsyncData(current.failed(kind: AuthFailureKind.unknown));
      operation.release();
    }
  }

  Future<void> registerPasskey() async {
    final current = currentValue;
    if (current == null || current.isBusy) {
      return;
    }
    final operation = _operations.begin(
      operation: DebugAuthOperation.passkeyRegistration,
    );
    if (!ref.mounted || !operation.isCurrent) {
      return;
    }
    state = AsyncData(
      current.working(nextOperation: DebugAuthOperation.passkeyRegistration),
    );
    try {
      if (!ref.mounted || !operation.isCurrent) {
        return;
      }
      final action = ref.read(debugAuthPasskeyRegistrationActionProvider);
      final outcome = await action.execute(
        ref: ref,
        capability: operation,
      );
      if (!ref.mounted || !operation.isCurrent) {
        return;
      }
      state = AsyncData(
        switch (outcome.kind) {
          DebugAuthActionOutcomeKind.succeeded => current.succeeded(
            success: DebugAuthSuccessKind.passkeyRegistered,
          ),
          DebugAuthActionOutcomeKind.cancelled => current,
          DebugAuthActionOutcomeKind.failed => current.failed(
            kind: outcome.failureKind ?? AuthFailureKind.unknown,
          ),
          DebugAuthActionOutcomeKind.stale => current,
        },
      );
      operation.release();
    } on Exception {
      if (!ref.mounted || !operation.isCurrent) {
        return;
      }
      if (operation.hasObservedSessionMutation) {
        final latest = currentValue;
        if (latest == null || !ref.mounted || !operation.isCurrent) {
          return;
        }
        state = AsyncData(
          latest.clearedForSessionChange(preserveOperation: false),
        );
        operation.release();
        return;
      }
      state = AsyncData(current.failed(kind: AuthFailureKind.unknown));
      operation.release();
    }
  }

  Future<void> refreshJwt() async {
    final current = currentValue;
    if (current == null || current.isBusy) {
      return;
    }
    final operation = _operations.begin(
      operation: DebugAuthOperation.jwtRefresh,
    );
    if (!ref.mounted || !operation.isCurrent) {
      return;
    }
    state = AsyncData(
      current.working(nextOperation: DebugAuthOperation.jwtRefresh),
    );
    try {
      if (!ref.mounted || !operation.isCurrent) {
        return;
      }
      final action = ref.read(debugAuthJwtRefreshActionProvider);
      final outcome = await action.execute(
        ref: ref,
        capability: operation,
      );
      if (!ref.mounted || !operation.isCurrent) {
        return;
      }
      if (outcome.kind != DebugAuthActionOutcomeKind.succeeded &&
          operation.hasObservedSessionMutation) {
        final latest = currentValue;
        if (latest == null || !ref.mounted || !operation.isCurrent) {
          return;
        }
        state = AsyncData(
          latest.clearedForSessionChange(preserveOperation: false),
        );
        operation.release();
        return;
      }
      state = AsyncData(
        switch (outcome.kind) {
          DebugAuthActionOutcomeKind.succeeded => current.succeeded(
            success: DebugAuthSuccessKind.jwtRefreshed,
            expiresAt: outcome.expiresAt,
          ),
          DebugAuthActionOutcomeKind.cancelled => current,
          DebugAuthActionOutcomeKind.failed => current.failed(
            kind: outcome.failureKind ?? AuthFailureKind.unknown,
          ),
          DebugAuthActionOutcomeKind.stale => current,
        },
      );
      operation.release();
    } on Exception {
      if (!ref.mounted || !operation.isCurrent) {
        return;
      }
      if (operation.hasObservedSessionMutation) {
        final latest = currentValue;
        if (latest == null || !ref.mounted || !operation.isCurrent) {
          return;
        }
        state = AsyncData(
          latest.clearedForSessionChange(preserveOperation: false),
        );
        operation.release();
        return;
      }
      state = AsyncData(current.failed(kind: AuthFailureKind.unknown));
      operation.release();
    }
  }

  Future<void> verifyUserMe() async {
    final current = currentValue;
    if (current == null || current.isBusy) {
      return;
    }
    final operation = _operations.begin(
      operation: DebugAuthOperation.userMeVerification,
    );
    if (!ref.mounted || !operation.isCurrent) {
      return;
    }
    state = AsyncData(
      current.working(nextOperation: DebugAuthOperation.userMeVerification),
    );
    try {
      if (!ref.mounted || !operation.isCurrent) {
        return;
      }
      final action = ref.read(debugAuthUserMeActionProvider);
      final outcome = await action.execute(
        ref: ref,
        capability: operation,
      );
      if (!ref.mounted || !operation.isCurrent) {
        return;
      }
      state = AsyncData(
        switch (outcome.kind) {
          DebugAuthActionOutcomeKind.succeeded => current.succeeded(
            success: DebugAuthSuccessKind.userMeVerified,
            expiresAt: outcome.expiresAt,
            summary: outcome.userSummary,
          ),
          DebugAuthActionOutcomeKind.cancelled => current,
          DebugAuthActionOutcomeKind.failed => current.failed(
            kind: outcome.failureKind ?? AuthFailureKind.unknown,
          ),
          DebugAuthActionOutcomeKind.stale => current,
        },
      );
      operation.release();
    } on Exception {
      if (!ref.mounted || !operation.isCurrent) {
        return;
      }
      state = AsyncData(current.failed(kind: AuthFailureKind.unknown));
      operation.release();
    }
  }

  Future<void> signOut() async {
    final current = currentValue;
    if (current == null || current.isBusy) {
      return;
    }
    final operation = _operations.begin(operation: DebugAuthOperation.signOut);
    if (!ref.mounted || !operation.isCurrent) {
      return;
    }
    state = AsyncData(
      current.working(nextOperation: DebugAuthOperation.signOut),
    );
    try {
      if (!ref.mounted || !operation.isCurrent) {
        return;
      }
      final action = ref.read(debugAuthSignOutActionProvider);
      final outcome = await action.execute(
        ref: ref,
        capability: operation,
      );
      if (!ref.mounted || !operation.isCurrent) {
        return;
      }
      state = AsyncData(
        outcome.kind == DebugAuthActionOutcomeKind.succeeded
            ? current.signedOut()
            : current.signedOut(
                failure: outcome.failureKind ?? AuthFailureKind.unknown,
              ),
      );
      operation.release();
    } on Exception {
      if (!ref.mounted || !operation.isCurrent) {
        return;
      }
      state = AsyncData(
        current.signedOut(failure: AuthFailureKind.unknown),
      );
      operation.release();
    }
  }
}
