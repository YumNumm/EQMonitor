enum AuthSessionStatus { signedOut, authenticated }

final class AuthSession {
  // ignore: unnecessary_type_name_in_constructor
  const AuthSession.signedOut() : status = AuthSessionStatus.signedOut;

  // ignore: unnecessary_type_name_in_constructor
  const AuthSession.authenticated() : status = AuthSessionStatus.authenticated;

  final AuthSessionStatus status;

  bool get isAuthenticated => status == AuthSessionStatus.authenticated;
}
