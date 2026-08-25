import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/auth/data/model/auth_failure.dart';
import 'package:eqmonitor/feature/auth/data/model/debug_auth_state.dart';
import 'package:eqmonitor/feature/auth/data/notifier/auth_session_notifier.dart';
import 'package:eqmonitor/feature/auth/data/notifier/debug_auth_operation_coordinator.dart';
import 'package:eqmonitor/feature/auth/data/provider/user_jwt_provider.dart';
import 'package:eqmonitor/feature/auth/data/repository/native_social_auth_repository.dart';
import 'package:eqmonitor/feature/auth/data/repository/passkey_repository.dart';
import 'package:eqmonitor/feature/auth/data/repository/user_api_client.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debug_auth_action.g.dart';

enum DebugAuthActionOutcomeKind { succeeded, cancelled, failed, stale }

final class DebugAuthActionOutcome {
  // ignore: unnecessary_type_name_in_constructor
  const DebugAuthActionOutcome.success({this.expiresAt, this.userSummary})
    : kind = DebugAuthActionOutcomeKind.succeeded,
      failureKind = null;

  // ignore: unnecessary_type_name_in_constructor
  const DebugAuthActionOutcome.cancelled()
    : kind = DebugAuthActionOutcomeKind.cancelled,
      failureKind = null,
      expiresAt = null,
      userSummary = null;

  // ignore: unnecessary_type_name_in_constructor
  const DebugAuthActionOutcome.failure({required AuthFailureKind failure})
    : kind = DebugAuthActionOutcomeKind.failed,
      failureKind = failure,
      expiresAt = null,
      userSummary = null;

  // ignore: unnecessary_type_name_in_constructor
  const DebugAuthActionOutcome.stale()
    : kind = DebugAuthActionOutcomeKind.stale,
      failureKind = null,
      expiresAt = null,
      userSummary = null;

  final DebugAuthActionOutcomeKind kind;
  final AuthFailureKind? failureKind;
  final DateTime? expiresAt;
  final DebugAuthUserSummary? userSummary;
}

typedef ReadDebugAuthJwtExpiry = Future<DateTime?> Function();

@Riverpod(keepAlive: true)
Future<ReadDebugAuthJwtExpiry> debugAuthJwtExpiry(Ref ref) async {
  final provider = await ref.watch(userJwtServiceProvider.future);
  return () async => provider.expiresAt;
}

@riverpod
DebugAuthSignInAction debugAuthSignInAction(Ref ref) =>
    const DebugAuthSignInAction();

final class DebugAuthSignInAction {
  const new();

  Future<DebugAuthActionOutcome> execute({
    required Ref ref,
    required DebugAuthPresentationOperationCapability capability,
    required DebugAuthProviderKind provider,
  }) async {
    if (!ref.mounted || !capability.isCurrent) {
      return const DebugAuthActionOutcome.stale();
    }
    final Result<void, AuthFailure> result;
    switch (provider) {
      case DebugAuthProviderKind.google:
        final repository = await ref.read(
          nativeSocialAuthRepositoryProvider.future,
        );
        if (!ref.mounted || !capability.isCurrent) {
          return const DebugAuthActionOutcome.stale();
        }
        result = await repository.signInWithGoogle();
      case DebugAuthProviderKind.apple:
        final repository = await ref.read(
          nativeSocialAuthRepositoryProvider.future,
        );
        if (!ref.mounted || !capability.isCurrent) {
          return const DebugAuthActionOutcome.stale();
        }
        result = await repository.signInWithApple();
      case DebugAuthProviderKind.passkey:
        final repository = await ref.read(passkeyRepositoryProvider.future);
        if (!ref.mounted || !capability.isCurrent) {
          return const DebugAuthActionOutcome.stale();
        }
        result = switch (await repository.signIn()) {
          Success() => const Success(null),
          Failure(:final exception, :final stackTrace) => Failure(
            exception,
            stackTrace,
          ),
        };
    }
    if (!ref.mounted || !capability.isCurrent) {
      return const DebugAuthActionOutcome.stale();
    }
    if (result case Failure(:final exception)) {
      return exception.kind == AuthFailureKind.cancelled
          ? const DebugAuthActionOutcome.cancelled()
          : DebugAuthActionOutcome.failure(failure: exception.kind);
    }
    final session = ref.read(authSessionProvider);
    final isAuthenticated = switch (session) {
      AsyncData(:final value) => value.isAuthenticated,
      _ => false,
    };
    if (!isAuthenticated) {
      return const DebugAuthActionOutcome.failure(
        failure: AuthFailureKind.invalidResponse,
      );
    }
    if (!ref.mounted || !capability.isCurrent) {
      return const DebugAuthActionOutcome.stale();
    }
    final readExpiry = await ref.read(debugAuthJwtExpiryProvider.future);
    if (!ref.mounted || !capability.isCurrent) {
      return const DebugAuthActionOutcome.stale();
    }
    final expiry = await readExpiry();
    if (!ref.mounted || !capability.isCurrent) {
      return const DebugAuthActionOutcome.stale();
    }
    return DebugAuthActionOutcome.success(expiresAt: expiry);
  }
}

@riverpod
DebugAuthPasskeyRegistrationAction debugAuthPasskeyRegistrationAction(
  Ref ref,
) => const DebugAuthPasskeyRegistrationAction();

