enum AuthSessionStatus { signedOut, authenticated }

final class AuthSession {
  // ignore: unnecessary_type_name_in_constructor
  const AuthSession.signedOut()
    : status = AuthSessionStatus.signedOut,
      userJwt = null;

  // ignore: unnecessary_type_name_in_constructor
  const AuthSession.authenticated({required this.userJwt})
    : status = AuthSessionStatus.authenticated;

  final AuthSessionStatus status;
  final String? userJwt;

  bool get isAuthenticated => status == AuthSessionStatus.authenticated;
}
