import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/auth/data/model/auth_failure.dart';
import 'package:eqmonitor/feature/auth/data/model/debug_auth_state.dart';
import 'package:eqmonitor/feature/auth/data/notifier/auth_session_notifier.dart';
import 'package:eqmonitor/feature/auth/data/provider/auth_environment_provider.dart';
import 'package:eqmonitor/feature/auth/data/provider/user_jwt_provider.dart';
import 'package:eqmonitor/feature/auth/data/repository/native_social_auth_repository.dart';
import 'package:eqmonitor/feature/auth/data/repository/passkey_repository.dart';
import 'package:eqmonitor/feature/auth/data/repository/user_api_client.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debug_auth_notifier.g.dart';

@riverpod
class DebugAuthNotifier extends _$DebugAuthNotifier {
  @override
  Future<DebugAuthState> build() async {
    try {
      final environmentResult = await ref.watch(
        authEnvironmentProvider.future,
      );
      if (environmentResult case Failure(:final exception)) {
        return const DebugAuthState.signedOut().withFailure(
          kind: exception.kind,
        );
      }
      final result = await ref.read(authSessionProvider.notifier).restore();
      switch (result) {
        case Success(:final value) when value.isAuthenticated:
          final jwt = await ref.read(userJwtServiceProvider.future);
          return const DebugAuthState.signedOut().authenticated(
            authenticatedProvider: null,
            expiresAt: jwt.expiresAt,
            success: DebugAuthSuccessKind.restored,
          );
        case Success():
          return const DebugAuthState.signedOut();
        case Failure(:final exception):
          return const DebugAuthState.signedOut().withFailure(
            kind: exception.kind,
          );
      }
    } on Exception {
      return const DebugAuthState.signedOut().withFailure(
        kind: AuthFailureKind.unknown,
      );
    }
  }

  DebugAuthState? get currentValue => switch (state) {
    AsyncData(:final value) => value,
    _ => null,
  };

  Future<void> signInWithGoogle() async {
    final current = currentValue;
    if (current == null || current.isBusy) {
      return;
    }
    state = AsyncData(
      current.working(nextOperation: DebugAuthOperation.googleSignIn),
    );
    try {
      final repository = await ref.read(
        nativeSocialAuthRepositoryProvider.future,
      );
      final result = await repository.signInWithGoogle();
      switch (result) {
        case Success():
          final jwt = await ref.read(userJwtServiceProvider.future);
          state = AsyncData(
            current.authenticated(
              authenticatedProvider: DebugAuthProviderKind.google,
              expiresAt: jwt.expiresAt,
              success: DebugAuthSuccessKind.signedIn,
            ),
          );
        case Failure(:final exception):
          state = AsyncData(current.failed(kind: exception.kind));
      }
    } on Exception {
      state = AsyncData(current.failed(kind: AuthFailureKind.unknown));
    }
  }

  Future<void> signInWithApple() async {
    final current = currentValue;
    if (current == null || current.isBusy) {
      return;
    }
    state = AsyncData(
      current.working(nextOperation: DebugAuthOperation.appleSignIn),
    );
    try {
      final repository = await ref.read(
        nativeSocialAuthRepositoryProvider.future,
      );
      final result = await repository.signInWithApple();
      switch (result) {
        case Success():
          final jwt = await ref.read(userJwtServiceProvider.future);
          state = AsyncData(
            current.authenticated(
              authenticatedProvider: DebugAuthProviderKind.apple,
              expiresAt: jwt.expiresAt,
              success: DebugAuthSuccessKind.signedIn,
            ),
          );
        case Failure(:final exception):
          state = AsyncData(current.failed(kind: exception.kind));
      }
    } on Exception {
      state = AsyncData(current.failed(kind: AuthFailureKind.unknown));
    }
  }

