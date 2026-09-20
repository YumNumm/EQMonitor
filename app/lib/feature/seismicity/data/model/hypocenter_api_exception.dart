enum HypocenterApiErrorKind {
  network,
  revisionChanged,
  periodUnavailable,
  cancelled,
}

class const HypocenterApiException({
  required final String message,
  final int? statusCode,
  final HypocenterApiErrorKind kind = HypocenterApiErrorKind.network,
}) implements Exception {
  bool get isRevisionChanged =>
      kind == HypocenterApiErrorKind.revisionChanged || statusCode == 409;

  @override
  String toString() => message;
}
