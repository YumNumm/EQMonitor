class HypocenterApiException implements Exception {
  const HypocenterApiException({required this.message, this.statusCode});

  final String message;
  final int? statusCode;

  bool get isRevisionChanged => statusCode == 409;

  @override
  String toString() => message;
}