  Future<void> signInWithPasskey() async {
    final current = currentValue;
    if (current == null || current.isBusy) {
      return;
    }
    state = AsyncData(
      current.working(nextOperation: DebugAuthOperation.passkeySignIn),
    );
    try {
      final repository = await ref.read(passkeyRepositoryProvider.future);
      final result = await repository.signIn();
      switch (result) {
        case Success(:final value) when value.isAuthenticated:
          final jwt = await ref.read(userJwtServiceProvider.future);
          state = AsyncData(
            current.authenticated(
              authenticatedProvider: DebugAuthProviderKind.passkey,
              expiresAt: jwt.expiresAt,
              success: DebugAuthSuccessKind.signedIn,
            ),
          );
        case Success():
          state = AsyncData(
            current.failed(kind: AuthFailureKind.invalidResponse),
          );
        case Failure(:final exception):
          state = AsyncData(current.failed(kind: exception.kind));
      }
    } on Exception {
      state = AsyncData(current.failed(kind: AuthFailureKind.unknown));
    }
  }

  Future<void> registerPasskey() async {
    final current = currentValue;
    if (current == null || current.isBusy) {
      return;
    }
    state = AsyncData(
      current.working(nextOperation: DebugAuthOperation.passkeyRegistration),
    );
    try {
      final repository = await ref.read(passkeyRepositoryProvider.future);
      final result = await repository.register();
      state = AsyncData(
        switch (result) {
          Success() => current.succeeded(
            success: DebugAuthSuccessKind.passkeyRegistered,
          ),
          Failure(:final exception) => current.failed(kind: exception.kind),
        },
      );
    } on Exception {
      state = AsyncData(current.failed(kind: AuthFailureKind.unknown));
    }
  }

  Future<void> refreshJwt() async {
    final current = currentValue;
    if (current == null || current.isBusy) {
      return;
    }
    state = AsyncData(
      current.working(nextOperation: DebugAuthOperation.jwtRefresh),
    );
    try {
      final result = await ref.read(authSessionProvider.notifier).refreshJwt();
      switch (result) {
        case Success(:final value) when value.isAuthenticated:
          final jwt = await ref.read(userJwtServiceProvider.future);
          state = AsyncData(
            current.succeeded(
              success: DebugAuthSuccessKind.jwtRefreshed,
              expiresAt: jwt.expiresAt,
            ),
          );
        case Success():
          state = AsyncData(
            current.failed(kind: AuthFailureKind.invalidResponse),
          );
        case Failure(:final exception):
          state = AsyncData(current.failed(kind: exception.kind));
      }
    } on Exception {
      state = AsyncData(current.failed(kind: AuthFailureKind.unknown));
    }
  }

  Future<void> verifyUserMe() async {
    final current = currentValue;
    if (current == null || current.isBusy) {
      return;
    }
    state = AsyncData(
      current.working(nextOperation: DebugAuthOperation.userMeVerification),
    );
    try {
      final client = await ref.read(userApiClientProvider.future);
      final result = await client.getJson(
        path: api.UserApiClientUrls.getV2UserMe,
      );
      if (result case Failure(:final exception)) {
        state = AsyncData(current.failed(kind: exception.kind));
        return;
      }
      final summaryResult = const DebugAuthUserSummaryParser().parse(
        result.unwrap(),
      );
      if (summaryResult case Failure(:final exception)) {
        state = AsyncData(current.failed(kind: exception.kind));
        return;
      }
      final jwt = await ref.read(userJwtServiceProvider.future);
      state = AsyncData(
        current.succeeded(
          success: DebugAuthSuccessKind.userMeVerified,
          expiresAt: jwt.expiresAt,
          summary: summaryResult.unwrap(),
        ),
      );
    } on Exception {
      state = AsyncData(current.failed(kind: AuthFailureKind.unknown));
    }
  }

  Future<void> signOut() async {
    final current = currentValue;
    if (current == null || current.isBusy) {
      return;
    }
    state = AsyncData(
      current.working(nextOperation: DebugAuthOperation.signOut),
    );
    try {
      final result = await ref.read(authSessionProvider.notifier).signOut();
      state = AsyncData(
        switch (result) {
          Success() => current.signedOut(),
          Failure(:final exception) => current.signedOut(
            failure: exception.kind,
          ),
        },
      );
    } on Exception {
      state = AsyncData(
        current.signedOut(failure: AuthFailureKind.unknown),
      );
    }
  }
}
