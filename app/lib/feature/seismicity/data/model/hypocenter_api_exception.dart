enum HypocenterApiErrorKind {
  network,
  revisionChanged,
  periodUnavailable,
  cancelled,
}

class HypocenterApiException implements Exception {
  const HypocenterApiException({
    required this.message,
    this.statusCode,
    this.kind = HypocenterApiErrorKind.network,
  });

  final String message;
  final int? statusCode;
  final HypocenterApiErrorKind kind;

  bool get isRevisionChanged =>
      kind == HypocenterApiErrorKind.revisionChanged || statusCode == 409;

  @override
  String toString() => message;
}
