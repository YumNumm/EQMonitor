import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/auth/data/model/auth_failure.dart';
import 'package:eqmonitor/feature/auth/data/model/auth_session.dart';

enum DebugAuthProviderKind { google, apple, passkey }

enum DebugAuthOperation {
  restoring,
  googleSignIn,
  appleSignIn,
  passkeySignIn,
  passkeyRegistration,
  jwtRefresh,
  userMeVerification,
  signOut,
}

enum DebugAuthSuccessKind {
  restored,
  signedIn,
  passkeyRegistered,
  jwtRefreshed,
  userMeVerified,
  signedOut,
}

final class DebugAuthUserSummary {
  const new({
    required this.abbreviatedUserId,
    required this.maskedEmail,
  });

  final String abbreviatedUserId;
  final String maskedEmail;
}

final class DebugAuthUserSummaryParser {
  const new();

  Result<DebugAuthUserSummary, AuthFailure> parse(
    Map<String, dynamic> body,
  ) {
    final userId = body['id'];
    final email = body['email'];
    if (userId is! String ||
        userId.isEmpty ||
        email is! String ||
        email.isEmpty) {
      return const Failure(
        AuthFailure(kind: AuthFailureKind.invalidResponse),
      );
    }
    final separatorIndex = email.indexOf('@');
    if (separatorIndex < 1 || separatorIndex == email.length - 1) {
      return const Failure(
        AuthFailure(kind: AuthFailureKind.invalidResponse),
      );
    }
    final localPart = email.substring(0, separatorIndex);
    final domain = email.substring(separatorIndex + 1);
    final abbreviatedUserId = userId.length > 6
        ? '${userId.substring(0, 6)}…'
        : userId.length > 1
        ? '${userId.substring(0, 1)}…'
        : '***';
    return Success(
      DebugAuthUserSummary(
        abbreviatedUserId: abbreviatedUserId,
        maskedEmail:
            '${localPart.substring(0, 1)}***@${domain.substring(0, 1)}***',
      ),
    );
  }
}

final class DebugAuthState {
  const new({
    required this.sessionStatus,
    this.operation,
    this.provider,
    this.failureKind,
    this.successKind,
    this.jwtExpiresAt,
    this.userSummary,
  });

  // ignore: unnecessary_type_name_in_constructor
  const DebugAuthState.signedOut()
    : this(sessionStatus: AuthSessionStatus.signedOut);

  // ignore: unnecessary_type_name_in_constructor
  const DebugAuthState.restoring()
    : this(
        sessionStatus: AuthSessionStatus.signedOut,
        operation: DebugAuthOperation.restoring,
      );

  final AuthSessionStatus sessionStatus;
  final DebugAuthOperation? operation;
  final DebugAuthProviderKind? provider;
  final AuthFailureKind? failureKind;
  final DebugAuthSuccessKind? successKind;
  final DateTime? jwtExpiresAt;
  final DebugAuthUserSummary? userSummary;

  bool get isAuthenticated => sessionStatus == AuthSessionStatus.authenticated;

  bool get isBusy => operation != null;

  DebugAuthState working({required DebugAuthOperation nextOperation}) =>
      DebugAuthState(
        sessionStatus: sessionStatus,
        operation: nextOperation,
        provider: provider,
        jwtExpiresAt: jwtExpiresAt,
        userSummary: userSummary,
      );

  DebugAuthState authenticated({
    required DebugAuthProviderKind? authenticatedProvider,
    required DateTime? expiresAt,
    required DebugAuthSuccessKind success,
  }) => DebugAuthState(
    sessionStatus: AuthSessionStatus.authenticated,
    provider: authenticatedProvider,
    successKind: success,
    jwtExpiresAt: expiresAt,
  );

  DebugAuthState succeeded({
    required DebugAuthSuccessKind success,
    DateTime? expiresAt,
    DebugAuthUserSummary? summary,
  }) => DebugAuthState(
    sessionStatus: sessionStatus,
    provider: provider,
    successKind: success,
    jwtExpiresAt: expiresAt ?? jwtExpiresAt,
    userSummary: summary ?? userSummary,
  );

  DebugAuthState failed({required AuthFailureKind kind}) {
    if (kind == AuthFailureKind.unauthorized) {
      return const DebugAuthState.signedOut().withFailure(kind: kind);
    }
    return DebugAuthState(
      sessionStatus: sessionStatus,
      provider: provider,
      failureKind: kind,
      jwtExpiresAt: jwtExpiresAt,
      userSummary: userSummary,
    );
  }

  DebugAuthState withFailure({required AuthFailureKind kind}) => DebugAuthState(
    sessionStatus: sessionStatus,
    provider: provider,
    failureKind: kind,
    jwtExpiresAt: jwtExpiresAt,
    userSummary: userSummary,
  );

  DebugAuthState signedOut({AuthFailureKind? failure}) => DebugAuthState(
    sessionStatus: AuthSessionStatus.signedOut,
    failureKind: failure,
    successKind: failure == null ? DebugAuthSuccessKind.signedOut : null,
  );
}
