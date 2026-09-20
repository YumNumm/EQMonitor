enum AuthFailureKind {
  cancelled,
  busy,
  configuration,
  environmentMismatch,
  sessionRequired,
  passkeyUnsupported,
  passkeyDomainAssociation,
  passkeyCredentialUnavailable,
  unauthorized,
  rateLimited,
  server,
  timeout,
  network,
  invalidResponse,
  storage,
  unknown,
}

final class const AuthFailure({
  required final AuthFailureKind kind,
  final int? statusCode,
}) implements Exception {
  @override
  String toString() => 'AuthFailure(kind: $kind, statusCode: $statusCode)';
}
