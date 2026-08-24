enum AuthFailureKind {
  cancelled,
  configuration,
  environmentMismatch,
  unauthorized,
  rateLimited,
  server,
  timeout,
  network,
  invalidResponse,
  storage,
  unknown,
}

final class AuthFailure implements Exception {
  const new({required this.kind, this.statusCode});

  final AuthFailureKind kind;
  final int? statusCode;

  @override
  String toString() => 'AuthFailure(kind: $kind, statusCode: $statusCode)';
}