final class DebugAuthPasskeyRegistrationAction {
  const new();

  Future<DebugAuthActionOutcome> execute({
    required Ref ref,
    required DebugAuthPresentationOperationCapability capability,
  }) async {
    if (!ref.mounted || !capability.isCurrent) {
      return const DebugAuthActionOutcome.stale();
    }
    final repository = await ref.read(passkeyRepositoryProvider.future);
    if (!ref.mounted || !capability.isCurrent) {
      return const DebugAuthActionOutcome.stale();
    }
    final result = await repository.register();
    if (!ref.mounted || !capability.isCurrent) {
      return const DebugAuthActionOutcome.stale();
    }
    return switch (result) {
      Success() => const DebugAuthActionOutcome.success(),
      Failure(:final exception)
          when exception.kind == AuthFailureKind.cancelled =>
        const DebugAuthActionOutcome.cancelled(),
      Failure(:final exception) => DebugAuthActionOutcome.failure(
        failure: exception.kind,
      ),
    };
  }
}

@riverpod
DebugAuthJwtRefreshAction debugAuthJwtRefreshAction(Ref ref) =>
    const DebugAuthJwtRefreshAction();

final class DebugAuthJwtRefreshAction {
  const new();

  Future<DebugAuthActionOutcome> execute({
    required Ref ref,
    required DebugAuthPresentationOperationCapability capability,
  }) async {
    if (!ref.mounted || !capability.isCurrent) {
      return const DebugAuthActionOutcome.stale();
    }
    final result = await ref.read(authSessionProvider.notifier).refreshJwt();
    if (!ref.mounted || !capability.isCurrent) {
      return const DebugAuthActionOutcome.stale();
    }
    if (result case Failure(:final exception)) {
      return DebugAuthActionOutcome.failure(failure: exception.kind);
    }
    final session = ref.read(authSessionProvider);
    final isAuthenticated = switch (session) {
      AsyncData(:final value) => value.isAuthenticated,
      _ => false,
    };
    if (!isAuthenticated) {
      return const DebugAuthActionOutcome.failure(
        failure: AuthFailureKind.invalidResponse,
      );
    }
    if (!ref.mounted || !capability.isCurrent) {
      return const DebugAuthActionOutcome.stale();
    }
    final readExpiry = await ref.read(debugAuthJwtExpiryProvider.future);
    if (!ref.mounted || !capability.isCurrent) {
      return const DebugAuthActionOutcome.stale();
    }
    final expiry = await readExpiry();
    if (!ref.mounted || !capability.isCurrent) {
      return const DebugAuthActionOutcome.stale();
    }
    return DebugAuthActionOutcome.success(expiresAt: expiry);
  }
}

@riverpod
DebugAuthUserMeAction debugAuthUserMeAction(Ref ref) =>
    const DebugAuthUserMeAction();

final class DebugAuthUserMeAction {
  const new();

  Future<DebugAuthActionOutcome> execute({
    required Ref ref,
    required DebugAuthPresentationOperationCapability capability,
  }) async {
    if (!ref.mounted || !capability.isCurrent) {
      return const DebugAuthActionOutcome.stale();
    }
    final client = await ref.read(userApiClientProvider.future);
    if (!ref.mounted || !capability.isCurrent) {
      return const DebugAuthActionOutcome.stale();
    }
    final result = await client.getJson(
      path: api.UserApiClientUrls.getV2UserMe,
    );
    if (!ref.mounted || !capability.isCurrent) {
      return const DebugAuthActionOutcome.stale();
    }
    if (result case Failure(:final exception)) {
      return DebugAuthActionOutcome.failure(failure: exception.kind);
    }
    final summaryResult = const DebugAuthUserSummaryParser().parse(
      result.unwrap(),
    );
    if (summaryResult case Failure(:final exception)) {
      return DebugAuthActionOutcome.failure(failure: exception.kind);
    }
    if (!ref.mounted || !capability.isCurrent) {
      return const DebugAuthActionOutcome.stale();
    }
    final readExpiry = await ref.read(debugAuthJwtExpiryProvider.future);
    if (!ref.mounted || !capability.isCurrent) {
      return const DebugAuthActionOutcome.stale();
    }
    final expiry = await readExpiry();
    if (!ref.mounted || !capability.isCurrent) {
      return const DebugAuthActionOutcome.stale();
    }
    return DebugAuthActionOutcome.success(
      expiresAt: expiry,
      userSummary: summaryResult.unwrap(),
    );
  }
}

@riverpod
DebugAuthSignOutAction debugAuthSignOutAction(Ref ref) =>
    const DebugAuthSignOutAction();

final class DebugAuthSignOutAction {
  const new();

  Future<DebugAuthActionOutcome> execute({
    required Ref ref,
    required DebugAuthPresentationOperationCapability capability,
  }) async {
    if (!ref.mounted || !capability.isCurrent) {
      return const DebugAuthActionOutcome.stale();
    }
    final result = await ref.read(authSessionProvider.notifier).signOut();
    if (!ref.mounted || !capability.isCurrent) {
      return const DebugAuthActionOutcome.stale();
    }
    return switch (result) {
      Success() => const DebugAuthActionOutcome.success(),
      Failure(:final exception) => DebugAuthActionOutcome.failure(
        failure: exception.kind,
      ),
    };
  }
}
